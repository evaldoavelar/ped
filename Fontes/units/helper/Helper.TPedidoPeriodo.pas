unit Helper.TPedidoPeriodo;

interface

uses System.Generics.Collections, System.SysUtils,
  System.classes;

type

  TPedidoPeriodo = class
  private
    FValor: Currency;
    FData: TDate;
    procedure SetData(const Value: TDate);
    procedure SetValor(const Value: Currency);
  public
    constructor Create(AData: TDate; AValor: Currency);
  published
    property Data: TDate read FData write SetData;
    property Valor: Currency read FValor write SetValor;
  end;

  TListaPeriodoPedido = class
  private
    FPeriodos: TObjectList<TPedidoPeriodo>;
  published
    property Periodos: TObjectList<TPedidoPeriodo> read FPeriodos write FPeriodos;
  public
    function indexOfData(Data: TDate): Integer;
    constructor Create();
    destructor Destroy;override;

  end;

implementation

{ TPedidoPeriodo }

procedure TPedidoPeriodo.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TPedidoPeriodo.SetValor(const Value: Currency);
begin
  FValor := Value;
end;

constructor TPedidoPeriodo.Create(AData: TDate; AValor: Currency);
begin
  self.FData := AData;
  self.Valor := AValor;
end;

{ TListaPeriodoPedido }

constructor TListaPeriodoPedido.Create;
begin
  self.FPeriodos := TObjectList<TPedidoPeriodo>.Create;
end;

destructor TListaPeriodoPedido.Destroy;
begin
  self.FPeriodos.Clear;
  freeAndNil(self.FPeriodos);
  inherited;

end;

function TListaPeriodoPedido.indexOfData(Data: TDate): Integer;
var
  i: Integer;
begin
  result := -1;

  for i := 0 to Periodos.Count - 1 do
  begin
    if Periodos[i].Data = Data then
    begin
      result := i;
      Break;
    end;
  end;
end;

end.
