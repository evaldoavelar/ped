unit Dominio.Entidades.TSangriaSuprimento;

interface

uses
  Dominio.Entidades.TEntity, Dominio.Mapeamento.Tipos,
  Dominio.Mapeamento.Atributos, Dominio.Entidades.TSangriaSuprimento.Tipo;

type

  [Tabela('SANGRIASUPRIMENTO')]
  TSangriaSuprimento = class(TEntity)
  private
    FTipoPagamento: TSangriaSuprimentoTipo;
    FID: integer;
    FTipo: integer;
    FHISTORICO: string;

    FValor: Currency;
    FHORA: TTime;
    FDATA: TDate;
    FFORMA: string;
    FCODVEN: string;
    function getTIPOPROXY: string;
    procedure SetID(const Value: integer);
    procedure SetTipo(const Value: integer);
    procedure SetTipoPagamento(const Value: TSangriaSuprimentoTipo);
    function getTipoPagamento: TSangriaSuprimentoTipo;
    procedure SetHISTORICO(const Value: string);
    procedure SetValor(const Value: Currency);
    procedure SetDATA(const Value: TDate);
    procedure SetHORA(const Value: TTime);
    procedure SetFORMA(const Value: string);
    procedure SetCODVEN(const Value: string);
  published
    [AutoInc('AUTOINC')]
    [PrimaryKey('PK_SANGRIASUPRIMENTO', 'ID')]
    [Campo('ID', tpINTEGER, 0, 0, True)]
    property ID: integer read FID write SetID;

    [Campo('TIPO', tpINTEGER, 0, 0, True)]
    property TIPOPROXY: string read getTIPOPROXY;
    property TipoSangriaSuprimento: TSangriaSuprimentoTipo read getTipoPagamento write SetTipoPagamento;
    property Tipo: integer read FTipo write SetTipo;

    [Campo('HISTORICO', tpVARCHAR, 200)]
    property HISTORICO: string read FHISTORICO write SetHISTORICO;

    [Campo('FORMA', tpVARCHAR, 50)]
    property FORMA: string read FFORMA write SetFORMA;

    [Campo('VALOR', tpNUMERIC, 15, 4, True, '0')]
    property Valor: Currency read FValor write SetValor;

    [Campo('DATA', tpDATE)]
    property DATA: TDate read FDATA write SetDATA;

    [Campo('HORA', tpTIME)]
    property HORA: TTime read FHORA write SetHORA;

    [Campo('CODVEN', tpVARCHAR, 10)]
    [ForeignKeyAttribute('FKSANGRIASUPRIVEN', 'CODVEN', 'VENDEDOR', 'CODIGO', None, None)]
    property CODVEN: string read FCODVEN write SetCODVEN;
  end;

implementation

{ TClasseBase }

{ TSangriaSuprimento }

function TSangriaSuprimento.getTipoPagamento: TSangriaSuprimentoTipo;
begin
  result := TSangriaSuprimentoTipo(FTipo);
end;

function TSangriaSuprimento.getTIPOPROXY: string;
begin
  result := TipoSangriaSuprimento.DESCRICAO;
end;

procedure TSangriaSuprimento.SetCODVEN(const Value: string);
begin
  FCODVEN := Value;
end;

procedure TSangriaSuprimento.SetDATA(const Value: TDate);
begin
  FDATA := Value;
end;

procedure TSangriaSuprimento.SetFORMA(const Value: string);
begin
  FFORMA := Value;
end;

procedure TSangriaSuprimento.SetHISTORICO(const Value: string);
begin
  FHISTORICO := Value;
end;

procedure TSangriaSuprimento.SetHORA(const Value: TTime);
begin
  FHORA := Value;
end;

procedure TSangriaSuprimento.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TSangriaSuprimento.SetTipo(const Value: integer);
begin
  FTipo := Value;
end;

procedure TSangriaSuprimento.SetTipoPagamento(
  const Value: TSangriaSuprimentoTipo);
begin
  FTipo := Ord(Value);
end;

procedure TSangriaSuprimento.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

end.
