unit Pedido.Pagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Dominio.Entidades.CondicaoPagto,
  Dominio.Entidades.TPedido, System.Actions, Vcl.ActnList, Dominio.Entidades.TFormaPagto,
  System.Generics.Collections, Dominio.Entidades.TFactory,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento;

type
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
  private
    { Private declarations }
    FPedido: TPedido;
    procedure AddPagamento;
    procedure CarregaCondicaoDePagamento(aPagto: TList<TCONDICAODEPAGTO>);
    procedure ConfiguraPagamento;
    procedure BindLabelsPagamentos(ValorRecebido, aValorAcrescimo,
      ValorRestante, Troco: Currency);
    procedure BindPagamentos(aPagamentos: TPEDIDOPAGAMENTO);
    procedure SetPedido(const Value: TPedido);
    procedure ParcelaPedido(aPagto: TPEDIDOPAGAMENTO);
  public
    { Public declarations }
    property Pedido: TPedido read FPedido write SetPedido;
  end;

const
  corDestaque = $00ECE3D2;

var
  FrmPagamento: TFrmPagamento;

implementation

uses
  Helper.Currency,
  Helpers.HelperString,
  Util.Funcoes,
  Pedido.Venda.Part.Pagamento,
  Pedido.Pagamento.Imagem,
  Dominio.Entidades.TFormaPagto.Tipo;

{$R *.dfm}


procedure TFrmPagamento.actCancelarExecute(Sender: TObject);
begin
  inherited;
  for VAR I := FPedido.Pagamentos.FormasDePagamento.Count - 1 downto 0 do
  Begin
    FPedido.Pagamentos.RemovePagamento(FPedido.Pagamentos.FormasDePagamento[I]);
  End;

  close;
end;

procedure TFrmPagamento.actFinalizaPagamentoExecute(Sender: TObject);
begin

  TRY
    inherited;
    if FPedido.Pagamentos.ValorRestante = 0 then
      close()
    else
    begin
      AddPagamento;
      edtValorPagto.Text := '';
      if FPedido.Pagamentos.ValorRestante > 0 then
        try
          lvFormaPagto.SetFocus;
        except
        end;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPagamento.BindLabelsPagamentos(ValorRecebido: Currency; aValorAcrescimo: Currency; ValorRestante: Currency; Troco: Currency);
begin
  lblValorRestante.Caption := ValorRestante.ToReais;
  lblValorPago.Caption := ValorRecebido.ToReais;
  lblTroco.Caption := Troco.ToReais;
  lblValorLiquido.Caption := FPedido.VALORLIQUIDO.ToReais;
  // lblValorAcrescimo.Caption := aValorAcrescimo.ToReais;
  lblValorTotal.Caption := FPedido.ValorBruto.ToReais;
end;

procedure TFrmPagamento.ConfiguraPagamento;
begin
  // flog.d('>>> Entrando em  TViewOrdemDeServico.ConfiguraPagamento ');
  try

    LimpaScrollBox(scrBoxPagamentos);
    TFramePedidoPagamentoImagem
      .new(nil)
      .SetParent(scrBoxPagamentos)
      .setup;

    FPedido.Pagamentos.ValorOriginal := FPedido.VALORLIQUIDO;

    FPedido.Pagamentos.OnEfetuaPagamento := procedure(ValorRecebido: Currency; aValorAcrescimo: Currency; ValorRestante: Currency; Troco: Currency)
      begin
        BindLabelsPagamentos(ValorRecebido, aValorAcrescimo, ValorRestante, Troco);

      end;

    BindLabelsPagamentos(FPedido.Pagamentos.ValorRecebido, FPedido.Pagamentos.ValorAcrescimo, FPedido.Pagamentos.ValorRestante, FPedido.Pagamentos.Troco);
    var
    formaPagtos := TFactory
      .DaoFormaPagto
      .ListaAtivosObject();

    LimpaListBox<TFormaPagto>(lvFormaPagto);
    // LimpaListBox<TCONDICAODEPAGTO>(lvCondicaoPagamento);

    for var pagto in FPedido.Pagamentos.FormasDePagamento do
      BindPagamentos(pagto);

    lvCondicaoPagamento.Clear;
    for var formaPagto in formaPagtos do
    begin
      lvFormaPagto.AddItem(formaPagto.DESCRICAO, formaPagto);
    end;

    lvFormaPagto.ItemIndex := lvFormaPagto.Items.IndexOf('DINHEIRO');
  except
    on E: Exception do
    begin
      // flog.d(E);
      raise Exception.Create('ConfiguraPagamento: ' + E.Message);
    end;
  end;
  // flog.d('<<< Saindo de TViewOrdemDeServico.ConfiguraPagamento ');
end;

