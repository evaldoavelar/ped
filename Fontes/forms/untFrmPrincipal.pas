unit untFrmPrincipal;

interface

uses
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.UITypes,
  System.Classes, Vcl.Graphics, System.Threading,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  JvExExtCtrls, JvExtComponent, JvClock, Vcl.StdCtrls, JvExControls,
  JvNavigationPane, Data.DB,
  Vcl.ActnList, Vcl.Menus,
  Dao.IDaoParcelas, System.Actions, Vcl.Imaging.jpeg,
  FireDAC.Stan.Def, FireDAC.Phys.IBWrapper, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  Dominio.Entidades.TParcelas, Sistema.TLicenca, Licenca.InformaSerial, Util.Exceptions, Util.VclFuncoes, Orcamento.Criar, Helper.TLiveBindingFormatCurr,
  Filtro.Orcamentos, Relatorio.TRVendasDoDia, Filtro.Datas, Filtro.DatasVendedor, Dominio.Entidades.TVendedor,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Phys.FBDef, Relatorio.TRParcelasCliente, Dominio.Entidades.TCliente, Pedido.SelecionaCliente, Filtro.Cliente,
  Relatorio.TRProdutosVendidos, Helper.TProdutoVenda, parceiro.InformaPagto, Cadastros.parceiro,
  Cadastros.parceiro.FormaPagto, Filtro.VendasParceiro, Relatorio.TRVendasPorParceiro, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, Vcl.CategoryButtons, Vcl.WinXCtrls,
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
    Action2: TAction;
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
    procedure lblVencimentoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
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
  private
    { Private declarations }
    DaoParcelas: IDaoParcelas;
    procedure ExibeVencidos;
    procedure ExibeVencendo;
    procedure Backup(arquivo: string; force: Boolean = false);
    function RetornaNomeArquivoBackup(): string;
    function RetornaNomeArquivoLicenca(): string;
    procedure MigrateBD;
    procedure ListaParcelas(ACaption: string; AParcelas: TObjectList<TParcelas>);
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
    procedure WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  Pedido.Venda, Util.Funcoes, Recebimento.Recebe, Dominio.Entidades.TFactory, Cadastros.Cliente, Cadastros.FormaPagto,
  Cadastros.Vendedor, Cadastros.Produto, Cadastros.Fornecedor, Configuracoes.Parametros, Splash.Form,
  Dominio.Entidades.TEmitente, Recebimento.ListaParcelas, Sistema.TParametros, Login.FrmLogin,
  Filtro.Vencimento, Filtro.Parcelas,
  Database.IDataseMigration, Database.TDataseMigrationBase, Filtro.Pedidos, Grafico.Pedidos;

{$R *.dfm}


procedure TFrmPrincipal.actAbreMenuExecute(Sender: TObject);
begin
  if svMenuLateralEsquerdo.Opened then
    FecharMenuLateralEsquerdo
  else
    AbrirMenuLateralEsquerdo;
end;

procedure TFrmPrincipal.actAjudaExecute(Sender: TObject);
begin
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
end;

procedure TFrmPrincipal.actBackupExecute(Sender: TObject);
var
  arquivo: string;
begin
  try
    arquivo := RetornaNomeArquivoBackup();
    Backup(arquivo);
    MessageDlg(Format('Backup feito em: %s', [arquivo]), mtInformation, [mbOK], 0);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actCadastroFormaPagtoParceiroExecute(Sender: TObject);
begin
  try
    FrmCadastroFormaPagtoParceiro := TFrmCadastroFormaPagtoParceiro.Create(Self);
    try

      FrmCadastroFormaPagtoParceiro.ShowModal;
    finally
      FreeAndNil(FrmCadastroFormaPagtoParceiro);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actCadastroParceiroExecute(Sender: TObject);
begin
  try
    frmCadastroParceiro := TfrmCadastroParceiro.Create(Self);
    try

      frmCadastroParceiro.ShowModal;
    finally
      FreeAndNil(frmCadastroParceiro);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actCadastrosExecute(Sender: TObject);
begin
  catbtnCadastros.Color := $00955200;
  pgcMenu.ActivePage := tsCadastro;
  AbreSubMenu;

end;

procedure TFrmPrincipal.actCadClientesExecute(Sender: TObject);
begin
  try
    frmCadastroCliente := TfrmCadastroCliente.Create(Self);
    try

      frmCadastroCliente.ShowModal;
    finally
      FreeAndNil(frmCadastroCliente);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actCadFormaPagtoExecute(Sender: TObject);
