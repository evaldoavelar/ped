unit Dao.IDAOPedidoPagamento;

interface

uses System.Generics.Collections, Dominio.Entidades.Pedido.Pagamentos.Pagamento;

type

  IDAOPedidoPagamento = interface
    ['{BB576016-C8C1-485F-8495-E07DDE9628D4}']
    procedure Excluir(id: Integer; idpedido: Integer);
    procedure ExcluirPorPedido(idpedido: Integer);
    procedure Inclui(aPagto: TPEDIDOPAGAMENTO);
    procedure Validar(aPagto: TPEDIDOPAGAMENTO);
    procedure Atualiza(aPagto: TPEDIDOPAGAMENTO);
    function GetPAGTO(SEQ: Integer; idpedido: Integer): TPEDIDOPAGAMENTO;
    function ListaObject(idpedido: Integer): tLIST<TPEDIDOPAGAMENTO>;
  end;

implementation

end.
