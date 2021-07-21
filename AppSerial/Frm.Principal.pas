unit Frm.Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl, System.Actions, FMX.ActnList, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.Effects,
  Licenca.GeradorSerial, AppSerial.Dominio.TClientePED, FrmCadastro.Cliente, Licenca.Serial, AppSerial.Dao.IDAOClientePED, AppSerial.Dao.IDAOLicenca, AppSerial.Dominio.TAppFactory,
  FMX.VirtualKeyboard, FMX.PlatForm;

type
  TFrmPrincipal = class(TForm)
    tbcPrincipal: TTabControl;
    tabPrincipal: TTabItem;
    tabApoio: TTabItem;
    act1: TActionList;
    actChangeTab: TChangeTabAction;
    lytSuperior: TLayout;
    lytInferior: TLayout;
    lytBotao1: TLayout;
    RoundBotao1: TRoundRect;
    imgBotao1: TImage;
    lblTituloRotulo1: TLabel;
    lytTotulosBotao1: TLayout;
    lblDetalheRotulo1: TLabel;
    lytBotao2: TLayout;
    RoundRect1: TRoundRect;
    imgBotao2: TImage;
    lytRotulosBotao2: TLayout;
    lblDetalheBotao2: TLabel;
    lblTituloBotao2: TLabel;
    lytPrincipal: TLayout;
    actGeradorSerial: TAction;
    lytMenu: TLayout;
    img1: TImage;
    lbl1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure imgBotao2Click(Sender: TObject);
    procedure imgBotao1Click(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
    FActiveForm: TForm;
    procedure Detalhes;

  public
    procedure MudarAba(ATabItem: TTabItem; Sender: TObject);
    procedure AbrirForm(AFormClass: TComponentClass);
    procedure ActiveFormClose(Sender: TObject; var Action: TCloseAction);

    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}


procedure TFrmPrincipal.ActiveFormClose(Sender: TObject; var Action: TCloseAction);
begin
  MudarAba(tabPrincipal,sender);
end;

procedure TFrmPrincipal.btnVoltarClick(Sender: TObject);
begin
  MudarAba(tabPrincipal, self);
end;

procedure TFrmPrincipal.Detalhes;
var
  DaoLicenca: IDAOLicenca;
  DaoCliente: IDAOClientePED;
begin
  DaoLicenca := TAppFactory.DAOLicencaPED;
  DaoCliente := TAppFactory.DAOClientePED;

  lblDetalheRotulo1.Text := Format('%d  Clientes Cadastrados', [DaoCliente.Count]);
  lblDetalheBotao2.Text := Format('%d Licenças Ativas', [DaoLicenca.CountAtivas]);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  tbcPrincipal.ActiveTab := tabPrincipal;
  tbcPrincipal.TabPosition := TTabPosition.None;

  lytSuperior.Height := self.ClientHeight * 0.6;
  Detalhes();
end;

procedure TFrmPrincipal.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
var
  FService: IFMXVirtualKeyboardService;
begin
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));
    if (FService <> nil) { and (vksVisible in FService.VirtualKeyBoardState) } then
    begin
      // Back button pressed, keyboard visible, so do nothing...
    end
    else
    begin
      // Back button pressed, keyboard not visible or not supported on this platform, lets exit the app...
      if MessageDlg('Exit Application?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbOK, TMsgDlgBtn.mbCancel], -1) = mrOK then
      begin
        // Exit application here...
      end
      else
      begin
        // They changed their mind, so ignore the Back button press...
        Key := 0;
      end;
    end;
  end

end;

procedure TFrmPrincipal.imgBotao1Click(Sender: TObject);
begin
  AbrirForm(TFrmCadastroClientes);

end;

procedure TFrmPrincipal.imgBotao2Click(Sender: TObject);
begin
  AbrirForm(TFrmGeraSerial);
  // FrmGeradorSerial := TFrmGeradorSerial.Create(self);
  // FrmGeradorSerial.Show;
  // FrmGeradorSerial.Free;
end;

procedure TFrmPrincipal.AbrirForm(AFormClass: TComponentClass);
var
  layoutBase: TComponent;
  Botao: TControl;
begin

  if Assigned(FActiveForm) then
  begin
    if FActiveForm.ClassType = AFormClass then
    begin
      MudarAba(tabApoio, self);
      Exit;
    end
    else
    begin
{$IF DEFINED(iOS) or DEFINED(ANDROID)}
      FActiveForm.Close;
      FActiveForm.DisposeOf;
      FActiveForm := nil;
{$ELSE}
      FActiveForm.Close;
      FActiveForm := nil;
{$ENDIF}
    end;
  end;

  Application.CreateForm(AFormClass, FActiveForm);

  layoutBase := FActiveForm.FindComponent('lytBase');

  if Assigned(layoutBase) then
  begin
    lytPrincipal.AddObject(TLayout(layoutBase));
    MudarAba(tabApoio, self);
    FActiveForm.OnClose :=  ActiveFormClose;
  end;

  // Botao := FActiveForm.FindComponent('btnMaster');
  // if Assigned(botao) then
  // mlv.MasterButton := Tcontrol(Botao);

end;

procedure TFrmPrincipal.MudarAba(ATabItem: TTabItem; Sender: TObject);
begin
  actChangeTab.Tab := ATabItem;
  actChangeTab.ExecuteTarget(Sender);
end;

end.
