unit Pedido.Venda.Part.LogoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Pedido.Venda.IPart,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type

  TPedidoVendaPartLogoItens = class(TFrame, IPart)
    Image1: TImage;
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


constructor TPedidoVendaPartLogoItens.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TPedidoVendaPartLogoItens.Destroy;
begin

  inherited;
end;

class function TPedidoVendaPartLogoItens.New(aOwner: TComponent): IPart;
begin
  result := Self.Create(aOwner);
end;

function TPedidoVendaPartLogoItens.setOnObjectChange(
  aCallback: TOnObjectChange): IPart;
begin

end;

function TPedidoVendaPartLogoItens.setParams(aObj: array of TObject): IPart;

begin
  result := Self;

end;

function TPedidoVendaPartLogoItens.setParent(aParent: TWinControl): IPart;
begin
  result := Self;
  Self.Parent := aParent;

end;

function TPedidoVendaPartLogoItens.SetUp: IPart;
begin
  result := Self;
  Self.Align := alTop;
end;

initialization

RegisterClass(TPedidoVendaPartLogoItens);

end.
