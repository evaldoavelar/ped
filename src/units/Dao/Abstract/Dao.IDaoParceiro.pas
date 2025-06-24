unit Dao.IDaoParceiro;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  Data.DB,
  Sistema.TLog,
  Dominio.Entidades.TParceiro;

type

  IDaoParceiro = interface
    ['{7E02757E-EEAA-43CF-8C5F-56770DCE3CA4}']
    procedure ExcluirParceiro(codigo: string);
    procedure IncluiParceiro(Parceiro: TParceiro);
    procedure ValidaParceiro(Parceiro: TParceiro);
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(aNome:string): TObjectList<TParceiro>; overload;
    function ListarAtivos(): TObjectList<TParceiro>; overload;
    procedure AtualizaParceiro(Parceiro: TParceiro);
    function GetParceiro(idpedido: Integer): TParceiro; overload;
    function GetParceiro(codigo: string): TParceiro; overload;
    function GetParceirobyNome(nome: string): TParceiro;
  end;

implementation

end.
