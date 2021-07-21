unit FrmCadastro.Base;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, System.Actions, FMX.ActnList, FMX.TabControl, FMX.Controls, FMX.Types, FMX.Layouts,
  FMX.Forms, FMX.Graphics, FMX.StdActns, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TFrmCadastroBase = class(TForm)
    lytBase: TLayout;
    tbcPrincipal: TTabControl;
    tabListagem: TTabItem;
    tabEdicao: TTabItem;
    act1: TActionList;
    actChangeTab: TChangeTabAction;
    tlbListagem: TToolBar;
    btn4: TSpeedButton;
    actFecharForm: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actFecharFormExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MudarAba(ATabItem: TTabItem; Sender: TObject);
    { Public declarations }

  end;

var
  FrmCadastroBase: TFrmCadastroBase;

implementation

{$R *.fmx}

{ TFrmCadastroBase }

procedure TFrmCadastroBase.actFecharFormExecute(Sender: TObject);
begin
    Close;
end;

procedure TFrmCadastroBase.FormCreate(Sender: TObject);
var
  I: Integer;
  ajustes: ITextSettings;
begin
{$IF DEFINED(WIN32)}
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if IInterface(Self.Components[I]).QueryInterface(ITextSettings, ajustes) = S_OK then
    begin
      ajustes.TextSettings.BeginUpdate;
      ajustes.TextSettings.FontColor := TAlphaColorRec.Black;
      ajustes.TextSettings.EndUpdate;
    end;
  end;
{$ENDIF}
end;

procedure TFrmCadastroBase.MudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  actChangeTab.Tab := ATabItem;
  actChangeTab.ExecuteTarget(Sender);
end;

end.
