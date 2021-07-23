unit Dominio.Entidades.Observe;

interface

uses Dominio.IEntidade;

type

  IEntityObservable = interface
    ['{E3F57406-7D81-40BD-82F7-1891E0567594}']
    [weak]
    procedure Update(const ModelBase: IEntity);
  end;

implementation

end.
