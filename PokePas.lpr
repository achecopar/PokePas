PROGRAM PokePas;

USES Crt, BaseDeDatos, Utilidades, DT_Especie, DT_TipoElemental, DT_Pokedex,
  GUI_Pokedex, ControladorPokedex, SysUtils;

CONST
    TECLA_ESC= #27;
    TECLA_ENTER= #13;
    //Comandos teclas especiales.
    TECLA_ESPECIAL_PRESIONADA= #0; //Al presionar una tecla especial primero se lanza este caracter.
    TECLA_FLECHA_ARRIBA= #72; //Es una tecla especial.
    TECLA_FLECHA_ABAJO= #80;  //Es una tecla especial.
    TECLA_FLECHA_DERECHA= #77;//Es una tecla especial.
    TECLA_FLECHA_IZQUIERDA= #75; //Es una tecla especial.

TYPE
    Menu= RECORD
        Opciones: ARRAY[1..20] OF String;
        SelectedOption: 1..20;
        tope: 1..20;
    end;

VAR
    m: Menu;
    key: CHAR;
    i: INTEGER;
    str: String;

PROCEDURE DrawLogo();
VAR logo: Text;
    linea: String;
    i: INTEGER;
Begin
    assign(logo, 'Images\Logo.txt' );
    {$I-}
    reset(logo);
    {$I+}
    IF IOResult<> 0 THEN BEGIN
      WriteLn('El archivo "Images\Logo.txt'+'" no existe.');
    end ELSE Begin
        i:= 1;
        TextBackGround(Blue);
        TextColor(Yellow);
        WHILE NOT EOF(logo) DO BEGIN
            ReadLn(logo,linea);
            GoTOXY(1,i);
            Write(linea);
            i:= i+1;
        end;
        Close(logo);
        TextBackGround(Black);
    end;

    TextColor(Yellow);
    GoToXY(1,18);
    Write('                                                                                 ');
    GoToXY(1,19);
    Write('Bienvenido/a a PokePas V1.0 -- Utiliza las flechas para moverte entre opciones. ');
End;
PROCEDURE DrawMenu(m: Menu);
VAR i: INTEGER;
Begin
    TextColor(LightGreen);
    TextBackground(Green);
    GoToXY(1,22);

    FOR i:= 1 TO m.tope DO BEGIN
        IF m.SelectedOption=i THEN
            TextColor(LightCyan)
        ELSE
            TextColor(Yellow);

        IF i=1 THEN Write('  ') ELSE Write('    ');
        Write(m.Opciones[i]);
    end;
    Write('   ');
End;
PROCEDURE DrawMainScreen(m: Menu); Begin
    ClrScr;
    TextBackGround(Black);
    DrawLogo;
    TextBackground(Black);
    GoToXY(1,20);
    Write('                                                                                 ');
    Write('                                                                               ');

    DrawMenu(m);

    TextBackGround(Black);
    GoToXY(1,23);
    Write('                                                                                 ');
    GoToXY(1,24);
    TextBackground(LightGray);
    TextColor(LightBlue);
    Write('Presiona ENTER para seleccionar la opcion marcada o el numero de la misma.      ');
    GoToXY(1,25);
    Write('Presiona ESC para salir directamente.                                           ');
    TextBackground(Black);
End;

PROCEDURE ShowErrorMessage(); Begin
    TextBackground(Blue);
    ClrScr;
    GoToXY(1,11);
    TextColor(Red);
    Write('         LO SIENTO... AUN NO HEMOS DESARROLLADO ESTA FUNCINALIDAD              ');
    GoToXY(1,12);
    Write('                 Presiona '); TextColor(LightRed); Write('ENTER '); TextColor(Red); Write('para volver al menu principal.                  ');
    ReadLn;
    TextBackground(Black);
END;

BEGIN
    cursoroff;
    m.tope:= 4;
    m.SelectedOption:= 1;
    m.opciones[1]:= '1- Pokedex General';
    m.opciones[2]:= '2- Creador Pokemon';
    m.opciones[3]:= '3- Battle Center';
    m.opciones[4]:= '4- Aventura';

    REPEAT
        DrawMainScreen(m);
        key:= ReadKey;

        IF key=TECLA_ENTER THEN Begin
            str:= IntToStr(m.SelectedOption);
            key:= str[1];
        end;

        CASE key OF
            '1': ShowPokedex();
            '2': ShowErrorMessage();
            '3': ShowErrorMessage();
            '4': ShowErrorMessage();
            #0: Begin
                key:= ReadKey;
                CASE key OF
                    TECLA_FLECHA_DERECHA:
                        IF m.SelectedOption=m.tope THEN  m.selectedOption:= 1
                        ELSE m.selectedOption:= m.selectedOption+1;
                    TECLA_FLECHA_IZQUIERDA:
                        IF m.SelectedOption=1 THEN  m.selectedOption:= m.tope
                        ELSE m.selectedOption:= m.selectedOption-1;
                end;
            end ELSE Begin

            end;
        end;
    UNTIL key=TECLA_ESC;

    TextBackground(LightBlue);
    ClrScr;
    GoToXY(1,11);
    TextColor(Yellow);
    WriteLn(' PokePas es un proyecto independiente pensado para ensenar. Muchas gracias por ');
    WriteLn('       formar parte de esta iniciativa. Espero te haya sido de utilidad ;-)        ');
    GoToXY(1,20);
    TextColor(White);
    WriteLn('Kyshuo Ayame - KAEduSoft 2015 - Proyecto independiente sin fines de lucro.        ');
    Write('El uso que hagas de este proyecto y su codigo queda 100% bajo tu responsabilidad');

    TextColor(lightred);
    TextBackGround(LightGray);
    FOR i:= 1 TO 5 DO Begin
        GoToXY(1,25);
        Write('Este mensaje se cerrara en ',6-i,' segundos.                                         ');
        Delay(1000);
    END;
END.
