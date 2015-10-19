UNIT DT_Especie;

INTERFACE

CONST
    (*Constantes definidas para la operación EstadisticaEspecie. Según el
    argumento pasado será el resultado que la operación retorne.*)
    PS_Base= 1;
    ATK_Base= 2;
    DEF_Base=3 ;
    ATKSp_Base= 4;
    DEFSp_Base= 5;
    VEL_Base= 6;
    AMISTAD_Base= 7;
    EXP_Base= 8;
    PS_Esfuerzo= 9;
    ATK_Esfuerzo= 10;
    DEF_Esfuerzo= 11;
    ATKSp_Esfuerzo= 12;
    DEFSp_Esfuerzo= 13;
    VEL_Esfuerzo= 14;
    RatioCaptura= 15;

  TYPE
      Especie= RECORD
          Id: INTEGER;
          Numero: STRING;
          Nombre: STRING;
          Tipo1: INTEGER;
          Tipo2: INTEGER;
          PS_Base: INTEGER;
          ATK_Base: INTEGER;
          DEF_Base: INTEGER;
          ATKSp_Base: INTEGER;
          DEFSp_Base: INTEGER;
          VEL_Base: INTEGER;
          AMISTAD_Base: INTEGER;
          EXP_Base: INTEGER;
          PS_Esfuerzo: INTEGER;
          ATK_Esfuerzo: INTEGER;
          DEF_Esfuerzo: INTEGER;
          ATKSp_Esfuerzo: INTEGER;
          DEFSp_Esfuerzo: INTEGER;
          VEL_Esfuerzo: INTEGER;
          Crecimiento: STRING;
          RatioCaptura: INTEGER;
      end;

      RangoTiposElementales= 1..2; //Para el argumento 't' de la operación TipoEspecie.
      RangoEstadisticasEspecie= 1..15; //Para el argumento 'estadistica' de la operacion EstadisticaEspecie.


  (*Crea una Especie Pokemon a partir de los argumentos pasados como parámetro y la retorna.
  El Tipo Secundario para especies sin tipo secundario será 'NULL'.*)
  PROCEDURE CrearEspecie(id: INTEGER; numero, nombre: STRING; tipo1, tipo2, PS_Base,
    ATK_Base, DEF_Base, ATKSp_Base, DEFSp_Base, VEL_Base, AMISTAD_Base, EXP_Base,
    PS_Esfuerzo, ATK_Esfuerzo, DEF_Esfuerzo, ATKSp_Esfuerzo, DEFSp_Esfuerzo,
    VEL_Esfuerzo: INTEGER; Crecimiento: STRING; RatioCaptura: INTEGER; VAR e: Especie);

  (*Retorna el Id de la especie dada.*)
  FUNCTION IdEspecie(e: Especie): INTEGER;

  (*Retorna el número de la especie dada.*)
  FUNCTION NumeroEspecie(e: Especie): STRING;

  (*Retorna el nombre de la especie dada.*)
  FUNCTION NombreEspecie(e: Especie): STRING;

  (*Si t es 1 retorna el Tipo Primario de la especie, si t es 2 retorna el Tipo
  Secundario de la especie.*)
  FUNCTION TipoEspecie(t: RangoTiposElementales; e: Especie): INTEGER;

  (*Retorna una de las estadísticas de la especie 'e' según el valor pasado en el
  argumento 'estadistica'. Los posibles valores dicho argumento son las constantes
  definidas en esta unidad: PS_Base, ATK_Base, DEF_Base, ATKSp_Base, DEFSp_Base,
  VEL_Base, AMISTAD_Base, EXP_Base, PS_Esfuerzo, ATK_Esfuerzo, DEF_Esfuerzo,
  ATKSp_Esfuerzo, DEFSp_Esfuerzo, VEL_Esfuerzo, RatioCaptura.*)
  FUNCTION EstadisticaEspecie(estadistica: RangoEstadisticasEspecie; e: Especie): INTEGER;

  (*Devuelve el tipo de creicmiento de la especie pudiendo ser 'RAPIDO', 'NORMAL',
  'LENTO', 'ERRÁTICO', 'FLUCTUANTE' o 'PARABOLICO'.*)
  FUNCTION CrecimientoEspecie(e: Especie): STRING;

IMPLEMENTATION
  (*Crea una Especie Pokemon a partir de los argumentos pasados como parámetro y la retorna.
  El Tipo Secundario para especies sin tipo secundario será 'NULL'.*)
  PROCEDURE CrearEspecie(id: INTEGER; numero, nombre: STRING; tipo1, tipo2, PS_Base,
    ATK_Base, DEF_Base, ATKSp_Base, DEFSp_Base, VEL_Base, AMISTAD_Base, EXP_Base,
    PS_Esfuerzo, ATK_Esfuerzo, DEF_Esfuerzo, ATKSp_Esfuerzo, DEFSp_Esfuerzo,
    VEL_Esfuerzo: INTEGER; Crecimiento: STRING; RatioCaptura: INTEGER; VAR e: Especie);
  Begin

  end;

  (*Retorna el Id de la especie dada.*)
  FUNCTION IdEspecie(e: Especie): INTEGER;
  Begin

  end;

  (*Retorna el número de la especie dada.*)
  FUNCTION NumeroEspecie(e: Especie): STRING;
  Begin

  end;

  (*Retorna el nombre de la especie dada.*)
  FUNCTION NombreEspecie(e: Especie): STRING;
  Begin

  end;

  (*Si t es 1 retorna el Tipo Primario de la especie, si t es 2 retorna el Tipo
  Secundario de la especie.*)
  FUNCTION TipoEspecie(t: RangoTiposElementales; e: Especie): INTEGER;
  Begin

  end;

  (*Retorna una de las estadísticas de la especie 'e' según el valor pasado en el
  argumento 'estadistica'. Los posibles valores dicho argumento son las constantes
  definidas en esta unidad: PS_Base, ATK_Base, DEF_Base, ATKSp_Base, DEFSp_Base,
  VEL_Base, AMISTAD_Base, EXP_Base, PS_Esfuerzo, ATK_Esfuerzo, DEF_Esfuerzo,
  ATKSp_Esfuerzo, DEFSp_Esfuerzo, VEL_Esfuerzo, RatioCaptura.*)
  FUNCTION EstadisticaEspecie(estadistica: RangoEstadisticasEspecie; e: Especie): INTEGER;
  Begin

  end;

  (*Devuelve el tipo de creicmiento de la especie pudiendo ser 'RAPIDO', 'NORMAL',
  'LENTO', 'ERRÁTICO', 'FLUCTUANTE' o 'PARABOLICO'.*)
  FUNCTION CrecimientoEspecie(e: Especie): STRING;
  Begin

  end;

end.

