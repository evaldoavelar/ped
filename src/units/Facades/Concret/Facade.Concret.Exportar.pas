unit Facade.Concret.Exportar;

interface

uses Facades.Abstract.Exportar;

type

  TFacadeExportar = class(TInterfacedObject, IFacadeExportar)
  public
    constructor Create();
    destructor Destroy; override;
    class function New(): IFacadeExportar;
  end;

implementation

{ FacadeExportar }

constructor TFacadeExportar.Create;
begin

end;

destructor TFacadeExportar.Destroy;
begin

  inherited;
end;

class function TFacadeExportar.New: IFacadeExportar;
begin
  result := TFacadeExportar.Create;
end;

end.
