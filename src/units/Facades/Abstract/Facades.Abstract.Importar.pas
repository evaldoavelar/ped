unit Facades.Abstract.Importar;

interface

uses
  Facades.Abstract.Observable;

type

  IFacadeImportar = interface(IFacadeObservable)
    ['{F9858109-7569-4A7A-B8FB-5B2A6490B033}']

    function ImportarEmitente: IFacadeImportar;
    function ImportarCliente: IFacadeImportar;
    function ImportarVendedor: IFacadeImportar;
    function ImportarFornecedor: IFacadeImportar;
    function ImportarFormaPagto: IFacadeImportar;
    function ImportarProduto: IFacadeImportar;
    function ImportarParceiro: IFacadeImportar;
    function ImportarCondicaodepagto: IFacadeImportar;
    function ImportarParceiroFormaPagto: IFacadeImportar;
    function ImportarEstoqueProduto: IFacadeImportar;
  end;

implementation

end.
