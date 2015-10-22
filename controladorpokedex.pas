UNIT ControladorPokedex;

{$mode objfpc}{$H+}

INTERFACE
USES
    DT_Pokedex, GUI_Pokedex, Crt, SysUtils;

CONST
    TECLA_ESC= #27;
    TECLA_ENTER= #13;
    //Comandos teclas especiales.
    TECLA_ESPECIAL_PRESIONADA= #0; //Al presionar una tecla especial primero se lanza este caracter.
    TECLA_FLECHA_ARRIBA= #72; //Es una tecla especial.
    TECLA_FLECHA_ABAJO= #80;  //Es una tecla especial.
    TECLA_FLECHA_DERECHA= #77;//Es una tecla especial.
    TECLA_FLECHA_IZQUIERDA= #75; //Es una tecla especial.

    (*Inicia los datos de la pokedex cargando desde la base de datos.
    Se establece una bandera indicando que la pokedex ya fue iniciada.*)
    PROCEDURE StartPokedex();

    (*Devuelve TRUE si la pokedex ya fue iniciada, FALSE sino.*)
    FUNCTION PokedexStarted(): BOOLEAN;

    (*Asigna el control del sistema a la pokedex.
    Si la pokedex no ha sido iniciada aún mediante 'StartPokedex' entonces la
    inicializará utilizando esa misma operación.
    Este procedimiento dibuja la pokedex en pantalla mediante el procedimiento
    'DrawPokedex' implementado en la unidad 'GUI_Pokedex'. Además, si se presiona
    la flecha hacia arriba sube una posición en la lista; si se presiona la flecha
    hacia abajo se baja una posición en la lista. Al presionar escape (ESC) se
    devuelve el control al programa principal.*)
    PROCEDURE ShowPokedex();

IMPLEMENTATION
VAR
    pokedexStart: BOOLEAN;
    pokedex: DatosPokedex;
    key: CHAR;

    (*Inicia los datos de la pokedex cargando desde la base de datos.
    Se establece una bandera indicando que la pokedex ya fue iniciada.*)
    PROCEDURE StartPokedex(); Begin
        IF NOT pokedexStarted THEN Begin
            IniciarPokedex(pokedex);
            pokedexStart:= true;
        End;
    end;

    (*Devuelve TRUE si la pokedex ya fue iniciada, FALSE sino.*)
    FUNCTION PokedexStarted(): BOOLEAN; Begin
        PokedexStarted:= pokedexStart;
    end;

    (*Asigna el control del sistema a la pokedex.
    Si la pokedex no ha sido iniciada aún mediante 'StartPokedex' entonces la
    inicializará utilizando esa misma operación.
    Este procedimiento dibuja la pokedex en pantalla mediante el procedimiento
    'DrawPokedex' implementado en la unidad 'GUI_Pokedex'. Además, si se presiona
    la flecha hacia arriba sube una posición en la lista; si se presiona la flecha
    hacia abajo se baja una posición en la lista. Al presionar escape (ESC) se
    devuelve el control al programa principal.*)
    PROCEDURE ShowPokedex();
    VAR especieBuscada: String;
        indiceEspecieBuscada: INTEGER;
    BEGIN
        //IF NOT PokedexStarted THEN
        StartPokedex;
        DrawPokedexBackground;
        DrawPokedex(pokedex);

        REPEAT
            key:= ReadKey;
            IF key=TECLA_ESPECIAL_PRESIONADA THEN Begin
                key:= ReadKey;
                CASE key OF
                    TECLA_FLECHA_ARRIBA:
                        Begin
                            AnteriorEspecie(pokedex);
                            DrawPokedex(pokedex);
                        end;
                    TECLA_FLECHA_ABAJO:
                        Begin
                            SiguienteEspecie(pokedex);
                            DrawPokedex(pokedex);
                        end;
                end;
            end else if (key='b') OR (key='B') then begin
                CursorOn;
                GoToXY(1,22);
                TextBackGround(Blue); TextColor(White);
                Write('                                      ');
                GoToXY(1,22);
                Write('Ingresa nombre o numero de especie:   ');
                GoToXY(1,23);
                Write('                                      ');
                GoToXY(3,23);
                ReadLn(especieBuscada);
                CursorOff;
                indiceEspecieBuscada:= BuscarEspecie(especieBuscada,pokedex);
                IF indiceEspecieBuscada=0 THEN Begin
                    TextBackground(LightRed); TextColor(Yellow);
                    GoToXY(1,23);
                    Write('                                      ');
                    GoToXY(1,23);
                    Write(' ERROR: No existe la especie buscada. ');
                    TextBackground(Black);
                end else begin
                    TextBackground(Black);
                    WHILE indiceEspecieBuscada<IndiceEspecieSeleccionada(pokedex) do begin
                        AnteriorEspecie(pokedex);
                    end;

                    WHILE indiceEspecieBuscada>IndiceEspecieSeleccionada(pokedex) do begin
                        SiguienteEspecie(pokedex);
                    end;

                    DrawPokedex(pokedex);
                end;
            end;
        until key=TECLA_ESC;
    end;

BEGIN
    pokedexStart:= false;
END.

