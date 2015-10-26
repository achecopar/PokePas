program PokePasApp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  Crt, BaseDeDatos, Utilidades, DT_Especie, DT_TipoElemental, DT_Pokedex,
  GUI_PokePasApp, SysUtils;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;

  Application.CreateForm(TPokePas,PokePas);
  PokePas.Show;
  Application.Run;
end.
