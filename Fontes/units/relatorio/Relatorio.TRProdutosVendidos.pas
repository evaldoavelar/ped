unit Relatorio.TRProdutosVendidos;

interface

uses
  ACBrUtil, System.SysUtils,
  System.Generics.Collections,
  Relatorio.TRBase, Data.DB,
  Dominio.Entidades.TParcelas,
  Dominio.Entidades.TEmitente,
  Dominio.Entidades.TVendedor,
  Helper.TProdutoVenda;

type
  TRProdutosVendidos = class(TRBase)
  private
    procedure Descricao(DataInicio, DataFim: TDate; vendedor: TVendedor);
    procedure Listar(Produtos: TList<TProdutoVenda>);
  public
    procedure Imprime(DataInicio, DataFim: TDate; vendedor: TVendedor; Emitente: TEmitente; Produtos: TList<TProdutoVenda>); overload;
  end;

implementation

{ TRProdutosVendidos }

procedure TRProdutosVendidos.Descricao(DataInicio, DataFim: TDate; vendedor: TVendedor);
var
  LinhaCmd: string;
begin

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'PRODUTOS VENDIDOS' + escBoldOff;
  Buffer.Add(LinhaCmd);

  if Assigned(vendedor) then
  begin
    Buffer.Add(esc20Cpi + PadSpace('Vendedor: ' + vendedor.CODIGO + '  ' +
      vendedor.NOME, Self.ColunasFonteCondensada, '|'));
  end;

  LinhaCmd := escAlignLeft + esc20Cpi +
    'Período: '
    + FormatDateTime('dd/mm/yyyy', DataInicio)
    + ' até '
    + FormatDateTime('dd/mm/yyyy', DataFim);
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignLeft + esc20Cpi +
    'Emissão: '
    + FormatDateTime('dd/mm/yyyy', now);
  Buffer.Add(LinhaCmd);

  Buffer.Add(Self.LinhaSimples);

end;

procedure TRProdutosVendidos.Imprime(DataInicio, DataFim: TDate; vendedor: TVendedor; Emitente: TEmitente; Produtos: TList<TProdutoVenda>);
begin
  Self.Cabecalho(Emitente);
  Self.Descricao(DataInicio, DataFim, vendedor);
  Self.Listar(Produtos);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

procedure TRProdutosVendidos.Listar(Produtos: TList<TProdutoVenda>);
var
  i: Integer;
  nTamDescricao: Integer;
  VlrLiquido: Double;
  sDescricao, sQuantidade, sVlrProduto, LinhaCmd: String;
  item: TProdutoVenda;
  Total: Currency;
  Quantidade: Double;
begin
  // Buffer.Add(escAlignLeft + esc20Cpi + Self.LinhaSimples);
  Buffer.Add(esc20Cpi +
    ACBrStr(PadSpace('#DESCRIÇÃO|QUANTIDADE|VL TOTAL R$',
    Self.ColunasFonteCondensada, '|')));
  Buffer.Add(Self.LinhaSimples);

  Total := 0;
  Quantidade := 0;

  for item in Produtos do
  begin

    sDescricao := Trim(item.Descricao);
    sVlrProduto := FormatFloatBr(item.Total, '###,###,##0.00');
    sQuantidade := FloatToStrF(item.Quantidade, ffNumber, 9, 2);

    LinhaCmd := PadRight(sDescricao, 48) + '|' + PadRight(sQuantidade, 5) + '|' + sVlrProduto;
    LinhaCmd := PadSpace(LinhaCmd, Self.ColunasFonteCondensada, '|');
    Buffer.Add(escAlignLeft + esc20Cpi + LinhaCmd);

    Total := Total + item.Total;
    Quantidade := Quantidade + item.Quantidade;
  end;

  Buffer.Add(ACBrStr(escAlignRight + esc20Cpi
  + escBoldOn +
  'Qtde Total: ' + FormatFloat('0.,00', Quantidade) +
  '  Valor Total: ' + FormatCurr('R$ 0.,00', Total) + escBoldOff));

end;

end.
