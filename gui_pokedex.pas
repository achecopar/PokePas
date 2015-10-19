UNIT GUI_Pokedex;

{$mode objfpc}{$H+}

INTERFACE
USES
  Crt, DT_Pokedex, DT_Especie, DT_TipoElemental, Utilidades;

  (*Dibuja en pantalla los datos de la especie seleccionada, tal como se describe en los documentos.*)
  PROCEDURE DrawPokedex(p: DatosPokedex);

IMPLEMENTATION
  CONST XDatos= 39; //Línea inicial para describir los datos.
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

  PROCEDURE DrawList(currentInd: INTEGER; l: ListaEspecies); Begin
      TextColor(Cyan);
      GoToXY(XDatos,14); WriteLn('**************************************');
      GoToXY(XDatos,15); WriteLn('        LISTADO DE ESPECIES           ');
      GoToXY(XDatos,16); WriteLn('**************************************');
      GoToXY(XDatos,24); WriteLn('**************************************');
      GoToXY(XDatos,17); Write('|'); GoToXY(XDatos,18); Write('|'); GoToXY(XDatos,19); Write('|'); GoToXY(XDatos,20); Write('|');
      GoToXY(XDatos,21); Write('|'); GoToXY(XDatos,22); Write('|'); GoToXY(XDatos,23); Write('|');
      GoToXY(XDatos+38,17); Write('|'); GoToXY(XDatos+38,18); Write('|'); GoToXY(XDatos+38,19); Write('|'); GoToXY(XDatos+38,20); Write('|');
      GoToXY(XDatos+38,21); Write('|'); GoToXY(XDatos+38,22); Write('|'); GoToXY(XDatos+38,23); Write('|');

      IF currentInd<=3 THEN Begin
          IF currentInd=1 THEN TextColor(LightCyan) ELSE TextColor(LightBlue);
          GoToXY(XDatos+1,17); Write(NombreEspecie(EspecieListaEspecies(1,l)));
          IF currentInd=2 THEN TextColor(LightCyan) ELSE TextColor(LightBlue);
          GoToXY(XDatos+1,18); Write(NombreEspecie(EspecieListaEspecies(2,l)));
          IF currentInd=3 THEN TextColor(LightCyan) ELSE TextColor(LightBlue);
          GoToXY(XDatos+1,19); Write(NombreEspecie(EspecieListaEspecies(3,l)));

          TextColor(LightBlue);
          GoToXY(XDatos+1,20); Write(NombreEspecie(EspecieListaEspecies(4,l)));
          GoToXY(XDatos+1,21); Write(NombreEspecie(EspecieListaEspecies(5,l)));
          GoToXY(XDatos+1,22); Write(NombreEspecie(EspecieListaEspecies(6,l)));
          GoToXY(XDatos+1,23); Write(NombreEspecie(EspecieListaEspecies(7,l)));
      end else begin
          TextColor(Blue);
          GoToXY(XDatos+1,17); Write(NombreEspecie(EspecieListaEspecies(currentInd-3,l)));
          GoToXY(XDatos+1,18); Write(NombreEspecie(EspecieListaEspecies(currentInd-2,l)));
          GoToXY(XDatos+1,19); Write(NombreEspecie(EspecieListaEspecies(currentInd-1,l)));
          TextColor(LightCyan);
          GoToXY(XDatos+1,20); Write(NombreEspecie(EspecieListaEspecies(currentInd,l)));
          TextColor(LightBlue);
          GoToXY(XDatos+1,21); Write(NombreEspecie(EspecieListaEspecies(currentInd+1,l)));
          GoToXY(XDatos+1,22); Write(NombreEspecie(EspecieListaEspecies(currentInd+2,l)));
          GoToXY(XDatos+1,23); Write(NombreEspecie(EspecieListaEspecies(currentInd+3,l)));
      end;
  end;

  (*Dibuja en pantalla los datos de la especie seleccionada, tal como se describe en los documentos.*)
  PROCEDURE DrawPokedex(p: DatosPokedex);
  VAR colorActual: INTEGER;
      especieActual: Especie;
      tipo1, tipo2: STRING;
  BEGIN
      especieActual:= EspecieSeleccionada(p);

      TextBackground(Black);
      ClrScr; //Limpiamos la pantalla.

      //Dibujamos la especie actual con el color adecuado según su tipo primario.
      tipo1:= NombreTipoElemental(ObtenerTipoElemental(TipoEspecie(1,especieActual),p));
      tipo2:= NombreTipoElemental(ObtenerTipoElemental(TipoEspecie(2,especieActual),p));
      ColorTipoElemental(tipo1,colorActual);
      DrawPokemon(NumeroEspecie(especieActual),colorActual);

      //Escribimos los datos específicos de esta especie.
      TextColor(White);
      GoToXY(XDatos,1);
      Write('#'); Write(NumeroEspecie(especieActual));
      GoToXY(XDatos+7,1);
      Write(NombreEspecie(especieActual));
      GoToXY(XDatos+24,1);
      Write(tipo1);

      IF tipo2<>'NULL' THEN Begin
          Write('/'+tipo2);
      end;

      //Escribimos las estadísticas base.
      GoToXY(XDatos,3); Write('==========ESTADISTICAS BASE===========');
      GoToXY(XDatos,4); TextColor(DarkGray); Write('PS= '); TextColor(White); Write(EstadisticaEspecie(PS_Base,especieActual));
      GoToXY(XDatos+8,4); TextColor(DarkGray); Write('ATK= '); TextColor(White); Write(EstadisticaEspecie(ATK_Base,especieActual));
      GoToXY(XDatos+17,4); TextColor(DarkGray); Write('DEF= '); TextColor(White); Write(EstadisticaEspecie(DEF_Base,especieActual));
      GoToXY(XDatos+26,4); TextColor(DarkGray); Write('VEL= '); TextColor(White); Write(EstadisticaEspecie(VEL_Base,especieActual));
      GoToXY(XDatos,5); TextColor(DarkGray); Write('ATKSp= '); TextColor(White); Write(EstadisticaEspecie(ATKSp_Base,especieActual));
      GoToXY(XDatos+11,5); TextColor(DarkGray); Write('DEFSp= '); TextColor(White); Write(EstadisticaEspecie(DEFSp_Base,especieActual));
      GoToXY(XDatos+22,5); TextColor(DarkGray); Write('AMISTAD= '); TextColor(White); Write(EstadisticaEspecie(AMISTAD_Base,especieActual));
      GoToXY(XDatos,6); TextColor(DarkGray); Write('EXP= '); TextColor(White); Write(EstadisticaEspecie(EXP_Base,especieActual));
      GoToXY(XDatos+9,6); TextColor(DarkGray); Write('RATIO= '); TextColor(White); Write(EstadisticaEspecie(RatioCaptura,especieActual));

      //Escribimos los datos de puntos de efuerzo.
      GoToXY(XDatos,8); Write('==========PUNTOS DE ESFUERZO==========');
      GoToXY(XDatos,9); TextColor(DarkGray); Write('PS= '); TextColor(White); Write(EstadisticaEspecie(PS_Esfuerzo,especieActual));
      GoToXY(XDatos+8,9); TextColor(DarkGray); Write('ATK= '); TextColor(White); Write(EstadisticaEspecie(ATK_Esfuerzo,especieActual));
      GoToXY(XDatos+17,9); TextColor(DarkGray); Write('DEF= '); TextColor(White); Write(EstadisticaEspecie(DEF_Esfuerzo,especieActual));
      GoToXY(XDatos+26,9); TextColor(DarkGray); Write('VEL= '); TextColor(White); Write(EstadisticaEspecie(VEL_Esfuerzo,especieActual));
      GoToXY(XDatos,10); TextColor(DarkGray); Write('ATKSp= '); TextColor(White); Write(EstadisticaEspecie(ATKSp_Esfuerzo,especieActual));
      GoToXY(XDatos+11,10); TextColor(DarkGray); Write('DEFSp= '); TextColor(White); Write(EstadisticaEspecie(DEFSp_Esfuerzo,especieActual));

      //Escribimos el tipo de crecimiento.
      GoToXY(XDatos,12); TextColor(DarkGray); Write('CREMIENTO: '); TextColor(White); Write(CrecimientoEspecie(especieActual));

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

