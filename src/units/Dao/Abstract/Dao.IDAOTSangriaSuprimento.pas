unit Dao.IDAOTSangriaSuprimento;

interface

uses System.Generics.Collections, Dominio.Entidades.TSangriaSuprimento;

type

  IDAOTSangriaSuprimento = interface
    ['{A6CC93EF-9CDD-47BD-B33C-E31D9653576C}']

    procedure Inclui(aObj: TSangriaSuprimento);
    procedure Valida(aObj: TSangriaSuprimento);
    function ListaObject(aData: TDate): TObjectList<TSangriaSuprimento>;
    function TotalSangriaSuprimento(aTipo: integer; dataInicio: TDatetime): Currency;
  end;

implementation

end.