begin

  try
    frmCadastroFormaPagto := TfrmCadastroFormaPagto.Create(Self);
    try
      frmCadastroFormaPagto.ShowModal;
    finally
      FreeAndNil(frmCadastroFormaPagto);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actCadFornecedorExecute(Sender: TObject);
begin
  try
    frmCadastroFornecedor := TfrmCadastroFornecedor.Create(Self);
    try
      frmCadastroFornecedor.ShowModal;
    finally
      FreeAndNil(frmCadastroFornecedor);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actCadProdutosExecute(Sender: TObject);
begin
  try
    frmCadastroProduto := TfrmCadastroProduto.Create(Self);
    try
      frmCadastroProduto.ShowModal;
    finally
      FreeAndNil(frmCadastroProduto);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actCadVendedorExecute(Sender: TObject);
begin
  try
    if not TFactory.VendedorLogado.PODEACESSARCADASTROVENDEDOR then
      raise Exception.Create('Vendedor não tem permissão para acessar cadastro de vendedores');

    frmCadastroVendedor := TfrmCadastroVendedor.Create(Self);
    try
      frmCadastroVendedor.ShowModal;
    finally
      FreeAndNil(frmCadastroVendedor);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actParametrosExecute(Sender: TObject);
begin
  try
    FrmConfiguracoes := TFrmConfiguracoes.Create(Self);
    try
      FrmConfiguracoes.ShowModal;
    finally
      FreeAndNil(FrmConfiguracoes);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actConfiguracoesExecute(Sender: TObject);
begin
  pgcMenu.ActivePage := tsConfiguracoes;
  AbreSubMenu;
end;

procedure TFrmPrincipal.actConsultaOrcamentoExecute(Sender: TObject);
begin
  try
    frmFiltroOrcamentos := TfrmFiltroOrcamentos.Create(Self);
    try
      frmFiltroOrcamentos.ShowModal;
    finally
      FreeAndNil(frmFiltroOrcamentos);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actConsultaPedidoExecute(Sender: TObject);
begin
  try
    frmFiltroPedidos := TfrmFiltroPedidos.Create(Self);
    try
      frmFiltroPedidos.ShowModal;
    finally
      FreeAndNil(frmFiltroPedidos);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actConsultasExecute(Sender: TObject);
begin
  pgcMenu.ActivePage := tsConsulta;
  AbreSubMenu;
end;

procedure TFrmPrincipal.actGraficoPedidosExecute(Sender: TObject);
begin
  try
    frmGraficoPedidos := TfrmGraficoPedidos.Create(Self);
    try
      frmGraficoPedidos.ShowModal;
    finally
      FreeAndNil(frmGraficoPedidos);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actInformaSerialExecute(Sender: TObject);
