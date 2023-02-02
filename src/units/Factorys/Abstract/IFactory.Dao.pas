unit IFactory.Dao;

interface

uses
  Dao.IDaoEmitente, Dao.IDaoFornecedor, Dao.IDaoFormaPagto,
  Dao.IDaoParceiro.FormaPagto, Dao.IDaoParceiroVenda,
  Dao.IDaoParametrosBancoDeDados, Dao.IDaoEstoqueProduto,
  Dao.IDoParceiroVenda.Pagamentos, Dao.IDaoParceiro, Dao.IDAOPedidoPeriodo,
  Dao.IDaoProdutos, Dao.IDAOCliente, Dao.IDaoParcelas, Dao.IDaoPedido,
  Dao.IDaoOrcamento, Dao.IDaoVendedor, Dao.IDaoParametros,
  Dao.IDAOPedidoPagamento, Dao.IDAOTSangriaSuprimento, Dao.IDaoFiltroEstoque,
  Dominio.Entidades.TEmitente, Sistema.TParametros, FireDAC.Comp.Client,
  Sistema.TBancoDeDados;

type

  IFactoryDao = interface
    function DaoEmitente(): IDaoEmitente;
    function DaoCliente(): IDAOCliente;
    function DaoFornecedor(): IDaoFornecedor;
    function DaoProduto(): IDaoProdutos;
    function DaoOrcamento(): IDaoOrcamento;
    function DaoFormaPagto(): IDaoFormaPagto;
    function DaoPedido(): IDaoPedido;
    function DaoParcelas(): IDaoParcelas;
    function DaoVendedor(): IDaoVendedor;
    function DaoParametros(): IDaoParametros;
    function DaoPedidoPeriodo(): IDAOPedidoPeriodo;
    function DaoParceiro(): IDaoParceiro;
    function DaoParceiroFormaPagto(): IDaoParceiroFormaPagto;
    function DaoParceiroVendaPagto(): IDaoParceiroVendaPagto;
    function DaoParceiroVenda(): IDaoParceiroVenda;
    function DAOPedidoPagamento(): IDAOPedidoPagamento;
    function DAOTSangriaSuprimento(): IDAOTSangriaSuprimento;
    function DaoEstoqueProduto(): IDaoEstoqueProduto;
    function DaoFiltroEstoque(): IDaoEstoqueFiltro;
    function DaoParametrosBancoDeDados: IDaoParametrosBancoDeDados;

    function getDadosEmitente: TEmitente;
    property DadosEmitente: TEmitente read getDadosEmitente;


    function Query(): TFDQuery;
    function Conexao(aBancoDeDados: TParametrosBancoDeDados = nil): TFDConnection;
    procedure Close();

  end;

implementation

end.
