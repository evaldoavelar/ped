unit untTestCaseDAOs;

interface


uses TestFramework, SysUtils, system.Rtti, Generics.Collections,
  Classes, Math, DateUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef,
  Dominio.Entidades.TEntity, Dominio.Entidades.TPedido, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TProduto, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TFactory, untTPedidoFactory, Dao.TDaoPedido, Dao.TDaoVendedor, Dao.TDaoProdutos, Dao.TDaoCliente;

type
  // classe de teste de Pedido
  TTestCaseDao = class(TTestCase)
  private
    DaoPedido: TDaoPedido;
    DaoCliente: TDaoCliente;
    DaoVen: TDaoVendedor;
    DaoProduto: TDaoProduto;
    procedure VendeItem(item: TItemPedido);
    procedure Parcela(parcelas: TObjectList<TParcelas>);
  published
    procedure TPedidoPodeSalvarPedido;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

implementation


{ TTestCaseDao }

procedure TTestCaseDao.Parcela(parcelas: TObjectList<TParcelas>);
begin
  DaoPedido.GravaParcelas(parcelas);
end;

procedure TTestCaseDao.SetUp;
begin
  inherited;
  DaoPedido := TDaoPedido.Create(TFactory.Conexao);
  DaoVen := TDaoVendedor.Create(TFactory.Conexao);
  DaoProduto := TDaoProduto.Create(TFactory.Conexao());
  DaoCliente := TDaoCliente.Create(TFactory.Conexao());
end;

procedure TTestCaseDao.TearDown;
begin
  inherited;
  DaoPedido.Free;
  DaoVen.Free;
  DaoProduto.Free;
end;

procedure TTestCaseDao.TPedidoPodeSalvarPedido;
var
  Pedido: TPedido;
  PedidoBanco: TPedido;
  item: TItemPedido;
  produto: TProduto;
  I: Integer;
begin
  // abre pedido
  Pedido := TPedidoFactory.RetornaPedido;
  Pedido.OnVendeItem := VendeItem;
  Pedido.OnParcela := Parcela;
  Pedido.Vendedor := DaoVen.GetVendedor('001');
  Pedido.ID := DaoPedido.GeraID();

  DaoPedido.AbrePedido(Pedido);
  produto := DaoProduto.GetProdutoPorCodigo('000001');
  item := TItemPedido.Create;
  item.SEQ := 1;
  item.CODPRODUTO := produto.CODIGO;
  item.DESCRICAO := produto.DESCRICAO;
  item.UND := produto.UND;
  item.QTD := 1;
  item.VALOR_UNITA := produto.PRECO_VENDA;
  item.IDPEDIDO := Pedido.ID;

  // vende item  - gravar no item no evento
  Pedido.VendeItem(item);
  DaoPedido.AtualizaPedido(Pedido);

  produto := DaoProduto.GetProdutoPorCodigo('000791');
  item := TItemPedido.Create;
  item.SEQ := 2;
  item.CODPRODUTO := produto.CODIGO;
  item.DESCRICAO := produto.DESCRICAO;
  item.UND := produto.UND;
  item.QTD := 11;
  item.VALOR_UNITA := produto.PRECO_VENDA;
  item.IDPEDIDO := Pedido.ID;
  Pedido.VendeItem(item);
  DaoPedido.AtualizaPedido(Pedido);

  Pedido.VALORENTRADA := 10.55;
  // parcela pedido gravar a parcela no evenyo
  Pedido.ParcelarPedido(4,10);

  //modifica parcela
  Pedido.parcelas.Items[0].VENCIMENTO := IncDay(Pedido.DATAPEDIDO ,5);
  DaoPedido.GravaParcelas( Pedido.parcelas);

  // finalizar pedido
  Pedido.STATUS := 'F';
  Pedido.Cliente := DaoCliente.GeTCliente('000001');
  DaoPedido.FinalizaPedido(Pedido);

  PedidoBanco := DaoPedido.getPedido(Pedido.ID);
  CheckEquals(PedidoBanco.ValorBruto, Pedido.ValorBruto);
  CheckEquals(PedidoBanco.NUMERO, Pedido.NUMERO);
  CheckEquals(PedidoBanco.DATAPEDIDO, Pedido.DATAPEDIDO);
  CheckEquals(PedidoBanco.OBSERVACAO, Pedido.OBSERVACAO);
  CheckEquals(PedidoBanco.VALORDESC, Pedido.VALORDESC);
  CheckEquals(PedidoBanco.VALORENTRADA, Pedido.VALORENTRADA);
  CheckEquals(PedidoBanco.ValorLiquido, Pedido.ValorLiquido);
  CheckEquals(PedidoBanco.STATUS, Pedido.STATUS);
  CheckEquals(PedidoBanco.Cliente.CODIGO, Pedido.Cliente.CODIGO);
  CheckEquals(PedidoBanco.Vendedor.CODIGO, Pedido.Vendedor.CODIGO);
  CheckEquals(PedidoBanco.ItemCount, Pedido.ItemCount);
  CheckEquals(PedidoBanco.parcelas.Count, Pedido.parcelas.Count);

  for I := 0 to 3 do
  begin
    CheckEquals(PedidoBanco.parcelas.Items[i].VALOR, Pedido.parcelas.Items[i].VALOR);
    CheckEquals(PedidoBanco.parcelas.Items[i].NUMPARCELA, Pedido.parcelas.Items[i].NUMPARCELA);
    CheckEquals(PedidoBanco.parcelas.Items[i].VENCIMENTO, Pedido.parcelas.Items[i].VENCIMENTO);
    CheckEquals(PedidoBanco.parcelas.Items[i].RECEBIDO, Pedido.parcelas.Items[i].RECEBIDO);
    CheckEquals(PedidoBanco.parcelas.Items[i].DATABAIXA, Pedido.parcelas.Items[i].DATABAIXA);
    CheckEquals(PedidoBanco.parcelas.Items[i].CODCLIENTE, Pedido.parcelas.Items[i].CODCLIENTE);
  end;

end;

procedure TTestCaseDao.VendeItem(item: TItemPedido);
begin
  DaoPedido.VendeItem(item);
end;

initialization

TestFramework.RegisterTest(TTestCaseDao.Suite);

end.
