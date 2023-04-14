unit Sistema.Parametros.PontoVenda;

interface

uses
  system.SysUtils,
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type
  TPontoVenda = class(TEntity)
  private
    FNUMCAIXA: string;
    FFUNCIONARCOMOCLIENTE: Boolean;
    procedure SetFUNCIONARCOMOCLIENTE(const Value: Boolean);
    procedure SetNUMCAIXA(const Value: string);
  public
    [campo('NUMCAIXA', tpVARCHAR, 10, 0, True, 'caixa-01')]
    property NUMCAIXA: string read FNUMCAIXA write SetNUMCAIXA;

    [campo('FUNCIONARCOMOCLIENTE', tpINTEGER, 0, 0, FALSE, '0')]
    property FUNCIONARCOMOCLIENTE: Boolean read FFUNCIONARCOMOCLIENTE write SetFUNCIONARCOMOCLIENTE;
    constructor create; override;
  end;

implementation

constructor TPontoVenda.create;
begin
  inherited;

end;

procedure TPontoVenda.SetFUNCIONARCOMOCLIENTE(const Value: Boolean);
begin
  if Value <> FFUNCIONARCOMOCLIENTE then
  begin
    FFUNCIONARCOMOCLIENTE := Value;
    Notify('FUNCIONARCOMOCLIENTE');
  end;
end;

procedure TPontoVenda.SetNUMCAIXA(const Value: string);
begin
  FNUMCAIXA := Value;
end;

end.
