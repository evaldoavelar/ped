unit Pedido.Venda;

interface

uses
  system.UITypes, system.Generics.Collections,
  Winapi.Windows, Winapi.Messages, system.SysUtils, system.Variants, system.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.ComCtrls,
  Vcl.ExtCtrls, system.Actions, Vcl.ActnList, JvParameterList,
  Sistema.TFormaPesquisa,
  Dominio.Entidades.TPedido, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TProduto, Dominio.Entidades.TParcelas,
  Factory.Dao, Dao.IDaoPedido, Dao.IDaoVendedor, Dao.IDaoProdutos, Dao.IDaoCliente, JvExExtCtrls, JvExtComponent, JvClock, JvExControls, JvNavigationPane,
  Vcl.Imaging.jpeg, Util.VclFuncoes, Dao.IDaoParcelas, Orcamento.Criar, Vcl.StdCtrls,
  Pedido.InformaParceiro, Dominio.Entidades.TParceiro, parceiro.InformaPagto,
  Vcl.Buttons, Vcl.Imaging.pngimage, Pedido.Venda.IPart, Vcl.WinXCtrls, Pedido.Venda.Part.Item,
  Pedido.Venda.Part.ItemCancelamento, Pedido.Venda.Part.LogoItens,
  Vcl.AutoComplete, Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  IFactory.Dao, Sistema.TParametros;

type

  TFrmPedidoVenda = class(TForm)
    pnlEsquerda: TPanel;
    pnlDireita: TPanel;
    pnlLegenda: TPanel;
    actVenda: TActionList;
    actVoltar: TAction;
    actConsultaVenda: TAction;
    actCancelaItem: TAction;
    actFinalizaVenda: TAction;
    actCancelaPedido: TAction;
    actPesquisaProduto: TAction;
    actConsultaPedido: TAction;
    actOrcamento: TAction;
    actTrocaForma: TAction;
    actInformaParceiro: TAction;
    pnlTopo: TPanel;
    lblStatusVenda: TLabel;
    Panel1: TPanel;
    Image5: TImage;
    Panel6: TPanel;
    Label4: TLabel;
    lblSubTotal: TLabel;
    Label10: TLabel;
    lblTotalItens: TLabel;
    Panel21: TPanel;
    Panel5: TPanel;
    Panel4: TPanel;
    btnIncrementaQuantidade: TSpeedButton;
    btnSubtraiQuantidade: TSpeedButton;
    medtQuantidade: TEdit;
    Panel3: TPanel;
    medtCodigo: TMaskEdit;
    scrItens: TScrollBox;
    Panel24: TPanel;
    Label13: TLabel;
    Panel26: TPanel;
    Panel8: TPanel;
    Label1: TLabel;
    Label14: TLabel;
    Panel27: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Panel12: TPanel;
    Panel25: TPanel;
    Panel28: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Label17: TLabel;
    Label18: TLabel;
    Panel32: TPanel;
    Panel33: TPanel;
    Panel34: TPanel;
    Label26: TLabel;
    Label27: TLabel;
    Panel35: TPanel;
    Panel36: TPanel;
    Panel37: TPanel;
    Label28: TLabel;
    Label29: TLabel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel40: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    Panel41: TPanel;
    Panel42: TPanel;
    Panel43: TPanel;
    Label32: TLabel;
    Label33: TLabel;
    Panel44: TPanel;
    Panel9: TPanel;
    Panel16: TPanel;
    lblBarraHora: TLabel;
    lblBarraData: TLabel;
    Panel20: TPanel;
    Image1: TImage;
    pnl3: TPanel;
    lblEmitente: TLabel;
    svMenuLateralEsquerdo: TSplitView;
    pnl4: TPanel;
    Label35: TLabel;
    Panel45: TPanel;
    Panel46: TPanel;
    btnFecharAtalhos: TSpeedButton;
    lablEsc: TLabel;
    lablIns: TLabel;
    lablDel: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Label21: TLabel;
    lablEnd: TLabel;
    Label8: TLabel;
    pgcEsquerdo: TPageControl;
    tsGeral: TTabSheet;
    tsPagamento: TTabSheet;
    Label2: TLabel;
    Label5: TLabel;
    P_Concluir: TPanel;
    Memo1: TMemo;
    Panel13: TPanel;
    Label9: TLabel;
    Panel14: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label39: TLabel;
    edtTroco: TJvCalcEdit;
    edtValorRecebido: TJvCalcEdit;
    scrBoxPagamentos: TScrollBox;
    tsProduto: TTabSheet;
    Panel15: TPanel;
    pnlPagamentoTopo: TPanel;
    lbl1: TLabel;
    Panel23: TPanel;
    Image6: TImage;
    Panel17: TPanel;
    Image7: TImage;
    lblDescricaoItem: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Panel18: TPanel;
    img3: TImage;
    Label23: TLabel;
    Label24: TLabel;
    lblQuantidadeItem: TLabel;
    Label36: TLabel;
    Label49: TLabel;
    lblValorUnitarioItem: TLabel;
    Panel19: TPanel;
    Panel22: TPanel;
    Label37: TLabel;
    Label38: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    lblValorTotalItem: TLabel;
    Label45: TLabel;
    Image3: TImage;
    actFechaAjuda: TAction;
    Timer1: TTimer;
    lblDataExtencoTopo: TLabel;
    lblDataTopo: TLabel;
    lblHoraTopo: TLabel;
    actExibeAjuda: TAction;
    Label34: TLabel;
    lblVersao: TLabel;
    Panel47: TPanel;
    actIncrementaQuantidade: TAction;
    actSubtraiQuantidade: TAction;
    Label25: TLabel;
    lblCupom: TLabel;
    Panel2: TPanel;
    actMinimizar: TAction;
    Label42: TLabel;
    cbbProduto: TAutoComplete;
    procedure FormCreate(Sender: TObject);
    procedure actVoltarExecute(Sender: TObject);
    procedure actFinalizaVendaExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure medtQuantidadeExit(Sender: TObject);
    procedure medtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure medtCodigoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure medtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure actPesquisaProdutoExecute(Sender: TObject);
    procedure actCancelaItemExecute(Sender: TObject);
    procedure actCancelaPedidoExecute(Sender: TObject);
    procedure actConsultaPedidoExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actOrcamentoExecute(Sender: TObject);
    procedure cbbProduto1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbbProduto1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actTrocaFormaExecute(Sender: TObject);
    procedure actInformaParceiroExecute(Sender: TObject);
    procedure actFechaAjudaExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure actExibeAjudaExecute(Sender: TObject);
    procedure actSubtraiQuantidadeExecute(Sender: TObject);
    procedure actIncrementaQuantidadeExecute(Sender: TObject);
    procedure cbbProduto1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbbProduto1CloseUp(Sender: TObject);
    procedure actMinimizarExecute(Sender: TObject);
    procedure medtQuantidadeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private

    FFactory: IFactoryDao;
    FParametros: TParametros;
    NSeqItem: Integer;
    FblEmVEnda: Boolean;
    Pedido: TPedido;
    DaoPedido: IDaoPedido;
    DaoCliente: IDaoCliente;
    DaoVen: IDaoVendedor;
    DaoProduto: IDaoProdutos;
    daoParcelas: IDaoParcelas;
    CachePesquisa: TStringList;
    FForma: TFormaPesquisa;

    procedure FinalizaVenda;
    procedure IncializaVariaveis;
    procedure IncializaComponentes;
    procedure VendeItemPorCodigo(aCodigo: string);
    procedure AbrePedido;
    function getQuantidade: Double;
    procedure setQuantidade(const Value: Double);
    procedure ValidaQuantidade;
    function getClienteVenda(Padrao: TCliente): TCliente;
    procedure PesquisaProduto;
    procedure RemoveItem;
    function getNumItem: Integer;
    procedure CancelaPedido;
    procedure ParcelaPedido;
    procedure ConsultaPedido;
    procedure GetObservacao;
    procedure Imprime();
    procedure Orcamento;
    procedure SetFormaPesquisaProduto(Forma: TFormaPesquisa);
    // procedure PesquisaProduto:TProduto;

    procedure OnVendeItem(Item: TItemPedido);
    procedure OnExcluiItem(Item: TItemPedido);
    procedure OnPedidoChange(ValorLiquido, ValorBruto: currency; Volume: Double);
    procedure OnParcelas(parcelas: TObjectList<TParcelas>);
    procedure VendeItemPorDescricao(Produto: TProduto);
    procedure LiberaProdutosCbbProduto;
    function GetParceiroVenda: TParceiro;
    procedure InformaVendaParceiro;
    procedure ExibePart(aPart: IPart; aParent: TWinControl; aParams: array of TObject);
    procedure LimpaScrollBox(aScroll: TScrollBox);
    procedure SomaSubtraiQuantidade(aValue: Double);

    function MontaDescricaoPesquisaProduto(const Item: TProduto): string;

    procedure WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo); message WM_GETMINMAXINFO;
    procedure Pagamento;
    procedure BindPagamento(aPagamentos: TPEDIDOPAGAMENTO);
    { Private declarations }

  public
    { Public declarations }
    property Quantidade: Double read getQuantidade write setQuantidade;
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation

