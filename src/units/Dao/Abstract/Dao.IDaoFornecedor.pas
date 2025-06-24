unit Dao.IDaoFornecedor;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  Data.DB,
  Sistema.TLog,
  Dominio.Entidades.TFornecedor;

type

  IDaoFornecedor = interface
    ['{64DEA23D-708C-4AFB-BB78-B37E13622D02}']
    procedure ExcluirFornecedor(codigo: string);
    procedure IncluiFornecedor(Fornecedor: TFornecedor);
    procedure ValidaForma(Fornecedor: TFornecedor);
    procedure AtualizaFornecedors(Fornecedor: TFornecedor);
    function GeFornecedor(codigo: string): TFornecedor;
    function GetFornecedorByName(nome: string): TFornecedor;
    function Lista(): TDataSet;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(aNome: string): TObjectList<TFornecedor>; overload;
    function ListaObject(): TObjectList<TFornecedor>;
    function GeraID: string;
  end;

implementation

end.
