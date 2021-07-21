unit Dominio.Entidades.TItemOrcamento;

interface

uses
  System.SysUtils,
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Util.Exceptions, Util.Funcoes;

type

  [Tabela('ITEMORCAMENTO')]
  TItemOrcamento = class(TEntity)
  private
    FSEQ: INTEGER;
    FIDORCAMENTO: INTEGER;
    FCODPRODUTO: string;
    FDESCRICAO: string;
    FUND: string;
    FQTD: double;
    FVALOR_UNITA: currency;
    FVALOR_DESCONTO: currency;
    function GetValorTotal: currency;
    procedure setIDORCAMENTO(value: INTEGER);
    procedure SetVALOR_DESCONTO(const value: currency);
    procedure SetQTD(const value: double);
    function GetValorLiquido: currency;
    function getValorBrutoCur: string;
    function getValorDescontoCur: string;
    function getValorLiquidoCur: string;
    function getValorUnitarioCur: string;

  published
    [campo('SEQ', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_ITEMORCAMENTO', 'IDORCAMENTO,SEQ')]
    property SEQ: INTEGER read FSEQ write FSEQ;
    [campo('IDORCAMENTO', tpINTEGER, 0, 0, True)]
    [ForeignKeyAttribute('FK_ITEMORCAMENTO_ORCAMENTO', 'IDORCAMENTO', 'ORCAMENTO', 'ID', Cascade, None)]
    property IDORCAMENTO: INTEGER read FIDORCAMENTO write setIDORCAMENTO;

    [campo('CODPRODUTO', tpVARCHAR, 6)]
    [ForeignKeyAttribute('FK_ITEMORCAMENTO_PROD', 'CODPRODUTO', 'PRODUTO', 'CODIGO', None, None)]
    property CODPRODUTO: string read FCODPRODUTO write FCODPRODUTO;

    [campo('DESCRICAO', tpVARCHAR, 100)]
    property DESCRICAO: string read FDESCRICAO write FDESCRICAO;
    [campo('UND', tpVARCHAR, 3)]
    property UND: string read FUND write FUND;
    [campo('QTD', tpNUMERIC, 15, 4)]
    property QTD: double read FQTD write SetQTD;
    [campo('VALOR_UNITA', tpNUMERIC, 15, 4)]
    property VALOR_UNITA: currency read FVALOR_UNITA write FVALOR_UNITA;
    [campo('VALOR_DESCONTO', tpNUMERIC, 15, 4)]
    property VALOR_DESCONTO: currency read FVALOR_DESCONTO write SetVALOR_DESCONTO;
    [campo('VALOR_BRUTO', tpNUMERIC, 15, 4)]
    property VALOR_BRUTO: currency read GetValorTotal;
    [campo('VALOR_LIQUIDO', tpNUMERIC, 15, 4)]
    property VALOR_LIQUIDO: currency read GetValorLiquido;

    property VALORBRUTOCUR: string read getValorBrutoCur;
    property VALORUNITATOCUR: string read getValorUnitarioCur;
    property VALORLIQUIDOTOCUR: string read getValorLiquidoCur;
    property VALORDESCONTOTOCUR: string read getValorDescontoCur;
  public
    constructor create;
    class function CreateItem(
      pSEQ: INTEGER;
      pPRODUTO: string;
      pDESCRICAO: string;
      pUND: string;
      pQTD: double;
      pVALOR_UNITA: currency;
      pVALOR_DESCONTO: currency
      ): TItemOrcamento;
  end;

implementation

{ TItemOrcamento }

function TItemOrcamento.getValorBrutoCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_BRUTO);
end;

function TItemOrcamento.getValorDescontoCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_DESCONTO);
end;

function TItemOrcamento.getValorLiquidoCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_LIQUIDO);
end;

function TItemOrcamento.getValorUnitarioCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_UNITA);
end;

constructor TItemOrcamento.create;
begin
  inherited;
  Self.InicializarPropriedades(nil);
end;

class function TItemOrcamento.CreateItem(pSEQ: INTEGER; pPRODUTO: string;
  pDESCRICAO, pUND: string; pQTD: double; pVALOR_UNITA, pVALOR_DESCONTO: currency): TItemOrcamento;
begin
  result := TItemOrcamento.create;
  result.SEQ := pSEQ;
  result.CODPRODUTO := pPRODUTO;
  result.DESCRICAO := pDESCRICAO;
  result.UND := pUND;
  result.QTD := pQTD;
  result.VALOR_UNITA := pVALOR_UNITA;
  result.VALOR_DESCONTO := pVALOR_DESCONTO;

end;

function TItemOrcamento.GetValorLiquido: currency;
begin
  try
    result := (Self.QTD * Self.VALOR_UNITA) - Self.VALOR_DESCONTO;
    result := TUtil.Truncar(result, 3);
  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Valor Líquido do Item: ' + E.message);
  end;
end;

function TItemOrcamento.GetValorTotal: currency;
begin
  try
    result := (Self.QTD * Self.VALOR_UNITA);
    result := TUtil.Truncar(result, 3);
  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Valor Total do Item: ' + E.message);
  end;
end;

procedure TItemOrcamento.setIDORCAMENTO(value: INTEGER);
begin
  if value < 0 then
    raise TValidacaoException.create('O valor para IDORCAMENTO não é válido');

  Self.FIDORCAMENTO := value;
end;

procedure TItemOrcamento.SetQTD(const value: double);
begin
  if value > 999 then
    raise TValidacaoException.create('A Quantidade Máxima permitida de um produto é de 999');

  FQTD := value;
end;

procedure TItemOrcamento.SetVALOR_DESCONTO(const value: currency);
begin
  FVALOR_DESCONTO := value;
end;

end.
