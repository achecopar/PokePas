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
    PROCEDURE IniciarPokedex(VAR p: DatosPokedex);
    Begin
        with p do
             begin
               indiceDeSeleccion := 1;
               CargarListaEspecies(especies);
               CargarListaTiposElementales(tiposElementales);
             end;
    end;

    (*Devuelve la especie marcada por el selector.*)
    FUNCTION EspecieSeleccionada(p: DatosPokedex): Especie;
    Begin
        EspecieSeleccionada := EspecieListaEspecies(p.indiceDeSeleccion, p.especies)
    end;

    (*Mueve el selector a la siguiente especie en la lista. Si ya está seleccionada
    la última especie entonces no se hace nada.*)
    PROCEDURE SiguienteEspecie(VAR p: DatosPokedex);
    BEGIN
         if esIndiceValidoListaEspecies(p.indiceDeSeleccion + 1, p.especies)
            then p.indiceDeSeleccion := p.indiceDeSeleccion + 1;
    end;

    (*Mueve el selector a la especie anterior en la lista. Si ya está seleccionada
    la primera especie entonces no se hace nada.*)
    PROCEDURE AnteriorEspecie(VAR p: DatosPokedex);
    BEGIN
        if p.indiceDeSeleccion > 1
           then p.indiceDeSeleccion := p.indiceDeSeleccion - 1;
    end;

    (*Retorna la lista de especies.*)
    FUNCTION ListaDeEspecies(p: DatosPokedex): ListaEspecies;
    BEGIN
        ListaDeEspecies:= p.especies;
    end;

    (*Retorna el índice de la especie seleccionada en la lista.*)
    FUNCTION IndiceEspecieSeleccionada(p: DatosPokedex): INTEGER;
    BEGIN
        IndiceEspecieSeleccionada := IdEspecie(especieListaEspecies(p.indiceDeSeleccion,
                                                                    p.especies));
    end;

    (*Retorna un TipoElemental a partir de su número ID. Si no existe un tipo con
    el ID indicado se retorna el tipo NULL.*)
    FUNCTION ObtenerTipoElemental(id: INTEGER; p: DatosPokedex): TipoElemental;
    VAR i: INTEGER; t: TipoElemental;
    BEGIN
        i := 0;
        if not esIndiceValidoListaTiposElementales(id, p.tiposElementales)then
           begin
            repeat
                 i := i + 1;
                 t := TipoListaTiposElementales(i, p.tiposElementales);
            until upperCase(nombreTipoElemental(t)) = 'NULL';
            ObtenerTipoElemental := t;
           end
        else
          begin
            repeat
                 i := i + 1;
                 t := TipoListaTiposElementales(i, p.tiposElementales);
            until id = idTipoElemental(t);
            ObtenerTipoElemental := t;
          end;
    end;

    (*Busca una especie en la pokedex que tenga un número o un nombre igual al
    argumento pasado como parámetro. Si la encuentra retorna su índice, sino la
    encuentra retorna 0*)
    FUNCTION BuscarEspecie(numeroONombre: String; p: DatosPokedex): INTEGER;
    var i, indice: INTEGER;
        numONom, compNum, compNom: STRING;
    Begin
        numONom := lowerCase(numeroONombre);
        i := 1;
        indice := 0;
        while (indice = 0) and esIndiceValidoListaEspecies(i, p.especies) do
        begin
             compNum := lowerCase(nombreEspecie(especieListaEspecies(i, p.especies)));
             compNom := lowerCase(numeroEspecie(especieListaEspecies(i, p.especies)));
             if (numONom = compNum) or (numONom = compNom)
                then indice := (idEspecie(especieListaEspecies(i, p.especies)));
             i := i + 1;
        end;
        BuscarEspecie := indice;
    end;

END.

