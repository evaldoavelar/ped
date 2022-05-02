unit Pedido.Venda.Part.CondicaoPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls,
  Dominio.Entidades.CondicaoPagto, Pedido.Venda.IPart;

type
  TViewPartVendaFormaPagto = class(TFrame, IPart)
    Panel1: TPanel;
    Panel2: TPanel;
    lblAcrescimo: TLabel;
    pnl1: TPanel;
    img1: TImage;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    lblQuantasVezes: TLabel;
    lblDescricao: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
  private
    FCONDICAODEPAGTO: TCONDICAODEPAGTO;
    FCallback: TOnObjectChange;
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

{$R *.dfm}


constructor TViewPartVendaFormaPagto.Create(aOwner: TComponent);
begin
  inherited;

end;

destructor TViewPartVendaFormaPagto.Destroy;
begin

  inherited;
end;

class function TViewPartVendaFormaPagto.New(aOwner: TComponent): IPart;
begin
  result := TViewPartVendaFormaPagto.Create(aOwner);
end;

function TViewPartVendaFormaPagto.setParams(aObj: array of TObject): IPart;
begin
  // Flog.d('>>> Entrando em  TViewPartVendaFormaPagto.setParams ');
  result := Self;
  if Length(aObj) = 0 then
    raise Exception.Create('NENHUMA FORMA DE PAGAMENTO PASSADA');

  if NOT(aObj[0] IS TCONDICAODEPAGTO) then
    raise Exception.Create('O OBJETO PRECISA SER DO TIPO TCONDICAODEPAGTO');

  FCONDICAODEPAGTO := TCONDICAODEPAGTO(aObj[0]);
  // Flog.d('<<< Saindo de TViewPartVendaFormaPagto.setParams ');
end;

function TViewPartVendaFormaPagto.setParams(aObj: array of string): IPart;
begin
  result := Self;
end;

function TViewPartVendaFormaPagto.setParent(aParent: TWinControl): IPart;
begin
  // Flog.d('<<< Saindo de TViewPartVendaFormaPagto.setParent ');
  result := Self;
  Self.Parent := aParent;
  // Flog.d('>>> Entrando em  TViewPartVendaFormaPagto.setParent ');
end;

function TViewPartVendaFormaPagto.SetUp: IPart;
begin
  // Flog.d('>>> Entrando em  TViewPartVendaFormaPagto.SetUp ');
  result := Self;
  Self.Align := alTop;

  lblDescricao.Caption := FCONDICAODEPAGTO.DESCRICAO;
  lblQuantasVezes.Caption := Format('%d VEZES', [FCONDICAODEPAGTO.QUANTASVEZES]);
  lblAcrescimo.Caption := FormatFloat('0.,00% ', FCONDICAODEPAGTO.ACRESCIMO);

  if FCONDICAODEPAGTO.StatusBD = TCONDICAODEPAGTO.TStatusBD.stDeletado then
    MarcaExcluido();
  // Flog.d('<<< Saindo de TViewPartVendaFormaPagto.SetUp ');
end;

procedure TViewPartVendaFormaPagto.SpeedButton1Click(Sender: TObject);
begin
  // Flog.d('>>> Entrando em  TViewPartVendaFormaPagto.SpeedButton1Click ');
  MarcaExcluido();
  FCONDICAODEPAGTO.StatusBD := TCONDICAODEPAGTO.TStatusBD.stDeletado;

  if Assigned(FCallback) then
    FCallback(Self);
end;

procedure TViewPartVendaFormaPagto.MarcaExcluido;
begin
  // Flog.d('>>> Entrando em  TViewPartVendaFormaPagto.MarcaExcluido ');
  lblAcrescimo.Font.Style := [fsStrikeOut];
  lblDescricao.Font.Style := [fsStrikeOut];
  lblQuantasVezes.Font.Style := [fsStrikeOut];

  lblAcrescimo.Font.Color := clRed;
  lblDescricao.Font.Color := clRed;
  lblQuantasVezes.Font.Color := clRed;
  // Flog.d('<<< Saindo de TViewPartVendaFormaPagto.MarcaExcluido ');
end;

function TViewPartVendaFormaPagto.setOnObjectChange(
  aCallback: TOnObjectChange): IPart;
begin
  // Flog.d('>>> Entrando em  TViewPartVendaFormaPagto.setOnObjectChange ');
  FCallback := aCallback;
  result := Self;
  // Flog.d('<<< Saindo de TViewPartVendaFormaPagto.setOnObjectChange ');
end;

initialization

RegisterClass(TViewPartVendaFormaPagto);

end.
