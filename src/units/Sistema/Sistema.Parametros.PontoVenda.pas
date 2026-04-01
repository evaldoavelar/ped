unit Sistema.Parametros.PontoVenda;

interface

uses
  system.SysUtils,
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos,
  Impressao.Parametros.Impressora.Termica;

type
  TPontoVenda = class(TEntity)
  private
    FImpressora: TParametrosImpressoraTermica;
    FNUMCAIXA: string;
    FFUNCIONARCOMOCLIENTE: Boolean;
    procedure SetFUNCIONARCOMOCLIENTE(const Value: Boolean);
    procedure SetNUMCAIXA(const Value: string);
    function getImpressora: TParametrosImpressoraTermica;
    procedure setImpressora(const Value: TParametrosImpressoraTermica);
  public
    [campo('NUMCAIXA', tpVARCHAR, 10, 0, True, 'caixa-01')]
    property NUMCAIXA: string read FNUMCAIXA write SetNUMCAIXA;

    [campo('FUNCIONARCOMOCLIENTE', tpINTEGER, 0, 0, FALSE, '0')]
    property FUNCIONARCOMOCLIENTE: Boolean read FFUNCIONARCOMOCLIENTE write SetFUNCIONARCOMOCLIENTE;

    property ImpressoraTermica: TParametrosImpressoraTermica read getImpressora write setImpressora;
    constructor create; override;
    destructor Destroy;
  end;

implementation

constructor TPontoVenda.create;
begin
  inherited;
  FImpressora := TParametrosImpressoraTermica.create;
end;

destructor TPontoVenda.Destroy;
begin
  if Assigned(FImpressora) then
    FreeAndNil(FImpressora);
end;

function TPontoVenda.getImpressora: TParametrosImpressoraTermica;
begin
  result := FImpressora;
end;

procedure TPontoVenda.SetFUNCIONARCOMOCLIENTE(const Value: Boolean);
begin
  if Value <> FFUNCIONARCOMOCLIENTE then
  begin
    FFUNCIONARCOMOCLIENTE := Value;
    Notify('FUNCIONARCOMOCLIENTE');
  end;
end;

procedure TPontoVenda.setImpressora(const Value: TParametrosImpressoraTermica);
begin
  Self.FImpressora := Value;
end;

procedure TPontoVenda.SetNUMCAIXA(const Value: string);
begin
  FNUMCAIXA := Value;
end;

end.
