unit Recebimento.Pagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, System.Actions, Dominio.Entidades.CondicaoPagto,
  Dominio.Entidades.TPedido, Vcl.ActnList, Dominio.Entidades.TFormaPagto,
  System.Generics.Collections, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TfrmRecebimentoPagamento = class(TfrmBase)
    pnl2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    Label6: TLabel;
    pnlImage4: TPanel;
    lblValorLiquido: TLabel;
    Image3: TPanel;
    lblValorTotal: TLabel;
    Panel2: TPanel;
    lblValorPago: TLabel;
    Panel3: TPanel;
    lblValorRestante: TLabel;
    Panel4: TPanel;
    lblTroco: TLabel;
    pnlCentro: TPanel;
    img2: TImage;
    labForma: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lvFormaPagto: TListBox;
    lvCondicaoPagamento: TListBox;
    pnlData: TPanel;
    edtValorPagto: TEdit;
    Panel1: TPanel;
    pnl3: TPanel;
    lbl1: TLabel;
    btnOK: TBitBtn;
    btnCancelar: TBitBtn;
    Panel5: TPanel;
    edtDesconto: TEdit;
    rbPorcentagem: TRadioButton;
    rbValor: TRadioButton;
    ActionList1: TActionList;
    actCancelar: TAction;
    actExcluirPagamento: TAction;
    actFinalizaPagamento: TAction;
    scrBoxPagamentos: TScrollBox;
    imgPagamento: TImage;
    procedure edtDescontoExit(Sender: TObject);
    procedure edtDescontoKeyPress(Sender: TObject; var Key: Char);
    procedure actCancelarExecute(Sender: TObject);
    procedure actFinalizaPagamentoExecute(Sender: TObject);
    procedure edtDescontoEnter(Sender: TObject);
    procedure edtValorPagtoEnter(Sender: TObject);
    procedure edtValorPagtoExit(Sender: TObject);
    procedure edtValorPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure lvCondicaoPagamentoExit(Sender: TObject);
    procedure lvCondicaoPagamentoKeyPress(Sender: TObject; var Key: Char);
    procedure lvCondicaoPagamentoEnter(Sender: TObject);
    procedure lvFormaPagtoExit(Sender: TObject);
    procedure lvFormaPagtoKeyPress(Sender: TObject; var Key: Char);
  private
    FPedido: TPedido;
    procedure BindLabelsPagamentos(ValorRecebido, aValorAcrescimo, ValorRestante, Troco: Currency);
    procedure AddPagamento;
    procedure CarregaCondicaoDePagamento(aPagto: TList<TCONDICAODEPAGTO>);
    procedure ConfiguraPagamento;
    procedure BindPagamentos(aPagamentos: TPEDIDOPAGAMENTO);
    { Private declarations }
  public
    { Public declarations }
    property Pedido: TPedido read FPedido write SetPedido;
  end;

const
  corDestaque = $00ECE3D2;

var
  frmRecebimentoPagamento: TfrmRecebimentoPagamento;

implementation

{$R *.dfm}


uses
  Helper.Currency,

  Util.Funcoes,Pedido.Pagamento.Imagem, Sistema.TLog;

procedure TfrmRecebimentoPagamento.actCancelarExecute(Sender: TObject);
begin
  inherited;
  TLog.d('>>> Entrando em  TFrmPagamento.actCancelarExecute ');
  inherited;
  for VAR I := FPedido.Pagamentos.FormasDePagamento.Count - 1 downto 0 do
  Begin
    FPedido.Pagamentos.RemovePagamento(FPedido.Pagamentos.FormasDePagamento[I]);
  End;

  close;
  TLog.d('<<< Saindo de TFrmPagamento.actCancelarExecute ');
end;

procedure TfrmRecebimentoPagamento.ConfiguraPagamento;
begin
  TLog.d('>>> Entrando em  TFrmPagamento.ConfiguraPagamento ');
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
    formaPagtos := fFactory
      .DaoFormaPagto
      .ListaAtivosObject();

    LimpaListBox<TFormaPagto>(lvFormaPagto);

    for var pagto in FPedido.Pagamentos.FormasDePagamento do
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
      TLog.d(E.Message);
      raise Exception.Create('ConfiguraPagamento: ' + e.message);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.ConfiguraPagamento ');