uses
  Util.Funcoes, Pedido.SelecionaCliente, Util.Exceptions, Relatorio.TRComprovante.CreditoDebito,
  Consulta.Produto, Pedido.CancelarItem, Filtro.Pedidos, Dominio.Entidades.TFormaPagto.Tipo,
  Pedido.Observacao, Dominio.Entidades.TEmitente, Relatorio.TRPedido,
  Pedido.Pagamento, Pedido.Venda.Part.Pagamento, Sistema.TLog,
  Factory.Entidades, IFactory.Entidades;

resourcestring
  StrPesquisa = '';

{$R *.dfm}


procedure TFrmPedidoVenda.BindPagamento(aPagamentos: TPEDIDOPAGAMENTO);
begin
  TFramePedidoVendaPagamento
    .new(nil)
    .setParams([aPagamentos])
    .SetParent(scrBoxPagamentos)
    .setOnObjectChange(
    procedure(aobj: TObject)
    begin
      aobj.Free;
    end)
    .setup;
end;

procedure TFrmPedidoVenda.FinalizaVenda;
var
  Cliente: TCliente;
  TotalParcelas: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.FinalizaVenda ');
  try
    if not FblEmVEnda then
      raise Exception.Create('O Pedido ainda não foi aberto');

    Cliente := getClienteVenda(Pedido.Cliente);

    // if (not Assigned(Cliente)) or (Cliente.CODIGO = '000000') or (Cliente.CODIGO = '') then
    // exit;

    if FParametros.BLOQUEARCLIENTECOMATRASO and Assigned(Cliente) then
    begin
      TotalParcelas := daoParcelas.GetNumeroDeParcelasVencidas(now, Cliente.CODIGO);
      if TotalParcelas > 0 then
        exit;
    end;

    Pedido.Cliente := Cliente;

    Pagamento();

    // ParcelaPedido();
    //
    if Pedido.Pagamentos.ValorRestante > 0 then
      exit;

    if FParametros.INFORMARPARCEIRONAVENDA then
      Pedido.AddParceiro(GetParceiroVenda());

    if FParametros.EXIBIROBSERVACAO then
      GetObservacao();

    Pedido.STATUS := 'F';
    DaoPedido.FinalizaPedido(Pedido);

    Imprime();

    IncializaVariaveis;

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.FinalizaVenda ');
end;

procedure TFrmPedidoVenda.AbrePedido;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.AbrePedido ');
  try
    FFactory.Conexao.Close;
    FFactory.Conexao.Open;

    if FParametros.PontoVenda.NUMCAIXA = '' then
      raise TValidacaoException.Create('O número do caixa não foi informado!');

    Pedido := TFactoryEntidades.new.Pedido;
    Pedido.OnVendeItem := OnVendeItem;
    Pedido.OnExcluiItem := OnExcluiItem;
    Pedido.OnChange := OnPedidoChange;
    Pedido.OnParcela := OnParcelas;

    Pedido.ID := DaoPedido.GeraID;
    Pedido.NUMERO := Format('%.6d', [Pedido.ID]);
    Pedido.DATAPEDIDO := Date();
    Pedido.HORAPEDIDO := Time();
    Pedido.STATUS := 'A';
    Pedido.Vendedor := DaoVen.GetVendedor(TFactoryEntidades.new.VendedorLogado.CODIGO);
    Pedido.Cliente := TFactoryEntidades.new.Cliente();
    Pedido.Cliente.CODIGO := '000000';
    Pedido.Cliente.NOME := 'Consumidor';
    Pedido.NUMCAIXA := FParametros.PontoVenda.NUMCAIXA;

    DaoPedido.AbrePedido(Pedido);

    lblCupom.Caption := Pedido.NUMERO;
    FblEmVEnda := True;
    lblStatusVenda.Caption := 'EM VENDA';
    LimpaScrollBox(scrItens);
  except
    on E: TValidacaoException do
      raise Exception.Create(E.Message);
    on E: TDaoException do
      raise Exception.Create('Dao: ' + E.Message);
    on E: Exception do
      raise Exception.Create('Falha ao abrir pedido: ' + E.Message);
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.AbrePedido ');
end;

