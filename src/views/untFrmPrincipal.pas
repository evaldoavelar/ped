unit untFrmPrincipal;

interface

uses
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.UITypes,
  System.Classes, Vcl.Graphics, System.Threading,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  JvExExtCtrls, JvExtComponent, JvClock, Vcl.StdCtrls, JvExControls,
  JvNavigationPane, Data.DB,
  Vcl.ActnList, Vcl.Menus,
  Dao.IDaoParcelas, System.Actions, Vcl.Imaging.jpeg,
  FireDAC.Stan.Def, FireDAC.Phys.IBWrapper, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  Dominio.Entidades.TParcelas, Sistema.TLicenca, Licenca.InformaSerial,
  Util.Exceptions, Util.VclFuncoes, Orcamento.Criar,
  Helper.TLiveBindingFormatCurr,
  Filtro.Orcamentos, Relatorio.TRVendasDoDia, Filtro.Datas,
  Filtro.DatasVendedor, Dominio.Entidades.TVendedor,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  Relatorio.TRParcelasCliente, Dominio.Entidades.TCliente,
  Filtro.Cliente,
  Relatorio.TRProdutosVendidos, Helper.TProdutoVenda, parceiro.InformaPagto,
  Cadastros.parceiro,
  Cadastros.parceiro.FormaPagto, Filtro.VendasParceiro,
  Relatorio.TRVendasPorParceiro, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  Vcl.CategoryButtons, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Facades.Abstract.Observer, FireDAC.Phys.FBDef;

