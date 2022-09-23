unit Dao.IDAOCliente;

interface

uses
  System.SysUtils, System.Classes,Data.DB,
  Dao.TDaoBase, Sistema.TLog,System.Generics.Collections,
  Dominio.Entidades.TCliente;

type

  IDAOCliente = interface
    ['{01DA9971-245B-4955-B97F-B50DA6901584}']
    procedure ValidaCliente(Cliente: TCliente);
    procedure IncluiCliente(Cliente: TCliente);
    procedure AtualizaCliente(Cliente: TCliente);
    function GeTCliente(codigo: string): TCliente;
    function GeTClienteByName(nome: string): TCliente;
    function GeTClientesByName(nome: string):TObjectList<TCliente>;
    procedure ExcluirCliente(codigo: string);
    function GeraID: string;
    function Listar(campo: string; valor: string): TDataSet;
  end;

implementation

end.
