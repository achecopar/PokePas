UNIT GUI_Pokedex;

{$mode objfpc}{$H+}

INTERFACE
USES
  Crt, DT_Pokedex, DT_Especie, DT_TipoElemental, Utilidades;

  (*Dibuja en pantalla los datos de la especie seleccionada,
  tal como se describe en los documentos.*)
  PROCEDURE DrawPokedex(p: DatosPokedex);

  (*Dibuja el fondo de la pokedex*)
  PROCEDURE DrawPokedexBackground();

IMPLEMENTATION
  CONST XDatos= 39; //Línea inicial para describir los datos.
        MAX_LEN_NAME = 20; //Longitud maxima del nombre de un pokemon.
        MAX_LEN_TYPE = 20; //Longitud maxima en pantalla de ambos tipos de un pokemon.

  (*Dibuja el fondo de la pokedex*)
  PROCEDURE DrawPokedexBackground();
  Begin
      TextBackground(Black);
      ClrScr; //Limpiamos la pantalla.

      TextColor(Cyan);
      GoToXY(XDatos,14); WriteLn('**************************************');
      GoToXY(XDatos,15); WriteLn('        LISTADO DE ESPECIES           ');
      GoToXY(XDatos,16); WriteLn('**************************************');
      GoToXY(XDatos,24); WriteLn('**************************************');
      GoToXY(XDatos,17); Write('|'); GoToXY(XDatos,18);
      Write('|'); GoToXY(XDatos,19); Write('|'); GoToXY(XDatos,20); Write('|');
      GoToXY(XDatos,21); Write('|'); GoToXY(XDatos,22);
      Write('|'); GoToXY(XDatos,23); Write('|');
      GoToXY(XDatos+38,17); Write('|'); GoToXY(XDatos+38,18);
      Write('|'); GoToXY(XDatos+38,19); Write('|'); GoToXY(XDatos+38,20); Write('|');
      GoToXY(XDatos+38,21); Write('|'); GoToXY(XDatos+38,22);
      Write('|'); GoToXY(XDatos+38,23); Write('|');

      //Escribimos las estadísticas base.
      TextColor(DarkGray);
      GoToXY(XDatos,3); Write('==========ESTADISTICAS BASE===========');
      GoToXY(XDatos,4); Write('PS=');
      GoToXY(XDatos+9,4); Write('ATK=');
      GoToXY(XDatos+19,4); Write('DEF=');
      GoToXY(XDatos+29,4); Write('VEL=');
      GoToXY(XDatos,5); Write('ATKSp=');
      GoToXY(XDatos+12,5); Write('DEFSp=');
      GoToXY(XDatos+24,5);  Write('AMISTAD=');
      GoToXY(XDatos,6); Write('EXP=');
      GoToXY(XDatos+10,6); Write('RATIO=');

      //Escribimos los datos de puntos de efuerzo.
      GoToXY(XDatos,8); Write('==========PUNTOS DE ESFUERZO==========');
      GoToXY(XDatos,9); Write('PS=');
      GoToXY(XDatos+8,9); Write('ATK=');
      GoToXY(XDatos+17,9); Write('DEF=');
      GoToXY(XDatos+26,9); Write('VEL=');
      GoToXY(XDatos,10); Write('ATKSp=');
      GoToXY(XDatos+11,10); Write('DEFSp=');

      //Escribimos el tipo de crecimiento.
      GoToXY(XDatos,12); Write('CREMIENTO:');
  end;

  (*Asigna el color correspondiente al tipo para dibujar el pokémon.*)
  PROCEDURE ColorTipoElemental(tipo: STRING; VAR c: INTEGER); Begin
      IF tipo='Acero' THEN c:= LightGray ELSE
      IF tipo='Agua' THEN c:= LightBlue ELSE
      IF tipo='Bicho' THEN c:= LightGreen ELSE
      IF tipo='Dragon' THEN c:= Red ELSE
      IF tipo='Electrico' THEN c:= Yellow ELSE
      IF tipo='Fantasma' THEN c:= DarkGray ELSE
      IF tipo='Fuego' THEN c:= LightRed ELSE
      IF tipo='Hada' THEN c:= LightMagenta ELSE
      IF tipo='Hielo' THEN c:= Cyan ELSE
      IF tipo='Lucha' THEN c:= Brown ELSE
      IF tipo='Normal' THEN c:= White ELSE
      IF tipo='Planta' THEN c:= Green ELSE
      IF tipo='Psiquico' THEN c:= Magenta ELSE
      IF tipo='Roca' THEN c:= LightGray ELSE
      IF tipo='Siniestro' THEN c:= Blue ELSE
      IF tipo='Tierra' THEN c:= Brown ELSE
      IF tipo='Veneno' THEN c:= Magenta ELSE
      IF tipo='Volador' THEN c:= LightGray ELSE
      IF tipo='NULL' THEN c:= DarkGray ELSE
      IF tipo='???' THEN c:= White;
  end;

  (*Dibuja el pokemon dado por el numero, con el color asignado.*)
  PROCEDURE DrawPokemon(numero: STRING; colorTipo: INTEGER);
  VAR i: INTEGER;
      imagen: Text;
      lineaDibujo: String;
  Begin
      assign(imagen, 'Images\'+numero+'.txt' );
      {$I-}
      reset(imagen);
      {$I+}
      IF IOResult<> 0 THEN BEGIN
        WriteLn('El archivo "'+'Images\'+numero+'.txt'+'" no existe.');
        WriteLn('Presiona ENTER para continuar.');
        ReadLn;
      end ELSE Begin
         TextColor(colorTipo);
         i:= 1;
         WHILE NOT EOF(imagen) DO Begin
             GoToXY(1,i);
             ReadLn(imagen,lineaDibujo);
             Write(lineaDibujo);
             i:= i+1;
         end;
         Close(imagen);
      end;
  end;

  PROCEDURE DrawList(currentInd: INTEGER; l: ListaEspecies);
  CONST spc = '                ';
  Begin
      IF currentInd<=3 THEN Begin
          IF currentInd=1 THEN TextColor(LightCyan) ELSE TextColor(LightBlue);
          GoToXY(XDatos+1,17); Write(NombreEspecie(EspecieListaEspecies(1,l)) + spc);
          IF currentInd=2 THEN TextColor(LightCyan) ELSE TextColor(LightBlue);
          GoToXY(XDatos+1,18); Write(NombreEspecie(EspecieListaEspecies(2,l)) + spc);
          IF currentInd=3 THEN TextColor(LightCyan) ELSE TextColor(LightBlue);
          GoToXY(XDatos+1,19); Write(NombreEspecie(EspecieListaEspecies(3,l)) + spc);

          TextColor(LightBlue);
          GoToXY(XDatos+1,20); Write(NombreEspecie(EspecieListaEspecies(4,l)) + spc);
          GoToXY(XDatos+1,21); Write(NombreEspecie(EspecieListaEspecies(5,l)) + spc);
          GoToXY(XDatos+1,22); Write(NombreEspecie(EspecieListaEspecies(6,l)) + spc);
          GoToXY(XDatos+1,23); Write(NombreEspecie(EspecieListaEspecies(7,l)) + spc);
      end else begin
          TextColor(Blue);
          GoToXY(XDatos+1,17); Write(NombreEspecie(EspecieListaEspecies(currentInd-3,l)) + spc);
          GoToXY(XDatos+1,18); Write(NombreEspecie(EspecieListaEspecies(currentInd-2,l)) + spc);
          GoToXY(XDatos+1,19); Write(NombreEspecie(EspecieListaEspecies(currentInd-1,l)) + spc);
          TextColor(LightCyan);
          GoToXY(XDatos+1,20); Write(NombreEspecie(EspecieListaEspecies(currentInd,l)) + spc);
          TextColor(LightBlue);
          GoToXY(XDatos+1,21); Write(NombreEspecie(EspecieListaEspecies(currentInd+1,l)) + spc);
          GoToXY(XDatos+1,22); Write(NombreEspecie(EspecieListaEspecies(currentInd+2,l)) + spc);
          GoToXY(XDatos+1,23); Write(NombreEspecie(EspecieListaEspecies(currentInd+3,l)) + spc);
      end;
  end;

  (*Dibuja en pantalla los datos de la especie seleccionada,
  tal como se describe en los documentos.*)
  PROCEDURE DrawPokedex(p: DatosPokedex);
  VAR colorActual: INTEGER;
      especieActual: Especie;
      tipo1, tipo2, name: STRING;
  BEGIN
      especieActual:= EspecieSeleccionada(p);

      //Dibujamos la especie actual con el color adecuado según su tipo primario.
      tipo1:= NombreTipoElemental(ObtenerTipoElemental(TipoEspecie(1,especieActual),p));
      tipo2:= NombreTipoElemental(ObtenerTipoElemental(TipoEspecie(2,especieActual),p));
      ColorTipoElemental(tipo1,colorActual);
      DrawPokemon(NumeroEspecie(especieActual),colorActual);

      //Escribimos los datos específicos de esta especie.
      TextColor(White);
      GoToXY(XDatos,1);
      Write('#' + NumeroEspecie(especieActual) + '    ');
      GoToXY(XDatos+7,1);
      name := NombreEspecie(especieActual);
      Write(name + stringOfChar(' ', MAX_LEN_NAME - length(name)));
      GoToXY(XDatos+24,1);
      Write(tipo1);

      IF tipo2<>'NULL' THEN Begin
          Write('/'+tipo2);
      end;
      Write(stringOfChar(' ', MAX_LEN_NAME - length(tipo1) - length(tipo2) + 5));

      TextColor(White);
      //Escribimos las estadísticas base.
      GoToXY(XDatos+4,4); Write(EstadisticaEspecie(PS_Base,especieActual), '  ');
      GoToXY(XDatos+14,4); Write(EstadisticaEspecie(ATK_Base,especieActual), '  ');
      GoToXY(XDatos+24,4); Write(EstadisticaEspecie(DEF_Base,especieActual), '  ');
      GoToXY(XDatos+34,4); Write(EstadisticaEspecie(VEL_Base,especieActual), '  ');
      GoToXY(XDatos+7,5); Write(EstadisticaEspecie(ATKSp_Base,especieActual), '  ');
      GoToXY(XDatos+19,5); Write(EstadisticaEspecie(DEFSp_Base,especieActual), '  ');
      GoToXY(XDatos+33,5); Write(EstadisticaEspecie(AMISTAD_Base,especieActual), '  ');
      GoToXY(XDatos+5,6); Write(EstadisticaEspecie(EXP_Base,especieActual), '  ');
      GoToXY(XDatos+17,6); Write(EstadisticaEspecie(RatioCaptura,especieActual), '  ');

      //Escribimos los datos de puntos de efuerzo.
      GoToXY(XDatos+4,9);  Write(EstadisticaEspecie(PS_Esfuerzo,especieActual), '  ');
      GoToXY(XDatos+13,9);  Write(EstadisticaEspecie(ATK_Esfuerzo,especieActual), '  ');
      GoToXY(XDatos+22,9);  Write(EstadisticaEspecie(DEF_Esfuerzo,especieActual), '  ');
      GoToXY(XDatos+31,9);  Write(EstadisticaEspecie(VEL_Esfuerzo,especieActual), '  ');
      GoToXY(XDatos+7,10);  Write(EstadisticaEspecie(ATKSp_Esfuerzo,especieActual), '  ');
      GoToXY(XDatos+18,10);  Write(EstadisticaEspecie(DEFSp_Esfuerzo,especieActual), '  ');

      //Escribimos el tipo de crecimiento.
      GoToXY(XDatos+23,12); Write(CrecimientoEspecie(especieActual), '    ');

      //Dibujamos la lista de selección.
      DrawList(IndiceEspecieSeleccionada(p),ListaDeEspecies(p));

      GoToXY(1,22);
      TextBackground(Blue); TextColor(Yellow);
      Write('  Presiona '); TextColor(white); Write('B');
      TextColor(Yellow); Write(' para buscar una especie  ');
      GoToXY(1,23);
      Write('                                      ');
      TextBackground(black);
  end;

end.

