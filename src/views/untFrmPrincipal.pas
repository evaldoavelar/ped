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
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Phys.FBDef,
  Relatorio.TRParcelasCliente, Dominio.Entidades.TCliente,
  Pedido.SelecionaCliente, Filtro.Cliente,
  Relatorio.TRProdutosVendidos, Helper.TProdutoVenda, parceiro.InformaPagto,
  Cadastros.parceiro,
  Cadastros.parceiro.FormaPagto, Filtro.VendasParceiro,
  Relatorio.TRVendasPorParceiro, Vcl.ComCtrls, System.ImageList, Vcl.ImgList,
  Vcl.CategoryButtons, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage;

type
  TFrmPrincipal = class(TForm)
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
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
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
    Label1: TLabel;
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
  Login.FrmLogin,
  Filtro.Vencimento, Filtro.Parcelas,
  Database.IDataseMigration, Database.TDataseMigrationBase, Filtro.Pedidos,
  Grafico.Pedidos,
  Sangria.Suprimento.Informar, Dominio.Entidades.TSangriaSuprimento.Tipo,
  Estoque.Atualizar,
  Estoque.Consultar, Etiquetas.Modelo3x2, Etiquetas.Modelo4x2, Sistema.TLog, Factory.Entidades, IFactory.Dao, IFactory.Entidades,
  Sistema.TBancoDeDados;

