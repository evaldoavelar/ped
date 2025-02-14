unit Dao.IDAOParcelaPagamento;

interface

uses
  system.Generics.Collections,
  Dominio.Entidades.Pedido.Parcela.Pagamentos,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento;

TYPE
  IDAOParcelaPagamento = interface
    procedure Excluir(aIdPedido: integer; aNumParcela: integer);
    procedure Incluir(Produto: TParcelaPagamentos);
    function GetPagamentos(idpedido: integer): TList<TPEDIDOPAGAMENTO>;
  end;

implementation

end.
