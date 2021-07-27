unit Dao.IDaoFiltroEstoque;

interface

type
  IDaoEstoqueFiltro = interface
    ['{53CCFB05-A864-429F-BC5F-93A99AD72E77}']
    function setDataIncio(aData: TDateTime): IDaoEstoqueFiltro;
    function setDataFim(aData: TDateTime): IDaoEstoqueFiltro;
    function setProduto(aCODIGO: string): IDaoEstoqueFiltro;

    function getDataIncio: TDateTime;
    function getDataFim: TDateTime;
    function getProduto: string;
  end;

implementation

end.
