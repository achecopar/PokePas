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
    e.id := id;
    e.numero := numero;
    e.nombre := nombre;
    e.tipo1 := tipo1;
    e.tipo2 := tipo2;
    e.PS_Base := PS_Base;
    e.ATK_Base := ATK_Base;
    e.DEF_Base := DEF_Base;
    e.ATKSp_Base := ATKSp_Base;
    e.DEFSp_Base := DEFSp_Base;
    e.VEL_Base := VEL_Base;
    e.AMISTAD_Base := AMISTAD_Base;
    e.EXP_Base := EXP_Base;
    e.PS_Esfuerzo := PS_Esfuerzo;
    e.ATK_Esfuerzo := ATK_Esfuerzo;
    e.DEF_Esfuerzo := DEF_Esfuerzo;
    e.ATKSp_Esfuerzo := ATKSp_Esfuerzo;
    e.DEFSp_Esfuerzo := DEFSp_Esfuerzo;
    e.VEL_Esfuerzo := VEL_Esfuerzo;
    e.Crecimiento := Crecimiento;
    e.RatioCaptura := RatioCaptura;
  end;

  (*Retorna el Id de la especie dada.*)
  FUNCTION IdEspecie(e: Especie): INTEGER;
  Begin
    IdEspecie := e.id;
  end;

  (*Retorna el número de la especie dada.*)
  FUNCTION NumeroEspecie(e: Especie): STRING;
  Begin
    NumeroEspecie := e.numero;
  end;

  (*Retorna el nombre de la especie dada.*)
  FUNCTION NombreEspecie(e: Especie): STRING;
  Begin
    NombreEspecie := e.nombre;
  end;

  (*Si t es 1 retorna el Tipo Primario de la especie, si t es 2 retorna el Tipo
  Secundario de la especie.*)
  FUNCTION TipoEspecie(t: RangoTiposElementales; e: Especie): INTEGER;
  Begin
    if t = 1 then TipoEspecie := e.tipo1
    else TipoEspecie := e.tipo2;
  end;

  (*Retorna una de las estadísticas de la especie 'e' según el valor pasado en el
  argumento 'estadistica'. Los posibles valores dicho argumento son las constantes
  definidas en esta unidad: PS_Base, ATK_Base, DEF_Base, ATKSp_Base, DEFSp_Base,
  VEL_Base, AMISTAD_Base, EXP_Base, PS_Esfuerzo, ATK_Esfuerzo, DEF_Esfuerzo,
  ATKSp_Esfuerzo, DEFSp_Esfuerzo, VEL_Esfuerzo, RatioCaptura.*)
  FUNCTION EstadisticaEspecie(estadistica: RangoEstadisticasEspecie; e: Especie): INTEGER;
  Begin
    case estadistica of
         PS_Base: EstadisticaEspecie := e.PS_Base;
         ATK_Base: EstadisticaEspecie := e.ATK_Base;
         DEF_Base: EstadisticaEspecie := e.DEF_Base;
         ATKSp_Base: EstadisticaEspecie := e.ATKSp_Base;
         DEFSp_Base: EstadisticaEspecie := e.DEFSp_Base;
         VEL_Base: EstadisticaEspecie := e.VEL_Base;
         AMISTAD_Base: EstadisticaEspecie := e.AMISTAD_Base;
         EXP_Base: EstadisticaEspecie := e.EXP_Base;
         PS_Esfuerzo: EstadisticaEspecie := e.PS_Esfuerzo;
         ATK_Esfuerzo: EstadisticaEspecie := e.ATK_Esfuerzo;
         DEF_Esfuerzo: EstadisticaEspecie := e.DEF_Esfuerzo;
         ATKSp_Esfuerzo: EstadisticaEspecie := e.ATKSp_Esfuerzo;
         DEFSp_Esfuerzo: EstadisticaEspecie := e.DEFSp_Esfuerzo;
         VEL_Esfuerzo: EstadisticaEspecie := e.VEL_Esfuerzo;
         RatioCaptura: EstadisticaEspecie := e.RatioCaptura;
    end;
  end;

  (*Devuelve el tipo de crecimiento de la especie pudiendo ser 'RAPIDO', 'NORMAL',
  'LENTO', 'ERRÁTICO', 'FLUCTUANTE' o 'PARABOLICO'.*)
  FUNCTION CrecimientoEspecie(e: Especie): STRING;
  Begin
    CrecimientoEspecie := e.Crecimiento;
  end;

end.

