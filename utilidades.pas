UNIT Utilidades;

INTERFACE
USES
  DT_Especie, DT_TipoElemental;

CONST
    MAX_NUMERO_ESPECIES= 1000;
    MAX_NUMERO_TIPOS_ELEMENTALES= 20;

TYPE
    (***************************************************
    * Tipo para manejar el listado de especies pokémon.*
    ***************************************************)
    ListaEspecies= RECORD
        lista: ARRAY[1..MAX_NUMERO_ESPECIES] OF Especie;
        tope: INTEGER;
    end;

    (***************************************************
    * Tipo para manejar el listado de tipos elementales*
    ***************************************************)
    ListaTiposElementales= RECORD
        lista: ARRAY[1..MAX_NUMERO_TIPOS_ELEMENTALES] OF TipoElemental;
        tope: INTEGER;
    end;

    (**********************************************************
    * Operaciones para manejar el listado de especies pokémon.*
    ***********************************************************)
    (*Inicia la lista como vacía*)
    PROCEDURE IniciarListaEspecies(VAR l: ListaEspecies);
    (*Agrega una especie al final de la lista.*)
    PROCEDURE AgregarEspecieListaEspecies(e: Especie; VAR l: ListaEspecies);
    (*Indica si la lista es vacía.*)
    FUNCTION EsVaciaListaEspecies(l: ListaEspecies): BOOLEAN;
    (*Retorna la especie del inicio de la lista. La lista no debe esar vacía.*)
    FUNCTION PrimeraEspecieListaEspecies(l: ListaEspecies): Especie;
    (*Indica si el índice pasado como argumento es válido.*)
    FUNCTION EsIndiceValidoListaEspecies(i: INTEGER; l: ListaEspecies): BOOLEAN;
    (*Retorna la especie del índice indicado. El índice debe ser válido.*)
    FUNCTION EspecieListaEspecies(indice: INTEGER; l: ListaEspecies): Especie;

    (**********************************************************
    * Operaciones para manejar el listado de tipos elementales*
    ***********************************************************)
    (*Inicia la lista como vacía*)
    PROCEDURE IniciarListaTiposElementales(VAR l: ListaTiposElementales);
    (*Agrega un tipo al final de la lista.*)
    PROCEDURE AgregarTipoListaTiposElementales(t: TipoElemental; VAR l: ListaTiposElementales);
    (*Indica si la lista es vacía.*)
    FUNCTION EsVaciaListaTiposElementales(l: ListaTiposElementales): BOOLEAN;
    (*Retorna el tipo del inicio de la lista. La lista no debe esar vacía.*)
    FUNCTION PrimerTipoListaTiposElementales(l: ListaTiposElementales): TipoElemental;
    (*Indica si el índice pasado como argumento es válido.*)
    FUNCTION EsIndiceValidoListaTiposElementales(i: INTEGER; l: ListaTiposElementales): BOOLEAN;
    (*Retorna el tipo del índice indicado. El índice debe ser válido.*)
    FUNCTION TipoListaTiposElementales(indice: INTEGER; l: ListaTiposElementales): TipoElemental;


IMPLEMENTATION
    (**********************************************************
    * Operaciones para manejar el listado de especies pokémon.*
    ***********************************************************)
    (*Inicia la lista como vacía*)
    PROCEDURE IniciarListaEspecies(VAR l: ListaEspecies);
    Begin
      l.tope := 0;
    end;

    (*Agrega una especie al final de la lista.*)
    PROCEDURE AgregarEspecieListaEspecies(e: Especie; VAR l: ListaEspecies);
    Begin
              l.tope := l.tope + 1;
              l.lista[l.tope] := e;
    end;

    (*Indica si la lista es vacía.*)
    FUNCTION EsVaciaListaEspecies(l: ListaEspecies): BOOLEAN;
    Begin
      EsVaciaListaEspecies := l.tope = 0;
    end;

    (*Retorna la especie del inicio de la lista. La lista no debe esar vacía.*)
    FUNCTION PrimeraEspecieListaEspecies(l: ListaEspecies): Especie;
    Begin
      PrimeraEspecieListaEspecies := l.lista[1];
    end;

    (*Indica si el índice pasado como argumento es válido.*)
    FUNCTION EsIndiceValidoListaEspecies(i: INTEGER; l: ListaEspecies): BOOLEAN;
    Begin
      EsIndiceValidoListaEspecies := l.tope >= i;
    end;

    (*Retorna la especie del índice indicado. El índice debe ser válido.*)
    FUNCTION EspecieListaEspecies(indice: INTEGER; l: ListaEspecies): Especie;
    BEGIN
      EspecieListaEspecies := l.lista[indice];
    end;

    (**********************************************************
    * Operaciones para manejar el listado de tipos elementales*
    ***********************************************************)
    (*Inicia la lista como vacía*)
    PROCEDURE IniciarListaTiposElementales(VAR l: ListaTiposElementales); Begin
              l.tope := 0;
    end;

    (*Agrega un tipo al final de la lista.*)
    PROCEDURE AgregarTipoListaTiposElementales(t: TipoElemental; VAR l: ListaTiposElementales); Begin
              l.tope := l.tope + 1;
              l.lista[l.tope] := t;
    end;

    (*Indica si la lista es vacía.*)
    FUNCTION EsVaciaListaTiposElementales(l: ListaTiposElementales): BOOLEAN; Begin
              EsVaciaListaTiposElementales := l.tope=0;
    end;

    (*Retorna el tipo del inicio de la lista. La lista no debe esar vacía.*)
    FUNCTION PrimerTipoListaTiposElementales(l: ListaTiposElementales): TipoElemental; Begin
                      PrimerTipoListaTiposElementales := l.lista[1];
    end;

    (*Indica si el índice pasado como argumento es válido.*)
    FUNCTION EsIndiceValidoListaTiposElementales(i: INTEGER; l: ListaTiposElementales): BOOLEAN; Begin
             EsIndiceValidoListaTiposElementales := (i < l.tope);

    end;

    (*Retorna el tipo del índice indicado. El índice debe ser válido.*)
    FUNCTION TipoListaTiposElementales(indice: INTEGER; l: ListaTiposElementales): TipoElemental;  Begin
         (* Ivana   *)
             if(indice<l.tope) then
                          TipoListaTiposElementales := l.lista[indice];
     (* TipoListaTiposElementales := l.lista[indice];   *)
    end;
end.

