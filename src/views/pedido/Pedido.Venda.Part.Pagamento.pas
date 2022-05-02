unit Pedido.Venda.Part.Pagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls, Pedido.Venda.IPart,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento;

type
  TFramePedidoVendaPagamento = class(TFrame, IPart)
    Panel1: TPanel;
    lblAcrescimo: TLabel;
    Panel2: TPanel;
    lblValor: TLabel;
    Panel3: TPanel;
    lblQuantasVezes: TLabel;
    lblDescricao: TLabel;
    pnl1: TPanel;
    img1: TImage;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    FPAGAMENTO: TPEDIDOPAGAMENTO;
    FCallback: TOnObjectChange;
    // Flog: ILog;
    procedure MarcaExcluido;
    { Private declarations }
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

uses
  Helper.Currency;

{$R *.dfm}


constructor TFramePedidoVendaPagamento.Create(aOwner: TComponent);
begin
  inherited;
  // Flog := TFactoryModels.New.Log;
end;

destructor TFramePedidoVendaPagamento.Destroy;
begin

  inherited;
end;

class function TFramePedidoVendaPagamento.New(aOwner: TComponent): IPart;
begin
  result := TFramePedidoVendaPagamento.Create(aOwner);
end;

function TFramePedidoVendaPagamento.setOnObjectChange(aCallback: TOnObjectChange): IPart;
begin
  // Flog.d('>>> Entrando em  TViewConcretCadastroOrdemServicoPagamento.setOnObjectChange ');
  FCallback := aCallback;
  result := Self;
  // Flog.d('<<< Saindo de TViewConcretCadastroOrdemServicoPagamento.setOnObjectChange ');
end;

function TFramePedidoVendaPagamento.setParams(aObj: array of TObject): IPart;
begin
  // Flog.d('>>> Entrando em  TViewConcretCadastroOrdemServicoPagamento.setParams ');
  result := Self;
  if Length(aObj) = 0 then
    raise Exception.Create('NENHUMA FORMA DE PAGAMENTO PASSADA');

  if NOT(aObj[0] IS TPEDIDOPAGAMENTO) then
    raise Exception.Create('O OBJETO PRECISA SER DO TIPO TPEDIDOPAGAMENTO');

  FPAGAMENTO := TPEDIDOPAGAMENTO(aObj[0]);
  // Flog.d('<<< Saindo de TViewConcretCadastroOrdemServicoPagamento.setParams ');
end;

function TFramePedidoVendaPagamento.setParams(aObj: array of string): IPart;
begin
  result := Self;
end;

function TFramePedidoVendaPagamento.setParent(aParent: TWinControl): IPart;
begin
  // Flog.d('<<< Saindo de TViewConcretCadastroOrdemServicoPagamento.setParent ');
  result := Self;
  Self.Parent := aParent;
  // Flog.d('>>> Entrando em  TViewConcretCadastroOrdemServicoPagamento.setParent ');
end;

function TFramePedidoVendaPagamento.SetUp: IPart;
begin
  // Flog.d('>>> Entrando em  TViewConcretCadastroOrdemServicoPagamento.SetUp ');
  result := Self;
  Self.Align := alTop;

  lblDescricao.Caption := FPAGAMENTO.DESCRICAO;
  lblQuantasVezes.Caption := Format('%s', [FPAGAMENTO.CONDICAO]);
  lblValor.Caption := FPAGAMENTO.VALOR.ToReais;
  lblAcrescimo.Caption := Format('ACRÉSCIMO: %s', [FPAGAMENTO.ACRESCIMO.ToReais]);

  if FPAGAMENTO.StatusBD = TPEDIDOPAGAMENTO.TStatusBD.stDeletado then
    MarcaExcluido();
  // Flog.d('<<< Saindo de TViewConcretCadastroOrdemServicoPagamento.SetUp ');
end;

procedure TFramePedidoVendaPagamento.SpeedButton1Click(Sender: TObject);
begin
  // Flog.d('>>> Entrando em  TViewConcretCadastroOrdemServicoPagamento.SpeedButton1Click ');
  MarcaExcluido();
  FPAGAMENTO.StatusBD := TPEDIDOPAGAMENTO.TStatusBD.stDeletado;

  if Assigned(FCallback) then
    FCallback(Self);
end;

procedure TFramePedidoVendaPagamento.MarcaExcluido;
begin
  // Flog.d('>>> Entrando em  TViewConcretCadastroOrdemServicoPagamento.MarcaExcluido ');
  lblAcrescimo.Font.Style := [fsStrikeOut];
  lblDescricao.Font.Style := [fsStrikeOut];
  lblQuantasVezes.Font.Style := [fsStrikeOut];

  lblAcrescimo.Font.Color := clRed;
  lblDescricao.Font.Color := clRed;
  lblQuantasVezes.Font.Color := clRed;
  // Flog.d('<<< Saindo de TViewConcretCadastroOrdemServicoPagamento.MarcaExcluido ');
end;

initialization

RegisterClass(TFramePedidoVendaPagamento);

end.