end;

procedure TfrmRecebimentoPagamento.CarregaCondicaoDePagamento(aPagto: TList<TCONDICAODEPAGTO>);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.CarregaCondicaoDePagamento ');
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
  lvCondicaoPagamento.ItemIndex := 0;
  TLog.d('<<< Saindo de TFrmPagamento.CarregaCondicaoDePagamento ');
end;

procedure TfrmRecebimentoPagamento.AddPagamento;
VAR
  valor: Currency;
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

    if FPedido.Pagamentos.FormasDePagamento.Count = 0 then
      LimpaScrollBox(scrBoxPagamentos);

    VAR
    forma := TFormaPagto(lvFormaPagto.Items.Objects[lvFormaPagto.ItemIndex]);
    var
    condicao := TCONDICAODEPAGTO(lvCondicaoPagamento.Items.Objects[lvCondicaoPagamento.ItemIndex]);
    var
    valorCalculoAccrescimo := TUtil.IFF<Currency>(valor < FPedido.Pagamentos.ValorRestante, FPedido.Pagamentos.ValorRestante, valor);
    var
    totalCrescimo := condicao.CalculaValorDoAcrescimo(valorCalculoAccrescimo);

    var
    Troco := (valor - (FPedido.Pagamentos.ValorRestante + totalCrescimo));
    Troco := TUtil.IFF<Currency>(Troco < 0, Troco, 0);

    if (valor > (FPedido.Pagamentos.ValorRestante + totalCrescimo))
      and (forma.TipoPagamento <> TTipoPagto.dinheiro) then
      raise Exception.Create('TROCO SOMENTE PERMITIDO PARA PAGAMENTO EM DINHEIRO!');

    if (forma.TipoPagamento = TTipoPagto.Crediario) then
      if (not Assigned(FPedido.Cliente)) or (FPedido.Cliente.CODIGO = '000000') or (FPedido.Cliente.CODIGO = '') then
        raise Exception.Create('PARA VENDER NO CREDIÁRIO É PRECISO INFORMAR O CLIENTE!');

    var
    pagto := FPedido.Pagamentos.NewPagamento();
    pagto.DESCRICAO := forma.DESCRICAO;
    pagto.Tipo := forma.Tipo;
    pagto.IDPAGTO := forma.ID;
    pagto.IDPEDIDO := FPedido.ID;
    pagto.IDCONDICAO := condicao.ID;
    pagto.condicao := condicao.DESCRICAO;
    pagto.valor := valor;
    pagto.Troco := Troco;
    pagto.QUANTASVEZES := condicao.QUANTASVEZES;
    pagto.ACRESCIMO := totalCrescimo;

    if (pagto.TipoPagamento = TTipoPagto.Crediario) then
      ParcelaPedido(pagto);

    FPedido.Pagamentos.AddPagamento(pagto);

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

procedure TfrmRecebimentoPagamento.BindPagamentos(aPagamentos: TPEDIDOPAGAMENTO);
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

procedure TfrmRecebimentoPagamento.BindLabelsPagamentos(ValorRecebido: Currency; aValorAcrescimo: Currency; ValorRestante: Currency; Troco: Currency);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.BindLabelsPagamentos ');
  lblValorRestante.Caption := ValorRestante.ToReais;
  lblValorPago.Caption := ValorRecebido.ToReais;
  lblTroco.Caption := Troco.ToReais;
  lblValorLiquido.Caption := FPedido.VALORLIQUIDO.ToReais;
  // lblValorAcrescimo.Caption := aValorAcrescimo.ToReais;
  lblValorTotal.Caption := FPedido.ValorBruto.ToReais;
  TLog.d('<<< Saindo de TFrmPagamento.BindLabelsPagamentos ');
end;

procedure TfrmRecebimentoPagamento.actFinalizaPagamentoExecute(Sender: TObject);
begin
  inherited;
  TLog.d('>>> Entrando em  TFrmPagamento.actFinalizaPagamentoExecute ');
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
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.actFinalizaPagamentoExecute ');
end;

