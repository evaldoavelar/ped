unit untTestCaseOrcamento;

interface

uses
  System.Generics.Collections,
  TestFramework, Classes, Math, DateUtils, SysUtils,
  Dominio.Entidades.TFactory, Dominio.Entidades.TEntity, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TOrcamento, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemOrcamento, Dominio.Entidades.TProduto;

type
  // classe de teste de Orcamento
  TTestCaseOrcamento = class(TTestCase)
  private
    EntityFactory: TFactory;
    procedure VerificaEventoChange(ValorLiquido, ValorBruto,ValorDesconto: currency; Volume: Double);
    procedure VerificaEventoVendeItem(Item: TItemOrcamento);

  published

    procedure TOrcamentoPodeNotificarAoVenderItem;
    procedure TOrcamentoPodeRemoverItem;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

implementation

uses
  untTFaker, untTOrcamentoFactory;

{ TTestCaseTADDateTime }

{ TTestCaseOrcamento }

procedure TTestCaseOrcamento.SetUp;
begin
  inherited;
  EntityFactory := TFactory.Create;
  FormatSettings.ShortDateFormat := 'dd/mm/yyyy';
end;

procedure TTestCaseOrcamento.TearDown;
begin
  inherited;
  EntityFactory.Free;
  EntityFactory := nil;
end;

procedure TTestCaseOrcamento.VerificaEventoChange(ValorLiquido, ValorBruto, ValorDesconto: currency; Volume: Double);
begin
  CheckEquals(10.50, ValorBruto);
  CheckEquals(9.30, ValorLiquido);
  CheckEquals(1.20, ValorDesconto);
end;

procedure TTestCaseOrcamento.VerificaEventoVendeItem(Item: TItemOrcamento);
begin
  CheckEquals(10.50, Item.VALOR_UNITA);
  CheckEquals('Descrição Produto', Item.DESCRICAO);
  CheckEquals('UN', Item.UND);
  CheckEquals(1, Item.QTD);
  CheckEquals(10.50, Item.VALOR_BRUTO);
end;

procedure TTestCaseOrcamento.TOrcamentoPodeNotificarAoVenderItem;
Var
  Orcamento: TOrcamento;
begin
  Orcamento := TOrcamentoFactory.RetornaOrcamento;
  Orcamento.VALORDESC := 0;
  Orcamento.OnChange := VerificaEventoChange;
  Orcamento.OnVendeItem := VerificaEventoVendeItem;

  Orcamento.VendeItem(
    TItemOrcamento.CreateItem(
    1,
    '0001',
    'Descrição Produto',
    'UN',
    1,
    10.50,
    1.20
    )

    );

    FreeAndNil(Orcamento);

end;

procedure TTestCaseOrcamento.TOrcamentoPodeRemoverItem;
Var
  Orcamento: TOrcamento;
  I: Integer;
begin
  Orcamento := TOrcamentoFactory.RetornaOrcamento;

  for I := 1 to 5 do
  begin
    Orcamento.VendeItem(TOrcamentoFactory.RetornaItem(I))
  end;

  CheckEquals(64.57, Orcamento.ValorBruto);
  CheckEquals(56.37, Orcamento.ValorLiquido);

  Orcamento.ExcluiItem(2);

  CheckEquals(51.66, Orcamento.ValorBruto);
  CheckEquals(44.66, Orcamento.ValorLiquido);

  Orcamento.VendeItem(TOrcamentoFactory.RetornaItem(6));
  CheckEquals(64.57, Orcamento.ValorBruto);
  CheckEquals(56.37, Orcamento.ValorLiquido);

   FreeAndNil(Orcamento);
end;

initialization

TestFramework.RegisterTest(TTestCaseOrcamento.Suite);

end.
