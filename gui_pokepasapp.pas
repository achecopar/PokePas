unit GUI_PokePasApp;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, LCLType, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Menus, DT_Pokedex, DT_Especie, DT_TipoElemental, Utilidades;

CONST
    MAX_NUMERO_ESPECIES= 1000;
type

  { TPokePas }

  TPokePas = class(TForm)
    Buscar: TButton;
    LogoPokePas: TImage;
    MainMenu: TMainMenu;
    Creador: TMenuItem;
    BattleCenter: TMenuItem;
    Aventura: TMenuItem;
    Acerca: TMenuItem;
    PanelPokePas: TPanel;
    Salir: TMenuItem;
    PokedexGeneral: TMenuItem;
    Bienvenida: TStaticText;
    Busqueda: TEdit;
    ImagenPokemon: TImage;
    Inicio: TMenuItem;
    Info: TStaticText;
    txtCrecimiento: TEdit;
    txtPS: TEdit;
    txtDEF: TEdit;
    txtDEFSp: TEdit;
    txtRATIO: TEdit;
    txtPSE: TEdit;
    txtVELE: TEdit;
    txtATKE: TEdit;
    txtATKSpE: TEdit;
    txtDEFE: TEdit;
    txtDEFSpE: TEdit;
    Id: TEdit;
    Nombre: TEdit;
    Tipo: TEdit;
    txtVEL: TEdit;
    txtAMISTAD: TEdit;
    txtATK: TEdit;
    txtATKSp: TEdit;
    txtEXP: TEdit;
    Pokemon: TGroupBox;
    Estadisticas: TGroupBox;
    Esfuerzo: TGroupBox;
    Crecimiento: TLabel;
    AMISTAD: TLabel;
    DEF: TLabel;
    DEFSp: TLabel;
    RATIO: TLabel;
    PSE: TLabel;
    VELE: TLabel;
    ATKE: TLabel;
    ATKSpE: TLabel;
    DEFE: TLabel;
    DEFSpE: TLabel;
    PS: TLabel;
    VEL: TLabel;
    EXP: TLabel;
    ATK: TLabel;
    ATKSp: TLabel;
    ListaEspecies: TListBox;
    MainMenu1: TMainMenu;
    PanelPokedex: TPanel;
    procedure AcercaClick(Sender: TObject);
    procedure AventuraClick(Sender: TObject);
    procedure BattleCenterClick(Sender: TObject);
    procedure BuscarClick(Sender: TObject);
    procedure CreadorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InicioClick(Sender: TObject);
    procedure ListaEspeciesClick(Sender: TObject);
    procedure ListaEspeciesKeyDown(Sender: TObject; var Key: Word);
    procedure PokedexGeneralClick(Sender: TObject);
    procedure SalirClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

  var
  PokePas: TPokePas;
  pokedexStart: BOOLEAN;
  pokedex: DatosPokedex;
  key: CHAR;

implementation

{$R *.lfm}

