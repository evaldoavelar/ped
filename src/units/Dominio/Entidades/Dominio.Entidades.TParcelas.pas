unit Dominio.Entidades.TParcelas;

interface

uses
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Dominio.Entidades.TVendedor;

type

  [Tabela('PARCELAS')]
  TParcelas = class(TEntity)
  private
    FNUMPARCELA: INTEGER;
    FIDPEDIDO: INTEGER;
    FVALOR: Currency;
    FVENCIMENTO: TDate;
    FRECEBIDO: string;
    FDATABAIXA: TDate;
    FCODCLIENTE: string;
    FNOME: string;
    FVendedorRecebimento: TVendedor;
    FIDPAGTO: INTEGER;
    procedure SetVendedorRecebimento(const Value: TVendedor);
    procedure SetIDPAGTO(const Value: INTEGER);

  published
    [ForeignKeyAttribute('FK_PARCELAS_PAGTO', 'SEQPAGTO,IDPEDIDO', 'PEDIDOPAGAMENTO', 'SEQ,IDPEDIDO', Cascade, None)]
    [campo('SEQPAGTO', tpINTEGER, 0, 0, True)]
    property SEQPAGTO: INTEGER read FIDPAGTO write SetIDPAGTO;
    [campo('IDPEDIDO', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_PARCELAS', 'IDPEDIDO,NUMPARCELA,SEQPAGTO')]
    [ForeignKeyAttribute('FK_PARCELAS_PED', 'IDPEDIDO', 'PEDIDO', 'ID', Cascade, None)]
    property IDPEDIDO: INTEGER read FIDPEDIDO write FIDPEDIDO;
    [campo('NUMPARCELA', tpINTEGER, 0, 0, True)]
    property NUMPARCELA: INTEGER read FNUMPARCELA write FNUMPARCELA;
    [campo('VALOR', tpNUMERIC, 15, 4, True, '0')]
    property VALOR: Currency read FVALOR write FVALOR;
    [campo('VENCIMENTO', tpDATE, 0, 0, True)]
    property VENCIMENTO: TDate read FVENCIMENTO write FVENCIMENTO;
    [campo('RECEBIDO', tpVARCHAR, 1, 0, false, 'N')]
    property RECEBIDO: string read FRECEBIDO write FRECEBIDO;
    [campo('DATABAIXA', tpDATE)]
    property DATABAIXA: TDate read FDATABAIXA write FDATABAIXA;

    [campo('CODCLIENTE', tpVARCHAR, 10, 0, True)]
    [ForeignKeyAttribute('FK_PARCELAS_CLI', 'CODCLIENTE', 'CLIENTE', 'CODIGO', None, None)]
    property CODCLIENTE: string read FCODCLIENTE write FCODCLIENTE;

    property NOME: string read FNOME write FNOME;

    [campo('CODVENRECEBIMENTO', tpVARCHAR, 10)]
    property VendedorRecebimento: TVendedor read FVendedorRecebimento write SetVendedorRecebimento;

  public
    constructor Create();
    class function CreateParcela(
      pNUMPARCELA: INTEGER;
      pIDPEDIDO: INTEGER;
      pSEQ: INTEGER;
      pVALOR: Currency;
      pVENCIMENTO: TDateTime;
      pCLIENTE: string
      ): TParcelas;
  end;

implementation


{ TParcelas }

constructor TParcelas.Create;
begin
  inherited;
  Self.InicializarPropriedades(nil);
  Self.RECEBIDO := 'N';
end;

class function TParcelas.CreateParcela(pNUMPARCELA: INTEGER; pIDPEDIDO: INTEGER; pSEQ: INTEGER; pVALOR: Currency; pVENCIMENTO: TDateTime;
  pCLIENTE: string): TParcelas;
begin
  result := TParcelas.Create;
  result.NUMPARCELA := pNUMPARCELA;
  result.IDPEDIDO := pIDPEDIDO;
  result.VALOR := pVALOR;
  result.VENCIMENTO := pVENCIMENTO;
  result.CODCLIENTE := pCLIENTE;
  result.SEQPAGTO := pSEQ;
end;

procedure TParcelas.SetIDPAGTO(const Value: INTEGER);
begin
  FIDPAGTO := Value;
end;

procedure TParcelas.SetVendedorRecebimento(const Value: TVendedor);
begin
  FVendedorRecebimento := Value;
end;

end.
