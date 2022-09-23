unit Dao.IDaoPedido;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TItemPedido,
  Dominio.Entidades.TPedido,
  Dominio.Entidades.TParcelas,
  Dominio.Entidades.Pedido.Pagamentos,
  Helper.TProdutoVenda;

type

  IDaoPedido = interface
    ['{4503CBE6-4D7B-4937-A259-32F44B769601}']
    procedure AbrePedido(pedido: TPedido);
    procedure VendeItem(Item: TItemPedido);
    procedure ExcluiItem(Item: TItemPedido);
    procedure GravaPgamento(Pagamentos: TPAGAMENTOS);
    procedure AtualizaPedido(pedido: TPedido);
    procedure AdicionaComprovante(pedido: TPedido);
    procedure FinalizaPedido(pedido: TPedido);
    function getPedido(id: Integer): TPedido;
    function GeraID: Integer;
    function Listar(campo, valor: string; dataInicio, dataFim: TDate): TDataSet; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(dataInicio, dataFim: TDate): TDataSet; overload;
    function Totais(dataInicio, dataFim: TDate): TList<TPair<string, string>>; overload;
    function Totais(dataInicio, dataFim: TDate; CodVen: string): TList<TPair<string, string>>; overload;
    function TotaisParceiro(dataInicio, dataFim: TDate; CodParceiro: string): TList<TPair<string, Currency>>;
    function ProdutosVendidos(dataInicio, dataFim: TDate): TList<TProdutoVenda>;

  end;

implementation



end.
