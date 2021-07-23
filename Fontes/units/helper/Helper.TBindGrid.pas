unit Helper.TBindGrid;

interface

uses
  System.Generics.Collections, System.SysUtils,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TParcelas,
  Vcl.Grids;

type
  TBindGrid = class
  public
    class procedure BindPagamentos(grid: TStringGrid; items: Tlist<TPEDIDOPAGAMENTO>); static;
    class procedure InicializaGrid(grid: TStringGrid; Titulos: array of string; ColWidth: array of Integer);

    class procedure BindProdutos(grid: TStringGrid; items: TObjectList<TItemPedido>); static;
    class procedure BindParcelas(grid: TStringGrid; items: TObjectList<TParcelas>);
  end;

implementation


{ TBindGrid }

class procedure TBindGrid.InicializaGrid(grid: TStringGrid; Titulos: array of string; ColWidth: array of Integer);
var
  i, row: Integer;
begin

  for i := 0 to grid.ColCount - 1 do
    grid.Cols[i].Clear;

  grid.RowCount := 1;
  grid.ColCount := Length(Titulos);

  if (grid.RowCount = 1) then
    grid.RowCount := 2;

  grid.FixedRows := 1;

  for i := Low(Titulos) to High(Titulos) do
  begin
    // titulo
    grid.Cells[i, 0] := Titulos[i];
    grid.ColWidths[i] := ColWidth[i];
  end;

end;

class procedure TBindGrid.BindPagamentos(grid: TStringGrid; items: Tlist<TPEDIDOPAGAMENTO>);
const
  Titulos: array [0 .. 5] of string = ('Seq', 'Descrição', 'Condição', 'Acrécimo', 'Valor', 'Quantas Vezes');
  ColWidth: array [0 .. 5] of Integer = (40, 200, 200, 80, 80, 80);
var
  i, row: Integer;
  item: TPEDIDOPAGAMENTO;
begin

  InicializaGrid(grid, Titulos, ColWidth);
  grid.RowCount := items.Count + 1;
  // linhas
  row := 0;
  for item in items do
  begin
    row := row + 1;

    grid.Cells[0, row] := IntToStr(item.SEQ);
    grid.Cells[1, row] := item.DESCRICAO;
    grid.Cells[2, row] := item.CONDICAO;
    grid.Cells[3, row] := FormatCurr('R$ ###,##0.00', item.ACRESCIMO);
    grid.Cells[4, row] := FormatCurr('R$ ###,##0.00', item.Valor);
    grid.Cells[5, row] := IntToStr(item.QUANTASVEZES);
  end;

end;

class procedure TBindGrid.BindProdutos(grid: TStringGrid; items: TObjectList<TItemPedido>);
const
  Titulos: array [0 .. 7] of string = ('Seq', 'Cod Produto', 'UND', 'QTD', 'Valor Unitário', 'Valor Desconto', 'Valor Total', 'Descrição');
  ColWidth: array [0 .. 7] of Integer = (40, 70, 40, 40, 80, 80, 80, 400);
var
  i, row: Integer;
  item: TItemPedido;
begin

  InicializaGrid(grid, Titulos, ColWidth);
  grid.RowCount := items.Count + 1;
  // linhas
  row := 0;
  for item in items do
  begin
    row := row + 1;

    grid.Cells[0, row] := IntToStr(item.SEQ);
    grid.Cells[1, row] := item.CODPRODUTO;
    grid.Cells[2, row] := item.UND;
    grid.Cells[3, row] := FloatToStr(item.QTD);
    grid.Cells[4, row] := FormatCurr('R$ ###,##0.00', item.VALOR_UNITA);
    grid.Cells[5, row] := FormatCurr('R$ ###,##0.00', item.VALOR_DESCONTO);
    grid.Cells[6, row] := FormatCurr('R$ ###,##0.00', item.VALOR_TOTAL);
    grid.Cells[7, row] := item.DESCRICAO;
  end;

end;

class procedure TBindGrid.BindParcelas(grid: TStringGrid; items: TObjectList<TParcelas>);
const
  Titulos: array [0 .. 5] of string = ('Pedido', 'Parcela', 'Valor', 'Vencimento', 'Recebido', 'Data da Baixa');
  ColWidth: array [0 .. 5] of Integer = (110, 170, 110, 110, 110, 110);
var
  i, row: Integer;
  item: TParcelas;
begin

  InicializaGrid(grid, Titulos, ColWidth);

  // linhas
  row := 0;
  if not Assigned(items) then
    exit;

  grid.RowCount := items.Count + 1;
  for item in items do
  begin
    row := row + 1;

    grid.Cells[0, row] := Format('%.*d', [6, item.IDPEDIDO]);
    grid.Cells[1, row] := IntToStr(item.NUMPARCELA) + 'ª Parcela';
    grid.Cells[2, row] := FormatCurr('R$ ###,##0.00', item.Valor);
    grid.Cells[3, row] := DateToStr(item.VENCIMENTO);
    if item.RECEBIDO = 'S' then
    begin
      grid.Cells[4, row] := 'Sim';
      grid.Cells[5, row] := DateToStr(item.DATABAIXA);
    end
    else
    begin
      grid.Cells[4, row] := 'Não';
      grid.Cells[5, row] := '-';
    end;

    grid.Objects[0, row] := (item);
  end;

end;

end.
