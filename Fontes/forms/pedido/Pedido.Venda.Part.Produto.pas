unit Pedido.Venda.Part.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Pedido.Venda.IPart;

type
  TPedidoPartFrameProduto = class(TFrame, IPart)
    pnlPagamentoTopo: TPanel;
    lbl1: TLabel;
    Panel23: TPanel;
    Image1: TImage;
    Panel14: TPanel;
    Image3: TImage;
    Label43: TLabel;
    Label44: TLabel;
    Label46: TLabel;
    Panel4: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Panel15: TPanel;
    img3: TImage;
    Panel13: TPanel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Panel18: TPanel;
  private
    { Private declarations }
  public
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


constructor TPedidoPartFrameProduto.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TPedidoPartFrameProduto.Destroy;
begin

  inherited;
end;

class function TPedidoPartFrameProduto.New(aOwner: TComponent): IPart;
begin
  result := Self.New(aOwner);
end;

function TPedidoPartFrameProduto.setParams(aObj: array of TObject): IPart;
begin
  result := Self;
end;

function TPedidoPartFrameProduto.setParent(aParent: TWinControl): IPart;
begin
  result := Self;
  Self.Parent := aParent;

end;

function TPedidoPartFrameProduto.SetUp: IPart;
begin
  result := Self;
  Self.Align := alTop;
end;

initialization

RegisterClass(TPedidoPartFrameProduto);

end.