procedure TFrmPedidoVenda.actCancelaItemExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actCancelaItemExecute ');
  RemoveItem;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actCancelaItemExecute ');
end;

procedure TFrmPedidoVenda.actCancelaPedidoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actCancelaPedidoExecute ');
  self.CancelaPedido;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actCancelaPedidoExecute ');
end;

procedure TFrmPedidoVenda.actConsultaPedidoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actConsultaPedidoExecute ');
  ConsultaPedido;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actConsultaPedidoExecute ');
end;

procedure TFrmPedidoVenda.actExibeAjudaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actExibeAjudaExecute ');
  if svMenuLateralEsquerdo.Opened = false then
  begin

    svMenuLateralEsquerdo.Placement := svpRight;
    svMenuLateralEsquerdo.DisplayMode := svmOverlay;
    svMenuLateralEsquerdo.Opened := not svMenuLateralEsquerdo.Opened;
    svMenuLateralEsquerdo.OpenedWidth := 250;
  end
  else
  begin
    actFechaAjuda.Execute;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actExibeAjudaExecute ');
end;

procedure TFrmPedidoVenda.actFechaAjudaExecute(Sender: TObject);
begin
  svMenuLateralEsquerdo.Close;
end;

procedure TFrmPedidoVenda.actFinalizaVendaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actFinalizaVendaExecute ');
  self.FinalizaVenda();
  TLog.d('<<< Saindo de TFrmPedidoVenda.actFinalizaVendaExecute ');
end;

procedure TFrmPedidoVenda.actIncrementaQuantidadeExecute(Sender: TObject);
begin
  try
    SomaSubtraiQuantidade(1);
  except
    on E: Exception do
    begin
      // TLog.d('SomaSubtraiQuantidade: ' + e.Message);
    end;
  end;
end;

procedure TFrmPedidoVenda.SomaSubtraiQuantidade(aValue: Double);
var
  qtd: Double;
begin
  inherited;
  qtd := StrToFloatDef(medtQuantidade.Text, 1);

  qtd := qtd + aValue;

  qtd := TUtil.IFF<Double>(qtd <= 0, qtd, 1);
  qtd := TUtil.IFF<Double>(qtd >= 999, qtd, 999);

  medtQuantidade.Text := qtd.ToString;
end;

procedure TFrmPedidoVenda.actInformaParceiroExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actInformaParceiroExecute ');
  try
    InformaVendaParceiro;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actInformaParceiroExecute ');
end;

procedure TFrmPedidoVenda.actMinimizarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actMinimizarExecute ');
  Application.Minimize;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actMinimizarExecute ');
end;

procedure TFrmPedidoVenda.InformaVendaParceiro;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.InformaVendaParceiro ');
  if FblEmVEnda then
    raise Exception.Create('Não permitido durante a venda');

  FrmParceiroInfoPagto := TFrmParceiroInfoPagto.Create(nil);
  try
    FrmParceiroInfoPagto.ShowModal;
  finally
    FreeAndNil(FrmParceiroInfoPagto);
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.InformaVendaParceiro ');

end;

procedure TFrmPedidoVenda.actOrcamentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actOrcamentoExecute ');
  try
    Orcamento;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actOrcamentoExecute ');
end;

procedure TFrmPedidoVenda.actPesquisaProdutoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actPesquisaProdutoExecute ');
  try
    PesquisaProduto;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actPesquisaProdutoExecute ');
end;

procedure TFrmPedidoVenda.actSubtraiQuantidadeExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actSubtraiQuantidadeExecute ');
  try
    SomaSubtraiQuantidade(-1);
  except
    on E: Exception do
    begin
      // TLog.d('SomaSubtraiQuantidade: ' + e.Message);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actSubtraiQuantidadeExecute ');
end;

procedure TFrmPedidoVenda.actTrocaFormaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actTrocaFormaExecute ');
  try
    case FForma of
      FLeitor:
        begin
          SetFormaPesquisaProduto(TFormaPesquisa.FDescricao);
          cbbProduto.SetFocus;
        end;
      FDescricao:
        begin
          SetFormaPesquisaProduto(TFormaPesquisa.FLeitor);
          medtCodigo.SetFocus;
        end;
    end;
  except
    on E: Exception do
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actTrocaFormaExecute ');
end;

procedure TFrmPedidoVenda.actVoltarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.actVoltarExecute ');
  try
    if FblEmVEnda then
      raise Exception.Create('Cancele ou Finalize a Venda para poder sair');
    Close;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.actVoltarExecute ');
end;

