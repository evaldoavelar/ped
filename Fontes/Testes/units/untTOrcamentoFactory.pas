unit untTOrcamentoFactory;

interface

uses TestFramework, Classes, Math, DateUtils, SysUtils,
  Dominio.Entidades.TFactory, Dominio.Entidades.TEntity, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TOrcamento, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemOrcamento, Dominio.Entidades.TProduto;

type
  TOrcamentoFactory = class

    class function RetornaOrcamento: TOrcamento;
    class function RetornaItem(seq: Integer): TItemOrcamento;
  end;

implementation

{ TOrcamentoFactory }

uses untTFaker;

class function TOrcamentoFactory.RetornaOrcamento: TOrcamento;
Var
  cliente: TCliente;
  I: Integer;
begin

  result := TFactory.Orcamento();
  result.NUMERO := TFaker.Code;
  result.DATAOrcamento := Date();
  result.HORAOrcamento := Time();
  result.OBSERVACAO := TFaker.Comment(1000);
  result.VALORDESC := 2.20;
  result.STATUS := 'A';
  result.Vendedor := TVendedor.CreateVendedor(TFaker.Code, TFaker.Name, 0, 0);
  result.cliente := 'Consumidor';

end;

class function TOrcamentoFactory.RetornaItem(seq: Integer): TItemOrcamento;
begin
  result := TItemOrcamento.CreateItem(
    seq,
    '00001',
    'Descrição Produto',
    'UN',
    1.23,
    10.50,
    1.20
    )
end;

end.
