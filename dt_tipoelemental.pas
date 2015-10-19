UNIT DT_TipoElemental;

INTERFACE
    TYPE
        TipoElemental= RECORD
          id: INTEGER;
          nombre: STRING;
        end;

    PROCEDURE CrearTipoElemental(id: INTEGER; nombre: STRING; VAR t: TipoElemental); //Inicializa un tipo elemental.
    FUNCTION NombreTipoElemental(t: TipoElemental): STRING; //Retorna el nombre del tipo.
    FUNCTION IdTipoElemental(t: TipoElemental): INTEGER; //Retorna el Id del tipo.

IMPLEMENTATION
    PROCEDURE CrearTipoElemental(id: INTEGER; nombre: STRING; VAR t: TipoElemental);
    Begin
        t.id:= id;
        t.nombre:= nombre;
    End;//CrearTipoElemental
    //--------------------------------------------------------------------------
    FUNCTION NombreTipoElemental(t: TipoElemental): STRING; //Retorna el nombre del tipo.
    Begin
        NombreTipoElemental:= t.nombre;
    end;//NombreTipoElemental
    //--------------------------------------------------------------------------
    FUNCTION IdTipoElemental(t: TipoElemental): INTEGER; //Retorna el Id del tipo.
    Begin
        IdTipoElemental:= t.id;
    end;
    //--------------------------------------------------------------------------
END.

