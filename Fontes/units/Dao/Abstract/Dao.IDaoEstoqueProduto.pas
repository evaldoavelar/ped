unit Dao.IDaoEstoqueProduto;

interface

uses System.Generics.Collections, Dao.IDaoFiltroEstoque,
  Dominio.Entidades.TEstoqueProduto;

type

  IDaoEstoqueProduto = interface
    ['{5D99D869-E783-46D3-BD66-F844E43E6CD9}']
    procedure Inclui(aESTOQUEPRODUTO: TEstoqueProduto);
    procedure Delete(aESTOQUEPRODUTO: TEstoqueProduto);
    procedure Valida(aESTOQUEPRODUTO: TEstoqueProduto);
    function UpdateStatus(aIDPEDIDO: Integer; aSEQ: Integer; aStatus: string): Integer; overload;
    function ListaObject(aFiltro: IDaoEstoqueFiltro): tLIST<TEstoqueProduto>;
  end;

implementation

end.
