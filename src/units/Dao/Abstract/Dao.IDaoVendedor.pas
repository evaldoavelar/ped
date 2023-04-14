unit Dao.IDaoVendedor;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  Data.DB,
  Sistema.TLog,
  Dominio.Entidades.TVendedor;

type

  IDaoVendedor = interface
    ['{7E02757E-EEAA-43CF-8C5F-56770DCE3CA4}']
    procedure ExcluirVendedor(codigo: string);
    procedure IncluiVendedor(vendedor: TVendedor);
    procedure ValidaVendedor(vendedor: TVendedor);
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(descricao: string): TObjectList<TVendedor>; overload;
    function Listar(): TObjectList<TVendedor>; overload;
    procedure AtualizaVendedor(vendedor: TVendedor);
    function GetVendedor(codigo: string): TVendedor;
    function GetVendedorbyNome(nome: string): TVendedor;
  end;

implementation

end.
