unit parceiro.InformaPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  JvExMask, JvToolEdit, JvBaseEdits, Vcl.ExtCtrls, Dominio.Entidades.TParceiro.FormaPagto,
  Dao.IDaoParceiro.FormaPagto, Dominio.Entidades.TFactory, System.Bindings.Helper,
  Consulta.parceiro.FormaPagto, System.Generics.Collections,
   Dominio.Entidades.TParceiro, Dao.IDaoParceiro, JvComponentBase, JvEnterTab, parceiro.FramePagamento,
  Dominio.Entidades.TParceiroVenda, Dominio.Entidades.TParceiroVenda.Pagamentos, System.Actions, Vcl.ActnList;

type
  TFrmParceiroInfoPagto = class(TfrmBase)
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    edtValorPagto: TJvCalcEdit;
    Panel4: TPanel;
    lblValorPagamento: TLabel;
    Panel5: TPanel;
    scrBoxPagamentos: TScrollBox;
    Panel8: TPanel;
    Panel9: TPanel;
    Label2: TLabel;
    Panel10: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Panel11: TPanel;
    Panel12: TPanel;
    Label6: TLabel;
    Panel13: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Panel2: TPanel;
    Panel6: TPanel;
    Label14: TLabel;
    lblValorLiquido: TLabel;
    Label9: TLabel;
    btnIncluir: TBitBtn;
    btnCancelar: TBitBtn;
    Label10: TLabel;
    Label3: TLabel;
    lblTotalComissao: TLabel;
    btnAdicionar: TSpeedButton;
    Panel7: TPanel;
    lstFormaPagto: TListBox;
    cbbParceiro: TComboBox;
    lbl1: TLabel;
    ActionList1: TActionList;
    actAdicionar: TAction;
    actIncluir: TAction;
    actCancelar: TAction;
    actExcluiPagamento: TAction;
    Label11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstFormaPagtoEnter(Sender: TObject);
    procedure lstFormaPagtoExit(Sender: TObject);
    procedure lstFormaPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure cbbParceiroKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure actAdicionarExecute(Sender: TObject);
    procedure actExcluiPagamentoExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
  private
    pagtos: TObjectList<TParceiroFormaPagto>;
    parceiros: TObjectList<TParceiro>;
    DaoParceiroFormaPagto: IDaoParceiroFormaPagto;
    DaoParceiro: IDaoParceiro;
    ParceiroVenda: TParceiroVenda;

    procedure OnAddPagamento(Pagamento: TParceiroVendaPagto);
    procedure OnRemovePagamento(Index: Integer);

    procedure PopulaLista;
    procedure LimpaScrollBox(aScroll: TScrollBox);
    procedure ExibePagamento;
    procedure Inicializa;
    procedure AdicionarPagamento;
    procedure Incluir;
    procedure SetParceiro;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmParceiroInfoPagto: TFrmParceiroInfoPagto;

implementation

{$R *.dfm}


procedure TFrmParceiroInfoPagto.FormCreate(Sender: TObject);
begin
  inherited;
  DaoParceiroFormaPagto := TFactory.DaoParceiroFormaPagto;
  DaoParceiro := TFactory.DaoParceiro;

  PopulaLista;

end;

procedure TFrmParceiroInfoPagto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(parceiros);
  FreeAndNil(pagtos);
  FreeAndNil(ParceiroVenda);
end;

procedure TFrmParceiroInfoPagto.FormShow(Sender: TObject);
begin
  Inicializa;

end;

procedure TFrmParceiroInfoPagto.actAdicionarExecute(Sender: TObject);
begin
  inherited;
  try
    AdicionarPagamento;

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;;
end;

