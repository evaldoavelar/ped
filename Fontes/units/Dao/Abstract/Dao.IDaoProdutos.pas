unit Dao.IDaoProdutos;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  Data.DB,
  Dao.TDaoBase,
  Dominio.Entidades.TProduto;

type

  IDaoProdutos = interface
  ['{EBE8B393-95CA-43A0-BC68-6E259720F0FF}']
    procedure ExcluirProduto(codigo: string);
    procedure IncluiProduto(Produto: TProduto);
    procedure AtualizaProduto(Produto: TProduto);
    function GetProdutoPorCodigo(codigo: string): TProduto;
    function GetProdutoPorDescricao(descricao: string): TProduto;
    function GetProdutosPorDescricao(descricao: string): TObjectList<TProduto>;
    function GetProdutosPorDescricaoParcial(descricao: string): TObjectList<TProduto>;
    function Listar(campo, valor: string): TDataSet;
    procedure ValidaProduto(Produto: TProduto);
    function GetProdutoPorCodigoBarras(codBarras: string): TProduto;
    function GeraID: string;
  end;

implementation

end.
