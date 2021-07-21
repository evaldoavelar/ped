unit Pedido.Venda.Part.Item;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Dominio.Entidades.TItemPedido,
  Pedido.Venda.IPart, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TPedidoVendaFramePartItem = class(TFrame,IPart)
    Panel33: TPanel;
    pnlNumero: TPanel;
    pnlCodigoPrd: TPanel;
    ViewPartVendaItens: TPanel;
    lblDescricao: TLabel;
    pnlPreco: TPanel;
    lblTotalDesc: TLabel;
    lblDesconto: TLabel;
    lblPreco: TLabel;
    lblTotal: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function setParams(aObj: array of TObject): IPart;
    function setParent(aParent: TWinControl): IPart;
    function SetUp: IPart;

  public
    class function New(aOwner: TComponent): IPart; virtual;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}


constructor TPedidoVendaFramePartItem.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TPedidoVendaFramePartItem.Destroy;
begin

  inherited;
end;

class function TPedidoVendaFramePartItem.New(aOwner: TComponent): IPart;
begin
  result := Self.Create(aOwner);
end;

function TPedidoVendaFramePartItem.setParams(aObj: array of TObject): IPart;
var
  Item: TItemPedido;
  I: Integer;
begin
  result := Self;
  // pnlNumero.Caption := FormatDateTime('ss', now)
  if Length(aObj) = 0 then
    exit;

  for I := 0 to Length(aObj) -1 do
  begin
    Item := TItemPedido(aObj[I]);

    self.pnlNumero.Caption := Item.SEQ.ToString.PadLeft(3, '0');
    self.pnlCodigoPrd.Caption := Item.CODPRODUTO;
    self.lblDescricao.Caption := Item.DESCRICAO;

    self.lblPreco.Caption := FloatToStrF(Item.QTD, ffNumber, 9, 3) + '  ' + Item.UND +
      '   X   ' + FloatToStrF(Item.VALOR_UNITA, ffNumber, 9, 2);

    self.lblTotal.Caption := FloatToStrF(Item.VALOR_TOTAL, ffNumber, 9, 2);

    if item.VALOR_DESCONTO > 0 then
    begin
      self.lblTotalDesc.Caption := FloatToStrF( Item.VALOR_TOTAL - Item.VALOR_DESCONTO, ffNumber, 9, 2);
      self.lblDesconto.Caption := '-' + FloatToStrF(Item.VALOR_DESCONTO, ffNumber, 9, 2);
    end
    else
    begin
      self.lblTotalDesc.Visible := false;
      self.lblDesconto.Visible := false;
    end;

    //self.Parent := scrboxItens;
    self.Align := alTop;



  end;
end;

function TPedidoVendaFramePartItem.setParent(aParent: TWinControl): IPart;
begin
  result := Self;
  Self.Parent := aParent;

end;

function TPedidoVendaFramePartItem.SetUp: IPart;
begin
  result := Self;
  Self.Align := alTop;
end;

initialization

RegisterClass(TPedidoVendaFramePartItem);

end.
