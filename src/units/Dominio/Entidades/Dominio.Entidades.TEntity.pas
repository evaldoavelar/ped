unit Dominio.Entidades.TEntity;

interface

uses System.Classes, System.Rtti, System.Generics.Collections, System.SysUtils,
  System.Bindings.Expression, System.Bindings.Helper, Dominio.Mapeamento.Atributos,
  Dominio.Entidades.Observe, Dominio.IEntidade, Dominio.Entidades.Observable;

type

  TEntity = class(TInterfacedObject, IEntity, IEntityObserver)
  protected
    type
    TExpressionList = TObjectList<TBindingExpression>;
  public
    type
    TStatusBD = (stNenhum, stCriar, stDeletado, stAtualizar, stAdicionado);
  private
    [JSONMarshalled(false)]
    FBindings: TExpressionList;
    FObserves: TList<IEntityObservable>;
    FStatusBD: TStatusBD;
    function FieldInList(Field: string; List: TStringList): Boolean;
    procedure SetStatusBD(const Value: TStatusBD);
  protected
    property Bindings: TExpressionList read FBindings;
    procedure InicializarPropriedades(ignore: TStringList = nil);
    procedure Notify(const APropertyName: string = '');

  public
    [ignore(true)]
    property StatusBD: TStatusBD read FStatusBD write SetStatusBD;

    procedure Bind(const AProperty: string; const ABindToObject: TObject;
      const ABindToProperty: string; const ACreateOptions:
      TBindings.TCreateOptions = [coNotifyOutput, coEvaluate]);

    procedure BindReadOnly(const AProperty: string; const ABindToObject: TObject;
      const ABindToProperty: string; const ACreateOptions:
      TBindings.TCreateOptions = [coNotifyOutput, coEvaluate]);

    procedure ClearBindings;

    destructor Destroy; override;
    constructor Create; virtual;

    procedure addObserver(obs: IEntityObservable);
    procedure removeObserver(obs: IEntityObservable);
    procedure NotifyObservers;

  end;

implementation


{ TEntity }

procedure TEntity.addObserver(obs: IEntityObservable);
begin
  FObserves.add(obs);
end;

procedure TEntity.Bind(const AProperty: string; const ABindToObject: TObject; const ABindToProperty: string; const ACreateOptions: TBindings.TCreateOptions);
begin
  // From source to dest
  FBindings.add(TBindings.CreateManagedBinding(
    { inputs }
    [TBindings.CreateAssociationScope([Associate(Self, 'src')])],
    'src.' + AProperty,
    { outputs }
    [TBindings.CreateAssociationScope([Associate(ABindToObject, 'dst')])],
    'dst.' + ABindToProperty,
    nil, nil, ACreateOptions));
  // From dest to source
  FBindings.add(TBindings.CreateManagedBinding(
    { inputs }
    [TBindings.CreateAssociationScope([Associate(ABindToObject, 'src')])],
    'src.' + ABindToProperty,
    { outputs }
    [TBindings.CreateAssociationScope([Associate(Self, 'dst')])],
    'dst.' + AProperty,
    nil, nil, ACreateOptions));
end;

procedure TEntity.BindReadOnly(const AProperty: string;
  const ABindToObject: TObject; const ABindToProperty: string;
  const ACreateOptions: TBindings.TCreateOptions);
begin
  // From source to dest
  FBindings.add(TBindings.CreateManagedBinding(
    { inputs }
    [TBindings.CreateAssociationScope([Associate(Self, 'src')])],
    'src.' + AProperty,
    { outputs }
    [TBindings.CreateAssociationScope([Associate(ABindToObject, 'dst')])],
    'dst.' + ABindToProperty,
    nil, nil, ACreateOptions));
end;

procedure TEntity.ClearBindings;
var
  i: TBindingExpression;
  j: Integer;
begin
  if assigned(FBindings) then
  begin
    for i in FBindings do
      TBindings.RemoveBinding(i);

    FBindings.Clear;
  end;
end;

constructor TEntity.Create;
begin
  FBindings := TExpressionList.Create(false { AOwnsObjects } );
  FObserves := TList<IEntityObservable>.Create;
end;

destructor TEntity.Destroy;
begin
  if assigned(FObserves) then
  begin
    FObserves.Clear;
    FObserves.free;
  end;
  ClearBindings;
  if assigned(FBindings) then
    FreeAndNil(FBindings);
  inherited;
end;

function TEntity.FieldInList(Field: string; List: TStringList): Boolean;
begin
  if List = nil then
  begin
    result := false;
  end
  else
  begin
    result := List.IndexOf(Field) >= 0;
  end;
end;

procedure TEntity.InicializarPropriedades(ignore: TStringList);
var
  context: TRttiContext;
  rType: TRttiType;
  Field: TRttiField;
  method: TRttiMethod;
  prop: TRttiProperty;
begin
  context := TRttiContext.Create;
  rType := context.GetType(Self.ClassType);
  // for field in rType.GetFields do
  // ;//do something here
  // for method in rType.GetMethods do
  // ;//do something here
  for prop in rType.GetProperties do
  begin
    if not FieldInList(prop.Name, ignore) and (prop.IsWritable) then
    begin

      case prop.PropertyType.TypeKind of
        tkUnknown:
          prop.SetValue(Self, TValue.From(''));
        tkInteger:
          prop.SetValue(Self, TValue.From(0));
        tkChar:
          ;
        tkEnumeration:
          ;
        tkFloat:
          prop.SetValue(Self, TValue.From(0));
        tkString:
          prop.SetValue(Self, TValue.From(''));
        tkSet:
          ;
        tkClass:
          ;
        tkMethod:
          ;
        tkWChar:
          ;
        tkLString:
          prop.SetValue(Self, TValue.From(''));
        tkWString:
          prop.SetValue(Self, TValue.From(''));
        tkVariant:
          ;
        tkArray:
          ;
        tkRecord:
          ;
        tkInterface:
          ;
        tkInt64:
          prop.SetValue(Self, TValue.From(0));
        tkDynArray:
          ;
        tkUString:
          prop.SetValue(Self, TValue.From(''));
        tkClassRef:
          ;
        tkPointer:
          ;
        tkProcedure:
          ;
      end;

    end;
  end;

end;

procedure TEntity.Notify(const APropertyName: string);
begin
  TBindings.Notify(Self, APropertyName);
end;

procedure TEntity.NotifyObservers;
var
  i: Integer;
begin
  for i := 0 to Pred(FObserves.Count) do
  begin
    try
      FObserves[i].Update(Self);
    except
    end;
  end;
end;

procedure TEntity.removeObserver(obs: IEntityObservable);
begin
  if (FObserves.IndexOf(obs)) >= 0 then
    FObserves.remove(obs);
end;

procedure TEntity.SetStatusBD(const Value: TStatusBD);
begin
  FStatusBD := Value;
end;

end.
