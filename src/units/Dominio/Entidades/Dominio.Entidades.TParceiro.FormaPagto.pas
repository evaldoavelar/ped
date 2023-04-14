unit Dominio.Entidades.TParceiro.FormaPagto;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos,
  System.SysUtils;

type

  [Tabela('PARCEIROFORMAPAGTO')]
  TParceiroFormaPagto = class(TEntity)
  private
    FDESCRICAO: string;
    FID: integer;
    FCOMISSAOPERCENTUAL: Currency;
    FDATAALTERACAO: TDateTime;
    procedure SetCOMISSAOPERCENTUAL(const Value: Currency);
    procedure SetDESCRICAO(const Value: string);
    procedure SetID(const Value: integer);
    procedure SetDATAALTERACAO(const Value: TDateTime);
  public
    [AutoInc('AUTOINC')]
    [campo('ID', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_PARCEIROFORMAPAGTO', 'ID')]
    property ID: integer read FID write SetID;

    [campo('DESCRICAO', tpVARCHAR, 200)]
    property DESCRICAO: string read FDESCRICAO write SetDESCRICAO;

    [campo('COMISSAOPERCENTUAL', tpNUMERIC, 15, 4)]
    property COMISSAOPERCENTUAL: Currency read FCOMISSAOPERCENTUAL write SetCOMISSAOPERCENTUAL;

    [campo('DATAALTERACAO', tpTIMESTAMP)]
    property DATAALTERACAO: TDateTime read FDATAALTERACAO write SetDATAALTERACAO;
  end;

implementation

{ TParceiroFormaPagto }

procedure TParceiroFormaPagto.SetCOMISSAOPERCENTUAL(const Value: Currency);
begin
  FCOMISSAOPERCENTUAL := Value;
end;

procedure TParceiroFormaPagto.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TParceiroFormaPagto.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TParceiroFormaPagto.SetID(const Value: integer);
begin
  FID := Value;
end;

end.