type
  TFrmPrincipal = class(TForm, IFacadeObserver)
    mmPrincipal: TMainMenu;
    mniVendas: TMenuItem;
    mniCadastros: TMenuItem;
    mniCadClientes: TMenuItem;
    mniCadProdutos: TMenuItem;
    actPrincipal: TActionList;
    actCadClientes: TAction;
    actCadProdutos: TAction;
    actSair: TAction;
    mniRelatrios: TMenuItem;
    mniPedidos: TMenuItem;
    actPedidoVenda: TAction;
    pnlContainer: TPanel;
    actConsultaPedido: TAction;
    actRecebimento: TAction;
    ConsultaPedido1: TMenuItem;
    N1: TMenuItem;
    Recebimento1: TMenuItem;
    N2: TMenuItem;
    Sair1: TMenuItem;
    lblVencendo: TLabel;
    lblVencimento: TLabel;
    actCadFormaPagto: TAction;
    actCadFormaPagto1: TMenuItem;
    N3: TMenuItem;
    actCadVendedor: TAction;
    Vendedor1: TMenuItem;
    actCadFornecedor: TAction;
    Fornecedor1: TMenuItem;
    actParametros: TAction;
    Configuraes1: TMenuItem;
    actConfiguracoes1: TMenuItem;
    actRelatorioVencendo: TAction;
    actRelatorioVencidas: TAction;
    actBackup: TAction;
    FazerBackupAgora1: TMenuItem;
    FDIBBackup: TFDIBBackup;
    lblBackup: TLabel;
    Parcelas1: TMenuItem;
    actParcelas: TAction;
    ListagemdeParcelas1: TMenuItem;
    ParcelasVencidas1: TMenuItem;
    actGraficoPedidos: TAction;
    pnlLicenca: TPanel;
    lblLicenca: TLabel;
    actInformaSerial: TAction;
    Licena1: TMenuItem;
    actInformaSerial1: TMenuItem;
    actVerVencimento: TAction;
    VerVencimento1: TMenuItem;
    actOrcamento: TAction;
    Oramento1: TMenuItem;
    actConsultaOrcamento: TAction;
    ConsultaOramento1: TMenuItem;
    N4: TMenuItem;
    VendasdoDia1: TMenuItem;
    actRelatorioVendasDoDia: TAction;
    actVendasDoDiaPorVendedor: TAction;
    actVendasDoDiaPorVendedor1: TMenuItem;
    actLoginLogoff: TAction;
    rocarVendedor1: TMenuItem;
    actRelatorioParcelasCliente: TAction;
    actRelatorioParcelasCliente1: TMenuItem;
    actRelatorioProdutosVendidos: TAction;
    N6: TMenuItem;
    ProdutosVendidos1: TMenuItem;
    actInformaVendaParceiro: TAction;
    actCadastroParceiro: TAction;
    mniCadastroParceiro: TMenuItem;
    mniInformaVendaParceiro: TMenuItem;
    actCadastroFormaPagtoParceiro: TAction;
    mniCadastroFormaPagtoParceiro: TMenuItem;
    actFiltroVendasParceiro: TAction;
    mniFiltroVendasParceiro: TMenuItem;
    mniN5: TMenuItem;
    actVendasPorParceiro: TAction;
    mniVendasPorParceiro: TMenuItem;
    pnlToolbar: TPanel;
    pnlToolBarLeft: TPanel;
    Image2: TImage;
    imgMenu: TImage;
    pnlToolBarCenter: TPanel;
    lblUsuario: TLabel;
    Image3: TImage;
    lblUpdate: TLabel;
    lblCaixa: TLabel;
    ActivityIndicator1: TActivityIndicator;
    svMenuLateralEsquerdo: TSplitView;
    catMenuItems: TCategoryButtons;
    CategoryButtons5: TCategoryButtons;
    ilIconsMenu: TImageList;
    actCadastros: TAction;
    actCaixa: TAction;
    actConsultas: TAction;
    actRelatorios: TAction;
    svSubMenu: TSplitView;
    pgcMenu: TPageControl;
    tsCadastro: TTabSheet;
    catbtnCadastros: TCategoryButtons;
    tsRelatorios: TTabSheet;
    CategoryButtons4: TCategoryButtons;
    tsConsulta: TTabSheet;
    CategoryButtons2: TCategoryButtons;
    tsConfiguracoes: TTabSheet;
    CategoryButtons3: TCategoryButtons;
    actConfiguracoes: TAction;
    popUpUsuario: TPopupMenu;
    actTrocarUsuario1: TMenuItem;
    MenuItem1: TMenuItem;
    mniSair: TMenuItem;
    svMenuLateralDireito: TSplitView;
    pnlAtalhos: TPanel;
    actAbreMenu: TAction;
    img1: TImage;
    Image5: TImage;
    Image4: TImage;
    actAjuda: TAction;
    CategoryButtons6: TCategoryButtons;
    Panel1: TPanel;
    Label35: TLabel;
    Panel45: TPanel;
    actMinimizar: TAction;
    actSangria: TAction;
    actSuprimento: TAction;
    tsCaixa: TTabSheet;
    CategoryButtons1: TCategoryButtons;
    actEstoqueAtualizar: TAction;
    actEstoque: TAction;
    tsEstoque: TTabSheet;
    CategoryButtons7: TCategoryButtons;
    actConsultarEstoque: TAction;
    actEtiquetas: TAction;
    tsEtiquetas: TTabSheet;
    CategoryButtons8: TCategoryButtons;
    actEtiquetasModelo4x2: TAction;
    lblNotify: TLabel;
    actImportar: TAction;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    actAbrirCaixa: TAction;
    actFecharCaixa: TAction;
    actRelatorioMensal: TAction;
    lblCaixaStatus: TLabel;
    Image1: TImage;
    procedure actPedidoVendaExecute(Sender: TObject);
    procedure imgNFCEDblClick(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actConsultaPedidoExecute(Sender: TObject);
    procedure actRecebimentoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure VerificaParcelasVencendo;
    procedure actCadClientesExecute(Sender: TObject);
    procedure actCadFormaPagtoExecute(Sender: TObject);
    procedure actCadVendedorExecute(Sender: TObject);
    procedure actCadProdutosExecute(Sender: TObject);
    procedure actCadFornecedorExecute(Sender: TObject);
    procedure lblVencimentoMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure lblVencimentoMouseLeave(Sender: TObject);
    procedure lblVencimentoClick(Sender: TObject);
    procedure actParametrosExecute(Sender: TObject);
    procedure lblVencendoClick(Sender: TObject);
    procedure actRelatorioVencendoExecute(Sender: TObject);
    procedure actRelatorioVencidasExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actBackupExecute(Sender: TObject);
    procedure actParcelasExecute(Sender: TObject);
    procedure actGraficoPedidosExecute(Sender: TObject);
    procedure actInformaSerialExecute(Sender: TObject);
    procedure actVerVencimentoExecute(Sender: TObject);
    procedure actOrcamentoExecute(Sender: TObject);
    procedure actConsultaOrcamentoExecute(Sender: TObject);
    procedure actRelatorioVendasDoDiaExecute(Sender: TObject);
    procedure actVendasDoDiaPorVendedorExecute(Sender: TObject);
    procedure actLoginLogoffExecute(Sender: TObject);
    procedure actRelatorioParcelasClienteExecute(Sender: TObject);
    procedure actRelatorioProdutosVendidosExecute(Sender: TObject);
    procedure actInformaVendaParceiroExecute(Sender: TObject);
    procedure actCadastroParceiroExecute(Sender: TObject);
    procedure actCadastroFormaPagtoParceiroExecute(Sender: TObject);
    procedure actFiltroVendasParceiroExecute(Sender: TObject);
    procedure actVendasPorParceiroExecute(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure svMenuLateralEsquerdoClick(Sender: TObject);
    procedure actCadastrosExecute(Sender: TObject);
    procedure actConsultasExecute(Sender: TObject);
    procedure actRelatoriosExecute(Sender: TObject);
    procedure actConfiguracoesExecute(Sender: TObject);
    procedure catbtnCadastrosClick(Sender: TObject);
    procedure imgMenuClick(Sender: TObject);
    procedure actAbreMenuExecute(Sender: TObject);
    procedure actAjudaExecute(Sender: TObject);
    procedure actMinimizarExecute(Sender: TObject);
    procedure actSangriaExecute(Sender: TObject);
    procedure actSuprimentoExecute(Sender: TObject);
    procedure actCaixaExecute(Sender: TObject);
    procedure actEstoqueAtualizarExecute(Sender: TObject);
    procedure actEstoqueExecute(Sender: TObject);
    procedure actConsultarEstoqueExecute(Sender: TObject);
    procedure actEtiquetasModelo3x2Execute(Sender: TObject);
    procedure actEtiquetasExecute(Sender: TObject);
    procedure actEtiquetasModelo4x2Execute(Sender: TObject);
    procedure actImportarExecute(Sender: TObject);
    procedure actAbrirCaixaExecute(Sender: TObject);
    procedure actFecharCaixaExecute(Sender: TObject);
    procedure actRelatorioMensalExecute(Sender: TObject);
  private
    { Private declarations }

    FConfigurarDataBase: Boolean;
    procedure ExibeVencidos;
    procedure ExibeVencendo;
    procedure Backup(arquivo: string; force: Boolean = false);
    function RetornaNomeArquivoBackup(): string;
    function RetornaNomeArquivoLicenca(): string;
    procedure MigrateBD;
    procedure ListaParcelas(ACaption: string;
      AParcelas: TObjectList<TParcelas>);
    function CheckLicenca: Boolean;
    procedure InformarSerial;
    procedure DefineLabelVendedor;
    procedure AbreSubMenu;
    procedure AbrirMenuLateralEsquerdo;
    procedure ConfiguraMenuLateral;
    procedure FecharMenuLateralDireito;
    procedure FecharMenuLateralEsquerdo;
    procedure FechaSubMenu;
    procedure ExibeAtalhos;
    procedure WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo);
      message WM_GETMINMAXINFO;
    procedure InciaLog(habilitar: Boolean);
    procedure Inicializar;
    procedure ImportarTabelas;
    procedure FacadeUpdate(const aValue: string);
    function ChecaCaixaAberto: Boolean;
    procedure SetarStatusCaixa;
  public
    { Public declarations }

  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  Pedido.Venda, Util.Funcoes, Recebimento.Recebe, Factory.Dao,
  Cadastros.Cliente, Cadastros.FormaPagto,
  Cadastros.Vendedor, Cadastros.Produto, Cadastros.Fornecedor,
  Configuracoes.Parametros, Splash.Form,
  Dominio.Entidades.TEmitente, Recebimento.ListaParcelas, Sistema.TParametros,
  Login.FrmLogin, Caixa.Abertura, Caixa.Fechamento,
  Filtro.Vencimento, Filtro.Parcelas,
  Database.IDataseMigration, Database.TDataseMigrationBase, Filtro.Pedidos,
  Grafico.Pedidos, Filtro.DatasNumCaixa,
  Sangria.Suprimento.Informar, Dominio.Entidades.TSangriaSuprimento.Tipo,
  Estoque.Atualizar,
  Estoque.Consultar, Etiquetas.Modelo3x2, Etiquetas.Modelo4x2, Sistema.TLog, Factory.Entidades, IFactory.Dao, IFactory.Entidades,
  Sistema.TBancoDeDados, Facade.Concret.Importar, Facades.Abstract.Importar,
  Filtro.MesAno, Relatorio.TRTotalizadorMensal,
  Dominio.Entidades.TTotalizadorMensal,
  System.DateUtils,
  Utils.IO;

{$R *.dfm}


procedure TFrmPrincipal.ImportarTabelas;
var
  LFacadeImportar: IFacadeImportar;
begin
  TLog.IniciaCache;
  try
    LFacadeImportar := TFacadeImportar.new;
    LFacadeImportar.addObserver(self);

    LFacadeImportar.ImportarCliente
      .ImportarVendedor
      .ImportarFornecedor
      .ImportarFormaPagto
      .ImportarProduto
      .ImportarParceiro
      .ImportarParceiroFormaPagto
      .ImportarCondicaodepagto;

  finally
    TLog.FinalizaCache;
  end;
end;

procedure TFrmPrincipal.InciaLog(habilitar: Boolean);
var
  diretoriolog: string;
begin
  diretoriolog := TUtil.DiretorioApp + '\Log\';

  if not DirectoryExists(diretoriolog) then
    ForceDirectories(diretoriolog);

  TLog.Ativar := habilitar;
  TLog.ArquivoLog := diretoriolog + 'PED-LOG-' + FormatDateTime('dd-mm-yyyy', Now) + '.txt';
  TLog.Clean(15);
end;

procedure TFrmPrincipal.actAbreMenuExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actAbreMenuExecute ');
  if svMenuLateralEsquerdo.Opened then
    FecharMenuLateralEsquerdo
  else
    AbrirMenuLateralEsquerdo;
  TLog.d('<<< Saindo de TFrmPrincipal.actAbreMenuExecute ');
end;

procedure TFrmPrincipal.actFecharCaixaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actFecharCaixaExecute ');
  try

    if not ChecaCaixaAberto then
    begin
      raise Exception.Create('Caixa não está aberto.');
    end;
    try
      frmCaixaFechamento := TfrmCaixaFechamento.Create(self);
      frmCaixaFechamento.showmodal;
    finally
      frmCaixaFechamento.free;
    end;
    SetarStatusCaixa;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TFrmPrincipal.actFecharCaixaExecute ');
end;

function TFrmPrincipal.ChecaCaixaAberto: Boolean;
begin
  result := false;
  var
  LControleCaixa := TFactory.new(nil, true)
    .DAOControleCaixa
    .CaixaAberto(TFactoryEntidades.Parametros.PontoVenda.NUMCAIXA);

  if LControleCaixa <> nil then
  begin
    FreeAndNil(LControleCaixa);
    exit(true);
  end;

end;

procedure TFrmPrincipal.actAbrirCaixaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actAbrirCaixaExecute ');
  try

    TLog.d('Checando controle caixa');

    if ChecaCaixaAberto() then
      raise Exception.Create('Caixa Anterior não foi fechado.');

    try
      frmCaixaAbertura := TfrmCaixaAbertura.Create(self);
      frmCaixaAbertura.showmodal;
    finally
      frmCaixaAbertura.free;
    end;

    SetarStatusCaixa;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actAbrirCaixaExecute ');
end;

procedure TFrmPrincipal.actAjudaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actAjudaExecute ');
  if svMenuLateralDireito.Opened = false then
  begin

    svMenuLateralDireito.Placement := svpLeft;
    svMenuLateralDireito.Placement := svpRight;
    svMenuLateralDireito.DisplayMode := svmOverlay;
    svMenuLateralDireito.OpenedWidth := 250;
    svMenuLateralDireito.Open;
  end
  else
  begin
    FecharMenuLateralDireito();
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actAjudaExecute ');
end;

procedure TFrmPrincipal.actBackupExecute(Sender: TObject);
var
  arquivo: string;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actBackupExecute ');
  try
    arquivo := RetornaNomeArquivoBackup();
    Backup(arquivo);
    MessageDlg(Format('Backup feito em: %s', [arquivo]), mtInformation,
      [mbOK], 0);
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actBackupExecute ');
end;

procedure TFrmPrincipal.actCadastroFormaPagtoParceiroExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadastroFormaPagtoParceiroExecute ');
  try
    FrmCadastroFormaPagtoParceiro :=
      TFrmCadastroFormaPagtoParceiro.Create(self);
    try

      FrmCadastroFormaPagtoParceiro.showmodal;
    finally
      FreeAndNil(FrmCadastroFormaPagtoParceiro);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadastroFormaPagtoParceiroExecute ');
end;

procedure TFrmPrincipal.actCadastroParceiroExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadastroParceiroExecute ');
  try
    frmCadastroParceiro := TfrmCadastroParceiro.Create(self);
    try

      frmCadastroParceiro.showmodal;
    finally
      FreeAndNil(frmCadastroParceiro);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadastroParceiroExecute ');
end;

procedure TFrmPrincipal.actCadastrosExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadastrosExecute ');
  catbtnCadastros.Color := $00955200;
  pgcMenu.ActivePage := tsCadastro;
  AbreSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadastrosExecute ');
end;

procedure TFrmPrincipal.actCadClientesExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadClientesExecute ');
  try
    frmCadastroCliente := TfrmCadastroCliente.Create(self);
    try

      frmCadastroCliente.showmodal;
    finally
      FreeAndNil(frmCadastroCliente);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadClientesExecute ');
end;

procedure TFrmPrincipal.actCadFormaPagtoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadFormaPagtoExecute ');
  try
    frmCadastroFormaPagto := TfrmCadastroFormaPagto.Create(self);
    try
      frmCadastroFormaPagto.showmodal;
    finally
      FreeAndNil(frmCadastroFormaPagto);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadFormaPagtoExecute ');
end;

procedure TFrmPrincipal.actCadFornecedorExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadFornecedorExecute ');
  try
    frmCadastroFornecedor := TfrmCadastroFornecedor.Create(self);
    try
      frmCadastroFornecedor.showmodal;
    finally
      FreeAndNil(frmCadastroFornecedor);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadFornecedorExecute ');
end;

procedure TFrmPrincipal.actCadProdutosExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadProdutosExecute ');
  try
    frmCadastroProduto := TfrmCadastroProduto.Create(self);
    try
      frmCadastroProduto.showmodal;
    finally
      FreeAndNil(frmCadastroProduto);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadProdutosExecute ');
end;

procedure TFrmPrincipal.actCadVendedorExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCadVendedorExecute ');
  try
    if not TFactoryEntidades.new.VendedorLogado.PODEACESSARCADASTROVENDEDOR then
      raise Exception.Create
        ('Vendedor não tem permissão para acessar cadastro de vendedores');

    frmCadastroVendedor := TfrmCadastroVendedor.Create(self);
    try
      frmCadastroVendedor.showmodal;
    finally
      FreeAndNil(frmCadastroVendedor);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actCadVendedorExecute ');
end;

procedure TFrmPrincipal.actCaixaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actCaixaExecute ');
  catbtnCadastros.Color := $00955200;
  pgcMenu.ActivePage := tsCaixa;
  AbreSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.actCaixaExecute ');
end;

procedure TFrmPrincipal.actParametrosExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actParametrosExecute ');
  try
    FrmConfiguracoes := TFrmConfiguracoes.Create(self);
    try
      FrmConfiguracoes.showmodal;

      TFactoryEntidades.setParametros(TFactory.new.DaoParametros.GetParametros);
    finally
      FreeAndNil(FrmConfiguracoes);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actParametrosExecute ');
end;

procedure TFrmPrincipal.actConfiguracoesExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actConfiguracoesExecute ');
  pgcMenu.ActivePage := tsConfiguracoes;
  AbreSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.actConfiguracoesExecute ');
end;

procedure TFrmPrincipal.actConsultaOrcamentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actConsultaOrcamentoExecute ');
  try
    frmFiltroOrcamentos := TfrmFiltroOrcamentos.Create(self);
    try
      frmFiltroOrcamentos.showmodal;
    finally
      FreeAndNil(frmFiltroOrcamentos);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actConsultaOrcamentoExecute ');
end;

procedure TFrmPrincipal.actConsultaPedidoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actConsultaPedidoExecute ');
  try
    frmFiltroPedidos := TfrmFiltroPedidos.Create(self);
    try
      frmFiltroPedidos.showmodal;
    finally
      FreeAndNil(frmFiltroPedidos);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actConsultaPedidoExecute ');
end;

procedure TFrmPrincipal.actConsultarEstoqueExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actConsultarEstoqueExecute ');
  ViewEstoqueMovimentacoes := TViewEstoqueMovimentacoes.Create(self);
  try
    ViewEstoqueMovimentacoes.showmodal;
  finally
    ViewEstoqueMovimentacoes.free;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actConsultarEstoqueExecute ');
end;

procedure TFrmPrincipal.actConsultasExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actConsultasExecute ');
  pgcMenu.ActivePage := tsConsulta;
  AbreSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.actConsultasExecute ');
end;

procedure TFrmPrincipal.actEstoqueAtualizarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actEstoqueAtualizarExecute ');
  try
    FrmEstoqueAtualizar := TFrmEstoqueAtualizar.Create(self);
    try
      FrmEstoqueAtualizar.showmodal;
    finally
      FrmEstoqueAtualizar.free;
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actEstoqueAtualizarExecute ');
end;

procedure TFrmPrincipal.actEstoqueExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actEstoqueExecute ');
  pgcMenu.ActivePage := tsEstoque;
  AbreSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.actEstoqueExecute ');
end;

procedure TFrmPrincipal.actEtiquetasModelo3x2Execute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actEtiquetasModelo3x2Execute ');
  try
    FrmEtiquetasModelo3x2 := TFrmEtiquetasModelo3x2.Create(self);
    try
      FrmEtiquetasModelo3x2.showmodal;
    finally
      FreeAndNil(FrmEtiquetasModelo3x2);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actEtiquetasModelo3x2Execute ');
end;

procedure TFrmPrincipal.actEtiquetasModelo4x2Execute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actEtiquetasModelo4x2Execute ');

  try
    FrmEtiquetasModelo4x2 := TFrmEtiquetasModelo4x2.Create(self);
    try
      FrmEtiquetasModelo4x2.showmodal;
    finally
      FreeAndNil(FrmEtiquetasModelo4x2);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actEtiquetasModelo4x2Execute ');
end;

procedure TFrmPrincipal.actEtiquetasExecute(Sender: TObject);
begin
  pgcMenu.ActivePage := tsEtiquetas;
  AbreSubMenu;
end;

procedure TFrmPrincipal.actGraficoPedidosExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actGraficoPedidosExecute ');
  try
    frmGraficoPedidos := TfrmGraficoPedidos.Create(self);
    try
      frmGraficoPedidos.showmodal;
    finally
      FreeAndNil(frmGraficoPedidos);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actGraficoPedidosExecute ');
end;

procedure TFrmPrincipal.actImportarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actImportarExecute ');
  TTask.Create(ImportarTabelas).Start;
  TLog.d('<<< Saindo de TFrmPrincipal.actImportarExecute ');
end;

procedure TFrmPrincipal.actInformaSerialExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actInformaSerialExecute ');
  try
    InformarSerial();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actInformaSerialExecute ');
end;

procedure TFrmPrincipal.actInformaVendaParceiroExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actInformaVendaParceiroExecute ');
  try
    FechaSubMenu;
    FrmParceiroInfoPagto := TFrmParceiroInfoPagto.Create(nil);
    try
      FrmParceiroInfoPagto.showmodal;
    finally
      FreeAndNil(FrmParceiroInfoPagto);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actInformaVendaParceiroExecute ');
end;

procedure TFrmPrincipal.actLoginLogoffExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actLoginLogoffExecute ');
  try
    FrmLogin := TfrmLogin.Create(self);
    try
      if FrmLogin.showmodal = mrAbort then
        abort;

      TFactoryEntidades.new.VendedorLogado := FrmLogin.Vendedor;

      DefineLabelVendedor();
    finally
      FrmLogin.free;
    end;
  except
    on E: EAbort do
      exit;
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actLoginLogoffExecute ');
end;

procedure TFrmPrincipal.actMinimizarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actMinimizarExecute ');
  Application.Minimize;
  TLog.d('<<< Saindo de TFrmPrincipal.actMinimizarExecute ');
end;

procedure TFrmPrincipal.actOrcamentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actOrcamentoExecute ');
  try
    FechaSubMenu;
    FrmCadastroOrcamento := TFrmCadastroOrcamento.Create(nil);
    try
      FrmCadastroOrcamento.showmodal;
    finally
      FreeAndNil(FrmCadastroOrcamento);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actOrcamentoExecute ');
end;

procedure TFrmPrincipal.InformarSerial();
var
  Licenca: TLicenca;
  arquivo: tstringlist;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.InformarSerial ');
  FrmInformaSerial := TFrmInformaSerial.Create(self);
  try
    if FrmInformaSerial.showmodal = mrOk then
    begin
      arquivo := tstringlist.Create;
      arquivo.Text := FrmInformaSerial.edtSerial1.Text + '-' +
        FrmInformaSerial.edtSerial2.Text + '-' +
        FrmInformaSerial.edtSerial3.Text;
      arquivo.SaveToFile(RetornaNomeArquivoLicenca());
      arquivo.free;

      Licenca := TLicenca.Create;
      try
        if not(Licenca.LicencaValida(RetornaNomeArquivoLicenca(),
          TFactory.new.DadosEmitente.CNPJ, Now)) then
          raise Exception.Create('O serial não é válido!');
        CheckLicenca;
      finally
        Licenca.free;
      end;

    end;
  finally
    FrmInformaSerial.free;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.InformarSerial ');
end;

procedure TFrmPrincipal.DefineLabelVendedor;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.DefineLabelVendedor ');
  lblUsuario.Caption := TFactoryEntidades.new.VendedorLogado.NOME;
  TLog.d('<<< Saindo de TFrmPrincipal.DefineLabelVendedor ');
end;

procedure TFrmPrincipal.actParcelasExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actParcelasExecute ');
  try
    frmFiltroParcelas := TfrmFiltroParcelas.Create(self);
    try
      frmFiltroParcelas.showmodal;
      VerificaParcelasVencendo;
    finally
      FreeAndNil(frmFiltroParcelas);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actParcelasExecute ');
end;

procedure TFrmPrincipal.actPedidoVendaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actPedidoVendaExecute ');
  try
    FechaSubMenu;

    if not ChecaCaixaAberto() then
      raise Exception.Create('O Caixa não foi aberto!');

    if CheckLicenca() then
    begin
      try

        FrmPedidoVenda := TFrmPedidoVenda.Create(self);
        try
          FrmPedidoVenda.showmodal;
          VerificaParcelasVencendo;
        finally
          FreeAndNil(FrmPedidoVenda);
        end;
      except
        on E: Exception do
        begin
          TLog.d(E.Message);
          MessageDlg(E.Message, mtError, [mbOK], 0);
        end;
      end;
    end
    else
    begin
      MessageDlg('� preciso uma licen�a para acessar a tela de pedidos!',
        mtError, [mbOK], 0);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actPedidoVendaExecute ');
end;

procedure TFrmPrincipal.actRecebimentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRecebimentoExecute ');
  try
    FechaSubMenu;
    if not TFactoryEntidades.new.VendedorLogado.PODERECEBERPARCELA then
      raise Exception.Create
        ('Vendedor não tem permissão para acessar recebimento de parcelas');

    frmRecebimento := TfrmRecebimento.Create(self);
    try
      frmRecebimento.showmodal;
      VerificaParcelasVencendo;
    finally
      FreeAndNil(frmRecebimento);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actRecebimentoExecute ');
end;

procedure TFrmPrincipal.actRelatorioParcelasClienteExecute(Sender: TObject);
var
  impressao: TRParcelasCliente;
  Cliente: TCliente;
  parcelasVencidas: TObjectList<TParcelas>;
  parcelasVencendo: TObjectList<TParcelas>;
  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatorioParcelasClienteExecute ');
  try

    frmFiltroCliente := TfrmFiltroCliente.Create(self);
    try
      frmFiltroCliente.showmodal;
      if not Assigned(frmFiltroCliente.Cliente) then
        abort;

      Cliente := frmFiltroCliente.Cliente;
    finally
      frmFiltroCliente.free;
      frmFiltroCliente := nil;
    end;

    if (not Assigned(Cliente)) or (Cliente.CODIGO = '000000') or
      (Cliente.CODIGO = '') then
      abort;

    LFactory := TFactory.new(nil, true);
    parcelasVencidas := LFactory.DaoParcelas.GeTParcelasVencidasPorCliente
      (Cliente.CODIGO, Now);
    parcelasVencendo := LFactory.DaoParcelas.GeTParcelasVencendoPorCliente
      (Cliente.CODIGO, Now);

    impressao := TRParcelasCliente.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.Imprime(Cliente, LFactory.DadosEmitente, parcelasVencidas,
      parcelasVencendo);

    FreeAndNil(Cliente);
    FreeAndNil(impressao);
    FreeAndNil(parcelasVencidas);
    FreeAndNil(parcelasVencendo);

    LFactory.Close;
  except
    on E: EAbort do
      exit;
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end; //
  TLog.d('<<< Saindo de TFrmPrincipal.actRelatorioParcelasClienteExecute ');
end;

procedure TFrmPrincipal.actRelatorioProdutosVendidosExecute(Sender: TObject);
var
  impressao: TRProdutosVendidos;
  DataIncio, DataFim: TDate;
  ProdutosVenda: TList<TProdutoVenda>;
  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatorioProdutosVendidosExecute ');
  try

    frmFiltroDatas := TfrmFiltroDatas.Create(self);
    try
      if frmFiltroDatas.showmodal <> mrOk then
        exit;

      DataIncio := frmFiltroDatas.edtDataIncio.Date;
      DataFim := frmFiltroDatas.edtDataFim.Date;
    finally
      frmFiltroDatas.free;
    end;

    LFactory := TFactory.new(nil, true);

    ProdutosVenda := LFactory.DaoPedido.ProdutosVendidos(DataIncio, DataFim);

    impressao := TRProdutosVendidos.Create(TFactoryEntidades.Parametros.PontoVenda.ImpressoraTermica);

    impressao.Imprime(DataIncio, DataFim, TFactoryEntidades.new.VendedorLogado,
      LFactory.DadosEmitente, ProdutosVenda);

    FreeAndNil(ProdutosVenda);
    FreeAndNil(impressao);
    LFactory.Close;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end; //
  TLog.d('<<< Saindo de TFrmPrincipal.actRelatorioProdutosVendidosExecute ');
end;

procedure TFrmPrincipal.actRelatoriosExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatoriosExecute ');
  pgcMenu.ActivePage := tsRelatorios;
  AbreSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.actRelatoriosExecute ');
end;

procedure TFrmPrincipal.actRelatorioVencendoExecute(Sender: TObject);
var
  Parcelas: TObjectList<TParcelas>;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatorioVencendoExecute ');
  frmFiltroVencimento := TfrmFiltroVencimento.Create(self);
  try
    try
      if frmFiltroVencimento.showmodal = mrOk then
      begin
        Parcelas := TFactory.new.DaoParcelas.GetParcelaVencendoObj
          (frmFiltroVencimento.edtDataIncio.Date,
          frmFiltroVencimento.edtDataFim.Date);
        ListaParcelas('Parcelas Vencendo', Parcelas);

        if Assigned(Parcelas) then
          FreeAndNil(Parcelas);
      end;
    finally
      FreeAndNil(frmFiltroVencimento);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actRelatorioVencendoExecute ');
end;

procedure TFrmPrincipal.actRelatorioVencidasExecute(Sender: TObject);
var
  Parcelas: TObjectList<TParcelas>;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatorioVencidasExecute ');
  try
    Parcelas := TFactory.new.DaoParcelas.GetParcelaVencidasObj(Now);
    ListaParcelas('Parcelas Vencidas', Parcelas);

    if Assigned(Parcelas) then
      FreeAndNil(Parcelas);
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actRelatorioVencidasExecute ');
end;

procedure TFrmPrincipal.actRelatorioVendasDoDiaExecute(Sender: TObject);
var
  impressao: TRVendasDoDia;
  DataIncio, DataFim: TDatetime;
  LNumCaixa: string;
  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatorioVendasDoDiaExecute ');
  try
    LNumCaixa := '';
    var
    frmFiltro := TfrmFiltroDatasNumCaixa.Create(self);
    try
      if frmFiltro.showmodal <> mrOk then
        exit;

      DataIncio := Now;
      DataFim := Now;

      ReplaceDate(DataIncio, frmFiltro.edtDataIncio.Date);
      ReplaceTime(DataIncio, EncodeTime(0, 0, 0, 0));

      ReplaceDate(DataFim, frmFiltro.edtDataFim.Date);
      ReplaceTime(DataFim, EncodeTime(23, 59, 59, 0));

      if frmFiltro.cbbNumeroDoCaixa.ItemIndex <> 0 then
        LNumCaixa := frmFiltro.cbbNumeroDoCaixa.Text;
    finally
      frmFiltro.free;
    end;

    LFactory := TFactory.new(nil, true);

    impressao := TRVendasDoDia.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.Imprime(DataIncio,
      DataFim,
      TFactoryEntidades.new.VendedorLogado,
      LFactory.DadosEmitente,
      LFactory.DaoPedido.Totais(DataIncio, DataFim, LNumCaixa, false)
      );

    FreeAndNil(impressao);
    LFactory.Close;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end; //
  TLog.d('<<< Saindo de TFrmPrincipal.actRelatorioVendasDoDiaExecute ');
end;

procedure TFrmPrincipal.actSairExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actSairExecute ');
  self.Close;
  TLog.d('<<< Saindo de TFrmPrincipal.actSairExecute ');
end;

procedure TFrmPrincipal.actSangriaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actSangriaExecute ');
  FrmSangria := TFrmSangria.Create(self);
  try
    FrmSangria.setTipo(TSangriaSuprimentoTipo.Sangria);
    FrmSangria.showmodal;
  finally
    FrmSangria.free;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actSangriaExecute ');
end;

procedure TFrmPrincipal.actSuprimentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actSuprimentoExecute ');
  FrmSangria := TFrmSangria.Create(self);
  try
    FrmSangria.setTipo(TSangriaSuprimentoTipo.Suprimento);
    FrmSangria.showmodal;
  finally
    FrmSangria.free;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actSuprimentoExecute ');
end;

procedure TFrmPrincipal.actVendasDoDiaPorVendedorExecute(Sender: TObject);
var
  impressao: TRVendasDoDia;
  DataIncio, DataFim: TDatetime;
  Vendedor: TVendedor;
  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actVendasDoDiaPorVendedorExecute ');
  try

    frmFiltroDataVendedor := TfrmFiltroDataVendedor.Create(self);
    try
      if frmFiltroDataVendedor.showmodal <> mrOk then
        exit;

      DataIncio := Now;
      DataFim := Now;

      ReplaceDate(DataIncio, frmFiltroDataVendedor.edtDataIncio.Date);
      ReplaceTime(DataIncio, EncodeTime(0, 0, 0, 0));

      ReplaceDate(DataFim, frmFiltroDataVendedor.edtDataFim.Date);
      ReplaceTime(DataFim, EncodeTime(23, 59, 59, 0));
      Vendedor := frmFiltroDataVendedor.Vendedor;
    finally
      frmFiltroDataVendedor.free;
    end;

    if not Assigned(Vendedor) then
      raise Exception.Create('Vendedor N�o selecionado');

    LFactory := TFactory.new(nil, true);

    impressao := TRVendasDoDia.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.Imprime(
      TFactoryEntidades.new.VendedorLogado,
      DataIncio,
      DataFim,
      Vendedor,
      LFactory.DadosEmitente,
      LFactory.DaoPedido.Totais(DataIncio, DataFim, Vendedor.CODIGO)
      );

    FreeAndNil(impressao);
    LFactory.Close;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end; //
  TLog.d('<<< Saindo de TFrmPrincipal.actVendasDoDiaPorVendedorExecute ');
end;

procedure TFrmPrincipal.actVendasPorParceiroExecute(Sender: TObject);
var
  impressao: TRVendasPorParceiro;
  DataIncio, DataFim: TDate;

  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actVendasPorParceiroExecute ');
  try

    frmFiltroDatas := TfrmFiltroDatas.Create(self);
    try
      if frmFiltroDatas.showmodal <> mrOk then
        exit;

      DataIncio := frmFiltroDatas.edtDataIncio.Date;
      DataFim := frmFiltroDatas.edtDataFim.Date;
    finally
      frmFiltroDatas.free;
    end;
    LFactory := TFactory.new(nil, true);

    impressao := TRVendasPorParceiro.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.Imprime(TFactoryEntidades.new.VendedorLogado, DataIncio, DataFim, LFactory.DadosEmitente);

    FreeAndNil(impressao);
    LFactory.Close;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actVendasPorParceiroExecute ');
end;

procedure TFrmPrincipal.actFiltroVendasParceiroExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actFiltroVendasParceiroExecute ');
  try
    frmFiltroVendasParceiro := TfrmFiltroVendasParceiro.Create(nil);
    try
      frmFiltroVendasParceiro.showmodal;
    finally
      FreeAndNil(frmFiltroVendasParceiro);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actFiltroVendasParceiroExecute ');
end;

procedure TFrmPrincipal.actRelatorioMensalExecute(Sender: TObject);
var
  LFiltro: TfrmFiltroMesAno;
  LTotais: TObjectList<TTotalizadorMensalItem>;
  LImpressao: TRTotalizadorMensal;
  LDataInicio, LDataFim: TDate;
  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatorioMensalExecute ');
  try
    if not TFactoryEntidades.new.VendedorLogado.PODEACESSARRELATORIOIMENSAL then
    begin
      MessageDlg('Acesso negado. Você não tem permissão para acessar o Relatório Mensal.',
        mtWarning, [mbOK], 0);
      Exit;
    end;

    LFiltro := TfrmFiltroMesAno.Create(Self);
    try
      if LFiltro.ShowModal <> mrOk then
        Exit;

      LDataInicio := EncodeDate(LFiltro.AnoInicio, LFiltro.MesInicio, 1);
      LDataFim := EncodeDate(LFiltro.AnoFim, LFiltro.MesFim,
        DaysInAMonth(LFiltro.AnoFim, LFiltro.MesFim));

      LFactory := TFactory.new(nil, true);
      try
        LTotais := LFactory.DaoPedido.TotaisMensais(LDataInicio, LDataFim,
          LFiltro.NumCaixa);
        try
          LImpressao := TRTotalizadorMensal.Create(
            TFactoryEntidades.Parametros.ImpressoraTermica);
          try
            LImpressao.Imprime(TFactoryEntidades.new.VendedorLogado,
              LDataInicio, LDataFim, LFiltro.NumCaixa,
              LFactory.DadosEmitente, LTotais);
          finally
            FreeAndNil(LImpressao);
          end;
        finally
          FreeAndNil(LTotais);
        end;
      finally
        LFactory.Close;
      end;
    finally
      FreeAndNil(LFiltro);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actRelatorioMensalExecute ');
end;

procedure TFrmPrincipal.actVerVencimentoExecute(Sender: TObject);
var
  Licenca: TLicenca;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actVerVencimentoExecute ');
  Licenca := TLicenca.Create;
  try
    if (Licenca.LicencaValida(RetornaNomeArquivoLicenca(),
      TFactory.new.DadosEmitente.CNPJ, Now)) then
      MessageDlg('Licença válida de ' + DateToStr(Licenca.DataDeIncio) + ' até '
        + DateToStr(Licenca.DataVencimento) + #13 + 'CNPJ: ' +
        TUtil.PadL(Licenca.cnpjLicenca, 14, '*'), mtInformation, [mbOK], 0)
    else
      raise Exception.Create('O sistema não possui uma licença válida');
  finally
    Licenca.free;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actVerVencimentoExecute ');
end;

procedure TFrmPrincipal.Backup(arquivo: string; force: Boolean = false);
var
  LBancoDeDados: TParametrosBancoDeDados;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.Backup ');
  try
    // se não for backup forçado
    if not force then
      // se arquivo existe, não realiza o backup
      if FileExists(arquivo) then
        exit;

    LBancoDeDados := TFactory.new.DaoParametrosBancoDeDados.Carregar();

    FDIBBackup.DriverLink := FDPhysFBDriverLink1;
    FDIBBackup.Host := '127.0.0.1';
    FDIBBackup.Database := TUtilsIO.ExtractDirectoryFromPath(LBancoDeDados.Database);
    FDIBBackup.Password := LBancoDeDados.Senhaproxy;
    FDIBBackup.UserName := LBancoDeDados.Usuario;
    FDIBBackup.Protocol := ipTCPIP;
    FreeAndNil(LBancoDeDados);

    FDIBBackup.BackupFiles.Clear;
    FDIBBackup.BackupFiles.Add(arquivo);

    FDIBBackup.Backup;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.Backup ');
end;

procedure TFrmPrincipal.catbtnCadastrosClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.catbtnCadastrosClick ');
  FechaSubMenu();
  TLog.d('<<< Saindo de TFrmPrincipal.catbtnCadastrosClick ');
end;

function TFrmPrincipal.CheckLicenca: Boolean;
var
  Licenca: TLicenca;
  CNPJ: string;
  LFactory: IFactoryDao;
  LEmitente: TEmitente;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.CheckLicenca ');
  exit(true);
  result := false;
  pnlLicenca.Visible := false;

  CNPJ := '';

  LEmitente := TFactory.new.DadosEmitente;

  if Assigned(LEmitente) then
    CNPJ := LEmitente.CNPJ;

  Licenca := TLicenca.Create;
  try

    if FileExists(RetornaNomeArquivoLicenca()) then
    begin
      try
        if not Licenca.LicencaValida(RetornaNomeArquivoLicenca(), CNPJ, Now)
        then
        begin
          result := (Licenca.DiasRestantes >= 0) and Licenca.CnpjIguais;

          if Licenca.DiasRestantes < 0 then
          begin
            lblLicenca.Caption :=
              'A Licença do sistema está vencida. Clique aqui para informar uma nova licença';
            pnlLicenca.Visible := true;
          end
          else if Licenca.DiasRestantes < 30 then
          begin
            lblLicenca.Caption :=
              Format('A Licença do sistema estará vencendo em %d dias. Evite o bloqueio do sistema e solicite uma nova licença',
              [Licenca.DiasRestantes]);
            pnlLicenca.Visible := true;
          end
          else if not Licenca.CnpjIguais then
          begin
            lblLicenca.Caption :=
              ('A Licença não pertence ao CNPJ! Clique aqui para informar uma nova licença');
            pnlLicenca.Visible := true;
          end
        end
        else
        begin
          result := true;
          pnlLicenca.Visible := false;
        end;
      except
        on E: TValidacaoException do
        begin
          lblLicenca.Caption := E.Message +
            ' - Clique aqui para informar uma nova licença';
          pnlLicenca.Visible := true;
        end;
      end;
    end
    else
    begin
      lblLicenca.Caption :=
        'O sistema não possui uma licença de uso. Clique aqui para informar uma nova licença';
      pnlLicenca.Visible := true;
    end;

  finally
    FreeAndNil(Licenca);
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.CheckLicenca ');

end;

function TFrmPrincipal.RetornaNomeArquivoBackup(): string;
var
  diretorio: string;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.RetornaNomeArquivoBackup ');
  diretorio := TUtil.DiretorioApp + 'backup';
  if not DirectoryExists(diretorio) then
    CreateDir(diretorio);
  result := Format('%s\bkp-%s.fbk',
    [diretorio, FormatDateTime('dd-mm-yyyy', Now)]);
  TLog.d('<<< Saindo de TFrmPrincipal.RetornaNomeArquivoBackup ');
end;

function TFrmPrincipal.RetornaNomeArquivoLicenca: string;
begin
  result := TUtil.DiretorioApp + 'licenca.evd';
end;

procedure TFrmPrincipal.SetarStatusCaixa;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.SetarStatusCaixa ');
  try
    lblCaixaStatus.Visible := true;
    if ChecaCaixaAberto then
    begin
      lblCaixaStatus.Caption := 'CAIXA ABERTO';
      lblCaixaStatus.Font.Color := $00A25800;
    end
    ELSE
    begin
      lblCaixaStatus.Caption := 'CAIXA FECHADO';
      lblCaixaStatus.Font.Color := $002D39C1;
    end;
  except
    on E: Exception do
    begin
      lblCaixaStatus.Caption := 'ERRO';
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TFrmPrincipal.SetarStatusCaixa ');
end;

procedure TFrmPrincipal.svMenuLateralEsquerdoClick(Sender: TObject);
begin
  FechaSubMenu;
end;

procedure TFrmPrincipal.AbreSubMenu;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.AbreSubMenu ');
  svSubMenu.Open;
  svSubMenu.DisplayMode := svmOverlay;
  svSubMenu.Left := svMenuLateralEsquerdo.Width;
  TLog.d('<<< Saindo de TFrmPrincipal.AbreSubMenu ');
end;

procedure TFrmPrincipal.FechaSubMenu;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.FechaSubMenu ');
  svSubMenu.Close;
  svSubMenu.CloseStyle := svcCollapse;
  svSubMenu.DisplayMode := svmOverlay;
  TLog.d('<<< Saindo de TFrmPrincipal.FechaSubMenu ');
end;

procedure TFrmPrincipal.ConfiguraMenuLateral;
var
  i: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.ConfiguraMenuLateral ');

  for i := 0 to Pred(pgcMenu.PageCount) do
  begin
    pgcMenu.Pages[i].TabVisible := false;

  end;

  // FecharMenuLateralEsquerdo();
  AbrirMenuLateralEsquerdo;
  FechaSubMenu;
  FecharMenuLateralDireito();
  self.Menu := nil;
  TLog.d('<<< Saindo de TFrmPrincipal.ConfiguraMenuLateral ');
end;

procedure TFrmPrincipal.FacadeUpdate(const aValue: string);
begin
  lblNotify.Caption := aValue;
end;

procedure TFrmPrincipal.FecharMenuLateralDireito;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.FecharMenuLateralDireito ');
  svMenuLateralDireito.Close;
  svMenuLateralDireito.CloseStyle := svcCollapse;
  svMenuLateralDireito.DisplayMode := svmOverlay;
  TLog.d('<<< Saindo de TFrmPrincipal.FecharMenuLateralDireito ');
end;

procedure TFrmPrincipal.AbrirMenuLateralEsquerdo;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.AbrirMenuLateralEsquerdo ');
  // abrir o menu
  svMenuLateralEsquerdo.Open;
  svMenuLateralEsquerdo.DisplayMode := svmDocked;
  // exibir o caption dos bot�es
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  FechaSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.AbrirMenuLateralEsquerdo ');
end;

procedure TFrmPrincipal.FecharMenuLateralEsquerdo;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.FecharMenuLateralEsquerdo ');
  // fecha o menu no estilo compacto
  svMenuLateralEsquerdo.Close;
  svMenuLateralEsquerdo.CloseStyle := svcCompact;
  svMenuLateralEsquerdo.DisplayMode := svmOverlay;
  // esconder o caption dos bot�es
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions - [boShowCaptions];

  FechaSubMenu;
  TLog.d('<<< Saindo de TFrmPrincipal.FecharMenuLateralEsquerdo ');
end;

procedure TFrmPrincipal.ExibeVencendo;
var
  Parcelas: TObjectList<TParcelas>;
begin
  Parcelas := TFactory.new.DaoParcelas.GetParcelaVencendoObj(Now, IncMonth(Now, 2));
  ListaParcelas('Parcelas Vencendo', Parcelas);
  if Assigned(Parcelas) then
    FreeAndNil(Parcelas);
end;

procedure TFrmPrincipal.ExibeVencidos;
var
  Parcelas: TObjectList<TParcelas>;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.ExibeVencidos ');
  Parcelas := TFactory.new.DaoParcelas.GetParcelaVencidasObj(Now);
  ListaParcelas('Parcelas Vencidas', Parcelas);

  if Assigned(Parcelas) then
    FreeAndNil(Parcelas);

  TLog.d('<<< Saindo de TFrmPrincipal.ExibeVencidos ');
end;

procedure TFrmPrincipal.ListaParcelas(ACaption: string;
  AParcelas: TObjectList<TParcelas>);
var
  Aleft, Atop: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.ListaParcelas ');
  frmParcelasVencendo := TfrmParcelasVencendo.Create(self);
  try
    Atop := lblVencimento.top - frmParcelasVencendo.Height;
    if Atop < 0 then
      Atop := self.top + 40;

    Aleft := lblVencendo.Left;

    frmParcelasVencendo.Parcelas := AParcelas;
    frmParcelasVencendo.SetTop(Atop);
    frmParcelasVencendo.SetLef(Aleft);
    frmParcelasVencendo.Caption := ACaption;
    frmParcelasVencendo.showmodal;
  finally
    FreeAndNil(frmParcelasVencendo);
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.ListaParcelas ');
end;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
var
  LVendedorLogado: TVendedor;
  LChamarInicializar: Boolean;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.FormActivate ');
  // try
  // CheckLicenca();
  // except
  // end;

  self.WindowState := TWindowState.wsMaximized;

  MigrateBD();

  if { DebugHook = 0 } true then
  begin

    // Self.BorderStyle := bsNone;
    SendMessage(Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
    Application.ProcessMessages;
    LChamarInicializar := FConfigurarDataBase;
    FrmLogin := TfrmLogin.Create(self);
    try
      FrmLogin.ConfigurarDataBase := FConfigurarDataBase;
      if FrmLogin.showmodal = mrAbort then
        Halt(0);

      TFactoryEntidades.new.VendedorLogado := FrmLogin.Vendedor;
      // if LChamarInicializar then
      Inicializar;
    finally
      FrmLogin.free;
    end;
  end
  else
  begin
    LVendedorLogado := TFactoryEntidades.new.VendedorLogado;

    LVendedorLogado.CODIGO := '001';
    LVendedorLogado.NOME := 'Debug';
    LVendedorLogado.PODEACESSARCADASTROVENDEDOR := true;
    LVendedorLogado.PODECANCELARPEDIDO := true;
    LVendedorLogado.PODERECEBERPARCELA := true;
    LVendedorLogado.PODECANCELARORCAMENTO := true;

  end;
  DefineLabelVendedor();
  self.BringToFront;

  TLog.d('<<< Saindo de TFrmPrincipal.FormActivate ');
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    FConfigurarDataBase := false;
    InciaLog(true);
    TLog.d('>>> Entrando em  TFrmPrincipal.FormCreate ');
    self.Menu := nil;

    ReportMemoryLeaksOnShutdown := DebugHook <> 0;

    TVclFuncoes.DisableVclStyles(pnlContainer, 'TPanel');
    TVclFuncoes.DisableVclStyles(pnlContainer, 'TLabel');

    ConfiguraMenuLateral;

    ExibeAtalhos;

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.FormCreate ');
end;

procedure TFrmPrincipal.ExibeAtalhos;
var
  i: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.ExibeAtalhos ');
  for i := 0 to actPrincipal.ActionCount - 1 do
  begin
    if actPrincipal.Actions[i].ShortCut <> 0 then
    begin
      with TLabel.Create(pnlAtalhos) do
      begin
        Caption := TUtil.PadR(ShortCutToText(actPrincipal.Actions[i].ShortCut),
          15, ' ') + actPrincipal.Actions[i].Caption;
        Parent := pnlAtalhos;
        AlignWithMargins := true;
        Font.Color := $005E4934;
        Font.Style := [fsBold];
        // Align := alBottom;
        Align := alTop;
      end;
    end;

  end;
  TLog.d('<<< Saindo de TFrmPrincipal.ExibeAtalhos ');
end;

procedure TFrmPrincipal.MigrateBD;
var
  migrate: IDataseMigration;
  Erros: TDictionary<TClass, string>;
  ListaErros: TStringBuilder;
  key: TClass;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.MigrateBD ');
  migrate := TDataseMigrationBase.Create(tpFirebird);
  migrate.migrate();
  Erros := migrate.GetErros();

  if Erros.Count > 0 then
  begin
    ListaErros := TStringBuilder.Create;
    ListaErros.Append
      ('Os seguintes erros foram encontrados na atualização do banco de dados');
    for key in Erros.Keys do
    begin
      ListaErros.Append('Erro: ' + Erros[key]);
    end;

    MessageDlg(ListaErros.ToString, mtError, [mbOK], 0);
    ListaErros.Clear;
    ListaErros.free;
  end;

  if Assigned(Erros) then
    FreeAndNil(Erros);
  TLog.d('<<< Saindo de TFrmPrincipal.MigrateBD ');
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);

begin
  TLog.d('>>> Entrando em  TFrmPrincipal.FormShow ');
  // with Screen.WorkAreaRect do
  // SetBounds(Left, top, Right - Left, Bottom - top);

  if true { DebugHook = 0 } then
  begin

    frmSplash := TfrmSplash.Create(self);
    try
      frmSplash.showmodal;
      FConfigurarDataBase := frmSplash.ConfigurarDataBase;
    finally
      FreeAndNil(frmSplash);
    end;
  end;

  TLog.d('<<< Saindo de TFrmPrincipal.FormShow ');
end;

procedure TFrmPrincipal.Inicializar;
var
  LFactory: IFactoryDao;
  task: ITask;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.Inicializar ');

  MigrateBD();

  LFactory := TFactory.new(nil, true);
  TFactoryEntidades.setParametros(LFactory.DaoParametros.GetParametros);

  self.Caption := 'Pedidos - ' + LFactory.DadosEmitente.FANTASIA;
  lblCaixa.Caption := TFactoryEntidades.Parametros.PontoVenda.NUMCAIXA;
  LFactory.Close;

  VerificaParcelasVencendo;
  SetarStatusCaixa;

  // if TFactoryEntidades.Parametros.FUNCIONARCOMOCLIENTE then
  // begin
  // actImportar.Execute;
  // end;

  if (TFactoryEntidades.Parametros.PontoVenda.FUNCIONARCOMOCLIENTE = false) and TFactoryEntidades.Parametros.BACKUPDIARIO then
  begin
    // abri uma tarefa de backup
    task := TTask.Create(
      procedure()
      var
        arquivo: string;
      begin
        try
          arquivo := RetornaNomeArquivoBackup();
          Backup(arquivo, true);
          lblBackup.Caption := 'Backup Realizado: ' + arquivo;
          lblBackup.Visible := true;
        except
          on E: Exception do
          begin
            lblBackup.Caption := 'Atenção! O Backup diário não foi feito.';
            lblBackup.Visible := true;
            lblBackup.Font.Color := $002B39C0;
          end;
        end;
      end);
    task.Start;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.Inicializar ');
end;

procedure TFrmPrincipal.Image3Click(Sender: TObject);
var
  Z: TPoint;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.Image3Click ');
  Z.X := 0;
  Z.Y := TImage(Sender).ClientHeight;
  Z := TImage(Sender).ClientToScreen(Z);
  popUpUsuario.Popup(Z.X, Z.Y);
  TLog.d('<<< Saindo de TFrmPrincipal.Image3Click ');
end;

procedure TFrmPrincipal.imgMenuClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.imgMenuClick ');
  actAbreMenu.Execute;
  TLog.d('<<< Saindo de TFrmPrincipal.imgMenuClick ');
end;

procedure TFrmPrincipal.imgNFCEDblClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.imgNFCEDblClick ');
  actPedidoVenda.Execute;
  TLog.d('<<< Saindo de TFrmPrincipal.imgNFCEDblClick ');
end;

procedure TFrmPrincipal.lblVencendoClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.lblVencendoClick ');
  ExibeVencendo;
  TLog.d('<<< Saindo de TFrmPrincipal.lblVencendoClick ');
end;

procedure TFrmPrincipal.lblVencimentoClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.lblVencimentoClick ');
  ExibeVencidos;
  TLog.d('<<< Saindo de TFrmPrincipal.lblVencimentoClick ');
end;

procedure TFrmPrincipal.lblVencimentoMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline];

