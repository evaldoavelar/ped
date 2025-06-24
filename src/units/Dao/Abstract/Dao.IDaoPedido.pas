unit Dao.IDaoPedido;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB,
  Sistema.TLog,
  Dominio.Entidades.TItemPedido,
  Dominio.Entidades.TPedido,

  Dominio.Entidades.Pedido.Pagamentos,
  Helper.TProdutoVenda;

type

  IDaoPedido = interface
    ['{4503CBE6-4D7B-4937-A259-32F44B769601}']
    procedure AbrePedido(Pedido: TPedido);
    procedure VendeItem(Item: TItemPedido);
    procedure ExcluiItem(Item: TItemPedido);
    procedure GravaPgamento(Pagamentos: TPAGAMENTOS);
    procedure AtualizaPedido(Pedido: TPedido);
    procedure AdicionaComprovante(Pedido: TPedido);
    procedure FinalizaPedido(Pedido: TPedido);
    function getPedido(id: Integer): TPedido;
    function GeraID: Integer;
    function Listar(campo, valor: string; dataInicio, dataFim: TDate): TDataSet; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(dataInicio, dataFim: TDate): TDataSet; overload;
    function Totais(dataInicio, dataFim: TDateTime; aNumCaixa: string; aMovimentacaoDoCaixa: boolean): TList<TPair<string, string>>; overload;
    function Totais(dataInicio, dataFim: TDateTime; CodVen: string): TList<TPair<string, string>>; overload;
    function TotaisParceiro(dataInicio, dataFim: TDate; CodParceiro: string): TList<TPair<string, Currency>>;
    function ProdutosVendidos(dataInicio, dataFim: TDate): TList<TProdutoVenda>;
    function TotalCaixa(dataInicio: TDateTime; dataFim: TDateTime): Currency;
    function TotalDinheiro(dataInicio, dataFim: TDateTime): Currency;
    function TotalTroco(dataInicio, dataFim: TDateTime): Currency;
    function ListaCaixas: TStringList;
  end;

implementation


end.
