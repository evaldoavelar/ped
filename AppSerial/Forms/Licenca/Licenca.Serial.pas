unit Licenca.Serial;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.DateUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, Data.Bind.GenData,
  FMX.Bind.GenData, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Objects, FMX.StdCtrls, FMX.ListView, FMX.ListView.Appearances,
  FMX.Layouts, FMX.MultiView, FMX.Memo, FMX.Bind.Navigator, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ListView.Adapters.Base,
  Util.TSerial, FMX.StdActns, FMX.MediaLibrary.Actions, Util.Funcoes, FrmCadastro.Base, FMX.TabControl, AppSerial.Dominio.TClientePED, AppSerial.Dao.IDAOClientePED,
  AppSerial.Dominio.TAppFactory,
  AppSerial.Dominio.TLicencaPED, FMX.VirtualKeyboard, FMX.PlatForm,
  AppSerial.Dao.IDAOLicenca, FMX.Menus, FMX.ListBox, FMX.Gestures;

type
  TFrmGeraSerial = class(TFrmCadastroBase)
    DGClientes: TDataGeneratorAdapter;
    AdapterClientes: TAdapterBindSource;
    lvListagemItem: TListView;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Layout4: TLayout;
    Layout5: TLayout;
    Label1: TLabel;
    edtDataInicio: TDateEdit;
    Layout8: TLayout;
    Layout9: TLayout;
    Label3: TLabel;
    edtFim: TDateEdit;
    Layout6: TLayout;
    Layout7: TLayout;
    lblSerial: TLabel;
    actGerarLicenca: TAction;
    btn1: TButton;
    tlb1: TToolBar;
    btnVoltarListagem: TSpeedButton;
    SpeedButton1: TSpeedButton;
    DGLicencas: TDataGeneratorAdapter;
    tabListagemLicencas: TTabItem;
    ToolBar1: TToolBar;
    btnVoltarEdicao: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label2: TLabel;
    lvListagemLicencas: TListView;
    AdapterLicencas: TAdapterBindSource;
    LinkListControlToField2: TLinkListControlToField;
    actNovaLicenca: TAction;
    ShowShareSheetAction1: TShowShareSheetAction;
    rec1: TRectangle;
    btn2: TSpeedButton;
    actDelete: TAction;
    lblTitulo: TLabel;
    btnSearch: TSpeedButton;
    procedure actGerarLicencaExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnVoltarListagemClick(Sender: TObject);
    procedure lvListagemItemItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure actNovaLicencaExecute(Sender: TObject);
    procedure btnVoltarEdicaoClick(Sender: TObject);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn2Click(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure lvListagemLicencasTap(Sender: TObject; const Point: TPointF);
  private
    FClientesPED: TObjectList<TClientePED>;
    FLicencasPED: TObjectList<TLicencaPED>;
    function GeraSerial: string;
    function RetornaCliente: TClientePED;

    function ListarCliente(): TObjectList<TClientePED>;
    procedure PesquisarClientes;
    procedure PesquisarLicencas;

    procedure Delete();
    function ListarLicencas: TObjectList<TLicencaPED>;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGeraSerial: TFrmGeraSerial;

implementation

uses
  System.TypInfo;

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}


procedure TFrmGeraSerial.PesquisarClientes();
begin
  AdapterClientes.Active := False;

  if Assigned(FClientesPED) then
    FreeAndNil(FClientesPED);

  FClientesPED := ListarCliente();

  AdapterClientes.Adapter := TListBindSourceAdapter<TClientePED>.create(Self, FClientesPED, True);
  AdapterClientes.Active := True;

end;

procedure TFrmGeraSerial.PesquisarLicencas;
begin
  AdapterLicencas.Active := False;

  if Assigned(FLicencasPED) then
    FreeAndNil(FLicencasPED);

  FLicencasPED := ListarLicencas();

  AdapterLicencas.Adapter := TListBindSourceAdapter<TLicencaPED>.create(Self, FLicencasPED, True);
  AdapterLicencas.Active := True;
end;

FUNCTION TFrmGeraSerial.ListarLicencas: TObjectList<TLicencaPED>;
var
  Dao: IDAOLicenca;
  Cliente: TClientePED;
begin
  Dao := TAppFactory.DAOLicencaPED();
  Cliente := RetornaCliente();
  result := Dao.Listar(Cliente.CODIGO);

end;

FUNCTION TFrmGeraSerial.ListarCliente: TObjectList<TClientePED>;
var
  Dao: IDAOClientePED;
begin
  Dao := TAppFactory.DAOClientePED();
  result := Dao.Listar();
end;

procedure TFrmGeraSerial.lvListagemItemItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  PesquisarLicencas;
  MudarAba(tabEdicao, Sender);
end;

procedure TFrmGeraSerial.lvListagemLicencasTap(Sender: TObject; const Point: TPointF);
begin
  inherited;
 ShowMessage('tap');
end;

procedure TFrmGeraSerial.actDeleteExecute(Sender: TObject);
begin
  inherited;
  Delete;
end;

procedure TFrmGeraSerial.actGerarLicencaExecute(Sender: TObject);
var
  Licenca: TLicencaPED;
  Cliente: TClientePED;
  Dao: IDAOLicenca;
