unit Dominio.Entidades.TParceiroVenda.Pagamentos;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Dominio.Entidades.TParceiro;

type

  [Tabela('PARCEIROVENDAPAGTO')]
  TParceiroVendaPagto = class(TEntity)
  private
    FSEQ: Integer;
    FVALORPAGAMENTO: Currency;
    FDESCRICAO: string;
    FCOMISSAOPERCENTUAL: Currency;
    FCOMISSAOVALOR: Currency;
    FIDPARCEIROVENDA: Integer;
    FIDPARCEIROFORMAPAGTO: Integer;
    procedure SetCOMISSAOPERCENTUAL(const Value: Currency);
    procedure SetCOMISSAOVALOR(const Value: Currency);
    procedure SetDESCRICAO(const Value: string);
    procedure SetIDPARCEIROVENDA(const Value: Integer);
    procedure SetSEQ(const Value: Integer);
    procedure SetVALORPAGAMENTO(const Value: Currency);
    procedure SetIDPARCEIROFORMAPAGTO(const Value: Integer);
    function getCOMISSAOVALOR: Currency;
  published

    [campo('SEQ', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PKPARCEIROVENDAPAGTO', 'SEQ,IDPARCEIROVENDA')]
    property SEQ: Integer read FSEQ write SetSEQ;

    [campo('IDPARCEIROVENDA', tpINTEGER, 0, 0, True)]
    [ForeignKeyAttribute('FKPARCEIROPAGTO', 'IDPARCEIROVENDA', 'PARCEIROVENDA', 'ID', Cascade, None)]
    property IDPARCEIROVENDA: Integer read FIDPARCEIROVENDA write SetIDPARCEIROVENDA;

    [ForeignKeyAttribute('FKPARCEIROPAGTO', 'IDPARCEIROFORMAPAGTO', 'PARCEIROFORMAPAGTO', 'ID', Cascade, None)]
    [campo('IDPARCEIROFORMAPAGTO', tpINTEGER, 0, 0, True)]
    property IDPARCEIROFORMAPAGTO: Integer read FIDPARCEIROFORMAPAGTO write SetIDPARCEIROFORMAPAGTO;

    [campo('DESCRICAO', tpVARCHAR, 35)]
    property DESCRICAO: string read FDESCRICAO write SetDESCRICAO;

    [campo('VALORPAGAMENTO', tpNUMERIC, 15, 4)]
    property VALORPAGAMENTO: Currency read FVALORPAGAMENTO write SetVALORPAGAMENTO;

    [campo('COMISSAOPERCENTUAL', tpNUMERIC, 15, 4)]
    property COMISSAOPERCENTUAL: Currency read FCOMISSAOPERCENTUAL write SetCOMISSAOPERCENTUAL;

    [campo('COMISSAOVALOR', tpNUMERIC, 15, 4)]
    property COMISSAOVALOR: Currency read getCOMISSAOVALOR ;
  end;

implementation

{ TParceiroVendaPagto }

function TParceiroVendaPagto.getCOMISSAOVALOR: Currency;
begin
   result := (VALORPAGAMENTO * COMISSAOPERCENTUAL) / 100;
end;

procedure TParceiroVendaPagto.SetCOMISSAOPERCENTUAL(const Value: Currency);
begin
  FCOMISSAOPERCENTUAL := Value;
end;

procedure TParceiroVendaPagto.SetCOMISSAOVALOR(const Value: Currency);
begin
  FCOMISSAOVALOR := Value;
end;

procedure TParceiroVendaPagto.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TParceiroVendaPagto.SetIDPARCEIROFORMAPAGTO(const Value: Integer);
begin
  FIDPARCEIROFORMAPAGTO := Value;
end;

procedure TParceiroVendaPagto.SetIDPARCEIROVENDA(const Value: Integer);
begin
  FIDPARCEIROVENDA := Value;
end;

procedure TParceiroVendaPagto.SetSEQ(const Value: Integer);
begin
  FSEQ := Value;
end;

procedure TParceiroVendaPagto.SetVALORPAGAMENTO(const Value: Currency);
begin
  FVALORPAGAMENTO := Value;
end;

end.
