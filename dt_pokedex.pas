UNIT DT_Pokedex;

INTERFACE
USES
  Utilidades, BaseDeDatos, DT_Especie, DT_TipoElemental, SysUtils;

TYPE
    DatosPokedex= RECORD
        especies: ListaEspecies;
        tiposElementales: ListaTiposElementales;
        indiceDeSeleccion: INTEGER;
    end;

    (*Carga desde la base de datos las listas de especies y tipos elementales. Se
    establece además el índice de selección (selector) en 1*)
    PROCEDURE IniciarPokedex(VAR p: DatosPokedex);
    (*Devuelve la especie marcada por el selector.*)
    FUNCTION EspecieSeleccionada(p: DatosPokedex): Especie;
    (*Mueve el selector a la siguiente especie en la lista. Si ya está seleccionada
    la última especie entonces no se hace nada.*)
    PROCEDURE SiguienteEspecie(VAR p: DatosPokedex);
    (*Mueve el selector a la especie anterior en la lista. Si ya está seleccionada
    la primera especie entonces no se hace nada.*)
    PROCEDURE AnteriorEspecie(VAR p: DatosPokedex);
    (*Retorna la lista de especies.*)
    FUNCTION ListaDeEspecies(p: DatosPokedex): ListaEspecies;
    (*Retorna el índice de la especie seleccionada en la lista.*)
    FUNCTION IndiceEspecieSeleccionada(p: DatosPokedex): INTEGER;
    (*Retorna un TipoElemental a partir de su número ID. Si no existe un tipo con
    el ID indicado se retorna el tipo NULL.*)
    FUNCTION ObtenerTipoElemental(id: INTEGER; p: DatosPokedex): TipoElemental;
    (*Busca una especie en la pokedex que tenga un número o un nombre igual al
    argumento pasado como parámetro. Si la encuentra retorna su índice, sino la
    encuentra retorna -1*)
    FUNCTION BuscarEspecie(numeroONombre: String; p: DatosPokedex): INTEGER;


IMPLEMENTATION

    (*Carga desde la base de datos las listas de especies y tipos elementales. Se
    establece además el índice de selección (selector) en 1*)
    PROCEDURE IniciarPokedex(VAR p: DatosPokedex); Begin

    end;

    (*Devuelve la especie marcada por el selector.*)
    FUNCTION EspecieSeleccionada(p: DatosPokedex): Especie; Begin

    end;

    (*Mueve el selector a la siguiente especie en la lista. Si ya está seleccionada
    la última especie entonces no se hace nada.*)
    PROCEDURE SiguienteEspecie(VAR p: DatosPokedex); BEGIN

    end;

    (*Mueve el selector a la especie anterior en la lista. Si ya está seleccionada
    la primera especie entonces no se hace nada.*)
    PROCEDURE AnteriorEspecie(VAR p: DatosPokedex); BEGIN

    end;

    (*Retorna la lista de especies.*)
    FUNCTION ListaDeEspecies(p: DatosPokedex): ListaEspecies; BEGIN
        ListaDeEspecies:= p.especies;
    end;

    (*Retorna el índice de la especie seleccionada en la lista.*)
    FUNCTION IndiceEspecieSeleccionada(p: DatosPokedex): INTEGER; BEGIN

    end;

    (*Retorna un TipoElemental a partir de su número ID. Si no existe un tipo con
    el ID indicado se retorna el tipo NULL.*)
    FUNCTION ObtenerTipoElemental(id: INTEGER; p: DatosPokedex): TipoElemental;
    VAR i: INTEGER; t: TipoElemental;
    BEGIN

    end;

    (*Busca una especie en la pokedex que tenga un número o un nombre igual al
    argumento pasado como parámetro. Si la encuentra retorna su índice, sino la
    encuentra retorna 0*)
    FUNCTION BuscarEspecie(numeroONombre: String; p: DatosPokedex): INTEGER;
    Begin

    end;

END.

