unit Dominio.Entidades.CondicaoPagto;

interface

uses
  Dominio.Entidades.TEntity, Dominio.Mapeamento.Tipos,
  Dominio.Mapeamento.Atributos;

type

  [Tabela('CONDICAODEPAGTO')]
  TCONDICAODEPAGTO = class(TEntity)
  private
    FQUANTASVEZES: integer;
    FACRESCIMO: Double;
    FDESCRICAO: string;
    FID: integer;
    FIDPAGTO: integer;
    FDATAALTERACAO: TDateTime;
    procedure SetACRESCIMO(const Value: Double);
    procedure SetDESCRICAO(const Value: string);
    procedure SetID(const Value: integer);
    procedure SetIDPAGTO(const Value: integer);
    procedure SetQUANTASVEZES(const Value: integer);
    procedure SetDATAALTERACAO(const Value: TDateTime);
  public
    [AutoInc('AUTOINC')]
    [PrimaryKey('PK_CONDICAODEPAGTO', 'ID')]
    [Campo('ID', tpINTEGER, 0, 0, True)]
    property ID: integer read FID write SetID;
    [ForeignKeyAttribute('FKPAGTO_CONDICAODEPAGTO', 'IDPAGTO', 'FORMAPAGTO', 'ID', TRuleAction.Cascade, TRuleAction.None, '')]
    [Campo('IDPAGTO', tpINTEGER, 0, 0, True)]
    property IDPAGTO: integer read FIDPAGTO write SetIDPAGTO;
    [Campo('DESCRICAO', tpVARCHAR, 60, 0, True)]
    property DESCRICAO: string read FDESCRICAO write SetDESCRICAO;
    [Campo('QUANTASVEZES', tpINTEGER, 0, 0, True)]
    property QUANTASVEZES: integer read FQUANTASVEZES write SetQUANTASVEZES;
    [Campo('ACRESCIMO', tpNUMERIC, 15, 4, True, '0')]
    property ACRESCIMO: Double read FACRESCIMO write SetACRESCIMO;

    [Campo('DATAALTERACAO', tpTIMESTAMP)]
    property DATAALTERACAO: TDateTime read FDATAALTERACAO write SetDATAALTERACAO;

    function CalculaValorDoAcrescimo(aValorPagamento: currency): currency;
    function CalculaAcrescimo(aValorPagamento: currency): currency;
  end;

implementation

uses
  Helper.currency;

{ TCONDICAODEPAGTO }

function TCONDICAODEPAGTO.CalculaAcrescimo(
  aValorPagamento: currency): currency;
begin
  Result := aValorPagamento + ((self.ACRESCIMO / 100) * aValorPagamento);
  Result := Result.ToDuasCasas;
end;

function TCONDICAODEPAGTO.CalculaValorDoAcrescimo(
  aValorPagamento: currency): currency;
begin
  Result := CalculaAcrescimo(aValorPagamento) - aValorPagamento;
end;

procedure TCONDICAODEPAGTO.SetACRESCIMO(const Value: Double);
begin
  FACRESCIMO := Value;
end;

procedure TCONDICAODEPAGTO.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TCONDICAODEPAGTO.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TCONDICAODEPAGTO.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TCONDICAODEPAGTO.SetIDPAGTO(const Value: integer);
begin
  FIDPAGTO := Value;
end;

procedure TCONDICAODEPAGTO.SetQUANTASVEZES(const Value: integer);
begin
  FQUANTASVEZES := Value;
end;

end.