procedure TFrmPedidoVenda.CancelaPedido;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.CancelaPedido ');
  try
    if not FblEmVEnda then
      raise Exception.Create('A Venda não foi aberta');

    if not Assigned(Pedido) then
      raise Exception.Create('Pedido não associado');

    if MessageDlg('Deseja Cancelar O pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Pedido.STATUS := 'C';
      DaoPedido.AtualizaPedido(Pedido);
      IncializaVariaveis;
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.CancelaPedido ');
end;

procedure TFrmPedidoVenda.cbbProduto1CloseUp(Sender: TObject);
begin
  // cbbProduto.Style := TComboBoxStyle.csSimple;
end;

procedure TFrmPedidoVenda.cbbProduto1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  try

    // if Key = VK_DOWN then
    // begin
    // scrItens.Perform(WM_VSCROLL, SB_LINEDOWN, 0);
    // end
    // else if Key = VK_UP then
    // begin
    // scrItens.Perform(WM_VSCROLL, SB_LINEUP, 0);
    // end

  except
    on E: Exception do
  end;
end;

procedure TFrmPedidoVenda.cbbProduto1KeyPress(Sender: TObject; var Key: Char);
var
  Produto: TProduto;
begin
  if Key = #13 then
  begin
    try
      if (cbbProduto.ItemIndex <> -1) and (trim(cbbProduto.Text) <> EmptyStr) then
      begin
        Produto := nil;

        if cbbProduto.ItemIndex > -1 then
        begin
          if cbbProduto.GetSelectObject <> nil then
          begin
            try
              OutputDebugString(PWideChar(cbbProduto.Items.Strings[cbbProduto.ItemIndex]));
              Produto := cbbProduto.GetSelectObject as TProduto;
            except
              raise Exception.Create('Produto não selecionado');
            end;
          end;
        end;

        VendeItemPorDescricao(Produto);
      end
      else
      begin
        VendeItemPorCodigo(cbbProduto.Text);
        cbbProduto.Text := StrPesquisa;
        cbbProduto.SelectAll;
        medtQuantidade.SelectAll;
        // cbbProduto.SetFocus;
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.Message);
        MessageDlg(E.Message, mtError, [mbOK], 0);
        try
          cbbProduto.Text := StrPesquisa;
          cbbProduto.SetFocus;
        except
        end;
      end;
    end;
    Key := #0;
  end
  else if Key = '+' then
  begin
    actIncrementaQuantidade.Execute;
    Key := #0;
  end
  else if Key = '-' then
  begin
    actSubtraiQuantidade.Execute;
    Key := #0;
  end
  // else if Key = #27 then
  // begin
  // cbbProduto.Text := StrPesquisa;
  // cbbProduto.DroppedDown := false;
  // end;
end;

procedure TFrmPedidoVenda.cbbProduto1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  Item: TProduto;
  itens: TObjectList<TProduto>;
  DescricaoProduto: string;
begin
  case Key of
    VK_Multiply:
      begin
        medtQuantidade.Text := Copy(cbbProduto.Text, 1, Length(cbbProduto.Text) - 1);
        try
          StrToFloat(medtQuantidade.Text);
        except
          MessageDlg('Quantidade inválida', mtError, [mbOK], 0);
          medtQuantidade.Text := '1';
          // DesbloqueiaControles;
          LiberaProdutosCbbProduto;
        end;
        // DesbloqueiaControles;
        LiberaProdutosCbbProduto;
      end;
    VK_INSERT:
      begin
        PesquisaProduto;
      end;
    VK_ESCAPE:
      begin
        // cbbProduto.DroppedDown := false;
        cbbProduto.Text := StrPesquisa;
      end
  else
    begin
      if (Length(cbbProduto.Text) > 1) and (cbbProduto.Text <> StrPesquisa) then
      begin
        // if not cbbProduto.AutoDropDown then
        // cbbProduto.AutoDropDown := True;
        // if cbbProduto.Style <> TComboBoxStyle.csDropDown then
        // cbbProduto.Style := TComboBoxStyle.csDropDown;

        // cbbProduto.DroppedDown := True;
        // cbbProduto.AutoComplete := Length(cbbProduto.Text) >= 2;
        // cbbProduto.DropDownWidth := 550;

        if (CachePesquisa.IndexOf(cbbProduto.Text) = -1)
          and (cbbProduto.Items.IndexOf(cbbProduto.Text) = -1)
          and (Key <> VK_RETURN) then
        begin
          OutputDebugString(PWideChar(cbbProduto.Text));
          itens := FFactory.DaoProduto.GetProdutosPorDescricaoParcial(cbbProduto.Text);
          itens.OwnsObjects := false;

          for Item in itens do
          begin
            DescricaoProduto := MontaDescricaoPesquisaProduto(Item);
            if cbbProduto.Items.IndexOf(DescricaoProduto) = -1 then
              cbbProduto.Items.AddObject(DescricaoProduto, Item)
            else
              Item.Free;
          end;

          FreeAndNil(itens);

          CachePesquisa.Add(cbbProduto.Text);
        end;
      end;
    end;
  end;
end;

procedure TFrmPedidoVenda.ConsultaPedido;
begin
  try
    if FblEmVEnda then
      raise Exception.Create('Não permitido durante a venda');

    frmFiltroPedidos := TfrmFiltroPedidos.Create(self);
    try
      frmFiltroPedidos.ShowModal;
    finally
      frmFiltroPedidos.Free;
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;

end;

procedure TFrmPedidoVenda.Pagamento;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.Pagamento ');
  LimpaScrollBox(scrBoxPagamentos);
  pgcEsquerdo.ActivePage := tsPagamento;
  FrmPagamento := TFrmPagamento.Create(self);
  try
    FrmPagamento.Pedido := Pedido;
    FrmPagamento.ShowModal;

    if Pedido.Pagamentos.FormasDePagamento.Count = 0 then
      exit;

    DaoPedido.GravaPgamento(Pedido.Pagamentos);

    Pedido.Troco := Pedido.Pagamentos.Troco;
    Pedido.VALORACRESCIMO := Pedido.Pagamentos.VALORACRESCIMO;

    self.edtTroco.Text := FormatCurr('R$ ###,##0.00', Pedido.Pagamentos.Troco);
    self.edtValorRecebido.Text := FormatCurr('R$ ###,##0.00', Pedido.Pagamentos.ValorRecebido);

    if Pedido.Pagamentos.ContemTipo(TTipoPagto.Crediario) then
      if Pedido.Cliente.CODIGO = '000000' then
        raise Exception.Create('Para a forma de pagamento crediário é preciso informar o cliente');

    for var pagto in Pedido.Pagamentos.FormasDePagamento do
    begin
      BindPagamento(pagto);
    end;

  finally
    FrmPagamento.Free;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.Pagamento ');
end;

procedure TFrmPedidoVenda.ParcelaPedido;
begin
  // FrmParcelamento := TFrmParcelamento.Create(self);
  // try
  // FrmParcelamento.Pedido := Pedido;
  // FrmParcelamento.ShowModal;
  //
  // if Pedido.parcelas.Count = 0 then
  // exit;
  //
  // DaoPedido.GravaParcelas(Pedido.parcelas);
  //
  // finally
  // FrmParcelamento.Free;
  // end;