{ Controlador Pokedex }

    (*Devuelve TRUE si la pokedex ya fue iniciada, FALSE sino.*)
    FUNCTION PokedexStarted(): BOOLEAN; Begin
        PokedexStarted:= pokedexStart;
    end;

    (*Dibuja en pantalla los datos de la especie seleccionada,
  tal como se describe en los documentos.*)
  PROCEDURE DrawPokedex(p: DatosPokedex);
  VAR especieActual: Especie;
      tipo1, tipo2: STRING;
      i: INTEGER;
  BEGIN
      pokedex := p;
      especieActual:= EspecieSeleccionada(p);

      //Mostramos la imagen de la especie actual.
      PokePas.ImagenPokemon.Picture.LoadFromFile('Images\'+ NumeroEspecie(especieActual) + '.png');

      //Escribimos los datos específicos de esta especie.
      PokePas.Id.Caption    := '#' + NumeroEspecie(especieActual);
      PokePas.Nombre.Caption:= NombreEspecie(especieActual);

      tipo1:= NombreTipoElemental(ObtenerTipoElemental(TipoEspecie(1,especieActual),p));
      tipo2:= NombreTipoElemental(ObtenerTipoElemental(TipoEspecie(2,especieActual),p));

      IF tipo2<>'NULL' THEN
         PokePas.Tipo.Caption := tipo1+'/'+tipo2
      ELSE
         PokePas.Tipo.Caption := tipo1;


      // Escribimos las estadísticas base.
      PokePas.txtPS.Text         := IntToStr(EstadisticaEspecie(PS_Base,especieActual));
      PokePas.txtATK.Text        := IntToStr(EstadisticaEspecie(ATK_Base,especieActual));
      PokePas.txtDEF.Text        := IntToStr(EstadisticaEspecie(DEF_Base,especieActual));
      PokePas.txtVEL.Text        := IntToStr(EstadisticaEspecie(VEL_Base,especieActual));
      PokePas.txtATKSp.Text      := IntToStr(EstadisticaEspecie(ATKSp_Base,especieActual));
      PokePas.txtDEFSp.Text      := IntToStr(EstadisticaEspecie(DEFSp_Base,especieActual));
      PokePas.txtAMISTAD.Text    := IntToStr(EstadisticaEspecie(AMISTAD_Base,especieActual));
      PokePas.txtEXP.Text        := IntToStr(EstadisticaEspecie(EXP_Base,especieActual));
      PokePas.txtRATIO.Text      := IntToStr(EstadisticaEspecie(RatioCaptura,especieActual));

      //Escribimos los datos de puntos de efuerzo.
      PokePas.txtPSE.Text        := IntToStr(EstadisticaEspecie(PS_Esfuerzo,especieActual));
      PokePas.txtATKE.Text       := IntToStr(EstadisticaEspecie(ATK_Esfuerzo,especieActual));
      PokePas.txtDEFE.Text       := IntToStr(EstadisticaEspecie(DEF_Esfuerzo,especieActual));
      PokePas.txtVELE.Text       := IntToStr(EstadisticaEspecie(VEL_Esfuerzo,especieActual));
      PokePas.txtATKSpE.Text     := IntToStr(EstadisticaEspecie(ATKSp_Esfuerzo,especieActual));
      PokePas.txtDEFSpE.Text     := IntToStr(EstadisticaEspecie(DEFSp_Esfuerzo,especieActual));

      //Escribimos el tipo de crecimiento.
      PokePas.txtCrecimiento.Caption := CrecimientoEspecie(especieActual);

      //Dibujamos la lista de selección.
      if PokePas.ListaEspecies.Count = 0 then
         for i := 1 to MAX_NUMERO_ESPECIES do
            PokePas.ListaEspecies.Items.Add(NombreEspecie(EspecieListaEspecies(i,ListaDeEspecies(p))));

      PokePas.ListaEspecies.ClearSelection;
      PokePas.ListaEspecies.ItemIndex := IndiceEspecieSeleccionada(pokedex)-1;
  end;

  (*Inicia los datos de la pokedex cargando desde la base de datos.
    Se establece una bandera indicando que la pokedex ya fue iniciada.*)
    PROCEDURE StartPokedex(); Begin
        IF NOT PokedexStarted THEN Begin
            IniciarPokedex(pokedex);
            pokedexStart:= true;
            DrawPokedex(pokedex);
        End;
    end;

    procedure SeleccionarEspecie(i: INTEGER);
    begin
         WHILE i<IndiceEspecieSeleccionada(pokedex) do begin
               AnteriorEspecie(pokedex);
         end;

         WHILE i>IndiceEspecieSeleccionada(pokedex) do begin
               SiguienteEspecie(pokedex);
         end;

         DrawPokedex(pokedex);
    end;

{ TPokePas }

procedure TPokePas.FormCreate(Sender: TObject);
begin
     pokedexStart := false;
end;


procedure TPokePas.ListaEspeciesClick(Sender: TObject);
var i: INTEGER;
    flag : Boolean;
begin
  i := 0;
  flag := true;
  while (i < PokePas.ListaEspecies.Items.Count) and flag do
  begin
    if PokePas.ListaEspecies.Selected[i] then
    begin
        SeleccionarEspecie(BuscarEspecie(PokePas.ListaEspecies.Items[i],pokedex));
        flag := false;
    end;
    i := i + 1;
  end;
end;

procedure TPokePas.ListaEspeciesKeyDown(Sender: TObject; var Key: Word);
begin
     case Key of
            VK_DOWN:
                  Begin
                     DrawPokedex(pokedex);
                  end;
            VK_UP:
                  Begin
                      DrawPokedex(pokedex);
                  end;
        end;
end;


procedure TPokePas.BuscarClick(Sender: TObject);
var indiceEspecieBuscada : INTEGER;
begin
        indiceEspecieBuscada := BuscarEspecie(PokePas.Busqueda.Caption,pokedex);
        IF indiceEspecieBuscada=0 THEN Begin
           MessageDlg('No existe la especie buscada.',mtError, mbOKCancel, 0);
        end else begin
           SeleccionarEspecie(indiceEspecieBuscada);
        end;
        PokePas.Busqueda.Caption := '';
end;
{ Menu }

procedure TPokePas.InicioClick(Sender: TObject);
begin
  PokePas.PanelPokePas.Visible := true;
  PokePas.PanelPokedex.Visible := false;

  PokePas.Bienvenida.Caption := 'Bienvenido/a a PokePas V1.1 -- Elige una de las opciones del menú. ';
end;

procedure TPokePas.PokedexGeneralClick(Sender: TObject);
begin
  StartPokedex();
  PokePas.PanelPokePas.Visible := false;
  PokePas.PanelPokedex.Visible := true;

  PokePas.Info.Caption := 'Para buscar una especie, ingrese su número o nombre';
end;

procedure TPokePas.CreadorClick(Sender: TObject);
begin
  PokePas.PanelPokePas.Visible := true;
  PokePas.PanelPokedex.Visible := false;

  PokePas.Bienvenida.Caption := 'LO SIENTO... AÚN NO HEMOS DESARROLLADO ESTA FUNCIONALIDAD';
end;

procedure TPokePas.BattleCenterClick(Sender: TObject);
begin
  PokePas.PanelPokePas.Visible := true;
  PokePas.PanelPokedex.Visible := false;

  PokePas.Bienvenida.Caption := 'LO SIENTO... AÚN NO HEMOS DESARROLLADO ESTA FUNCIONALIDAD';
end;

procedure TPokePas.AventuraClick(Sender: TObject);
begin
  PokePas.PanelPokePas.Visible := true;
  PokePas.PanelPokedex.Visible := false;

  PokePas.Bienvenida.Caption := 'LO SIENTO... AÚN NO HEMOS DESARROLLADO ESTA FUNCIONALIDAD';
end;

procedure TPokePas.AcercaClick(Sender: TObject);
begin
  PokePas.PanelPokePas.Visible := true;
  PokePas.PanelPokedex.Visible := false;

  PokePas.Bienvenida.Caption := 'PokePas es un proyecto independiente pensado para enseñar.' + LineEnding +
                                'Muchas gracias por formar parte de esta iniciativa.' + LineEnding +
                                'Espero te haya sido de utilidad ;-)  ' + LineEnding + LineEnding +
                                'Kyshuo Ayame - KAEduSoft 2015 - Proyecto independiente sin fines de lucro. '+ LineEnding +
                                'El uso que hagas de este proyecto y su código queda 100% bajo tu responsabilidad.';
end;

procedure TPokePas.SalirClick(Sender: TObject);
begin
  PokePas.Close;
end;

end.

