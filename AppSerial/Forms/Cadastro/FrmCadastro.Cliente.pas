unit FrmCadastro.Cliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FrmCadastro.Base, FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts,
  FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, System.Actions, FMX.ActnList, FMX.ListView, Data.Bind.GenData, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs,
  FMX.Bind.Editors, FMX.Edit, Data.Bind.Components, Data.Bind.ObjectScope, AppSerial.Dao.IDAOClientePED,
  AppSerial.Dominio.TAppFactory, System.Generics.Collections, AppSerial.Dominio.TClientePED, FMX.StdActns, FMX.Gestures;

type
  TFrmCadastroClientes = class(TFrmCadastroBase)
    lblTitulo: TLabel;
    lytEdicao: TLayout;
    lyt1: TLayout;
    Layout3: TLayout;
    lblName: TLabel;
    edtNome: TEdit;
    Layout4: TLayout;
    Label1: TLabel;
    edtTelefone: TEdit;
    Layout6: TLayout;
    Label2: TLabel;
    edtCNPJ: TEdit;
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    Label3: TLabel;
    edtCelular: TEdit;
    Layout2: TLayout;
    Label4: TLabel;
    edtContato: TEdit;
    ToolBar1: TToolBar;
    Label5: TLabel;
    SpeedButton1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    actDelete: TAction;
    actAdicionar: TAction;
    AdapterBindSource1: TAdapterBindSource;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    BindingsList1: TBindingsList;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    LinkPropertyToFieldText: TLinkPropertyToField;
    LinkControlToField1: TLinkControlToField;
    lvListagemItem: TListView;
    LinkListControlToField2: TLinkListControlToField;
    btnSearch: TSpeedButton;
    GestureManager1: TGestureManager;
    actMudarAbaEdicao: TAction;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actAdicionarExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure lvListagemItemItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure lvListagemItemPullRefresh(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure actMudarAbaEdicaoExecute(Sender: TObject);
  private
    FClientesPED: TObjectList<TClientePED>;
    { Private declarations }
    // function Mensagem()
    function ListarCliente(): TObjectList<TClientePED>;
    procedure PesquisarClientes;
    procedure Salvar;
    procedure Delete;
  public
    { Public declarations }
  end;

var
  FrmCadastroClientes: TFrmCadastroClientes;

implementation

{$R *.fmx}


procedure TFrmCadastroClientes.actAdicionarExecute(Sender: TObject);
begin
  inherited;
  AdapterBindSource1.Adapter.Append;
  MudarAba(tabEdicao, Sender);
end;

procedure TFrmCadastroClientes.actDeleteExecute(Sender: TObject);
begin
  MessageDlg('Deseja excluir o cliente?',
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

procedure TFrmCadastroClientes.actMudarAbaEdicaoExecute(Sender: TObject);
begin
  inherited;
  MudarAba(tabEdicao, Sender);
end;

procedure TFrmCadastroClientes.btnSearchClick(Sender: TObject);
begin
  inherited;
  lvListagemItem.SearchVisible := not lvListagemItem.SearchVisible;
end;

procedure TFrmCadastroClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Salvar();
  if Assigned(FClientesPED) then
    FClientesPED.DisposeOf;

  inherited;
end;

procedure TFrmCadastroClientes.FormCreate(Sender: TObject);
begin
  inherited;
  tbcPrincipal.TabPosition := TTabPosition.None;
  tbcPrincipal.ActiveTab := tabListagem;
  PesquisarClientes();
end;

procedure TFrmCadastroClientes.PesquisarClientes();
begin
  AdapterBindSource1.Active := False;

  if Assigned(FClientesPED) then
    FreeAndNil(FClientesPED);

  FClientesPED := ListarCliente();

  AdapterBindSource1.Adapter := TListBindSourceAdapter<TClientePED>.create(Self, FClientesPED, True);
  AdapterBindSource1.Active := True;

end;

FUNCTION TFrmCadastroClientes.ListarCliente: TObjectList<TClientePED>;
var
  Dao: IDAOClientePED;
begin
  Dao := TAppFactory.DAOClientePED();
  result := Dao.Listar();
end;

procedure TFrmCadastroClientes.lvListagemItemItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  inherited;
  MudarAba(tabEdicao, Sender);
end;

procedure TFrmCadastroClientes.lvListagemItemPullRefresh(Sender: TObject);
begin
  inherited;
  PesquisarClientes;
end;

procedure TFrmCadastroClientes.Delete();
var
  Dao: IDAOClientePED;
  Cliente: TClientePED;
  Adapter: TBindSourceAdapter;
begin
  inherited;
  Adapter := AdapterBindSource1.InternalAdapter;

  if Adapter.State in [TBindSourceAdapterState.seInsert, TBindSourceAdapterState.seEdit] then
    Adapter.Post;

  Cliente := TClientePED(Adapter.Current);

  Dao := TAppFactory.DAOClientePED();
  Dao.Delete(Cliente);

  Adapter.Delete;
end;

procedure TFrmCadastroClientes.Salvar();
var
  Dao: IDAOClientePED;
  Cliente: TClientePED;
  Adapter: TBindSourceAdapter;
begin
  inherited;
  Adapter := AdapterBindSource1.InternalAdapter;

  if Adapter.State in [TBindSourceAdapterState.seInsert, TBindSourceAdapterState.seEdit] then
  begin
    if Adapter.FindField('nome').GetTValue.AsString = '' then
    begin
      Adapter.CancelUpdates;
      exit;
    end;
    Adapter.Post;

    Cliente := TClientePED(Adapter.Current);

    Dao := TAppFactory.DAOClientePED();
    Dao.Salvar(Cliente);
  end;

end;

procedure TFrmCadastroClientes.SpeedButton1Click(Sender: TObject);
begin
  Salvar();
  MudarAba(tabListagem, Sender);
end;

end.
