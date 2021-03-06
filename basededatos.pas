UNIT BaseDeDatos;
(*******************************************************************************
La presente unidad tiene como objetivo realizar la conexión a la base de datos
del sistema y retornar datos desde ella. La base de datos tendrá por nombre la
cadena dada por la constante DATABASE_NAME y deberá estar almacenada en el mismo
directorio donde del proyecto, y por ende, del ejecutable del sistema.
*******************************************************************************)

{$mode objfpc}{$H+}
INTERFACE
USES
      Classes, SysUtils, sqldb, sqlite3conn, Utilidades, DT_Especie,
      DT_TipoElemental;
CONST
     DATABASE_NAME= 'PKMNPas.db';
     CONNECTION_TYPE= 'SQLite3';

VAR //Interface
  Conn: TSQLConnector;   //Conector de la base de datos.
  Trans: TSQLTransaction;//Transacción o 'Statement'
  Query: TSQLQuery;       //Consultor de la base de datos.



  FUNCTION GetConnection(): TSQLConnector;   //Retorna la conección.
  FUNCTION GetTransaction(): TSQLTransaction;//Retorna la transacción.
  FUNCTION GetQuery(): TSQLQuery;            //Retorna la consulta.

  (****************************************************************************)
  (*                   OPERACIONES PARA LECTURA DE DATOS                      *)
  (****************************************************************************)
  (*Crea todas las especies pokemon y las asigna a 'l' a partir de los datos
  almacenados en la base de datos. La lista resultante estará ordenada según
  los números usados en la pokedex de los videojuegos. La lista original será
  sobreescrita.*)
  PROCEDURE CargarListaEspecies(VAR l: ListaEspecies);

  (*Crea un listado con todos los tipos elementales del juego y lo asigna a 'l'.
  La lista resultante estará ordenada alfabéticamente. La lista original será
  sobreescrita.*)
  PROCEDURE CargarListaTiposElementales(VAR l: ListaTiposElementales);

IMPLEMENTATION
  FUNCTION GetConnection(): TSQLConnector; Begin
      GetConnection:= Conn;
  End; //GetConnection

  FUNCTION GetTransaction(): TSQLTransaction; Begin
     GetTransaction:= Trans;
  End; //GetTrasaction

  FUNCTION GetQuery(): TSQLQuery; Begin
      GetQuery:= Query;
  End; //GetQuery

  (****************************************************************************)
  (*                   OPERACIONES PARA LECTURA DE DATOS                      *)
  (****************************************************************************)
  (*Crea todas las especies pokemon y las asigna a 'l' a partir de los datos
  almacenados en la base de datos. La lista resultante estará ordenada según
  los números usados en la pokedex de los videojuegos.*)
  PROCEDURE CargarListaEspecies(VAR l: ListaEspecies);
  VAR e: Especie; //Especie auxiliar.
  Begin
      IniciarListaEspecies(l);

      Query.SQL.Text:= 'SELECT Especies.*, TiposDeCrecimiento.Nombre NombreCrecimiento FROM Especies, TiposDeCrecimiento WHERE Especies.TipoCrecimiento=TiposDeCrecimiento.TIPOS_DE_CRECIMIENTO_ID ORDER BY Especies.ESPECIE_ID';
      Query.Open;

      WHILE NOT Query.EOF DO Begin
        WITH e DO begin
           id:= Query.FieldByName('ESPECIE_ID').AsInteger;
           Numero:= Query.FieldByName('Numero').AsString;
           Nombre:= Query.FieldByName('Nombre').AsString;
           PS_Base:= Query.FieldByName('PS_Base').AsInteger;
           ATK_Base:= Query.FieldByName('ATK_Base').AsInteger;
           DEF_Base:= Query.FieldByName('DEF_Base').AsInteger;
           ATKSp_Base:= Query.FieldByName('ATKSp_Base').AsInteger;
           DEFSp_Base:= Query.FieldByName('DEFSp_Base').AsInteger;
           VEL_Base:= Query.FieldByName('VEL_Base').AsInteger;
           AMISTAD_Base:= Query.FieldByName('AMISTAD_Base').AsInteger;
           EXP_Base:= Query.FieldByName('EXP_Base').AsInteger;
           PS_Esfuerzo:= Query.FieldByName('PS_Esfuerzo').AsInteger;
           ATK_Esfuerzo:= Query.FieldByName('ATK_Esfuerzo').AsInteger;
           DEF_Esfuerzo:= Query.FieldByName('DEF_Esfuerzo').AsInteger;
           VEL_Esfuerzo:= Query.FieldByName('VEL_Esfuerzo').AsInteger;
           ATKSp_Esfuerzo:= Query.FieldByName('ATKSp_Esfuerzo').AsInteger;
           DEFSp_Esfuerzo:= Query.FieldByName('DEFSp_Esfuerzo').AsInteger;
           Crecimiento:= Query.FieldByName('NombreCrecimiento').AsString;
           Tipo1:= Query.FieldByName('Tipo1').AsInteger;
           Tipo2:= Query.FieldByName('Tipo2').AsInteger;
           RatioCaptura:= Query.FieldByName('RatioCaptura').AsInteger;
        end;

        AgregarEspecieListaEspecies(e,l);
        Query.Next;
      end;
      Query.Close;
  End;

  (*Crea un listado con todos los tipos elementales del juego y lo asigna a 'l'.
  La lista resultante estará ordenada alfabéticamente. La lista original será
  sobreescrita.*)
  PROCEDURE CargarListaTiposElementales(VAR l: ListaTiposElementales);
  VAR t: TipoElemental; //TipoElemental auxiliar.
  Begin
      IniciarListaTiposElementales(l);

      Query.SQL.Text:= 'SELECT * FROM TiposElementales';
      Query.Open;

      WHILE NOT Query.EOF DO Begin
        WITH t DO begin
           id:= Query.FieldByName('TYPE_ID').AsInteger;
           nombre:= Query.FieldByName('Nombre').AsString;
        end;

        AgregarTipoListaTiposElementales(t,l);
        Query.Next;
      end;
      Query.Close;
  end;



BEGIN //MAIN Código de inicialización ******************************************
  Conn := TSQLConnector.Create(nil);
  with Conn do begin
    ConnectorType := CONNECTION_TYPE;
    HostName := ''; // not important
    DatabaseName := DATABASE_NAME;
    UserName := ''; // not important
    Password := ''; // not important
  end;

  Trans := TSQLTransaction.Create(nil);
  Conn.Transaction := Trans;

  Query := TSQLQuery.Create(nil);
  Query.DataBase := Conn;

END.//**************************************************************************
