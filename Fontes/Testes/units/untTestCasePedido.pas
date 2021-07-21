unit untTestCasePedido;

interface

uses
  System.Generics.Collections,
  TestFramework, Classes, Math, DateUtils, SysUtils,
  Dominio.Entidades.TFactory, Dominio.Entidades.TEntity, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TPedido, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TProduto;

type
  // classe de teste de Pedido
  TTestCasePedido = class(TTestCase)
  private
    EntityFactory: TFactory;
    procedure VerificaEventoChange(ValorLiquido, ValorBruto: currency;Volume :Double );
    procedure VerificaEventoVendeItem(Item: TItemPedido);
    procedure VerificaEventoParcelas(parcelas: TObjectList<TParcelas>);


  published
    procedure TPedidoPodeRecaucularParcelas;
    procedure TPedidoPodeRecaucularParcelasComEntrada;
    procedure TPedidoPodeNotificarAoVenderItem;
    procedure TPedidoPodeNotificarAoParcelar;
    procedure TPedidoPodeGerarDataVencimentoParcelas;
    procedure TPedidoPodeRemoverItem;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

implementation

uses
  untTFaker, untTPedidoFactory;

{ TTestCaseTADDateTime }

{ TTestCasePedido }

procedure TTestCasePedido.SetUp;
begin
  inherited;
  EntityFactory := TFactory.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
end;

procedure TTestCasePedido.TearDown;
begin
  inherited;
  EntityFactory.Free;
  EntityFactory := nil;
end;



procedure TTestCasePedido.TPedidoPodeGerarDataVencimentoParcelas;
Var
  pedido: TPedido;
  formato: TFormatSettings;
  I: Integer;
begin

  pedido := TPedidoFactory.RetornaPedido;
  pedido.DATAPEDIDO := StrToDate('01/10/2016');

  for I := 1 to 5 do
  begin
    pedido.VendeItem(TPedidoFactory.RetornaItem(I));
  end;

  pedido.ParcelarPedido(7, StrToDate('31/10/2016') );

  CheckEquals(7, pedido.parcelas.Count);
  CheckEquals(StrToDate('31/10/2016'), pedido.parcelas.Items[0].VENCIMENTO);
  CheckEquals(StrToDate('30/11/2016'), pedido.parcelas.Items[1].VENCIMENTO);
  CheckEquals(StrToDate('02/01/2017'), pedido.parcelas.Items[2].VENCIMENTO);
   CheckEquals(StrToDate('31/01/2017'), pedido.parcelas.Items[3].VENCIMENTO);
  CheckEquals(StrToDate('28/02/2017'), pedido.parcelas.Items[4].VENCIMENTO);
  CheckEquals(StrToDate('31/03/2017'), pedido.parcelas.Items[5].VENCIMENTO);
  CheckEquals(StrToDate('01/05/2017'), pedido.parcelas.Items[6].VENCIMENTO);

end;

procedure TTestCasePedido.VerificaEventoChange(ValorLiquido, ValorBruto: currency;Volume :Double );
begin
  CheckEquals(10.50, ValorBruto);
  CheckEquals(10.50, ValorLiquido);
end;

procedure TTestCasePedido.VerificaEventoParcelas(parcelas: TObjectList<TParcelas>);
begin
  CheckEquals(3, parcelas.Count);
  CheckEquals(20.79, parcelas.Items[0].VALOR);
  CheckEquals(20.79, parcelas.Items[1].VALOR);
  CheckEquals(20.79, parcelas.Items[2].VALOR);
end;

procedure TTestCasePedido.VerificaEventoVendeItem(Item: TItemPedido);
begin
  CheckEquals(10.50, Item.VALOR_UNITA);
  CheckEquals('Descrição Produto', Item.DESCRICAO);
  CheckEquals('UN', Item.UND);
  CheckEquals(1, Item.QTD);
  CheckEquals(10.50, Item.VALOR_TOTAL);
end;

procedure TTestCasePedido.TPedidoPodeNotificarAoParcelar;
Var
  pedido: TPedido;
  I: Integer;
begin
  pedido := TPedidoFactory.RetornaPedido;
  pedido.OnParcela := VerificaEventoParcelas;

  for I := 1 to 5 do
  begin
    pedido.VendeItem(TPedidoFactory.RetornaItem(I))
  end;

  pedido.ParcelarPedido(3,StrToDate('31/10/2016'));

end;

procedure TTestCasePedido.TPedidoPodeNotificarAoVenderItem;
Var
  pedido: TPedido;
