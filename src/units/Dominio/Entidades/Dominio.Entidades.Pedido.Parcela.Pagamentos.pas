unit Dominio.Entidades.Pedido.Parcela.Pagamentos;

interface

uses
  system.Generics.Collections,
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos,
  Dominio.Entidades.Pedido.Pagamentos,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dominio.Entidades.TParcelas;

type

  [Tabela('RELACPARCELAPAGAMENTOS')]
  TRelacParcelaPagamento = class(TEntity)
  private
    FNUMPARCELA: integer;
    FIDPEDIDO: integer;
    FSEQPAGTO: integer;
  public
    [PrimaryKey('PKRELACPARCELAPAGAMENTOS', 'NUMPARCELA,SEQPAGTO,IDPEDIDO')]
    [campo('IDPEDIDO', tpINTEGER, 0, 0, True)]
    property IDPEDIDO: integer read FIDPEDIDO write FIDPEDIDO;

    [campo('NUMPARCELA', tpINTEGER, 0, 0, True)]
    property NUMPARCELA: integer read FNUMPARCELA write FNUMPARCELA;

    [campo('SEQPAGTO', tpINTEGER, 0, 0, True)]
    property SEQPAGTO: integer read FSEQPAGTO write FSEQPAGTO;
  end;

  // usada só para criar a tabela, pois os atributos não funcionam com herança
  [Tabela('PARCELAPAGAMENTOS')]
  TPedidoParcelaPagamento = class(TEntity)
  private
    FSEQ: integer;
    FQUANTASVEZES: integer;
    FACRESCIMO: Currency;
    FIDCONDICAO: integer;
    FTROCO: Currency;
    FVALOR: Currency;
    FDESCRICAO: string;
    FCONDICAO: string;
    FIDPEDIDO: integer;
    FTipo: integer;
    FIDPAGTO: integer;
    FDATAALTERACAO: TDateTime;
  public
    [AutoInc('AUTOINC')]
    [PrimaryKey('PKPEDIDOPAGAMENTOS', 'SEQ,IDPEDIDO')]
    [campo('SEQ', tpINTEGER, 0, 0, True)]
    property SEQ: integer read FSEQ write FSEQ;
    [campo('IDPEDIDO', tpINTEGER, 0, 0, True)]
    property IDPEDIDO: integer read FIDPEDIDO write FIDPEDIDO;
    [campo('DESCRICAO', tpVARCHAR, 200)]
    property DESCRICAO: string read FDESCRICAO write FDESCRICAO;
    [campo('CONDICAO', tpVARCHAR, 60, 0, True)]
    property CONDICAO: string read FCONDICAO write FCONDICAO;
    [campo('IDCONDICAO', tpINTEGER, 0, 0, True)]
    property IDCONDICAO: integer read FIDCONDICAO write FIDCONDICAO;
    [campo('TIPO', tpINTEGER, 0, 0, True)]
    property Tipo: integer read FTipo write FTipo;
    [campo('IDPAGTO', tpINTEGER, 0, 0, True)]
    property IDPAGTO: integer read FIDPAGTO write FIDPAGTO;
    [campo('ACRESCIMO', tpNUMERIC, 15, 4, True, '0')]
    property ACRESCIMO: Currency read FACRESCIMO write FACRESCIMO;
    [campo('VALOR', tpNUMERIC, 15, 4, True, '0')]
    property Valor: Currency read FVALOR write FVALOR;
    [campo('TROCO', tpNUMERIC, 15, 4, True, '0')]
    property TROCO: Currency read FTROCO write FTROCO;
    [campo('QUANTASVEZES', tpINTEGER)]
    property QUANTASVEZES: integer read FQUANTASVEZES write FQUANTASVEZES;
    [campo('DATAALTERACAO', tpTIMESTAMP)]
    property DATAALTERACAO: TDateTime read FDATAALTERACAO write FDATAALTERACAO;
  end;

  TParcelaPagamentos = class
  private
    FPagamentos: TPAGAMENTOS;
    FParcelas: TList<TParcelas>;
    procedure SetPagamentos(const Value: TPAGAMENTOS);
  public
    property Pagamentos: TPAGAMENTOS read FPagamentos write SetPagamentos;
    property Parcelas: TList<TParcelas> read FParcelas write FParcelas;
    constructor Create;
  end;

implementation

{ TParcelaPagamento }

constructor TParcelaPagamentos.Create;
begin
  Self.FPagamentos := TPAGAMENTOS.Create();
  Self.FParcelas := TList<TParcelas>.Create();
end;

procedure TParcelaPagamentos.SetPagamentos(const Value: TPAGAMENTOS);
begin
  FPagamentos := Value;
end;

end.
