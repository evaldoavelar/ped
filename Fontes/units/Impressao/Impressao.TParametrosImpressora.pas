unit Impressao.TParametrosImpressora;

interface

uses
  ACBrPosPrinter,
  system.SysUtils,
  Dominio.Mapeamento.Atributos,
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Tipos;

{ TImpressao }
// ==============================================================================
// Classe: TParametrosImpressora
// Autor: Evaldo
// Data: 18/8/2010
// Descrição: Classe responsavel pelos parametros da impressora
// ==============================================================================
type

  [Tabela('PARAMETROS')]
  TParametrosImpressora = class(TEntity)
  private
    FMODELOIMPRESSORA: string; // porta de comunicação
    FLinhasFinalCupom: Integer; // numero de linhas no final do cupom
    FColunasCupom: Integer;
    FPORTAIMPRESSORA: string; // numero de colunas no cupom
    FDebug: Boolean;
    FIMPRIMIR2VIAS: Boolean;
    FIMPRIMIRITENS2VIA: Boolean;
    FVELOCIDADE: string;
    function getPORTAIMPRESSORA: string;
    function getLinhasFinalCupom: Integer;
    function getMODELOIMPRESSORA: string;
    procedure setPORTAIMPRESSORA(const Value: string);
    procedure setLinhasFinalCupom(const Value: Integer);
    procedure setMODELOIMPRESSORA(const Value: string);
    function getVELOCIDADE: string;
    procedure setVELOCIDADE(const Value: string);
    function getColunasCupom: Integer;
    procedure setColunasCupom(const Value: Integer);
    function getIMPRIMIR2VIAS: Boolean;
    procedure setIMPRIMIR2VIAS(const Value: Boolean);
    function getIMPRIMIRITENS2VIA: Boolean;
    procedure setIMPRIMIRITENS2VIA(const Value: Boolean); // Filial do ceasa
  public
    [campo('MODELOIMPRESSORA', tpVARCHAR, 60)]
    property MODELOIMPRESSORA: string read getMODELOIMPRESSORA write setMODELOIMPRESSORA;

    property LinhasFinalCupom: Integer read getLinhasFinalCupom write setLinhasFinalCupom;
    property ColunasCupom: Integer read getColunasCupom write setColunasCupom;
    [campo('PORTAIMPRESSORA', tpVARCHAR, 10)]
    property PORTAIMPRESSORA: string read getPORTAIMPRESSORA write setPORTAIMPRESSORA;
    [campo('VELOCIDADE', tpVARCHAR, 10)]
    property VELOCIDADE: string read getVELOCIDADE write setVELOCIDADE;
    [campo('IMPRIMIR2VIAS', tpSMALLINT, 0, 0, True, '1')]
    property IMPRIMIR2VIAS: Boolean read getIMPRIMIR2VIAS write setIMPRIMIR2VIAS;
    [campo('IMPRIMIRITENS2VIA', tpSMALLINT, 0, 0, True, '1')]
    property IMPRIMIRITENS2VIA: Boolean read getIMPRIMIRITENS2VIA write setIMPRIMIRITENS2VIA;
    property Debug: Boolean read FDebug write FDebug;

    function ModeloAsModeloAsACBrPosPrinterModelo: TACBrPosPrinterModelo;

    constructor Create;
  end;

implementation


constructor TParametrosImpressora.Create;
begin
  inherited;
  InicializarPropriedades();
  FDebug := False;
  ColunasCupom := 5;
  LinhasFinalCupom := 48;
end;

function TParametrosImpressora.getPORTAIMPRESSORA: string;
begin
  result := FPORTAIMPRESSORA;
end;

function TParametrosImpressora.getVELOCIDADE: string;
begin
  result := FVELOCIDADE;
end;

function TParametrosImpressora.ModeloAsModeloAsACBrPosPrinterModelo: TACBrPosPrinterModelo;
begin
  // iEpson, iBematech, iDaruma, iDiebold
  if (LowerCase(FMODELOIMPRESSORA) = 'iepson') or (LowerCase(FMODELOIMPRESSORA) = 'ppescposepson') then
    result := ppEscPosEpson
  else if (LowerCase(FMODELOIMPRESSORA) = 'ibematech') or (LowerCase(FMODELOIMPRESSORA) = 'ppescbematech') then
    result := ppEscBematech
  else if (LowerCase(FMODELOIMPRESSORA) = 'idiebold') then
    result := ppEscDiebold
  else if (LowerCase(FMODELOIMPRESSORA) = 'ppescdaruma') then
    result := ppEscDaruma
  else if (LowerCase(FMODELOIMPRESSORA) = 'ppescelgin') then
    result := ppEscPosEpson;
end;

function TParametrosImpressora.getColunasCupom: Integer;
begin
  result := FColunasCupom;
end;

function TParametrosImpressora.getIMPRIMIR2VIAS: Boolean;
begin
  result := FIMPRIMIR2VIAS;
end;

function TParametrosImpressora.getIMPRIMIRITENS2VIA: Boolean;
begin
  result := FIMPRIMIRITENS2VIA;
end;

function TParametrosImpressora.getLinhasFinalCupom: Integer;
begin
  result := FLinhasFinalCupom;
end;

function TParametrosImpressora.getMODELOIMPRESSORA: string;
begin
  result := FMODELOIMPRESSORA;
end;

procedure TParametrosImpressora.setPORTAIMPRESSORA(const Value: string);
begin
  if Value <> FPORTAIMPRESSORA then
  begin
    FPORTAIMPRESSORA := Value;
    Notify('PORTAIMPRESSORA');
  end;
end;

procedure TParametrosImpressora.setVELOCIDADE(const Value: string);
begin
  if Value <> FVELOCIDADE then
  begin
    FVELOCIDADE := Value;
    Notify('VELOCIDADE');
  end;
end;

procedure TParametrosImpressora.setColunasCupom(const Value: Integer);
begin
  if Value <> FColunasCupom then
  begin
    FColunasCupom := Value;
    Notify('ColunasCupom');
  end;
end;

procedure TParametrosImpressora.setIMPRIMIR2VIAS(const Value: Boolean);
begin

  if Value <> FIMPRIMIR2VIAS then
  begin
    FIMPRIMIR2VIAS := Value;
    Notify('IMPRIMIR2VIAS');
  end;
end;

procedure TParametrosImpressora.setIMPRIMIRITENS2VIA(const Value: Boolean);
begin
  if Value <> FIMPRIMIRITENS2VIA then
  begin
    FIMPRIMIRITENS2VIA := Value;
    Notify('IMPRIMIRITENS2VIA');
  end;
end;

procedure TParametrosImpressora.setLinhasFinalCupom(const Value: Integer);
begin
  if Value <> FLinhasFinalCupom then
  begin
    FLinhasFinalCupom := Value;
    Notify('LINHASFINALCUPOM');
  end;
end;

procedure TParametrosImpressora.setMODELOIMPRESSORA(const Value: string);
begin
  if Value <> FMODELOIMPRESSORA then
  begin
    FMODELOIMPRESSORA := Value;
    Notify('MODELOIMPRESSORA');
  end;
end;

end.