end;

procedure TFrmPedidoVenda.PesquisaProduto;
var
  Produto: TProduto;
  idx: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.PesquisaProduto ');
  FrmConsultaProdutos := TFrmConsultaProdutos.Create(self);
  try
    FrmConsultaProdutos.ShowModal;

    if Assigned(FrmConsultaProdutos.Produto) then
    begin
      Produto := FrmConsultaProdutos.Produto;

      VendeItemPorDescricao(Produto);

      Produto.Free;

      // case FForma of
      // FLeitor:
      // begin
      // medtCodigo.Text := Produto.CODIGO;
      // FreeAndNil(Produto);
      // end;
      // FDescricao:
      // begin
      // idx := cbbProduto.Items.IndexOf(Produto.DESCRICAO);
      //
      // if idx >= 0 then
      // begin
      // cbbProduto.ItemIndex := idx;
      // FreeAndNil(Produto);
      // end
      // else
      // begin
      // idx := cbbProduto.Items.AddObject(Produto.DESCRICAO, Produto);
      // cbbProduto.ItemIndex := idx;
      // end;
      // end;
      // end;

    end;

  finally
    FrmConsultaProdutos.Free;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.PesquisaProduto ');
end;

procedure TFrmPedidoVenda.RemoveItem;
var
  NumItem: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.RemoveItem ');
  try
    if not FblEmVEnda then
      raise Exception.Create('A Venda não foi aberta');

    if not Assigned(Pedido) then
      raise Exception.Create('Pedido não associado');

    if Pedido.ItemCount = 0 then
      raise Exception.Create('O Pedido ainda não possui itens');

    NumItem := getNumItem();

    Pedido.ExcluiItem(NumItem);

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.RemoveItem ');
end;

procedure TFrmPedidoVenda.SetFormaPesquisaProduto(Forma: TFormaPesquisa);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.SetFormaPesquisaProduto ');
  FForma := Forma;

  case Forma of
    FLeitor:
      begin
        cbbProduto.Visible := false;
        medtCodigo.Visible := True;
        // lblCodigo.Caption := 'Código';
      end;
    FDescricao:
      begin
        // lblCodigo.Caption := 'Descrição do Produto';
        cbbProduto.Visible := True;
        medtCodigo.Visible := false;
        cbbProduto.Top := medtCodigo.Top;
        cbbProduto.Left := medtCodigo.Left;
        // cbbProduto.Width := medtCodigo.Width;
      end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.SetFormaPesquisaProduto ');
end;