begin
  pedido := TPedidoFactory.RetornaPedido;
  pedido.VALORDESC := 0;
  pedido.OnChange := VerificaEventoChange;
  pedido.OnVendeItem := VerificaEventoVendeItem;

  pedido.VendeItem(
    TItemPedido.CreateItem(
    1,
    '0001',
    'Descrição Produto',
    'UN',
    1,
    10.50,
    0,
    10.50
    )

    );

end;

procedure TTestCasePedido.TPedidoPodeRecaucularParcelas;
Var
  pedido: TPedido;
  I: Integer;
begin
  pedido := TPedidoFactory.RetornaPedido;

  for I := 1 to 5 do
  begin
    pedido.VendeItem(TPedidoFactory.RetornaItem(I))
  end;

  pedido.ParcelarPedido(3,StrToDate('31/10/2016'));

  CheckEquals(64.57, pedido.ValorBruto);
  CheckEquals(62.37, pedido.ValorLiquido);
  CheckEquals(62.37, pedido.TOTALPARCELAS);
  CheckEquals(3, pedido.parcelas.Count);

  pedido.VendeItem(
    TItemPedido.CreateItem(
    pedido.ItemCount,
    '0001',
    'Descrição Produto',
    'UN',
    1.23,
    10.50,
    0,
    10.50
    )
    );

  pedido.ParcelarPedido(3,StrToDate('31/10/2016'));


  CheckEquals(77.49, pedido.ValorBruto);
  CheckEquals(75.29, pedido.ValorLiquido);
  CheckEquals(75.29, pedido.TOTALPARCELAS);

  CheckEquals(3, pedido.parcelas.Count);
  CheckEquals(25.09, pedido.parcelas.Items[0].VALOR);
  CheckEquals(25.09, pedido.parcelas.Items[1].VALOR);
  CheckEquals(25.11, pedido.parcelas.Items[2].VALOR);

end;

procedure TTestCasePedido.TPedidoPodeRecaucularParcelasComEntrada;
Var
  pedido: TPedido;
  I: Integer;
begin
  pedido := TPedidoFactory.RetornaPedido;

  for I := 1 to 5 do
  begin
    pedido.VendeItem(TPedidoFactory.RetornaItem(I))
  end;

  CheckEquals(64.57, pedido.ValorBruto);
  CheckEquals(62.37, pedido.ValorLiquido);

  pedido.VALORENTRADA := 30.50;
  pedido.VALORDESC := 0;

  CheckEquals(64.57, pedido.ValorBruto);
  CheckEquals(34.07, pedido.ValorLiquido);


  pedido.ParcelarPedido(3,StrToDate('31/10/2016'));

  CheckEquals(64.57, pedido.ValorBruto);
  CheckEquals(34.07, pedido.ValorLiquido);
  CheckEquals(34.07, pedido.TOTALPARCELAS);
  CheckEquals(3, pedido.parcelas.Count);

  pedido.VendeItem(
    TItemPedido.CreateItem(
    pedido.ItemCount,
    '0001',
    'Descrição Produto',
    'UN',
    1.23,
    10.50,
    0,
    10.50
    )
    );

  pedido.ParcelarPedido(3,StrToDate('31/10/2016'));


  CheckEquals(77.49, pedido.ValorBruto);
  CheckEquals(46.99, pedido.ValorLiquido);
  CheckEquals(46.99, pedido.TOTALPARCELAS);

  CheckEquals(3, pedido.parcelas.Count);
  CheckEquals(15.66, pedido.parcelas.Items[0].VALOR);
  CheckEquals(15.66, pedido.parcelas.Items[1].VALOR);
  CheckEquals(15.67, pedido.parcelas.Items[2].VALOR);

end;

procedure TTestCasePedido.TPedidoPodeRemoverItem;
Var
  pedido: TPedido;
  I: Integer;
begin
  pedido := TPedidoFactory.RetornaPedido;

  for I := 1 to 5 do
  begin
    pedido.VendeItem(TPedidoFactory.RetornaItem(I))
  end;

  CheckEquals(64.57, pedido.ValorBruto);
  CheckEquals(62.37, pedido.ValorLiquido);

  pedido.ExcluiItem(2);

  CheckEquals(51.66, pedido.ValorBruto);
  CheckEquals(49.46, pedido.ValorLiquido);

  pedido.ParcelarPedido(2,10);

  CheckEquals(49.46, pedido.TOTALPARCELAS);
  CheckEquals(24.73, pedido.parcelas.Items[0].VALOR);
  CheckEquals(24.73, pedido.parcelas.Items[1].VALOR);

  pedido.VendeItem(TPedidoFactory.RetornaItem(6));
  CheckEquals(64.57, pedido.ValorBruto);
  CheckEquals(62.37, pedido.ValorLiquido);

end;

initialization

TestFramework.RegisterTest(TTestCasePedido.Suite);

end.
