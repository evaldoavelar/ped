unit Pedido.Venda.IPart;

interface

uses
  Vcl.Controls;

type

  TOnObjectChange = reference to procedure(aObj: TObject);

  IPart = interface
    ['{25DB63A5-A300-439A-9CDA-0B15ACD90E77}']
    function setParams(aObj: array of TObject): IPart;
    function setParent(aParent: TWinControl): IPart;
    function setOnObjectChange(aCallback: TOnObjectChange): IPart;
    function SetUp: IPart;
  end;

implementation

end.