procedure TFrmPedidoVenda.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.FormCloseQuery ');
  if FblEmVEnda then
    CanClose := MessageDlg('Deseja sair? O pedido não foi finalizado', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
  TLog.d('<<< Saindo de TFrmPedidoVenda.FormCloseQuery ');
end;

procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.FormCreate ');
  try

    // maximizar sem bordqas
    SendMessage(Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
    self.BorderStyle := bsNone;

    FFactory := TFactory.new(nil, True);
    FParametros := TFactoryEntidades.Parametros;

    if FParametros = nil then
      raise Exception.Create('Parâmetros não configurados');

    TVclFuncoes.DisableVclStyles(self, 'TLabel');
    TVclFuncoes.DisableVclStyles(self, 'TEdit');
    TVclFuncoes.DisableVclStyles(self, 'TMaskEdit');
    TVclFuncoes.DisableVclStyles(self, 'TRichEdit');
    lblBarraData.Caption := FormatDateTime('dd/mm/yyyy', now);
    lblBarraHora.Caption := FormatDateTime('hh:mm', now);

    DaoPedido := FFactory.DaoPedido();
    DaoVen := FFactory.DaoVendedor();
    DaoProduto := FFactory.DaoProduto();
    DaoCliente := FFactory.DaoCliente();
    daoParcelas := FFactory.daoParcelas();

    CachePesquisa := TStringList.Create;

    // remover borda
    // SetWindowRgn(cbbProduto.Handle, CreateRectRgn(2, 2, cbbProduto.Width - 2, cbbProduto.Height - 2), True);
    cbbProduto.DropDownWidth := 600;
    cbbProduto.MaxRowCount := 30;

    SetFormaPesquisaProduto(TFormaPesquisa(FParametros.PESQUISAPRODUTOPOR));

    pgcEsquerdo.Brush.Color := $00F0F0F0;

    for i := 0 to Pred(pgcEsquerdo.PageCount) do
    begin
      pgcEsquerdo.Pages[i].TabVisible := false;
    end;

    pgcEsquerdo.ActivePage := tsGeral;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.FormCreate ');
end;

procedure TFrmPedidoVenda.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.FormDestroy ');
  if Assigned(Pedido) then
    FreeAndNil(Pedido);

  FreeAndNil(CachePesquisa);
  FFactory.Close;
  TLog.d('<<< Saindo de TFrmPedidoVenda.FormDestroy ');
end;

procedure TFrmPedidoVenda.ExibePart(aPart: IPart; aParent: TWinControl; aParams: array of TObject);
begin
  aPart
    .setParams(aParams)
    .SetParent(aParent)
    .setup;
end;

procedure TFrmPedidoVenda.IncializaVariaveis;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.IncializaVariaveis ');
  medtQuantidade.Text := '1';
  lblCupom.Caption := '000000';
  lblStatusVenda.Caption := 'CAIXA LIVRE';
  LimpaScrollBox(scrItens);
  actFechaAjuda.Execute;
  pgcEsquerdo.ActivePage := tsGeral;
  lblSubTotal.Caption := '0';
  lblTotalItens.Caption := '0';
  FblEmVEnda := false;
  NSeqItem := 1;
  cbbProduto.ItemIndex := -1;
  cbbProduto.Text := '';
  if Assigned(Pedido) then
  begin
    // Pedido.Pagamentos.removeObserver(Pedido);
    FreeAndNil(Pedido);
  end;

  case FForma of
    FLeitor:
      begin
        if DebugHook = 1 then
          medtCodigo.Text := '000006'
        else
          medtCodigo.Text := '';
      end;
    FDescricao:
      begin
        try
          cbbProduto.ItemIndex := -1;
          medtQuantidade.SetFocus;
          medtQuantidade.SelectAll;
        except
          on E: Exception do
        end;
      end;
  end;

  try
    ExibePart(TPedidoVendaPartLogoItens.new(nil), scrItens, []);
  except
    on E: Exception do
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.IncializaVariaveis ');
end;

procedure TFrmPedidoVenda.LiberaProdutosCbbProduto;
var
  i: Integer;
begin

  // for i := 0 to cbbProduto.Items.Count - 1 do
  // cbbProduto.Items.Objects[i].Free;

  cbbProduto.Clear;
end;

procedure TFrmPedidoVenda.medtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    self.VendeItemPorCodigo(medtCodigo.Text);
  end;
end;

procedure TFrmPedidoVenda.medtCodigoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.medtCodigoKeyUp ');
  case Key of
    VK_RETURN:
      begin

      end;
    VK_Multiply:
      begin
        medtQuantidade.Text := Copy(medtCodigo.Text, 1, Length(medtCodigo.Text) - 1);
        try
          StrToFloat(medtQuantidade.Text);
        except
          MessageDlg('Quantidade inválida', mtError, [mbOK], 0);
          medtQuantidade.Text := '1';
          // DesbloqueiaControles;
          medtCodigo.Clear;
        end;
        // DesbloqueiaControles;
        medtCodigo.Clear;
      end;
    VK_INSERT:
      begin
        PesquisaProduto;
      end;

  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.medtCodigoKeyUp ');
end;

procedure TFrmPedidoVenda.medtQuantidadeExit(Sender: TObject);
begin
  try
    ValidaQuantidade;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        medtQuantidade.SetFocus;
      except
      end;
    end;
  end;
end;

procedure TFrmPedidoVenda.ValidaQuantidade;
var
  Quant: Double;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.ValidaQuantidade ');
  if medtQuantidade.Text <> '' then
  begin
    Quant := StrToFloat(medtQuantidade.Text);
    StrToFloat(medtQuantidade.Text);
    if StrToFloat(medtQuantidade.Text) <= 0 then
    begin
      raise Exception.Create('A quantidade deve ser superior a 0 (Zero).');
    end;
    if Quant > 9999 then
    begin
      raise Exception.Create('Quantia inválida. A quantidade deve ter até 4 casas decimais.');
    end;
  end
  else
  begin
    raise Exception.Create('A quantidade não pode ser nula.');
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.ValidaQuantidade ');
end;

procedure TFrmPedidoVenda.medtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if Length(medtQuantidade.Text) > 6 then
    begin
      cbbProduto.Text := medtQuantidade.Text;
      medtQuantidade.Text := '1';
      cbbProduto1KeyPress(Sender, Key);
    end
    else
    begin
      try
        case FForma of
          FLeitor:
            medtCodigo.SetFocus;
          FDescricao:
            cbbProduto.SetFocus;
        end;
      except
      end;
    end;
    Key := #0;
  end;
end;

procedure TFrmPedidoVenda.medtQuantidadeKeyUp(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      begin
        PesquisaProduto;
      end;
  end;
end;

function TFrmPedidoVenda.MontaDescricaoPesquisaProduto(const Item: TProduto): string;
begin
  result := Item.DESCRICAO + ' - ' + Item.CODIGO + ' - ' + FormatCurr(' R$ 0.,00', Item.PRECO_VENDA);
end;

procedure TFrmPedidoVenda.OnExcluiItem(Item: TItemPedido);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.OnExcluiItem ');
  DaoPedido.ExcluiItem(Item);
  ExibePart(TPedidoVendaPartItemCancelamento.new(nil), scrItens, [Item]);
  TLog.d('<<< Saindo de TFrmPedidoVenda.OnExcluiItem ');
end;

procedure TFrmPedidoVenda.OnParcelas(parcelas: TObjectList<TParcelas>);
begin

end;

procedure TFrmPedidoVenda.OnPedidoChange(ValorLiquido, ValorBruto: currency; Volume: Double);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.OnPedidoChange ');
  try
    self.lblTotalItens.Caption := FloatToStr(Volume);
  except
    on E: Exception do
      raise Exception.Create('Falha ao obter volume no evento');
  end;

  try
    self.lblSubTotal.Caption := FormatCurr('R$ ###,##0.00', ValorLiquido);
  except
    on E: Exception do
      raise Exception.Create('Falha ao obter volume no evento');
  end;

  try
    self.edtTroco.Text := FormatCurr('R$ ###,##0.00', Pedido.Pagamentos.Troco);
    self.edtValorRecebido.Text := FormatCurr('R$ ###,##0.00', Pedido.Pagamentos.ValorRecebido);
  except
    on E: Exception do
      raise Exception.Create('Falha ao obter troco no evento');
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.OnPedidoChange ');
end;

procedure TFrmPedidoVenda.LimpaScrollBox(aScroll: TScrollBox);
var
  i: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.LimpaScrollBox ');
  for i := aScroll.ControlCount - 1 downto 0 do
  Begin
    aScroll.Controls[i].Free;
  End;
  TLog.d('<<< Saindo de TFrmPedidoVenda.LimpaScrollBox ');
end;

procedure TFrmPedidoVenda.OnVendeItem(Item: TItemPedido);
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.OnVendeItem ');
  DaoPedido.VendeItem(Item);
  DaoPedido.AtualizaPedido(Pedido);

  ExibePart(TPedidoVendaFramePartItem.new(nil), scrItens, [Item]);

  lblValorTotalItem.Caption := FloatToStrF(Item.VALOR_TOTAL, ffNumber, 9, 2);
  lblValorUnitarioItem.Caption := FloatToStrF(Item.VALOR_UNITA, ffNumber, 9, 2);
  lblQuantidadeItem.Caption := FloatToStrF(Item.qtd, ffNumber, 9, 3);
  lblDescricaoItem.Caption := Item.DESCRICAO;
  pgcEsquerdo.ActivePage := tsProduto;

  // redtItens.Lines.Add(StringofChar('0', 3 - Length(IntToStr(item.SEQ))) +
  // IntToStr(item.SEQ) + '  ' + item.CODPRODUTO + '  ' + item.DESCRICAO);
  //
  // redtItens.Lines.Add(StringofChar(' ', 20) +
  // FloatToStrF(item.QTD, ffNumber, 9, 3) +
  // '  ' + item.UND + '    X    ' +
  // FloatToStrF(item.VALOR_UNITA, ffNumber, 9, 2) +
  // StringofChar(' ', 14) + FloatToStrF(item.VALOR_TOTAL, ffNumber, 9, 2));

  // if (item.VALOR_DESCONTO > 0) then
  // redtItens.Lines.Add(StringofChar(' ', 10) + 'Desconto Item : ' +
  // StringofChar(' ', 10) + FloatToStrF(item.VALOR_DESCONTO, ffNumber, 9, 2));
  TLog.d('<<< Saindo de TFrmPedidoVenda.OnVendeItem ');
end;

procedure TFrmPedidoVenda.Orcamento;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.Orcamento ');
  if FblEmVEnda then
    raise Exception.Create('Cancele ou Finalize a Venda para poder Criar um Orçamento');

  FrmCadastroOrcamento := TFrmCadastroOrcamento.Create(self);
  try
    FrmCadastroOrcamento.ShowModal;
  finally
    FrmCadastroOrcamento.Free;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.Orcamento ');
end;

procedure TFrmPedidoVenda.setQuantidade(const Value: Double);
begin

end;

procedure TFrmPedidoVenda.Timer1Timer(Sender: TObject);
var
  DiaSemana: Integer;
  stData: string;
begin
  DiaSemana := DayOfWeek(Date);
  case DiaSemana of
    1:
      stData := 'Domingo,';
    2:
      stData := 'Segunda-feira,';
    3:
      stData := 'Terça-feira,';
    4:
      stData := 'Quarta-feira,';
    5:
      stData := 'Quinta-feira,';
    6:
      stData := 'Sexta-feira,';
    7:
      stData := 'Sabado,';
  end;

  lblBarraData.Caption := FormatDateTime('dd/mm/yyyy', now);
  lblBarraHora.Caption := FormatDateTime('hh:mm', now);

  // lblDiaSemana.Caption := stData + ' ' + FormatDateTime(stFormatoData, Date);
  // .Caption := FormatDateTime(stFormatoData, Date);
  // lblHoraTopo.Caption := FormatDateTime('hh:mm', Time);
  // lblUsuarioTopo.Caption := stNomeUsuario;
  lblDataTopo.Caption := stData;
  lblDataExtencoTopo.Caption := FormatDateTime('d', Date) + ' de ' + FormatDateTime('mmmm', Date) + ' de ' + FormatDateTime('yyyy', Date);
  lblHoraTopo.Caption := FormatDateTime('hh:mm', Time);
  Timer1.Interval := 60000; // 1 minuto

end;

procedure TFrmPedidoVenda.VendeItemPorDescricao(Produto: TProduto);
var

  Item: TItemPedido;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.VendeItemPorDescricao ');
  try

    if not Assigned(Produto) then
      raise Exception.Create('Produto não selecionado');

    // se for quantidade fracionada e produto não vende fracionado
    if (Frac(self.Quantidade) <> 0) and (not Produto.QUANTIDADEFRACIONADA) then
      raise Exception.Create('ATENÇÃO: Produto Unitário com quantidade fracionada');

    if Produto.AVISARESTOQUEBAIXO then
    BEGIN
      VAR
      estoqueBaixo := ((Produto.ESTOQUE - self.Quantidade) <= Produto.ESTOQUEMINIMO);

      if (Produto.ESTOQUE - self.Quantidade) <= 0 then
      begin
        if MessageDlg('PRODUTO SEM ESTOQUE!!! VENDER MESMO ASSIM?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
          Abort;
      end
      else if estoqueBaixo then
        MessageDlg('PRODUTO COM ESTOQUE BAIXO: ' + Produto.DESCRICAO, mtInformation, [mbOK], 0);

    END;

    try
      cbbProduto.Enabled := false;

      if not Assigned(Pedido) then
      begin
        AbrePedido();
      end;

      if not Assigned(Pedido) then
        raise Exception.Create('Pedido não foi aberto');

      try
        Item := TItemPedido.Create;
        Item.SEQ := NSeqItem;
        Item.CODPRODUTO := Produto.CODIGO;
        Item.DESCRICAO := Produto.DESCRICAO;
        Item.UND := Produto.UND;
        Item.qtd := self.Quantidade;
        Item.VALOR_UNITA := Produto.PRECO_VENDA;
        Item.IDPEDIDO := Pedido.ID;
      except
        on E: Exception do
          raise Exception.Create('Falha ao montar Item: ' + E.Message);
      end;

      Pedido.VendeItem(Item);

      inc(NSeqItem);

      // FreeAndNil(Produto);
    finally
      try
        // medtQuantidade.SetFocus;
        medtQuantidade.Text := '1';

        cbbProduto.Enabled := True;
        medtQuantidade.SetFocus;
        cbbProduto.ItemIndex := -1;
        cbbProduto.Text := StrPesquisa;
        LiberaProdutosCbbProduto;
        medtQuantidade.SelectAll;
      except
      end;
    end;

  except
    on E: EAbort do
      exit;
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        cbbProduto.Text := StrPesquisa;
        cbbProduto.SetFocus;
      except
      end;
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.VendeItemPorDescricao ');
end;

procedure TFrmPedidoVenda.VendeItemPorCodigo(aCodigo: string);
var
  Produto: TProduto;
  Item: TItemPedido;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.VendeItemPorCodigo ');
  try
    if aCodigo.isEmpty then
    begin
      TLog.d('Sem códifgo do produto - saindo');
      exit;
    end;

    Produto := nil;

    // codigo
    if Length(aCodigo) <= 6 then
      Produto := DaoProduto.GetProdutoPorCodigo(aCodigo);

    // codigo barras
    if not Assigned(Produto) then
      Produto := DaoProduto.GetProdutoPorCodigoBarras(aCodigo);

    if not Assigned(Produto) then
      raise Exception.Create('Produto não encontrado');

    // se for quantidade fracionada e produto não vende fracionado
    if (Frac(self.Quantidade) <> 0) and (not Produto.QUANTIDADEFRACIONADA) then
      raise Exception.Create('ATENÇÃO: Produto Unitário com quantidade fracionada');

    try
      // medtCodigo.Enabled := false;

      if not Assigned(Pedido) then
      begin
        AbrePedido();
      end;

      if not Assigned(Pedido) then
        raise Exception.Create('Pedido não foi aberto');

      try
        Item := TItemPedido.Create;
        Item.SEQ := NSeqItem;
        Item.CODPRODUTO := Produto.CODIGO;
        Item.DESCRICAO := Produto.DESCRICAO;
        Item.UND := Produto.UND;
        Item.qtd := self.Quantidade;
        Item.VALOR_UNITA := Produto.PRECO_VENDA;
        Item.IDPEDIDO := Pedido.ID;
      except
        on E: Exception do
          raise Exception.Create('Falha ao montar Item: ' + E.Message);
      end;

      Pedido.VendeItem(Item);

      inc(NSeqItem);

      FreeAndNil(Produto);
    finally
      try
        // medtCodigo.Enabled := True;
        // medtCodigo.Text := '';
        medtQuantidade.SetFocus;
        medtQuantidade.Text := '1';
      except
      end;
    end;

  except
    on E: EAbort do
      exit;
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        medtCodigo.Text := '';
        medtCodigo.SetFocus;
      except
      end;
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.VendeItemPorCodigo ');
end;

procedure TFrmPedidoVenda.Imprime;
var
  RelPedido: TRPedido;
  RelComprovanteDC: TRComprovanteCreditoDebito;
  Emitente: TEmitente;
  ParcelasAtrasadas: TObjectList<TParcelas>;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.Imprime ');
  try // todo: buscar dos parametros
    RelPedido := TRPedido.Create(FParametros.ImpressoraTermica);
    RelComprovanteDC := TRComprovanteCreditoDebito.Create(FParametros.ImpressoraTermica);
    ParcelasAtrasadas := FFactory.daoParcelas.GeTParcelasVencidasPorCliente(Pedido.Cliente.CODIGO, now);
    Emitente := FFactory.DadosEmitente;

    try
      RelPedido.ImprimeCupom(
        Emitente,
        Pedido,
        ParcelasAtrasadas
        );
    finally
      FreeAndNil(RelPedido);
      FreeAndNil(ParcelasAtrasadas);
    end;

    try
      RelComprovanteDC.Imprime(FFactory.DadosEmitente, Pedido);
    finally
      FreeAndNil(RelComprovanteDC);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.Imprime ');
end;

procedure TFrmPedidoVenda.IncializaComponentes;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.IncializaComponentes ');
  try

    case FForma of
      FLeitor:
        medtCodigo.SetFocus;
      FDescricao:
        medtQuantidade.SetFocus;
    end;
    cbbProduto.ItemIndex := -1;
  except
    on ex: Exception do
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.IncializaComponentes ');
end;

procedure TFrmPedidoVenda.FormShow(Sender: TObject);
var
  Emitente: TEmitente;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.FormShow ');
  IncializaVariaveis();
  IncializaComponentes();

  Emitente := FFactory.DadosEmitente;

  if Assigned(Emitente) then
    lblEmitente.Caption := 'VENDEDOR: ' + TFactoryEntidades.new.VendedorLogado.NOME
  else
    lblEmitente.Caption := '';

  lblEmitente.Caption := TFactoryEntidades.Parametros.PontoVenda.NUMCAIXA + ' - ' + lblEmitente.Caption;

  TLog.d('<<< Saindo de TFrmPedidoVenda.FormShow ');
end;

function TFrmPedidoVenda.getClienteVenda(Padrao: TCliente): TCliente;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.getClienteVenda ');
  FrmInfoCliente := TFrmInfoCliente.Create(self);
  try
    FrmInfoCliente.Cliente := Padrao;
    FrmInfoCliente.ShowModal;
    result := FrmInfoCliente.Cliente;
  finally
    FrmInfoCliente.Free;
    FrmInfoCliente := nil;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.getClienteVenda ');
end;

function TFrmPedidoVenda.getNumItem: Integer;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.getNumItem ');
  FrmCancelarItem := TFrmCancelarItem.Create(self);
  try
    FrmCancelarItem.Top := self.Top + 120;
    FrmCancelarItem.Left := self.Left + 60;
    FrmCancelarItem.ShowModal;

    result := FrmCancelarItem.NumItem;
  finally
    FrmCancelarItem.Free;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.getNumItem ');
end;

function TFrmPedidoVenda.GetParceiroVenda: TParceiro;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.GetParceiroVenda ');
  FrmPedidoInformaParceiroVenda := TFrmPedidoInformaParceiroVenda.Create(self);
  try
    FrmPedidoInformaParceiroVenda.ParceiroVenda := Pedido.ParceiroVenda;
    FrmPedidoInformaParceiroVenda.ShowModal;
    result := FrmPedidoInformaParceiroVenda.ParceiroVenda;
  finally
    FrmPedidoInformaParceiroVenda.Free;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.GetParceiroVenda ');
end;

procedure TFrmPedidoVenda.GetObservacao;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.GetObservacao ');
  frmObservacao := TfrmObservacao.Create(self);
  try
    frmObservacao.Pedido := Pedido;
    frmObservacao.ShowModal;
  finally
    frmObservacao.Free;
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.GetObservacao ');
end;

function TFrmPedidoVenda.getQuantidade: Double;
begin
  TLog.d('>>> Entrando em  TFrmPedidoVenda.getQuantidade ');
  try
    ValidaQuantidade;
    result := StrToFloat(medtQuantidade.Text)
  except
    on E: Exception do
      raise Exception.Create('Quantidade Inválida ' + E.Message);
  end;
  TLog.d('<<< Saindo de TFrmPedidoVenda.getQuantidade ');
end;

procedure TFrmPedidoVenda.WMGetMinmaxInfo(var Msg: TWMGetMinmaxInfo);
var
  R: TRect;
begin
  inherited;

  // Obtem o retangulo com a area livre do desktop
  SystemParametersInfo(SPI_GETWORKAREA, SizeOf(R), @R, 0);

  Msg.MinMaxInfo^.ptMaxPosition := R.TopLeft;
  OffsetRect(R, -R.Left, -R.Top);
  Msg.MinMaxInfo^.ptMaxSize := R.BottomRight;

end;

end.
