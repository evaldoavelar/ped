unit Dominio.Entidades.TParceiro.FormaPagto;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Dominio.Entidades.TParceiro,
  System.Generics.Collections, System.SysUtils, Dominio.Entidades.TParceiroVenda.Pagamentos,
  Util.Exceptions;

type

  [Tabela('PARCEIROFORMAPAGTO')]
  TParceiroFormaPagto = class(TEntity)
  private
    FDESCRICAO: string;
    FID: integer;
    FCOMISSAOPERCENTUAL: Currency;
    procedure SetCOMISSAOPERCENTUAL(const Value: Currency);
    procedure SetDESCRICAO(const Value: string);
    procedure SetID(const Value: integer);
  public

    [campo('ID', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_PARCEIROFORMAPAGTO', 'ID')]
    property ID: integer read FID write SetID;

    [campo('DESCRICAO', tpVARCHAR, 200)]
    property DESCRICAO: string read FDESCRICAO write SetDESCRICAO;

    [campo('COMISSAOPERCENTUAL', tpNUMERIC, 15, 4)]
    property COMISSAOPERCENTUAL: Currency read FCOMISSAOPERCENTUAL write SetCOMISSAOPERCENTUAL;
  end;

implementation

{ TParceiroFormaPagto }

procedure TParceiroFormaPagto.SetCOMISSAOPERCENTUAL(const Value: Currency);
begin
  FCOMISSAOPERCENTUAL := Value;
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
