unit Facades.Abstract.Observable;

interface

uses
  Facades.Abstract.Observer;

type
  IFacadeObservable = interface
    ['{E0E62FA3-181F-4C76-BB17-946E2DC4F216}']
    procedure addObserver(aObs: IFacadeObserver);
    procedure removeObserver(aObs: IFacadeObserver);
    procedure NotifyObservers(aValue: string);
  end;

implementation

end.