procedure TfrmRecebimentoPagamento.edtDescontoEnter(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := corDestaque;
  pnlData.Color := corDestaque;
end;

procedure TfrmRecebimentoPagamento.edtDescontoExit(Sender: TObject);
begin
  inherited;
  edtDesconto.Text := Format('%f', [FPedido.VALORDESC]);
  FPedido.Pagamentos.ValorOriginal := FPedido.VALORLIQUIDO;
  BindLabelsPagamentos(FPedido.Pagamentos.ValorRecebido, FPedido.Pagamentos.ValorAcrescimo, FPedido.Pagamentos.ValorRestante, FPedido.Pagamentos.Troco);
end;

procedure TfrmRecebimentoPagamento.edtDescontoKeyPress(Sender: TObject;
var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    try
      if rbPorcentagem.Checked then
        FPedido.setDescontos(TTipoDesconto.tpPercentual, StrToCurrDef(edtDesconto.Text, 0))
      else
        FPedido.setDescontos(TTipoDesconto.tpValor, StrToCurrDef(edtDesconto.Text, 0));

      lvFormaPagto.SetFocus;
    except
    end;
    Key := #0
  end
end;

procedure TfrmRecebimentoPagamento.edtValorPagtoEnter(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := clWhite;
  pnlData.Color := clWhite;
end;

procedure TfrmRecebimentoPagamento.edtValorPagtoExit(Sender: TObject);
begin
  inherited;
  TEdit(Sender).Color := corDestaque;
  pnlData.Color := corDestaque;
end;

procedure TfrmRecebimentoPagamento.edtValorPagtoKeyPress(Sender: TObject;
var Key: Char);
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

procedure TfrmRecebimentoPagamento.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmPagamento.FormShow ');
  inherited;
  try
    edtDesconto.SetFocus;
  except
  end;

  ConfiguraPagamento();
  TLog.d('<<< Saindo de TFrmPagamento.FormShow ');
end;

procedure TfrmRecebimentoPagamento.lvCondicaoPagamentoEnter(Sender: TObject);
begin
  inherited;
  TListBox(Sender).Font.Size := TListBox(Sender).Font.Size + 1;
  TListBox(Sender).Color := clWhite;
  if TListBox(Sender).Items.Count = 1 then
    TListBox(Sender).ItemIndex := 0;
end;

procedure TfrmRecebimentoPagamento.lvCondicaoPagamentoExit(Sender: TObject);
begin
  inherited;
  TLog.d('>>> Entrando em  TFrmPagamento.lvCondicaoPagamentoExit ');
  inherited;
  TListBox(Sender).Font.Size := TListBox(Sender).Font.Size - 1;
  TListBox(Sender).Color := corDestaque;
  if (lvCondicaoPagamento.ItemIndex >= 0) then
  begin
    var
    condicao := TCONDICAODEPAGTO(lvCondicaoPagamento.Items.Objects[lvCondicaoPagamento.ItemIndex]);
    edtValorPagto.Text := condicao.CalculaAcrescimo(FPedido.Pagamentos.ValorRestante).ToStrDuasCasasSemPonto;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.lvCondicaoPagamentoExit ');
end;

procedure TfrmRecebimentoPagamento.lvCondicaoPagamentoKeyPress(Sender: TObject;
var Key: Char);
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

procedure TfrmRecebimentoPagamento.lvFormaPagtoExit(Sender: TObject);
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
    edtValorPagto.Text := condicao.CalculaAcrescimo(FPedido.Pagamentos.ValorRestante).ToStrDuasCasasSemPonto;
  end;
  TLog.d('<<< Saindo de TFrmPagamento.lvFormaPagtoExit ');
end;

procedure TfrmRecebimentoPagamento.lvFormaPagtoKeyPress(Sender: TObject;
var Key: Char);
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

procedure TfrmRecebimentoPagamento.SetPedido(const Value: TPedido);
begin
  FPedido := Value;
end;

end.