procedure TFrmPagamento.CarregaCondicaoDePagamento(aPagto: TList<TCONDICAODEPAGTO>);
begin
  lvCondicaoPagamento.Clear;
  for var condicao in aPagto do
  begin
    var
    totalAcrescimo := condicao.CalculaAcrescimo(FPedido.Pagamentos.ValorRestante);
    var
    ValorAcrescimo := condicao.CalculaValorDoAcrescimo(FPedido.Pagamentos.ValorRestante);

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
  lvCondicaoPagamento.ItemIndex := 0
end;

procedure TFrmPagamento.AddPagamento;
VAR
  valor: Currency;
begin
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

    if FPedido.Pagamentos.FormasDePagamento.Count = 0 then
      LimpaScrollBox(scrBoxPagamentos);

    VAR    forma := TFormaPagto(lvFormaPagto.Items.Objects[lvFormaPagto.ItemIndex]);
    var    condicao := TCONDICAODEPAGTO(lvCondicaoPagamento.Items.Objects[lvCondicaoPagamento.ItemIndex]);
    var    valorCalculoAccrescimo := TUtil.IFF<Currency>(valor < FPedido.Pagamentos.ValorRestante, FPedido.Pagamentos.ValorRestante, valor);
    var    totalCrescimo := condicao.CalculaValorDoAcrescimo(valorCalculoAccrescimo);

    if (valor > (FPedido.Pagamentos.ValorRestante + totalCrescimo))
      and (forma.TipoPagamento <> TTipoPagto.dinheiro) then
      raise Exception.Create('TROCO SOMENTE PERMITIDO PARA PAGAMENTO EM DINHEIRO!');

    if (forma.TipoPagamento = TTipoPagto.Parcelado) then
      if (not Assigned(FPedido.Cliente)) or (FPedido.Cliente.CODIGO = '000000') or (FPedido.Cliente.CODIGO = '') then
        raise Exception.Create('PARA VENDER PARCELADO É PRECISO INFORMAR O CLIENTE!');

    var
    pagto := FPedido.Pagamentos.NewPagamento();
    pagto.DESCRICAO := forma.DESCRICAO;
    pagto.Tipo := forma.Tipo;
    pagto.IDPAGTO := forma.ID;
    pagto.IDPEDIDO := FPedido.ID;
    pagto.IDCONDICAO := condicao.ID;
    pagto.condicao := condicao.DESCRICAO;
    pagto.valor := valor;
    pagto.QUANTASVEZES := condicao.QUANTASVEZES;
    pagto.ACRESCIMO := totalCrescimo;

    if (pagto.TipoPagamento = TTipoPagto.Parcelado) then
      ParcelaPedido(pagto);

    FPedido.Pagamentos.AddPagamento(pagto);

    BindPagamentos(pagto);

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmPagamento.ParcelaPedido(aPagto: TPEDIDOPAGAMENTO);
var
  NumParcelas: Integer;
  VencimentoPrimeiraParcela: TDate;
begin
  try
    NumParcelas := aPagto.QUANTASVEZES;
    VencimentoPrimeiraParcela := IncMonth(now, 1);
    aPagto.ParcelarPedido(FPedido.Cliente.CODIGO, NumParcelas, VencimentoPrimeiraParcela);
  except
    on E: Exception do
      raise Exception.Create('Falha ao gerar parcelas: ' + E.Message);
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
      FPedido.Pagamentos.RemovePagamento(aPagamentos);
      // FController.Salvar(Self.ActiveOS);
      aobj.Free;
    end)
    .setup;
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
  inherited;
  try
    lvFormaPagto.SetFocus;
  except
  end;

  ConfiguraPagamento();
end;

procedure TFrmPagamento.lvCondicaoPagamentoExit(Sender: TObject);
begin
  inherited;
  TListBox(Sender).Font.Size := TListBox(Sender).Font.Size - 1;
  TListBox(Sender).Color := corDestaque;
  if (lvCondicaoPagamento.ItemIndex >= 0) then
  begin
    var
    condicao := TCONDICAODEPAGTO(lvCondicaoPagamento.Items.Objects[lvCondicaoPagamento.ItemIndex]);
    edtValorPagto.Text := condicao.CalculaAcrescimo(FPedido.Pagamentos.ValorRestante).ToStrDuasCasasSemPonto;
  end;
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
end;

procedure TFrmPagamento.lvFormaPagtoExit(Sender: TObject);
begin
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
    edtValorPagto.Text := condicao.CalculaAcrescimo(FPedido.Pagamentos.ValorRestante).ToStrDuasCasasSemPonto;
  end;
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

procedure TFrmPagamento.SetPedido(const Value: TPedido);
begin
  FPedido := Value;
end;

end.
