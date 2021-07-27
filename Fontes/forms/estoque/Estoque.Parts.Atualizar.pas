unit Estoque.Parts.Atualizar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls, Pedido.Venda.IPart,
  Dominio.Entidades.TEstoqueProduto;

type
  TFrameEstoquePartsAtualizar = class(TFrame, IPart)
    pnl2: TPanel;
    pnlNumero: TPanel;
    pnlCodigoPrd: TPanel;
    ViewPartVendaItens: TPanel;
    lblDescricao: TLabel;
    pnlPreco: TPanel;
    lblPreco: TLabel;
    pnlCancelar: TPanel;
    img1: TImage;
    btnCancelar: TSpeedButton;
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FProduto: TEstoqueProduto;
    FCallback: TOnObjectChange;
    // Flog: ILog;
    procedure MarcaExcluido(aSource: TWinControl);
  public
    { Public declarations }
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


procedure TFrameEstoquePartsAtualizar.btnCancelarClick(Sender: TObject);
begin
  MarcaExcluido(pnl2);
  FProduto.StatusBD := TEstoqueProduto.TStatusBD.stDeletado;

  if Assigned(FCallback) then
    FCallback(FProduto);
end;

constructor TFrameEstoquePartsAtualizar.Create(aOwner: TComponent);
begin
  inherited;
  // Flog := TFactoryModels.New.Log;
end;

destructor TFrameEstoquePartsAtualizar.Destroy;
begin

  inherited;
end;

procedure TFrameEstoquePartsAtualizar.MarcaExcluido(aSource: TWinControl);
var
  I: Integer;
begin
  // Flog.d('>>> Entrando em  TViewPartVendaItens.MarcaExcluido ');

  for I := 0 to aSource.ControlCount - 1 do
  begin
    if (aSource.Controls[I] is TLabel) then
    begin
      TLabel(aSource.Controls[I]).Font.Style := [fsStrikeOut];
      TLabel(aSource.Controls[I]).Font.Color := clRed;
    end
    else if (aSource.Controls[I] is TPanel) then
    begin
      TPanel(aSource.Controls[I]).Font.Style := [fsStrikeOut];
      TPanel(aSource.Controls[I]).Font.Color := clRed;
    end;

    if aSource.Controls[I] is TWinControl then
      MarcaExcluido(TWinControl(aSource.Controls[I]));

  end;

  pnlCancelar.Visible := false;

  // Flog.d('<<< Saindo de TViewPartVendaItens.MarcaExcluido ');

end;

class function TFrameEstoquePartsAtualizar.New(aOwner: TComponent): IPart;
begin
  result := TFrameEstoquePartsAtualizar.Create(aOwner);
end;

function TFrameEstoquePartsAtualizar.setOnObjectChange(
  aCallback: TOnObjectChange): IPart;
begin
  FCallback := aCallback;
  result := Self;
end;

function TFrameEstoquePartsAtualizar.setParams(
  aObj: array of TObject): IPart;
begin
  result := Self;
  if Length(aObj) = 0 then
    raise Exception.Create('NENHUMA FORMA DE ESTOQUEPRODUTO PASSADO');

  if NOT(aObj[0] IS TEstoqueProduto) then
    raise Exception.Create('O OBJETO PRECISA SER DO TIPO TESTOQUEPRODUTO');

  FProduto := TEstoqueProduto(aObj[0]);
end;

function TFrameEstoquePartsAtualizar.setParams(
  aObj: array of string): IPart;
begin
  result := Self;
end;

function TFrameEstoquePartsAtualizar.setParent(
  aParent: TWinControl): IPart;
begin
  result := Self;
  Self.Parent := aParent;
end;

function TFrameEstoquePartsAtualizar.SetUp: IPart;
begin
  result := Self;
  Self.Align := alTop;

  lblDescricao.Caption := FProduto.DESCRICAO;
  Self.pnlCodigoPrd.Caption := FProduto.CODIGOPRD;
  pnlNumero.Caption := FProduto.id.ToString;
  Self.lblPreco.Caption := FloatToStrF(FProduto.QUANTIDADE, ffNumber, 9, 3) + // '  ' + FProduto.UND +
    '  UNIDADE(S)   ';

  if FProduto.StatusBD = TEstoqueProduto.TStatusBD.stDeletado then
    MarcaExcluido(Self);
end;

initialization

RegisterClass(TFrameEstoquePartsAtualizar);

end.
