unit Impressao.Parametros.Impressora.Tinta;

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
  TParametrosImpressoraTinta = class(TEntity)
  private
    FMODELOIMPRESSORATINTA: string;
    procedure SetMODELOIMPRESSORATINTA(const Value: string);
  public
    [campo('MODELOIMPRESSORATINTA', tpVARCHAR, 60)]
    property MODELOIMPRESSORATINTA: string read FMODELOIMPRESSORATINTA write SetMODELOIMPRESSORATINTA;

  end;

implementation

{ TParametrosImpressoraTinta }

procedure TParametrosImpressoraTinta.SetMODELOIMPRESSORATINTA(
  const Value: string);
begin
  if Value <> FMODELOIMPRESSORATINTA then
  begin
    FMODELOIMPRESSORATINTA := Value;
    Notify('MODELOIMPRESSORATINTA');
  end;
end;

end.
