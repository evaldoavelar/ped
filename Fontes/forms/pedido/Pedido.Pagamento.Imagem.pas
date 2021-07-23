unit Pedido.Pagamento.Imagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Pedido.Venda.IPart;

type
  TFramePedidoPagamentoImagem = class(TFrame, IPart)
    imgPagamento: TImage;
  private
    { Private declarations }
    FCallback: TOnObjectChange;
  public
    function setParams(aObj: array of TObject): IPart; overload;
    function setParams(aObj: array of string): IPart; overload;
    function setParent(aParent: TWinControl): IPart;
    function setOnObjectChange(aCallback: TOnObjectChange): IPart;
    function SetUp: IPart;

  public
    class function New(aOwner: TComponent): IPart; virtual;
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

constructor TFramePedidoPagamentoImagem.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TFramePedidoPagamentoImagem.Destroy;
begin

  inherited;
end;

class function TFramePedidoPagamentoImagem.New(aOwner: TComponent): IPart;
begin
  result := TFramePedidoPagamentoImagem.Create(aOwner);
end;

function TFramePedidoPagamentoImagem.setOnObjectChange(aCallback: TOnObjectChange): IPart;
begin
  FCallback := aCallback;
  result := Self;
end;

function TFramePedidoPagamentoImagem.setParams(aObj: array of TObject): IPart;
begin

end;

function TFramePedidoPagamentoImagem.setParams(aObj: array of string): IPart;
begin

end;

function TFramePedidoPagamentoImagem.setParent(aParent: TWinControl): IPart;
begin
  result := Self;
  Self.Parent := aParent;
end;

function TFramePedidoPagamentoImagem.SetUp: IPart;
begin
  result := Self;
  Self.Align := alClient;
end;

initialization

RegisterClass(TFramePedidoPagamentoImagem);

end.
