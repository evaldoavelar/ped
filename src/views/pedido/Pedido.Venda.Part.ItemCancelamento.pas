unit Pedido.Venda.Part.ItemCancelamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Dominio.Entidades.TItemPedido,
  Pedido.Venda.IPart;

type
  TPedidoVendaPartItemCancelamento = class(TFrame, IPart)
    pnlNumero: TPanel;
    ViewPartVendaItens: TPanel;
    lblDescricao: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    function setParams(aObj: array of TObject): IPart;
    function setParent(aParent: TWinControl): IPart;
    function SetUp: IPart;
    function setOnObjectChange(aCallback: TOnObjectChange): IPart;
  public
    class function New(aOwner: TComponent): IPart; virtual;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}


constructor TPedidoVendaPartItemCancelamento.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TPedidoVendaPartItemCancelamento.Destroy;
begin

  inherited;
end;

class function TPedidoVendaPartItemCancelamento.New(aOwner: TComponent): IPart;
begin
  result := Self.Create(aOwner);
end;

function TPedidoVendaPartItemCancelamento.setOnObjectChange(
  aCallback: TOnObjectChange): IPart;
begin

end;

function TPedidoVendaPartItemCancelamento.setParams(aObj: array of TObject): IPart;
var
  Item: TItemPedido;
  I: Integer;
begin
  result := Self;
  // pnlNumero.Caption := FormatDateTime('ss', now)
  if Length(aObj) = 0 then
    exit;

  for I := 0 to Length(aObj) - 1 do
  begin
    Item := TItemPedido(aObj[I]);

    Self.pnlNumero.Caption := Item.SEQ.ToString.PadLeft(3, '0');
    lblDescricao.Caption := StringOfChar(' ', 10) + 'CANCELADO ITEM : ' +
      StringOfChar('0', 3 - Length(IntToStr(Item.SEQ))) + Item.SEQ.ToString +
      StringOfChar(' ', 10) + '-' +
      FloatToStrF(Item.VALOR_UNITA, ffNumber, 9, 2);

    // self.Parent := scrboxItens;
    Self.Align := alTop;

  end;
end;

function TPedidoVendaPartItemCancelamento.setParent(aParent: TWinControl): IPart;
begin
  result := Self;
  Self.Parent := aParent;

end;

function TPedidoVendaPartItemCancelamento.SetUp: IPart;
begin
  result := Self;
  Self.Align := alTop;
end;

initialization

RegisterClass(TPedidoVendaPartItemCancelamento);

end.