begin
  try
    InformarSerial();
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actInformaVendaParceiroExecute(Sender: TObject);
begin
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
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actLoginLogoffExecute(Sender: TObject);
begin
  try
    FrmLogin := TfrmLogin.Create(Self);
    try
      if FrmLogin.ShowModal = mrAbort then
        abort;

      TFactory.VendedorLogado := FrmLogin.Vendedor;

      DefineLabelVendedor();
    finally
      FrmLogin.Free;
    end;
  except
    on E: EAbort do
      exit;
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actMinimizarExecute(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TFrmPrincipal.actOrcamentoExecute(Sender: TObject);
begin
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
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.InformarSerial();
var
  Licenca: TLicenca;
  arquivo: tstringlist;
begin
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
        if not(Licenca.LicencaValida(RetornaNomeArquivoLicenca(), TFactory.DadosEmitente.CNPJ, now)) then
          raise Exception.Create('O serial não é válido!');
        CheckLicenca;
      finally
        Licenca.Free;
      end;

    end;
  finally
    FrmInformaSerial.Free;
  end;
end;

procedure TFrmPrincipal.DefineLabelVendedor;
begin

  lblUsuario.Caption := TFactory.VendedorLogado.NOME

end;

procedure TFrmPrincipal.actParcelasExecute(Sender: TObject);
begin
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
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actPedidoVendaExecute(Sender: TObject);
begin
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
          MessageDlg(E.Message, mtError, [mbOK], 0);
      end;
    end
    else
    begin
      MessageDlg('É preciso uma licença para acessar a tela de pedidos!', mtError, [mbOK], 0);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actRecebimentoExecute(Sender: TObject);
begin
  try
    FechaSubMenu;
    if not TFactory.VendedorLogado.PODERECEBERPARCELA then
      raise Exception.Create('Vendedor não tem permissão para acessar recebimento de parcelas');

    frmRecebimento := TfrmRecebimento.Create(Self);
    try
      frmRecebimento.ShowModal;
      VerificaParcelasVencendo;
    finally
      FreeAndNil(frmRecebimento);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actRelatorioParcelasClienteExecute(Sender: TObject);
var
  impressao: TRParcelasCliente;
  Cliente: TCliente;
  parcelasVencidas: TObjectList<TParcelas>;
  parcelasVencendo: TObjectList<TParcelas>;
begin
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

    if (not Assigned(Cliente)) or (Cliente.CODIGO = '000000') or (Cliente.CODIGO = '') then
      abort;

    parcelasVencidas := TFactory.DaoParcelas.GeTParcelasVencidasPorCliente(Cliente.CODIGO, now);
    parcelasVencendo := TFactory.DaoParcelas.GeTParcelasVencendoPorCliente(Cliente.CODIGO, now);

    impressao := TRParcelasCliente.Create(TFactory.Parametros.Impressora);

    impressao.Imprime(
      Cliente,
      TFactory.DadosEmitente,
      parcelasVencidas,
      parcelasVencendo
      );

    FreeAndNil(Cliente);
    FreeAndNil(impressao);
    FreeAndNil(parcelasVencidas);
    FreeAndNil(parcelasVencendo);

  except
    on E: EAbort do
      exit;
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end; //

end;

procedure TFrmPrincipal.actRelatorioProdutosVendidosExecute(Sender: TObject);
var
  impressao: TRProdutosVendidos;
  DataIncio, DataFim: TDate;
  ProdutosVenda: TList<TProdutoVenda>;
begin
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

    ProdutosVenda := TFactory.DaoPedido.ProdutosVendidos(DataIncio, DataFim);

    impressao := TRProdutosVendidos.Create(TFactory.Parametros.Impressora);

    impressao.Imprime(
      DataIncio,
      DataFim,
      TFactory.VendedorLogado,
      TFactory.DadosEmitente,
      ProdutosVenda);

    FreeAndNil(ProdutosVenda);
    FreeAndNil(impressao);

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end; //

end;

procedure TFrmPrincipal.actRelatoriosExecute(Sender: TObject);
begin
  pgcMenu.ActivePage := tsRelatorios;
  AbreSubMenu;
end;

procedure TFrmPrincipal.actRelatorioVencendoExecute(Sender: TObject);
var
  Parcelas: TObjectList<TParcelas>;
begin
  frmFiltroVencimento := TfrmFiltroVencimento.Create(Self);
  try
    try
      if frmFiltroVencimento.ShowModal = mrOk then
      begin
        Parcelas := DaoParcelas.GetParcelaVencendoObj(frmFiltroVencimento.edtDataIncio.Date, frmFiltroVencimento.edtDataFim.Date);
        ListaParcelas('Parcelas Vencendo', Parcelas);

        if Assigned(Parcelas) then
          FreeAndNil(Parcelas);
      end;
    finally
      FreeAndNil(frmFiltroVencimento);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actRelatorioVencidasExecute(Sender: TObject);
var
  Parcelas: TObjectList<TParcelas>;
begin

  try
    Parcelas := DaoParcelas.GetParcelaVencidasObj(now);
    ListaParcelas('Parcelas Vencidas', Parcelas);

    if Assigned(Parcelas) then
      FreeAndNil(Parcelas);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;

end;

procedure TFrmPrincipal.actRelatorioVendasDoDiaExecute(Sender: TObject);
var
  impressao: TRVendasDoDia;
  DataIncio, DataFim: TDate;
begin
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

    impressao := TRVendasDoDia.Create(TFactory.Parametros.Impressora);

    impressao.Imprime(
      DataIncio,
      DataFim,
      TFactory.VendedorLogado,
      TFactory.DadosEmitente,
      TFactory.DaoPedido.Totais(DataIncio, DataFim));

    FreeAndNil(impressao);

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end; //
end;

procedure TFrmPrincipal.actSairExecute(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmPrincipal.actVendasDoDiaPorVendedorExecute(Sender: TObject);
var
  impressao: TRVendasDoDia;
  DataIncio, DataFim: TDate;
  Vendedor: TVendedor;
begin
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

    impressao := TRVendasDoDia.Create(TFactory.Parametros.Impressora);

    impressao.Imprime(
      Vendedor,
      DataIncio,
      DataFim,
      TFactory.VendedorLogado,
      TFactory.DadosEmitente,
      TFactory.DaoPedido.Totais(DataIncio, DataFim, Vendedor.CODIGO));

    FreeAndNil(impressao);

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end; //

end;

procedure TFrmPrincipal.actVendasPorParceiroExecute(Sender: TObject);
var
  impressao: TRVendasPorParceiro;
  DataIncio, DataFim: TDate;
begin
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

    impressao := TRVendasPorParceiro.Create(TFactory.Parametros.Impressora);

    impressao.Imprime(
      TFactory.VendedorLogado,
      DataIncio,
      DataFim,
      TFactory.DadosEmitente);

    FreeAndNil(impressao);

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actFiltroVendasParceiroExecute(Sender: TObject);
begin

  try
    frmFiltroVendasParceiro := TfrmFiltroVendasParceiro.Create(nil);
    try
      frmFiltroVendasParceiro.ShowModal;
    finally
      FreeAndNil(frmFiltroVendasParceiro);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.actVerVencimentoExecute(Sender: TObject);
var
  Licenca: TLicenca;
begin

  Licenca := TLicenca.Create;
  try
    if (Licenca.LicencaValida(RetornaNomeArquivoLicenca(), TFactory.DadosEmitente.CNPJ, now)) then
      MessageDlg('Licença válida de ' + DateToStr(Licenca.DataDeIncio) + ' até ' + DateToStr(Licenca.DataVencimento)
        + #13 + 'CNPJ: ' + TUtil.PadL(Licenca.cnpjLicenca, 14, '*'), mtInformation, [mbOK], 0)
    else
      raise Exception.Create('O sistema não possui uma licença válida');
  finally
    Licenca.Free;
  end;

end;

procedure TFrmPrincipal.Backup(arquivo: string; force: Boolean = false);
begin
  try
    // se não for backup forçado
    if not force then
      // se arquivo existe, não realiza o backup
      if FileExists(arquivo) then
        exit;

    // FDIBBackup.Host := TFactory.Conexao.Params.;
    FDIBBackup.Database := TFactory.Conexao.Params.Database;
    FDIBBackup.Password := TFactory.Conexao.Params.Password;
    FDIBBackup.UserName := TFactory.Conexao.Params.UserName;

    FDIBBackup.BackupFiles.Clear;
    FDIBBackup.BackupFiles.Add(arquivo);

    FDIBBackup.Backup;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TFrmPrincipal.catbtnCadastrosClick(Sender: TObject);
begin
  FechaSubMenu();
end;

function TFrmPrincipal.CheckLicenca: Boolean;
var
  Licenca: TLicenca;
  CNPJ: string;
begin
  exit(true);
  result := false;
  pnlLicenca.Visible := false;

  CNPJ := '';

  if Assigned(TFactory.DadosEmitente) then
    CNPJ := TFactory.DadosEmitente.CNPJ;

  Licenca := TLicenca.Create;
  try

    if FileExists(RetornaNomeArquivoLicenca()) then
    begin
      try
        if not Licenca.LicencaValida(RetornaNomeArquivoLicenca(), CNPJ, now) then
        begin
          result := (Licenca.DiasRestantes >= 0) and Licenca.CnpjIguais;

          if Licenca.DiasRestantes < 0 then
          begin
            lblLicenca.Caption := 'A Licença do sistema está vencida. Clique aqui para informar uma nova licença';
            pnlLicenca.Visible := true;
          end
          else if Licenca.DiasRestantes < 30 then
          begin
            lblLicenca.Caption :=
              Format('A Licença do sistema estará vencendo em %d dias. Evite o bloqueio do sistema e solicite uma nova licença', [Licenca.DiasRestantes]);
            pnlLicenca.Visible := true;
          end
          else if not Licenca.CnpjIguais then
          begin
            lblLicenca.Caption := ('A Licença não pertence ao CNPJ! Clique aqui para informar uma nova licença');
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
          lblLicenca.Caption := E.Message + ' - Clique aqui para informar uma nova licença';
          pnlLicenca.Visible := true;
        end;
      end;
    end
    else
    begin
      lblLicenca.Caption := 'O sistema não possúi uma licença de uso. Clique aqui para informar uma nova licença';
      pnlLicenca.Visible := true;
    end;

  finally
    FreeAndNil(Licenca);
  end;

end;

function TFrmPrincipal.RetornaNomeArquivoBackup(): string;
var
  diretorio: string;
begin
  diretorio := TUtil.DiretorioApp + 'backup';
  if not DirectoryExists(diretorio) then
    CreateDir(diretorio);
  result := Format('%s\bkp-%s.fbk', [diretorio, FormatDateTime('dd-mm-yyyy', now)]);
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
  svSubMenu.Open;
  svSubMenu.DisplayMode := svmOverlay;
  svSubMenu.Left := svMenuLateralEsquerdo.Width;
end;

procedure TFrmPrincipal.FechaSubMenu;
begin
  svSubMenu.Close;
  svSubMenu.CloseStyle := svcCollapse;
  svSubMenu.DisplayMode := svmOverlay;
end;

procedure TFrmPrincipal.ConfiguraMenuLateral;
var
  i: Integer;
begin

  for i := 0 to Pred(pgcMenu.PageCount) do
  begin
    pgcMenu.Pages[i].TabVisible := false;

  end;

  // FecharMenuLateralEsquerdo();
  AbrirMenuLateralEsquerdo;
  FechaSubMenu;
  FecharMenuLateralDireito();
  Self.Menu := nil;
end;

procedure TFrmPrincipal.FecharMenuLateralDireito;
begin
  svMenuLateralDireito.Close;
  svMenuLateralDireito.CloseStyle := svcCollapse;
  svMenuLateralDireito.DisplayMode := svmOverlay;
end;

procedure TFrmPrincipal.AbrirMenuLateralEsquerdo;
begin
  // abrir o menu
  svMenuLateralEsquerdo.Open;
  svMenuLateralEsquerdo.DisplayMode := svmDocked;
  // exibir o caption dos botões
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions + [boShowCaptions];
  FechaSubMenu;
end;

procedure TFrmPrincipal.FecharMenuLateralEsquerdo;
begin
  // fecha o menu no estilo compacto
  svMenuLateralEsquerdo.Close;
  svMenuLateralEsquerdo.CloseStyle := svcCompact;
  svMenuLateralEsquerdo.DisplayMode := svmOverlay;
  // esconder o caption dos botões
  catMenuItems.ButtonOptions := catMenuItems.ButtonOptions - [boShowCaptions];

  FechaSubMenu;
end;

procedure TFrmPrincipal.ExibeVencendo;
var
  Parcelas: TObjectList<TParcelas>;
begin
  Parcelas := DaoParcelas.GetParcelaVencendoObj(now, IncMonth(now, 2));
  ListaParcelas('Parcelas Vencendo', Parcelas);
  if Assigned(Parcelas) then
    FreeAndNil(Parcelas);
end;

procedure TFrmPrincipal.ExibeVencidos;
var
  Parcelas: TObjectList<TParcelas>;
begin
  Parcelas := DaoParcelas.GetParcelaVencidasObj(now);
  ListaParcelas('Parcelas Vencidas', Parcelas);

  if Assigned(Parcelas) then
    FreeAndNil(Parcelas);
end;

procedure TFrmPrincipal.ListaParcelas(ACaption: string; AParcelas: TObjectList<TParcelas>);
var
  Aleft, Atop: Integer;
begin

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

end;

procedure TFrmPrincipal.FormActivate(Sender: TObject);
begin
  try
    CheckLicenca();
  except
  end;

  if Assigned(TFactory.VendedorLogado) then
    exit;

  if DebugHook = 0 then
  begin

    // Self.BorderStyle := bsNone;
    SendMessage(Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
    Application.ProcessMessages;

    FrmLogin := TfrmLogin.Create(Self);
    try
      if FrmLogin.ShowModal = mrAbort then
        Halt(0);

      TFactory.VendedorLogado := FrmLogin.Vendedor;
    finally
      FrmLogin.Free;
    end;
  end
  else
  begin
    TFactory.VendedorLogado := TFactory.Vendedor;
    TFactory.VendedorLogado.CODIGO := '001';
    TFactory.VendedorLogado.NOME := 'Debug';
    TFactory.VendedorLogado.PODEACESSARCADASTROVENDEDOR := true;
    TFactory.VendedorLogado.PODECANCELARPEDIDO := true;
    TFactory.VendedorLogado.PODERECEBERPARCELA := true;
    TFactory.VendedorLogado.PODECANCELARORCAMENTO := true;

  end;
  DefineLabelVendedor();
  Self.WindowState := TWindowState.wsMaximized;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  try
    Self.Menu := nil;

    ReportMemoryLeaksOnShutdown := DebugHook <> 0;

    MigrateBD();

    TVclFuncoes.DisableVclStyles(pnlContainer, 'TPanel');
    TVclFuncoes.DisableVclStyles(pnlContainer, 'TLabel');
    DaoParcelas := TFactory.DaoParcelas;

    ConfiguraMenuLateral;

    ExibeAtalhos;

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPrincipal.ExibeAtalhos;
var
  i: Integer;
begin
  for i := 0 to actPrincipal.ActionCount - 1 do
  begin
    if actPrincipal.Actions[i].ShortCut <> 0 then
    begin
      with TLabel.Create(pnlAtalhos) do
      begin
        Caption := TUtil.PadR(ShortCutToText(actPrincipal.Actions[i].ShortCut), 15, ' ') + actPrincipal.Actions[i].Caption;
        Parent := pnlAtalhos;
        AlignWithMargins := true;
        Font.Color := $005E4934;
        Font.Style := [fsBold];
        // Align := alBottom;
        Align := alTop;
      end;
    end;

  end;

end;

procedure TFrmPrincipal.MigrateBD;
var
  migrate: IDataseMigration;
  Erros: TDictionary<TClass, string>;
  ListaErros: TStringBuilder;
  key: TClass;
begin
  migrate := TDataseMigrationBase.Create(tpFirebird);
  migrate.migrate();
  Erros := migrate.GetErros();

  if Erros.Count > 0 then
  begin
    ListaErros := TStringBuilder.Create;
    ListaErros.Append('Os seguintes erros foram encontrados na atualização do banco de dados');
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
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
  task: ITask;
begin
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

  VerificaParcelasVencendo;

  Self.Caption := 'Pedidos - ' + TFactory.DadosEmitente.FANTASIA;

  if TFactory.Parametros.BACKUPDIARIO then
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
      end
      );
    task.Start;
  end;

end;

procedure TFrmPrincipal.Image3Click(Sender: TObject);
var
  Z: TPoint;
begin
  Z.X := 0;
  Z.Y := TImage(Sender).ClientHeight;
  Z := TImage(Sender).ClientToScreen(Z);
  popUpUsuario.Popup(Z.X, Z.Y);
end;

procedure TFrmPrincipal.imgMenuClick(Sender: TObject);
begin
  actAbreMenu.Execute;
end;

procedure TFrmPrincipal.imgNFCEDblClick(Sender: TObject);
begin
  actPedidoVenda.Execute;
end;

procedure TFrmPrincipal.lblVencendoClick(Sender: TObject);
begin
  ExibeVencendo;
end;

procedure TFrmPrincipal.lblVencimentoClick(Sender: TObject);
begin
  ExibeVencidos;
end;

procedure TFrmPrincipal.lblVencimentoMouseLeave(Sender: TObject);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style - [fsUnderline];

end;

procedure TFrmPrincipal.lblVencimentoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  TLabel(Sender).Font.Style := TLabel(Sender).Font.Style + [fsUnderline];

end;

procedure TFrmPrincipal.VerificaParcelasVencendo;
var
  vencendo: Integer;
  vencidas: Integer;
begin
  try
    vencendo := DaoParcelas.GetNumeroDeParcelasVencendo(now, IncMonth(now, 2));

    if vencendo > 0 then
    begin
      lblVencendo.Caption := Format('%d Parcelas vencendo nos próximos 60 dias.', [vencendo]);
      lblVencendo.Visible := true;
    end
    else
      lblVencendo.Visible := false;

    vencidas := DaoParcelas.GetNumeroDeParcelasVencidas(now);

    if vencidas > 0 then
    begin
      lblVencimento.Caption := Format('%d Parcelas Vencidas.', [vencidas]);
      lblVencimento.Visible := true;
    end
    else
      lblVencimento.Visible := false;
  except
    on E: Exception do
      raise Exception.Create('Falha ao verificar parcelas em vencimento: ' + E.Message);
  end;
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
