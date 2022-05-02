unit Dominio.Entidades.Observable;

interface

uses Dominio.Entidades.Observe;

type

  IEntityObserver = interface
    ['{062EA0B0-552A-440D-B082-CB49D1AB9695}']
    procedure addObserver(obs: IEntityObservable);
    procedure removeObserver(obs: IEntityObservable);
    procedure NotifyObservers;
  end;

implementation

end.
