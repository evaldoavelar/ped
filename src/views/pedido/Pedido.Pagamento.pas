unit Pedido.Pagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Dominio.Entidades.CondicaoPagto,
  Dominio.Entidades.TPedido, System.Actions, Vcl.ActnList, Dominio.Entidades.TFormaPagto,
  System.Generics.Collections, Dominio.Entidades.Pedido.Pagamentos, Dominio.Entidades.TCliente,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento;

type

  TOnSetDesconto = reference to procedure(aTipo: TTipoDesconto; aValor: currency);
  TOnGetValorLiquido = reference to function: currency;
  TOnGetValorBruto = reference to function: currency;
  TOnGetValorDesc = reference to function: currency;

  TFrmPagamento = class(TfrmBase)
    pnl2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    pnlImage4: TPanel;
    lblValorLiquido: TLabel;
    Image3: TPanel;
    lblValorTotal: TLabel;
    pnlCentro: TPanel;
    img2: TImage;
    labForma: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lvFormaPagto: TListBox;
    lvCondicaoPagamento: TListBox;
    pnlData: TPanel;
    Panel1: TPanel;
    pnl3: TPanel;
    lbl1: TLabel;
    btnOK: TBitBtn;
    btnCancelar: TBitBtn;
    edtValorPagto: TEdit;
    Label2: TLabel;
    Panel2: TPanel;
    lblValorPago: TLabel;
    Panel3: TPanel;
    lblValorRestante: TLabel;
    Label8: TLabel;
    Panel4: TPanel;
    lblTroco: TLabel;
    ActionList1: TActionList;
    actCancelar: TAction;
    actExcluirPagamento: TAction;
    actFinalizaPagamento: TAction;
    scrBoxPagamentos: TScrollBox;
    Label6: TLabel;
    imgPagamento: TImage;
    Label7: TLabel;
    Panel5: TPanel;
    edtDesconto: TEdit;
    rbPorcentagem: TRadioButton;
    rbValor: TRadioButton;
    procedure actFinalizaPagamentoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvFormaPagtoExit(Sender: TObject);
    procedure lvFormaPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure lvCondicaoPagamentoKeyPress(Sender: TObject; var Key: Char);
    procedure lvFormaPagtoEnter(Sender: TObject);
    procedure lvCondicaoPagamentoExit(Sender: TObject);
    procedure edtValorPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorPagtoEnter(Sender: TObject);
    procedure edtValorPagtoExit(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure edtDescontoKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescontoExit(Sender: TObject);
  private
    { Private declarations }
    FPagamentos: TPAGAMENTOS;
    FRecebimento: boolean;
    FOnValorLiquido: TOnGetValorLiquido;
    FOnValorBruto: TOnGetValorBruto;
    FCliente: TCliente;
    FValorDesc: TOnGetValorDesc;
    FOnDesconto: TOnSetDesconto;
    FIDPedido: integer;
    procedure AddPagamento;
    procedure CarregaCondicaoDePagamento(aPagto: TList<TCONDICAODEPAGTO>);
    procedure ConfiguraPagamento;
    procedure BindLabelsPagamentos(ValorRecebido, aValorAcrescimo, ValorRestante, Troco: currency);
    procedure BindPagamentos(aPagamentos: TPEDIDOPAGAMENTO);
    procedure ParcelaPedido(aPagto: TPEDIDOPAGAMENTO);
  public
    { Public declarations }
    property Pagamentos: TPAGAMENTOS read FPagamentos write FPagamentos;
    property Recebimento: boolean read FRecebimento write FRecebimento;
    property OnGetValorLiquido: TOnGetValorLiquido read FOnValorLiquido write FOnValorLiquido;
    property OnValorBruto: TOnGetValorBruto read FOnValorBruto write FOnValorBruto;
    property Cliente: TCliente read FCliente write FCliente;
    property OnGetValorDesc: TOnGetValorDesc read FValorDesc write FValorDesc;
    property OnSetDesconto: TOnSetDesconto read FOnDesconto write FOnDesconto;
    property IDPedido: integer read FIDPedido write FIDPedido;
  end;

const
  corDestaque = $00ECE3D2;

var
  FrmPagamento: TFrmPagamento;

implementation

uses
  Helper.currency,
  Factory.Entidades,
  Util.Funcoes,
  Pedido.Venda.Part.Pagamento,
  Pedido.Pagamento.Imagem, Sistema.TLog,
  Dominio.Entidades.TFormaPagto.Tipo;

{$R *.dfm}


procedure TFrmPagamento.actCancelarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.actCancelarExecute ');
  inherited;
  for VAR I := Pagamentos.FormasDePagamento.Count - 1 downto 0 do
  Begin
    Pagamentos.RemovePagamento(Pagamentos.FormasDePagamento[I]);
  End;

  close;
  TLog.d('<<< Saindo de TFrmPagamento.actCancelarExecute ');
end;

procedure TFrmPagamento.actFinalizaPagamentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.actFinalizaPagamentoExecute ');
  TRY
    inherited;
    if Pagamentos.ValorRestante = 0 then
      close()
    else
    begin
      AddPagamento;
      edtValorPagto.Text := '';
      if Pagamentos.ValorRestante > 0 then
        try
          lvFormaPagto.SetFocus;
        except
        end;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.actFinalizaPagamentoExecute ');
end;

procedure TFrmPagamento.BindLabelsPagamentos(ValorRecebido: currency; aValorAcrescimo: currency; ValorRestante: currency; Troco: currency);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.BindLabelsPagamentos ');
  lblValorRestante.Caption := ValorRestante.ToReais;
  lblValorPago.Caption := ValorRecebido.ToReais;
  lblTroco.Caption := Troco.ToReais;
  lblValorLiquido.Caption := OnGetValorLiquido.ToReais;
  // lblValorAcrescimo.Caption := aValorAcrescimo.ToReais;
  lblValorTotal.Caption := OnValorBruto.ToReais;
  TLog.d('<<< Saindo de TFrmPagamento.BindLabelsPagamentos ');
end;

procedure TFrmPagamento.ConfiguraPagamento;
begin
  TLog.d('>>> Entrando em  TFrmPagamento.ConfiguraPagamento ');
  try
    LimpaScrollBox(scrBoxPagamentos);
    TFramePedidoPagamentoImagem
      .new(nil)
      .SetParent(scrBoxPagamentos)
      .setup;

    Pagamentos.ValorOriginal := OnGetValorLiquido;

    Pagamentos.OnEfetuaPagamento := procedure(ValorRecebido: currency; aValorAcrescimo: currency; ValorRestante: currency; Troco: currency)
      begin
        BindLabelsPagamentos(ValorRecebido, aValorAcrescimo, ValorRestante, Troco);
      end;

    BindLabelsPagamentos(Pagamentos.ValorRecebido, Pagamentos.ValorAcrescimo, Pagamentos.ValorRestante, Pagamentos.Troco);
    var
    formaPagtos := fFactory
      .DaoFormaPagto
      .ListaAtivosObject();

    LimpaListBox<TFormaPagto>(lvFormaPagto);

    for var pagto in Pagamentos.FormasDePagamento do
      BindPagamentos(pagto);

    lvCondicaoPagamento.Clear;
    for var formaPagto in formaPagtos do
    begin
      lvFormaPagto.AddItem(formaPagto.DESCRICAO, formaPagto);
    end;

    lvFormaPagto.ItemIndex := lvFormaPagto.Items.IndexOf('DINHEIRO');
  except
    on e: Exception do
    begin
      // flog.d(E);
      raise Exception.Create('ConfiguraPagamento: ' + e.message);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.ConfiguraPagamento ');
end;

procedure TFrmPagamento.CarregaCondicaoDePagamento(aPagto: TList<TCONDICAODEPAGTO>);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.CarregaCondicaoDePagamento ');
  lvCondicaoPagamento.Clear;
  for var condicao in aPagto do
  begin
    var
    totalAcrescimo := condicao.CalculaAcrescimo(Pagamentos.ValorRestante);
    var
    ValorAcrescimo := condicao.CalculaValorDoAcrescimo(Pagamentos.ValorRestante);

    var
    DescricaoAcrescimo := TUtil.IFF<string>(ValorAcrescimo > 0,
      Format(' R$ %f', [totalAcrescimo]),
      Format('(ACRÉSCIMO de R$ %f) R$ %f', [ValorAcrescimo, totalAcrescimo])
      );

    lvCondicaoPagamento.AddItem(
      condicao.DESCRICAO + DescricaoAcrescimo,
      condicao
      );
  end;
  lvCondicaoPagamento.ItemIndex := 0;
  TLog.d('<<< Saindo de TFrmPagamento.CarregaCondicaoDePagamento ');
end;

procedure TFrmPagamento.AddPagamento;
VAR
  valor: currency;
begin
  TLog.d('>>> Entrando em  TFrmPagamento.AddPagamento ');
  try
    if lvFormaPagto.ItemIndex < 0 then
      raise Exception.Create('SELECIONE A FORMA DE PAGAMENTO');

    if lvCondicaoPagamento.ItemIndex < 0 then
      raise Exception.Create('SELECIONE A CONDIÇÃO DE PAGAMENTO');

    var
    stValor := edtValorPagto.Text;

    TRY
      valor := StrToCurr(stValor);
    except
      raise Exception.Create('VALOR DO PAGAMENTO INVÁLIDO');
    END;

    if valor <= 0 then
      raise Exception.Create('VALOR DO PAGAMENTO PRECISA SER MAIOR QUE ZERO');

    if Pagamentos.FormasDePagamento.Count = 0 then
      LimpaScrollBox(scrBoxPagamentos);

    VAR
    forma := TFormaPagto(lvFormaPagto.Items.Objects[lvFormaPagto.ItemIndex]);
    var
    condicao := TCONDICAODEPAGTO(lvCondicaoPagamento.Items.Objects[lvCondicaoPagamento.ItemIndex]);
    var
    valorCalculoAccrescimo := TUtil.IFF<currency>(valor < Pagamentos.ValorRestante, Pagamentos.ValorRestante, valor);
    var
    totalCrescimo := condicao.CalculaValorDoAcrescimo(valorCalculoAccrescimo);

    var
    Troco := (valor - (Pagamentos.ValorRestante + totalCrescimo));
    Troco := TUtil.IFF<currency>(Troco < 0, Troco, 0);

    if (valor > (Pagamentos.ValorRestante + totalCrescimo))
      and (forma.TipoPagamento <> TTipoPagto.dinheiro) then
      raise Exception.Create('TROCO SOMENTE PERMITIDO PARA PAGAMENTO EM DINHEIRO!');

    if (forma.TipoPagamento = TTipoPagto.Crediario) then
      if (not Assigned(Cliente)) or (Cliente.CODIGO = '000000') or (Cliente.CODIGO = '') then
        raise Exception.Create('PARA VENDER NO CREDIÁRIO É PRECISO INFORMAR O CLIENTE!');

    var
    pagto := Pagamentos.NewPagamento();
    pagto.NUMCAIXA := TFactoryEntidades.Parametros.PontoVenda.NUMCAIXA;
    pagto.DESCRICAO := forma.DESCRICAO;
    pagto.Tipo := forma.Tipo;
    pagto.IDPAGTO := forma.ID;
    pagto.IDPedido := IDPedido;
    pagto.IDCONDICAO := condicao.ID;
    pagto.condicao := condicao.DESCRICAO;
    pagto.valor := valor;
    pagto.Troco := Troco;
    pagto.QUANTASVEZES := condicao.QUANTASVEZES;
    pagto.ACRESCIMO := totalCrescimo;

    if (pagto.TipoPagamento = TTipoPagto.Crediario) then
      ParcelaPedido(pagto);

    Pagamentos.AddPagamento(pagto);

    BindPagamentos(pagto);

  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.AddPagamento ');
end;

procedure TFrmPagamento.ParcelaPedido(aPagto: TPEDIDOPAGAMENTO);
var
  NumParcelas: integer;
  VencimentoPrimeiraParcela: TDate;
begin
  try
    NumParcelas := aPagto.QUANTASVEZES;
    VencimentoPrimeiraParcela := IncMonth(now, 1);
    aPagto.ParcelarPedido(Cliente.CODIGO, NumParcelas, VencimentoPrimeiraParcela);
  except
    on e: Exception do
      raise Exception.Create('Falha ao gerar parcelas: ' + e.message);
  end;
end;

procedure TFrmPagamento.BindPagamentos(aPagamentos: TPEDIDOPAGAMENTO);
begin
  TFramePedidoVendaPagamento
    .new(nil)
    .setParams([aPagamentos])
    .SetParent(scrBoxPagamentos)
    .setOnObjectChange(
    procedure(aobj: TObject)
    begin
      // flog.d('Pagamento cancelado');
      Pagamentos.RemovePagamento(aPagamentos);
      // FController.Salvar(Self.ActiveOS);
      aobj.Free;
    end)
    .setup;
end;

procedure TFrmPagamento.edtDescontoExit(Sender: TObject);
begin
  inherited;
  edtDesconto.Text := Format('%f', [OnGetValorDesc]);
  Pagamentos.ValorOriginal := OnGetValorLiquido;
  BindLabelsPagamentos(Pagamentos.ValorRecebido, Pagamentos.ValorAcrescimo, Pagamentos.ValorRestante, Pagamentos.Troco);
end;

procedure TFrmPagamento.edtDescontoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    try
      if rbPorcentagem.Checked then
        OnSetDesconto(TTipoDesconto.tpPercentual, StrToCurrDef(edtDesconto.Text, 0))
      else
        OnSetDesconto(TTipoDesconto.tpValor, StrToCurrDef(edtDesconto.Text, 0));

      lvFormaPagto.SetFocus;
    except
      on e: Exception do
      begin
        TLog.d(e.message);
        MessageDlg(e.message, mtError, [mbOK], 0);
      end;
    end;
    Key := #0
  end
end;

procedure TFrmPagamento.edtValorPagtoEnter(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := corDestaque;
  pnlData.Color := corDestaque;
end;

procedure TFrmPagamento.edtValorPagtoExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := clWhite;
  pnlData.Color := clWhite;
end;

procedure TFrmPagamento.edtValorPagtoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    try
      btnOK.SetFocus;
    except
    end;

  end
  else if Key = #27 then
    lvCondicaoPagamento.SetFocus;
end;

procedure TFrmPagamento.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.FormShow ');
  inherited;
  try
    edtDesconto.Enabled := not Recebimento;
    rbValor.Enabled := not Recebimento;
    rbPorcentagem.Enabled := not Recebimento;

    edtDesconto.SetFocus;
  except
  end;

  ConfiguraPagamento();
  TLog.d('<<< Saindo de TFrmPagamento.FormShow ');
end;

procedure TFrmPagamento.lvCondicaoPagamentoExit(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.lvCondicaoPagamentoExit ');
  inherited;
  TListBox(Sender).Font.Size := TListBox(Sender).Font.Size - 1;
  TListBox(Sender).Color := corDestaque;
  if (lvCondicaoPagamento.ItemIndex >= 0) then
  begin
    var
    condicao := TCONDICAODEPAGTO(lvCondicaoPagamento.Items.Objects[lvCondicaoPagamento.ItemIndex]);
    edtValorPagto.Text := condicao.CalculaAcrescimo(Pagamentos.ValorRestante).ToStrDuasCasasSemPonto;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.lvCondicaoPagamentoExit ');
end;

procedure TFrmPagamento.lvCondicaoPagamentoKeyPress(Sender: TObject;
var
  Key: Char);
begin
  inherited;
  if Key = #13 then
    try
      edtValorPagto.SetFocus;
    except
    end
  else if Key = #27 then
    lvFormaPagto.SetFocus;
end;

procedure TFrmPagamento.lvFormaPagtoEnter(Sender: TObject);
begin
  inherited;
  TListBox(Sender).Font.Size := TListBox(Sender).Font.Size + 1;
  TListBox(Sender).Color := clWhite;
  if TListBox(Sender).Items.Count = 1 then
    TListBox(Sender).ItemIndex := 0;

end;

procedure TFrmPagamento.lvFormaPagtoExit(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.lvFormaPagtoExit ');
  inherited;
  TListBox(Sender).Font.Size := TListBox(Sender).Font.Size - 1;
  TListBox(Sender).Color := corDestaque;
  if (lvFormaPagto.ItemIndex >= 0) then
  begin
    var
    formaPagto := TFormaPagto(lvFormaPagto.Items.Objects[lvFormaPagto.ItemIndex]);
    CarregaCondicaoDePagamento(formaPagto.CONDICAODEPAGTO);
  end;

  if (lvCondicaoPagamento.ItemIndex >= 0) then
  begin
    var
    condicao := TCONDICAODEPAGTO(lvCondicaoPagamento.Items.Objects[lvCondicaoPagamento.ItemIndex]);
    edtValorPagto.Text := condicao.CalculaAcrescimo(Pagamentos.ValorRestante).ToStrDuasCasasSemPonto;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.lvFormaPagtoExit ');
end;

procedure TFrmPagamento.lvFormaPagtoKeyPress(Sender: TObject;
var
  Key:
  Char);
begin
  inherited;
  if Key = #13 then
    try
      if lvCondicaoPagamento.Items.Count > 0 then
        lvCondicaoPagamento.ItemIndex := 0;
      lvCondicaoPagamento.SetFocus;
    except
    end
  ELSE if Key = #27 then
    close;
end;

end.