end;

procedure TFrmPrincipal.lblVencimentoMouseMove(Sender: TObject;
Shift: TShiftState; X, Y: Integer);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline];

end;

procedure TFrmPrincipal.VerificaParcelasVencendo;
var
  vencendo: Integer;
  vencidas: Integer;
  LDaoParcelas: IDaoParcelas;

begin
  TLog.d('>>> Entrando em  TFrmPrincipal.VerificaParcelasVencendo ');
  try

    LDaoParcelas := TFactory.new.DaoParcelas;

    vencendo := LDaoParcelas.GetNumeroDeParcelasVencendo(Now, IncMonth(Now, 2));

    if vencendo > 0 then
    begin
      lblVencendo.Caption :=
        Format('%d Parcelas vencendo nos próximos 60 dias.', [vencendo]);
      lblVencendo.Visible := true;
    end
    else
      lblVencendo.Visible := false;

    vencidas := LDaoParcelas.GetNumeroDeParcelasVencidas(Now);

    if vencidas > 0 then
    begin
      lblVencimento.Caption := Format('%d Parcelas Vencidas.', [vencidas]);
      lblVencimento.Visible := true;
    end
    else
      lblVencimento.Visible := false;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      raise Exception.Create('Falha ao verificar parcelas em vencimento: ' +
        E.Message);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.VerificaParcelasVencendo ');
end;

procedure TFrmPrincipal.WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo);
var
  R: TRect;
begin
  inherited;

  // Obtem o retangulo com a area livre do desktop
  SystemParametersInfo(SPI_GETWORKAREA, SizeOf(R), @R, 0);

  Msg.MinMaxInfo^.ptMaxPosition := R.TopLeft;
  OffsetRect(R, -R.Left, -R.top);
  Msg.MinMaxInfo^.ptMaxSize := R.BottomRight;

end;

end.
