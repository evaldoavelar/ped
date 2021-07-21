unit Dominio.Entidades.TEntity;

interface

uses System.Classes, System.Rtti, System.Generics.Collections, System.SysUtils,
  System.Bindings.Expression, System.Bindings.Helper;

type

  IEntity = interface
    // crtl+shift+g
    ['{69662EA0-4238-4E86-AF79-67F7D5F5845E}']
  end;

  TEntity = class(TInterfacedObject, IEntity)
  protected
    type
    TExpressionList = TObjectList<TBindingExpression>;

  private
    [JSONMarshalled(false)]
    FBindings: TExpressionList;
    function FieldInList(Field: string; List: TStringList): Boolean;
  protected
    property Bindings: TExpressionList read FBindings;
    procedure InicializarPropriedades(ignore: TStringList = nil);
    procedure Notify(const APropertyName: string = '');

  public
    procedure Bind(const AProperty: string; const ABindToObject: TObject;
      const ABindToProperty: string; const ACreateOptions:
      TBindings.TCreateOptions = [coNotifyOutput, coEvaluate]);

    procedure BindReadOnly(const AProperty: string; const ABindToObject: TObject;
      const ABindToProperty: string; const ACreateOptions:
      TBindings.TCreateOptions = [coNotifyOutput, coEvaluate]);

    procedure ClearBindings;

    destructor Destroy; override;
    constructor Create; virtual;

  end;

implementation

{ TEntity }

procedure TEntity.Bind(const AProperty: string; const ABindToObject: TObject; const ABindToProperty: string; const ACreateOptions: TBindings.TCreateOptions);
begin
  // From source to dest
  FBindings.Add(TBindings.CreateManagedBinding(
    { inputs }
    [TBindings.CreateAssociationScope([Associate(Self, 'src')])],
    'src.' + AProperty,
    { outputs }
    [TBindings.CreateAssociationScope([Associate(ABindToObject, 'dst')])],
    'dst.' + ABindToProperty,
    nil, nil, ACreateOptions));
  // From dest to source
  FBindings.Add(TBindings.CreateManagedBinding(
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
  FBindings.Add(TBindings.CreateManagedBinding(
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
end;

destructor TEntity.Destroy;
begin
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

end.
