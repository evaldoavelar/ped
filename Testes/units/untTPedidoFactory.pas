unit untTPedidoFactory;

interface

uses TestFramework, Classes, Math, DateUtils, SysUtils,
  Dominio.Entidades.TFactory, Dominio.Entidades.TEntity, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TPedido, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TProduto;

type
  TPedidoFactory = class

    class function RetornaPedido: TPedido;
    class function RetornaItem(seq: Integer): TItemPedido;
  end;

implementation

{ TPedidoFactory }

uses untTFaker;

class function TPedidoFactory.RetornaPedido: TPedido;
Var
  cliente: TCliente;
  I: Integer;
begin

  result := TFactory.Pedido();
  result.NUMERO := TFaker.Code;
  Result.VALORENTRADA := 0;
  result.DATAPEDIDO := Date();
  result.HORAPEDIDO := Time();
  result.OBSERVACAO := TFaker.Comment(1000);
  result.VALORDESC := 2.20;
  result.STATUS := 'A';
  result.Vendedor := TVendedor.CreateVendedor(TFaker.Code, TFaker.Name, 0, 0);
  result.cliente := TFactory.Cliente();
  result.cliente.CODIGO := '000000';
  result.cliente.NOME := 'Consumidor';

end;

class function TPedidoFactory.RetornaItem(seq: Integer): TItemPedido;
begin
  result := TItemPedido.CreateItem(
    seq,
    '00001',
    'Descrição Produto',
    'UN',
    1.23,
    10.50,
    0,
    10.50
    )
end;

end.