begin
  inherited;
  try
    Cliente := RetornaCliente();

    Licenca := TLicencaPED.create;
    Licenca.CODIGOCLIENTE := Cliente.CODIGO;
    Licenca.DATAINICIO := edtDataInicio.Date;
    Licenca.VENCIMENTO := edtFim.Date;
    Licenca.DATAGERACAO := Now;
    Licenca.Serial := GeraSerial();

    lblSerial.Text := Licenca.Serial;

    Dao := TAppFactory.DAOLicencaPED();
    Dao.Salvar(Licenca);

    Licenca.Free;

    actGerarLicenca.Enabled := False;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

function TFrmGeraSerial.RetornaCliente(): TClientePED;
begin
  inherited;
  result := TClientePED(AdapterClientes.InternalAdapter.Current);
end;

procedure TFrmGeraSerial.ShowShareSheetAction1BeforeExecute(Sender: TObject);
var
  Svc: IFMXClipboardService;
begin

  inherited;
{$IFDEF MSWINDOWS}
  if TPlatformServices.Current.SupportsPlatformService(IFMXClipboardService, Svc) then
    Svc.SetClipboard(lblSerial.Text);

{$ELSE}
  if lblSerial.Text = '' then
    ShowMessage('Gere um serial primeiro')
  else
    ShowShareSheetAction1.TextMessage := lblSerial.Text;

{$ENDIF}
end;

procedure TFrmGeraSerial.btn2Click(Sender: TObject);
begin
  inherited;

  MessageDlg('Deseja excluir a licenca?',
    System.UITypes.TMsgDlgType.mtInformation,
    [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo], 0,
    procedure(const BotaoPressionado: TModalResult)
    begin

      case BotaoPressionado of
        mrYes:
          begin
            Delete()
          end;
      end;
    end
    );

end;

procedure TFrmGeraSerial.btnSearchClick(Sender: TObject);
begin
  inherited;
  lvListagemItem.SearchVisible := not lvListagemItem.SearchVisible
end;

procedure TFrmGeraSerial.btnVoltarEdicaoClick(Sender: TObject);
begin
  inherited;
  PesquisarLicencas;
  MudarAba(tabEdicao, Sender);
end;

procedure TFrmGeraSerial.actNovaLicencaExecute(Sender: TObject);
begin
  inherited;
  edtDataInicio.Date := Now;
  edtFim.Date := incDay(Now, 180);
  actGerarLicenca.Enabled := True;
  lblSerial.Text := '';
  MudarAba(tabListagemLicencas, Sender);
end;

procedure TFrmGeraSerial.btnVoltarListagemClick(Sender: TObject);
begin
  inherited;
  MudarAba(tabListagem, Sender);
end;

procedure TFrmGeraSerial.Delete;
var
  Dao: IDAOLicenca;
  Licenca: TLicencaPED;
  Adapter: TBindSourceAdapter;
begin
  inherited;
  Adapter := AdapterLicencas.InternalAdapter;

  if Adapter.State in [TBindSourceAdapterState.seInsert, TBindSourceAdapterState.seEdit] then
    Adapter.Post;

  Licenca := TLicencaPED(Adapter.Current);

  Dao := TAppFactory.DAOLicencaPED();
  Dao.Delete(Licenca);

  Adapter.Delete;

end;

procedure TFrmGeraSerial.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(FClientesPED) then
    FClientesPED.Free;
  if Assigned(FLicencasPED) then
    FLicencasPED.Free;
end;

procedure TFrmGeraSerial.FormCreate(Sender: TObject);

begin
  inherited;

  tbcPrincipal.TabPosition := TTabPosition.None;
  tbcPrincipal.ActiveTab := tabListagem;
  PesquisarClientes();

end;

function TFrmGeraSerial.GeraSerial: string;
var
  Serial: TSerial;
  DataDeIncio, DataDeValidade: TDate;
  cnpj: string;
  Cliente: TClientePED;
begin

  Cliente := RetornaCliente();

  if Cliente = nil then
    Exit;

  DataDeIncio := edtDataInicio.Date;
  DataDeValidade := edtFim.Date;

  cnpj := TUtil.ExtrairNumeros(Trim(Cliente.cnpj));

  if CompareDate(DataDeIncio, Now) = LessThanValue then
    raise Exception.create('A data de inicío precisa ser igual ou maior que o dia de hoje');

  if CompareDate(DataDeValidade, DataDeIncio) = LessThanValue then
    raise Exception.create('A datafinal precisa ser maior que a data incial');

  if Length(cnpj) < 6 then
    raise Exception.create('Informe ao menos 6 numeros do CNPJ');

  Serial := TSerial.create;
  Serial.NbrSegsEdt := 3; // numero de segmentos
  Serial.SegSizeEdt := 6; // tamanho do segmento
  Serial.DefField.Add('Inicio=6'); // campo e tamanho do campo
  Serial.DefField.Add('Validade=6'); // campo e tamanho do campo
  Serial.DefField.Add('cnpj=6'); // campo e tamanho do campo

  Serial.DataField.Add('Inicio=' + FormatDateTime('ddmmyy', DataDeIncio)); // campo e valor do campo
  Serial.DataField.Add('Validade=' + FormatDateTime('ddmmyy', DataDeValidade)); // campo e valor do campo
  Serial.DataField.Add('cnpj=' + Copy(cnpj, Length(cnpj) - 6, 6)); // campo e valor do campo

  result := Serial.MakeLicense;

  Serial.Free;

end;

end.
