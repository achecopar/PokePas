UNIT Testing;

INTERFACE
    PROCEDURE TestearTipoElemental;
    PROCEDURE TestearEspecie;
    PROCEDURE TestearListaTiposElementales;
    PROCEDURE TestearListaEspecies;

IMPLEMENTATION
USES DT_TipoElemental, DT_Especie, BaseDeDatos, Utilidades, Crt, strutils, sysutils;
VAR archivoTesting: Text;
    linea: String;
    i, id, cantErrores: INTEGER;
    nombre, extract: String;
    tipos: ARRAY[1..20] OF TipoElemental;
    current: INTEGER;
    e1, e2: Especie;

    PROCEDURE TestearTipoElemental; Begin
        ClrScr;
        cursoroff;
        TextColor(LightGreen);
        WriteLn('                    SE REALIZARA EL TESTING TipoElemental');
        WriteLn('*******************************************************************************');

        assign(archivoTesting, 'testingFiles\testingTipoElemental.txt' );
        {$I-}
        reset(archivoTesting);
        {$I+}
        IF IOResult<> 0 THEN BEGIN
          TextColor(LightRed);
          WriteLn('ERROR: El archivo testingFiles\testingTipoElemental.txt'+'" no existe.');
          TextColor(LightGray);
          WriteLn('No se puede hacer el testing. Presioan ENTER para salir.');
          Exit;
        end ELSE Begin
            i:= 4;
            current:= 1;
            WHILE NOT EOF(archivoTesting) DO BEGIN
                ReadLn(archivoTesting,linea);
                extract:= ExtractDelimited(1,linea,[';']);
                id:= StrToInt(extract);
                nombre:= ExtractDelimited(2,linea,[';']);
                GoTOXY(3,i); Write(id);
                GotoXY(9,i); Write(nombre);
                i:= i+1;

                CrearTipoElemental(id,nombre,tipos[current]);
                current:= current+1;
            end;

            Reset(archivoTesting);
            i:=4;
            current:= 1;
            cantErrores:=0;
            WHILE NOT EOF(archivoTesting) DO begin
                TextColor(White);
                ReadLn(archivoTesting,linea);
                extract:= ExtractDelimited(1,linea,[';']);
                id:= StrToInt(extract);
                nombre:= ExtractDelimited(2,linea,[';']);

                Delay(500);
                GoToXY(28,i); Write('OK'); GotoXY(39,i);
                Write(NombreTipoElemental(tipos[current]));
                GotoXY(55,i); Write(IdTipoElemental(tipos[current]));
                GotoXY(67,i);
                IF ((id=IdTipoElemental(tipos[current]))AND(nombre=NombreTipoElemental(tipos[current]))) THEN begin
                   TextColor(LightCyan); Write('OK');
                end else begin
                    TextColor(LightRed);
                    Write('ERROR');
                    cantErrores:=cantErrores+1;
                end;

                i:= i+1; current:= current+1;
            end;
            Close(archivoTesting);

            GoToXY(1,24);
            IF cantErrores=0 THEN begin
                TextColor(LightCyan);
                Write('OK: No hubo errores. TipoElemental FINALIZADO. Presiona ENTER para salir.');
                ReadLn
            end else begin
                TextColor(LightRed);
                WriteLn('ERROR: Se encontraron ',cantErrores,' errores. Verifica los avisos en rojo.');
                Write('Presiona ENTER para salir.');
                ReadLn;
            end;
        end;
    end;

    PROCEDURE TestearEspecie; Begin
        ClrScr;
        TextColor(LightGreen);
        cursoroff;

        WriteLn('                        SE REALIZARA EL TESTING Especie');
        WriteLn('*******************************************************************************');

        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('CrearEspecie ');
        TextColor(LightGreen); Write('--> ');

        e1.Id:= 1;
        e1.Numero:= '1';
        e1.Nombre:= 'Bulbasaur';
        e1.Tipo1:= 12;
        e1.Tipo2:= 17;
        e1.PS_Base:= 45;
        e1.ATK_Base:= 49;
        e1.DEF_Base:= 49;
        e1.ATKSp_Base:= 65;
        e1.DEFSp_Base:= 65;
        e1.VEL_Base:= 45;
        e1.AMISTAD_Base:= 70;
        e1.EXP_Base:= 64;
        e1.PS_Esfuerzo:= 0;
        e1.ATK_Esfuerzo:= 0;
        e1.DEF_Esfuerzo:= 0;
        e1.ATKSp_Esfuerzo:= 1;
        e1.DEFSp_Esfuerzo:= 0;
        e1.VEL_Esfuerzo:= 0;
        e1.Crecimiento:= 'Normal';
        e1.RatioCaptura:= 45;

        CrearEspecie(1,'1','Bulbasaur',12,17,45,49,49,65,65,45,70,64,0,0,0,1,0,0,'Normal',45,e2);

        if ((e1.Id= e2.id) AND (e1.Numero= e2.numero) AND (e1.Nombre= e2.nombre)  AND
        (e1.Tipo1= e2.tipo1) AND (e1.Tipo2= e2.tipo2) AND (e1.PS_Base= e2.PS_Base) AND
        (e1.ATK_Base= e2.ATK_Base) AND (e1.DEF_Base= e2.DEF_Base) AND (e1.ATKSp_Base= e2.ATKSp_Base) AND
        (e1.DEFSp_Base= e2.DEFSp_Base) AND (e1.VEL_Base= e2.VEL_Base) AND (e1.AMISTAD_Base= e2.AMISTAD_Base) AND
        (e1.EXP_Base= e2.EXP_Base) AND (e1.PS_Esfuerzo= e2.PS_Esfuerzo) AND (e1.ATK_Esfuerzo= e2.ATK_Esfuerzo) AND
        (e1.DEF_Esfuerzo= e2.DEF_Esfuerzo) AND (e1.ATKSp_Esfuerzo= e2.ATKSp_Esfuerzo) AND
        (e1.DEFSp_Esfuerzo= e2.DEFSp_Esfuerzo) AND (e1.VEL_Esfuerzo= e2.VEL_Esfuerzo) AND
        (e1.Crecimiento= e2.Crecimiento) AND (e1.RatioCaptura= e2.RatioCaptura)) then begin
            TextColor(LightCyan);
            WriteLn('OK: Atributos incializados correctamente.')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Uno o mas valores no se inician correctamente.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('IdEspecie ');
        TextColor(LightGreen); Write('--> ');

        IF (e1.id=IdEspecie(e1)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Se obtuvo ',IdEspecie(e1),' y se esperaba ',e1.id,'.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('NumeroEspecie ');
        TextColor(LightGreen); Write('--> ');

        IF (e1.numero=NumeroEspecie(e1)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Se obtuvo ',NumeroEspecie(e1),' y se esperaba ',e1.numero,'.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('NombreEspecie ');
        TextColor(LightGreen); Write('--> ');

        IF (e1.Nombre=NombreEspecie(e1)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Se obtuvo ',NombreEspecie(e1),' y se esperaba ',e1.nombre,'.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('TipoEspecie ');
        TextColor(LightGreen); Write('--> ');

        IF (e1.Tipo1=TipoEspecie(1,e1)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Se obtuvo ',TipoEspecie(1,e1),' y se esperaba ',e1.Tipo1,'.');
        end;
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('TipoEspecie ');
        TextColor(LightGreen); Write('--> ');

        IF (e1.Tipo2=TipoEspecie(2,e1)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Se obtuvo ',TipoEspecie(2,e1),' y se esperaba ',e1.Tipo2,'.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('EstadisticaEspecie ');
        TextColor(LightGreen); Write('--> ');

        if ((e1.PS_Base= EstadisticaEspecie(PS_Base,e1)) AND
        (e1.ATK_Base= EstadisticaEspecie(ATK_Base,e1)) AND
        (e1.DEF_Base= EstadisticaEspecie(DEF_Base,e1)) AND
        (e1.ATKSp_Base= EstadisticaEspecie(ATKSp_Base,e1)) AND
        (e1.DEFSp_Base= EstadisticaEspecie(DEFSp_Base,e1)) AND
        (e1.VEL_Base= EstadisticaEspecie(VEL_Base,e1)) AND
        (e1.AMISTAD_Base= EstadisticaEspecie(AMISTAD_Base,e1)) AND
        (e1.EXP_Base= EstadisticaEspecie(EXP_Base,e1)) AND
        (e1.PS_Esfuerzo= EstadisticaEspecie(PS_Esfuerzo,e1)) AND
        (e1.ATK_Esfuerzo= EstadisticaEspecie(ATK_Esfuerzo,e1)) AND
        (e1.DEF_Esfuerzo= EstadisticaEspecie(DEF_Esfuerzo,e1)) AND
        (e1.ATKSp_Esfuerzo= EstadisticaEspecie(ATKSp_Esfuerzo,e1)) AND
        (e1.DEFSp_Esfuerzo= EstadisticaEspecie(DEFSp_Esfuerzo,e1)) AND
        (e1.VEL_Esfuerzo= EstadisticaEspecie(VEL_Esfuerzo,e1)) AND
        (e1.RatioCaptura= EstadisticaEspecie(RatioCaptura,e1))) then  begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Una o mas estadisticas no son retornadas correctamente.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('CrecimientoEspecie ');
        TextColor(LightGreen); Write('--> ');

        IF (e1.Crecimiento=CrecimientoEspecie(e1)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: Se obtuvo ',CrecimientoEspecie(e1),' y se esperaba ',e1.Crecimiento,'.');
        end;

        TextColor(White);
        WriteLn; Write('Presiona ENTER para finalizar.');
        ReadLn;


    end;

    PROCEDURE TestearListaTiposElementales;
    VAR l, l2: ListaTiposElementales;
        i: INTEGER;
    Begin
        cursoroff;
        TextColor(LightGreen);
        WriteLn('                SE REALIZARA EL TESTING ListaTiposElementales');
        WriteLn('*******************************************************************************');

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('IniciarListaTiposElementales ');
        TextColor(LightGreen); Write('--> ');
        IniciarListaTiposElementales(l);
        TextColor(LightCyan);  WriteLn('OK');

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('EsVaciaListaTiposElementales ');
        TextColor(LightGreen); Write('--> ');

        IF (EsVaciaListaTiposElementales(l)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: La lista recien se creo pero no se indica como vacia.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('AgregarTipoListaTiposElementales ');
        TextColor(LightGreen); Write('--> ');

        CargarListaTiposElementales(l2);

         TextColor(LightCyan); WriteLn('OK');

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('EsVaciaListaTiposElementales ');
        TextColor(LightGreen); Write('--> ');

        IF (NOT EsVaciaListaTiposElementales(l2)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: La lista ha sido cargada pero figura como vacia.');
        end;

        Delay(1000);
        TextColor(LightGreen); WriteLn('Recorriendo la lista********************');
        IF l2.lista[1].id= IdTipoElemental(PrimerTipoListaTiposElementales(l2)) THEN begin
            TextColor(LightCyan);
            WriteLn('OK: El primer tipo de la lista es devuelto correctamente.')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: El primer tipo es ',l2.lista[1].id,' y se obtuvo ',IdTipoElemental(PrimerTipoListaTiposElementales(l2)),'.');
        end;

        FOR i:=1 TO l2.tope DO begin
           if(l2.lista[i].id<>IdTipoElemental(TipoListaTiposElementales(i,l2))) then break;
        end;

        if i>=l2.tope then begin
             TextColor(LightCyan);
            WriteLn('OK: La lista se recorre correctamente.')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: TipoListaTiposElementales no retorna el indice indicado.');
        end;

        TextColor(White);
        WriteLn; Write('Presiona ENTER para finalizar.');
        ReadLn;
    end;

    PROCEDURE TestearListaEspecies;
    VAR l, l2: ListaEspecies;
        i: INTEGER;
    Begin
        cursoroff;
        TextColor(LightGreen);
        WriteLn('                SE REALIZARA EL TESTING ListaEspecies');
        WriteLn('*******************************************************************************');

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('IniciarListaListaEspecies ');
        TextColor(LightGreen); Write('--> ');
        IniciarListaEspecies(l);
        TextColor(LightCyan);  WriteLn('OK');

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('EsVaciaListaEspecies ');
        TextColor(LightGreen); Write('--> ');

        IF (EsVaciaListaEspecies(l)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: La lista recien se creo pero no se indica como vacia.');
        end;

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('AgregarEspecieListaEspecies ');
        TextColor(LightGreen); Write('--> ');

        CargarListaEspecies(l2);

        TextColor(LightCyan); WriteLn('OK');

        Delay(1000);
        TextColor(LightGreen); Write('Testeando ');
        TextColor(LightCyan);  Write('EsVaciaListaEspecies ');
        TextColor(LightGreen); Write('--> ');

        IF (NOT EsVaciaListaEspecies(l2)) then begin
            TextColor(LightCyan);
            WriteLn('OK')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: La lista ha sido cargada pero figura como vacia.');
        end;

        Delay(1000);
        TextColor(LightGreen); WriteLn('Recorriendo la lista********************');
        IF l2.lista[1].id= PrimeraEspecieListaEspecies(l2).id THEN begin
            TextColor(LightCyan);
            WriteLn('OK: La primera especie de la lista es devuelta correctamente.')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: La primera especie es ',l2.lista[1].id,' y se obtuvo ',IdEspecie(PrimeraEspecieListaEspecies(l2)),'.');
        end;

        FOR i:=1 TO l2.tope DO begin
           if(l2.lista[i].id<>EspecieListaEspecies(i,l2).id) then break;
        end;

        if i>=l2.tope then begin
             TextColor(LightCyan);
            WriteLn('OK: La lista se recorre correctamente.')
        end else begin
            TextColor(LightRed);
            WriteLn('ERROR: EspecieListaEspecies no retorna el indice indicado.');
        end;

        TextColor(White);
        WriteLn; Write('Presiona ENTER para finalizar.');
        ReadLn;
    end;
end.