procedure TFrmParceiroInfoPagto.actCancelarExecute(Sender: TObject);
begin
  inherited;
  if ParceiroVenda.Pagamentos.Count >= 1 then
  begin
    if MessageDlg('Deseja realmente sair?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      Close;
  end
  else
    Close;
end;

procedure TFrmParceiroInfoPagto.actExcluiPagamentoExecute(Sender: TObject);
begin
  inherited;
  ParceiroVenda.RemoveUltimoPagamento();
end;

procedure TFrmParceiroInfoPagto.actIncluirExecute(Sender: TObject);
begin
  inherited;
  // DaoParceiroVenda
  try
    Incluir;
    MessageDlg('Venda registrada com sucesso!', mtInformation, [mbOK], 0);
    Inicializa;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmParceiroInfoPagto.Incluir;
begin
  TFactory.DaoParceiroVenda.IncluiPagto(ParceiroVenda);
end;

procedure TFrmParceiroInfoPagto.SetParceiro();
var
  parceiro: TParceiro;
begin
  parceiro := TFactory.DaoParceiro.GetParceiro(TParceiro(cbbParceiro.Items.Objects[cbbParceiro.ItemIndex]).CODIGO);
  ParceiroVenda.AddParceiro(parceiro);
end;

procedure TFrmParceiroInfoPagto.AdicionarPagamento;
var
  pagto: TParceiroVendaPagto;
  FormaPagto: TParceiroFormaPagto;
begin
  inherited;

  if cbbParceiro.ItemIndex < 0 then
    raise Exception.Create('Nenhum parceiro selecionado');

  if lstFormaPagto.ItemIndex < 0 then
    raise Exception.Create('Nenhum pagamento selecionado');

  if edtValorPagto.Text.Trim = '' then
    raise Exception.Create('Valor do pagamento não informado');

  if (StrToFloatDef(edtValorPagto.Text, 0) = 0) or (edtValorPagto.Text.ToDouble() <= 0) then
    raise Exception.Create('Valor do pagamento não é válido');

  SetParceiro();

  FormaPagto := TParceiroFormaPagto(lstFormaPagto.Items.Objects[lstFormaPagto.ItemIndex]);

  pagto := TParceiroVendaPagto.Create;
  pagto.IDPARCEIROFORMAPAGTO := FormaPagto.ID;
  pagto.DESCRICAO := FormaPagto.DESCRICAO;
  pagto.VALORPAGAMENTO := edtValorPagto.Text.ToDouble();
  pagto.COMISSAOPERCENTUAL := FormaPagto.COMISSAOPERCENTUAL;

  ParceiroVenda.AddPagameto(pagto);

  ExibePagamento;

  edtValorPagto.Text := '0';
  lstFormaPagto.SetFocus;

end;

procedure TFrmParceiroInfoPagto.cbbParceiroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    lstFormaPagto.SetFocus;
end;

procedure TFrmParceiroInfoPagto.edtValorPagtoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    actAdicionar.Execute;
end;

procedure TFrmParceiroInfoPagto.ExibePagamento;
var
  FrameItem: TFramePagamento;
  componente: TComponent;
  stFrameName: string;
  pagto: TParceiroVendaPagto;
begin

  LimpaScrollBox(scrBoxPagamentos);

  if ParceiroVenda.Pagamentos.Count = 0 then
  begin
    exit;
  end;

  for pagto in ParceiroVenda.Pagamentos do
  begin

    stFrameName := 'FramePagamento' + pagto.SEQ.ToString;

    componente := scrBoxPagamentos.FindComponent(stFrameName);
    if componente = nil then
    begin
      FrameItem := TFramePagamento.Create(nil);
      FrameItem.Name := stFrameName;
      FrameItem.Parent := scrBoxPagamentos;
      FrameItem.Align := alTop;

    end
    else
    begin
      FrameItem := TFramePagamento(componente);
    end;
    FrameItem.setPagamento(pagto);

  end;

  scrBoxPagamentos.VertScrollBar.Position := 0;

end;

procedure TFrmParceiroInfoPagto.LimpaScrollBox(aScroll: TScrollBox);
var
  i: Integer;
begin

  for i := aScroll.ControlCount - 1 downto 0 do
  Begin
    aScroll.Controls[i].Free;
  End;

end;

procedure TFrmParceiroInfoPagto.lstFormaPagtoEnter(Sender: TObject);
begin
  inherited;
  TListBox(Sender).Color := $00E7F0EC;
  TListBox(Sender).ItemIndex := 0;
end;

procedure TFrmParceiroInfoPagto.lstFormaPagtoExit(Sender: TObject);
begin
  inherited;
  TListBox(Sender).Color := clWindow;
end;

procedure TFrmParceiroInfoPagto.lstFormaPagtoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtValorPagto.SetFocus;
end;

procedure TFrmParceiroInfoPagto.OnAddPagamento(Pagamento: TParceiroVendaPagto);
begin
  lblValorLiquido.Caption := FloatToStrF(ParceiroVenda.TotalPagamento, ffNumber, 9, 2);
  lblTotalComissao.Caption := FloatToStrF(ParceiroVenda.TotalComissao, ffNumber, 9, 2);
end;

procedure TFrmParceiroInfoPagto.OnRemovePagamento(Index: Integer);
begin
  ExibePagamento;
  lblValorLiquido.Caption := FloatToStrF(ParceiroVenda.TotalPagamento, ffNumber, 9, 2);
  lblTotalComissao.Caption := FloatToStrF(ParceiroVenda.TotalComissao, ffNumber, 9, 2);
end;

procedure TFrmParceiroInfoPagto.Inicializa;
begin

  lblValorLiquido.Caption := '0,00';
  lblTotalComissao.Caption := '0,00';
  edtValorPagto.Text := '';
  LimpaScrollBox(scrBoxPagamentos);

  if Assigned(ParceiroVenda) then
    FreeAndNil(ParceiroVenda);

  ParceiroVenda := TParceiroVenda.Create;
  ParceiroVenda.STATUS := 'A';
  ParceiroVenda.OnAddPgamento := OnAddPagamento;
  ParceiroVenda.OnRemovePagamento := OnRemovePagamento;
  ParceiroVenda.Vendedor := TFactory.DaoVendedor.GetVendedor(TFactory.VendedorLogado.CODIGO);
  ParceiroVenda.DATA := Now;

  inherited;
  try
    cbbParceiro.ItemIndex := -1;
    cbbParceiro.SetFocus;
  except
    on E: Exception do
  end;
end;

procedure TFrmParceiroInfoPagto.PopulaLista;
var
  pagto: TParceiroFormaPagto;
  parceiro: TParceiro;
  i: Integer;
begin
  try
    pagtos := DaoParceiroFormaPagto.ListaObject();

    lstFormaPagto.Clear;
    for pagto in pagtos do
    begin
      lstFormaPagto.Items.AddObject(pagto.DESCRICAO, pagto);
    end;

  except
    on E: Exception do
      raise Exception.Create('Falha ao popular lista: ' + E.Message);
  end;

  try
    parceiros := DaoParceiro.ListarAtivos();

    cbbParceiro.Clear;
    for parceiro in parceiros do
    begin
      cbbParceiro.Items.AddObject(parceiro.NOME, parceiro);
    end;

  except
    on E: Exception do
      raise Exception.Create('Falha ao popular lista: ' + E.Message);
  end;

end;

end.