{$R *.dfm}


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
      TFrmCadastroFormaPagtoParceiro.Create(Self);
    try

      FrmCadastroFormaPagtoParceiro.ShowModal;
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
    frmCadastroParceiro := TfrmCadastroParceiro.Create(Self);
    try

      frmCadastroParceiro.ShowModal;
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
    frmCadastroCliente := TfrmCadastroCliente.Create(Self);
    try

      frmCadastroCliente.ShowModal;
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
    frmCadastroFormaPagto := TfrmCadastroFormaPagto.Create(Self);
    try
      frmCadastroFormaPagto.ShowModal;
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
    frmCadastroFornecedor := TfrmCadastroFornecedor.Create(Self);
    try
      frmCadastroFornecedor.ShowModal;
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
    frmCadastroProduto := TfrmCadastroProduto.Create(Self);
    try
      frmCadastroProduto.ShowModal;
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

    frmCadastroVendedor := TfrmCadastroVendedor.Create(Self);
    try
      frmCadastroVendedor.ShowModal;
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
    FrmConfiguracoes := TFrmConfiguracoes.Create(Self);
    try
      FrmConfiguracoes.ShowModal;
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
    frmFiltroOrcamentos := TfrmFiltroOrcamentos.Create(Self);
    try
      frmFiltroOrcamentos.ShowModal;
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
    frmFiltroPedidos := TfrmFiltroPedidos.Create(Self);
    try
      frmFiltroPedidos.ShowModal;
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
  ViewEstoqueMovimentacoes := TViewEstoqueMovimentacoes.Create(Self);
  try
    ViewEstoqueMovimentacoes.ShowModal;
  finally
    ViewEstoqueMovimentacoes.Free;
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
    FrmEstoqueAtualizar := TFrmEstoqueAtualizar.Create(Self);
    try
      FrmEstoqueAtualizar.ShowModal;
    finally
      FrmEstoqueAtualizar.Free;
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
    FrmEtiquetasModelo3x2 := TFrmEtiquetasModelo3x2.Create(Self);
    try
      FrmEtiquetasModelo3x2.ShowModal;
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
    FrmEtiquetasModelo4x2 := TFrmEtiquetasModelo4x2.Create(Self);
    try
      FrmEtiquetasModelo4x2.ShowModal;
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
    frmGraficoPedidos := TfrmGraficoPedidos.Create(Self);
    try
      frmGraficoPedidos.ShowModal;
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
      FrmParceiroInfoPagto.ShowModal;
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
    FrmLogin := TfrmLogin.Create(Self);
    try
      if FrmLogin.ShowModal = mrAbort then
        abort;

      TFactoryEntidades.new.VendedorLogado := FrmLogin.Vendedor;

      DefineLabelVendedor();
    finally
      FrmLogin.Free;
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
      FrmCadastroOrcamento.ShowModal;
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
  FrmInformaSerial := TFrmInformaSerial.Create(Self);
  try
    if FrmInformaSerial.ShowModal = mrOk then
    begin
      arquivo := tstringlist.Create;
      arquivo.Text := FrmInformaSerial.edtSerial1.Text + '-' +
        FrmInformaSerial.edtSerial2.Text + '-' +
        FrmInformaSerial.edtSerial3.Text;
      arquivo.SaveToFile(RetornaNomeArquivoLicenca());
      arquivo.Free;

      Licenca := TLicenca.Create;
      try
        if not(Licenca.LicencaValida(RetornaNomeArquivoLicenca(),
          TFactory.new.DadosEmitente.CNPJ, Now)) then
          raise Exception.Create('O serial não é válido!');
        CheckLicenca;
      finally
        Licenca.Free;
      end;

    end;
  finally
    FrmInformaSerial.Free;
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
    frmFiltroParcelas := TfrmFiltroParcelas.Create(Self);
    try
      frmFiltroParcelas.ShowModal;
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
    if CheckLicenca() then
    begin
      try

        FrmPedidoVenda := TFrmPedidoVenda.Create(Self);
        try
          FrmPedidoVenda.ShowModal;
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
      MessageDlg('É preciso uma licença para acessar a tela de pedidos!',
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

    frmRecebimento := TfrmRecebimento.Create(Self);
    try
      frmRecebimento.ShowModal;
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

    frmFiltroCliente := TfrmFiltroCliente.Create(Self);
    try
      frmFiltroCliente.ShowModal;
      if not Assigned(frmFiltroCliente.Cliente) then
        abort;

      Cliente := frmFiltroCliente.Cliente;
    finally
      frmFiltroCliente.Free;
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

    frmFiltroDatas := TfrmFiltroDatas.Create(Self);
    try
      if frmFiltroDatas.ShowModal <> mrOk then
        exit;

      DataIncio := frmFiltroDatas.edtDataIncio.Date;
      DataFim := frmFiltroDatas.edtDataFim.Date;
    finally
      frmFiltroDatas.Free;
    end;

    LFactory := TFactory.new(nil, true);

    ProdutosVenda := LFactory.DaoPedido.ProdutosVendidos(DataIncio, DataFim);

    impressao := TRProdutosVendidos.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

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
  frmFiltroVencimento := TfrmFiltroVencimento.Create(Self);
  try
    try
      if frmFiltroVencimento.ShowModal = mrOk then
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
  DataIncio, DataFim: TDate;

  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actRelatorioVendasDoDiaExecute ');
  try

    frmFiltroDatas := TfrmFiltroDatas.Create(Self);
    try
      if frmFiltroDatas.ShowModal <> mrOk then
        exit;

      DataIncio := frmFiltroDatas.edtDataIncio.Date;
      DataFim := frmFiltroDatas.edtDataFim.Date;
    finally
      frmFiltroDatas.Free;
    end;
    LFactory := TFactory.new(nil, true);

    impressao := TRVendasDoDia.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.Imprime(DataIncio,
      DataFim,
      TFactoryEntidades.new.VendedorLogado,
      LFactory.DadosEmitente,
      LFactory.DaoPedido.Totais(DataIncio, DataFim));

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
  Self.Close;
  TLog.d('<<< Saindo de TFrmPrincipal.actSairExecute ');
end;

procedure TFrmPrincipal.actSangriaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actSangriaExecute ');
  FrmSangria := TFrmSangria.Create(Self);
  try
    FrmSangria.setTipo(TSangriaSuprimentoTipo.Sangria);
    FrmSangria.ShowModal;
  finally
    FrmSangria.Free;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actSangriaExecute ');
end;

procedure TFrmPrincipal.actSuprimentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actSuprimentoExecute ');
  FrmSangria := TFrmSangria.Create(Self);
  try
    FrmSangria.setTipo(TSangriaSuprimentoTipo.Suprimento);
    FrmSangria.ShowModal;
  finally
    FrmSangria.Free;
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.actSuprimentoExecute ');
end;

procedure TFrmPrincipal.actVendasDoDiaPorVendedorExecute(Sender: TObject);
var
  impressao: TRVendasDoDia;
  DataIncio, DataFim: TDate;
  Vendedor: TVendedor;
  LFactory: IFactoryDao;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.actVendasDoDiaPorVendedorExecute ');
  try

    frmFiltroDataVendedor := TfrmFiltroDataVendedor.Create(Self);
    try
      if frmFiltroDataVendedor.ShowModal <> mrOk then
        exit;

      DataIncio := frmFiltroDataVendedor.edtDataIncio.Date;
      DataFim := frmFiltroDataVendedor.edtDataFim.Date;
      Vendedor := frmFiltroDataVendedor.Vendedor;
    finally
      frmFiltroDataVendedor.Free;
    end;

    if not Assigned(Vendedor) then
      raise Exception.Create('Vendedor Não selecionado');

    LFactory := TFactory.new(nil, true);

    impressao := TRVendasDoDia.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.Imprime(Vendedor, DataIncio, DataFim, TFactoryEntidades.new.VendedorLogado,
      LFactory.DadosEmitente, LFactory.DaoPedido.Totais(DataIncio, DataFim,
      Vendedor.CODIGO));

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

    frmFiltroDatas := TfrmFiltroDatas.Create(Self);
    try
      if frmFiltroDatas.ShowModal <> mrOk then
        exit;

      DataIncio := frmFiltroDatas.edtDataIncio.Date;
      DataFim := frmFiltroDatas.edtDataFim.Date;
    finally
      frmFiltroDatas.Free;
    end;
    LFactory := TFactory.new(nil, true);

    impressao := TRVendasPorParceiro.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.Imprime(TFactoryEntidades.new.VendedorLogado, DataIncio, DataFim,
      LFactory.DadosEmitente);

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
      frmFiltroVendasParceiro.ShowModal;
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
    Licenca.Free;
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

    // FDIBBackup.Host := TFactory.Conexao.Params.;
    FDIBBackup.Database := LBancoDeDados.Database;
    FDIBBackup.Password := LBancoDeDados.Senhaproxy;
    FDIBBackup.UserName := LBancoDeDados.Usuario;

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
        'O sistema não possúi uma licença de uso. Clique aqui para informar uma nova licença';
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
  Self.Menu := nil;
  TLog.d('<<< Saindo de TFrmPrincipal.ConfiguraMenuLateral ');
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
  // exibir o caption dos botões
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
  // esconder o caption dos botões
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
  frmParcelasVencendo := TfrmParcelasVencendo.Create(Self);
  try
    Atop := lblVencimento.top - frmParcelasVencendo.Height;
    if Atop < 0 then
      Atop := Self.top + 40;

    Aleft := lblVencendo.Left;

    frmParcelasVencendo.Parcelas := AParcelas;
    frmParcelasVencendo.SetTop(Atop);
    frmParcelasVencendo.SetLef(Aleft);
    frmParcelasVencendo.Caption := ACaption;
    frmParcelasVencendo.ShowModal;
  finally
    FreeAndNil(frmParcelasVencendo);
  end;
  TLog.d('<<< Saindo de TFrmPrincipal.ListaParcelas ');
end;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
var
  LVendedorLogado: TVendedor;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.FormActivate ');
  // try
  // CheckLicenca();
  // except
  // end;

  Self.WindowState := TWindowState.wsMaximized;

  if Assigned(TFactoryEntidades.new.VendedorLogado) then
    exit;

  if { DebugHook = 0 } true then
  begin

    // Self.BorderStyle := bsNone;
    SendMessage(Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
    Application.ProcessMessages;

    FrmLogin := TfrmLogin.Create(Self);
    try
      if FrmLogin.ShowModal = mrAbort then
        Halt(0);

      TFactoryEntidades.new.VendedorLogado := FrmLogin.Vendedor;
    finally
      FrmLogin.Free;
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
  Self.BringToFront;

  TLog.d('<<< Saindo de TFrmPrincipal.FormActivate ');
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    FConfigurarDataBase := false;
    InciaLog(true);
    TLog.d('>>> Entrando em  TFrmPrincipal.FormCreate ');
    Self.Menu := nil;

    ReportMemoryLeaksOnShutdown := DebugHook <> 0;

    TVclFuncoes.DisableVclStyles(pnlContainer, 'TPanel');
    TVclFuncoes.DisableVclStyles(pnlContainer, 'TLabel');

    ConfiguraMenuLateral;

    ExibeAtalhos;

    MigrateBD();

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      if E.Message.Contains('una') then
        FConfigurarDataBase := true
      else
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
    ListaErros.Free;
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

  if DebugHook = 0 then
  begin

    frmSplash := TfrmSplash.Create(Self);
    try
      frmSplash.ShowModal;
    finally
      FreeAndNil(frmSplash);
    end;
  end;

  if FConfigurarDataBase then
    exit;

  Inicializar;
  TLog.d('<<< Saindo de TFrmPrincipal.FormShow ');
end;

procedure TFrmPrincipal.Inicializar;
var
  LFactory: IFactoryDao;
  task: ITask;
begin
  TLog.d('>>> Entrando em  TFrmPrincipal.Inicializar ');
  LFactory := TFactory.new(nil, true);
  TFactoryEntidades.setParametros(LFactory.DaoParametros.GetParametros);

  Self.Caption := 'Pedidos - ' + LFactory.DadosEmitente.FANTASIA;
  LFactory.Close;

  VerificaParcelasVencendo;
  if TFactoryEntidades.Parametros.BACKUPDIARIO then
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
      raise Exception.Create('Falha ao verificar parcelas em vencimento: ' +
        E.Message);
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
