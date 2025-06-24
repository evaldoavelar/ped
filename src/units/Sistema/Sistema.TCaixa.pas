unit Sistema.TCaixa;

interface

uses
  system.SysUtils, Vcl.ExtCtrls,
  Dominio.Entidades.TEntity,


  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  TCaixa = class(TEntity)
  private
    FNUMCAIXA: string;
    procedure SetNUMCAIXA(const Value: string);
  public
    [campo('NUMCAIXA', tpVARCHAR, 30)]
    property NUMCAIXA: string read FNUMCAIXA write SetNUMCAIXA;
  end;

implementation

{ TCaixa }

procedure TCaixa.SetNUMCAIXA(const Value: string);
begin
  FNUMCAIXA := Value;
end;

end.
