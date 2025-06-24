unit Dominio.Entidades.TControleCaixa;

interface

uses
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Dominio.Entidades.TVendedor;

type

  [Tabela('CONTROLECAIXA')]
  TControleCaixa = class(TEntity)
  private
    FDataFechamento: TDateTime;
    FCODVEN: string;
    FValorFechamento: Currency;
    FID: Integer;
    FDataAbertura: TDateTime;
    FNUMCAIXA: string;
    FValorAbertura: Currency;
  published
    [AutoInc('AUTOINC')]
    [PrimaryKey('PKPEDIDOPAGAMENTOS', 'ID')]
    [campo('ID', tpINTEGER, 0, 0, True)]
    property ID: Integer read FID write FID;

    [campo('DATAABERTURA', tpTIMESTAMP)]
    property DataAbertura: TDateTime read FDataAbertura write FDataAbertura;

    [campo('DATAFECHAMENTO', tpTIMESTAMP)]
    property DataFechamento: TDateTime read FDataFechamento write FDataFechamento;

    [campo('NUMCAIXA', tpVARCHAR, 10, 0, True, 'caixa-01')]
    property NUMCAIXA: string read FNUMCAIXA write FNUMCAIXA;

    [campo('CODVEN', tpVARCHAR, 10)]
    [ForeignKeyAttribute('FKPEDVEN', 'CODVEN', 'VENDEDOR', 'CODIGO', None, None)]
    property CODVEN: string read FCODVEN write FCODVEN;

    [campo('VALORABERTURA', tpNUMERIC, 15, 4)]
    property ValorAbertura: Currency read FValorAbertura write FValorAbertura;

    [campo('VALORFECHAMENTO', tpNUMERIC, 15, 4)]
    property ValorFechamento: Currency read FValorFechamento write FValorFechamento;

    constructor Create;
  end;

implementation

{ TControleCaixa }

constructor TControleCaixa.Create;
begin
  FID := 0;
  FDataAbertura := 0;
  FDataFechamento := 0;
  FNUMCAIXA := '';
  FCODVEN := '';
  FValorAbertura := 0.0;
  FValorFechamento := 0.0;
end;

end.
