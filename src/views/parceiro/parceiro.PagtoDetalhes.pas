unit parceiro.PagtoDetalhes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase,
  Dominio.Entidades.TParceiro, Dao.IDaoParceiro, Dominio.Entidades.TParceiroVenda,
  Dominio.Entidades.TParceiroVenda.Pagamentos, parceiro.FramePagamento, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TFrmPagtoDetalhes = class(TfrmBase)
    Panel1: TPanel;
    Panel6: TPanel;
    Label14: TLabel;
    lblValorLiquido: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    lblTotalComissao: TLabel;
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
    btnCancelar: TBitBtn;
    Panel3: TPanel;
    Panel4: TPanel;
    lblValor: TLabel;
    lblComissao: TLabel;
    Panel5: TPanel;
    lblForma: TLabel;
    lblCondicao: TLabel;
    pnlParceiro: TPanel;
    lblParceiro: TLabel;
    Image1: TImage;
  private
    FParceiroVenda: TParceiroVenda;
    procedure ExibePagamento;
    procedure LimpaScrollBox(aScroll: TScrollBox);
    { Private declarations }
  public
    { Public declarations }
    procedure SetParceiroVenda(ParceiroVenda: TParceiroVenda);
  end;

var
  FrmPagtoDetalhes: TFrmPagtoDetalhes;

implementation

{$R *.dfm}

{ TfrmBase1 }

procedure TFrmPagtoDetalhes.SetParceiroVenda(ParceiroVenda: TParceiroVenda);
begin
  FParceiroVenda := ParceiroVenda;
  ExibePagamento;

  lblValorLiquido.Caption := FloatToStrF(FParceiroVenda.TotalPagamento, ffNumber, 9, 2);
  lblTotalComissao.Caption := FloatToStrF(FParceiroVenda.TotalComissao, ffNumber, 9, 2);
  lblParceiro.Caption := FParceiroVenda.NOME;
end;

procedure TFrmPagtoDetalhes.LimpaScrollBox(aScroll: TScrollBox);
var
  i: Integer;
begin

  for i := aScroll.ControlCount - 1 downto 0 do
  Begin
    aScroll.Controls[i].Free;
  End;

end;

procedure TFrmPagtoDetalhes.ExibePagamento;
var
  FrameItem: TFramePagamento;
  componente: TComponent;
  stFrameName: string;
  pagto: TParceiroVendaPagto;
begin

  LimpaScrollBox(scrBoxPagamentos);

  if FParceiroVenda.Pagamentos.Count = 0 then
  begin
    exit;
  end;

  for pagto in FParceiroVenda.Pagamentos do
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

end.
