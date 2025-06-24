unit IFactory.Entidades;

interface

uses
  Dominio.Entidades.TFornecedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TPedido, Dominio.Entidades.TParceiro,
  Dominio.Entidades.TVendedor, Dominio.Entidades.TParceiro.FormaPagto,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TFormaPagto,
  Dominio.Entidades.TEmitente, Dominio.Entidades.TOrcamento,
  Dominio.Entidades.TParcelas, Dominio.Entidades.TProduto, ACBrPosPrinter,
  Sistema.TParametros;

type
  IFactoryEntidades = interface
    ['{A7CB4D92-8C0C-46AA-8311-CD707F549F68}']

    function Cliente(): TCliente;
    function Fornecedor(): TFornecedor;
    function vendedor(): TVendedor;
    function Parceiro(): TParceiro;
    function Pedido(): TPedido;
    function Orcamento(): TOrcamento;
    function Parcelas(): TParcelas;
    function ItemPedido(): TItemPedido;
    function Produto(): TProduto;
    function FormaPagto: TFormaPagto;
    function Emitente: TEmitente;
    function ParceiroFormaPagto: TParceiroFormaPagto;

    function getVendedorLogado(): TVendedor;
    procedure setVendedorLogado(vendedor: TVendedor);
    property VendedorLogado: TVendedor read getVendedorLogado write setVendedorLogado;
    function PosPrinter(): TACBrPosPrinter;
  //  function Parametros(): TParametros;
  end;

implementation

end.
