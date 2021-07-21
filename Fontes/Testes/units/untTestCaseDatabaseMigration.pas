unit untTestCaseDatabaseMigration;

interface

implementation

uses
  System.Generics.Collections,
  TestFramework, Classes, Math, DateUtils, SysUtils,
  Dominio.Entidades.TFactory, Dominio.Entidades.TEntity, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TPedido, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TProduto,
  Database.IDataseMigration,
  Database.TDataseMigrationBase;

type
  // classe de teste de Pedido
  TTestCaseDatabaseMigration = class(TTestCase)
  private
    EntityFactory: TFactory;
  published

    procedure PodeMigrar;

  public
    procedure SetUp; override;
    procedure TearDown; override;
  end;

  { TTestCaseDatabaseMigration }

procedure TTestCaseDatabaseMigration.PodeMigrar;
var
  migrate: IDataseMigration;
begin
  migrate := TDataseMigrationBase.Create(tpFirebird);
  migrate.migrate();
  CheckEquals(0, migrate.GetErros.Count, 'Foram encontrados erros na atualização');
end;

procedure TTestCaseDatabaseMigration.SetUp;
begin
  inherited;

end;

procedure TTestCaseDatabaseMigration.TearDown;
begin
  inherited;

end;

initialization

TestFramework.RegisterTest(TTestCaseDatabaseMigration.Suite);

end.
