unit untTFactoryGeneric;

interface

uses SysUtils, Generics.Collections,
untTEntity;

type

 // TFactoryMethod = reference to function: TEntity;

  TFactoryMethodKeyAlreadyRegisteredException = class(Exception);
  TFactoryMethodKeyNotRegisteredException = class(Exception);

  TFactoryMethod<TEntity> = reference to function: TEntity;

  TFactory<TKey, TEntity> = class
  private
    FFactoryMethods: TDictionary<TKey, TFactoryMethod<TEntity>>;
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    procedure RegisterFactoryMethod(Key: TKey; FactoryMethod: TFactoryMethod<TEntity>);
    procedure UnregisterFactoryMethod(Key: TKey);
    function IsRegistered(Key: TKey): boolean;
    function GetInstance(Key: TKey): TEntity;
  end;

implementation


constructor TFactory<TKey, TEntity>.Create;
begin
  inherited Create;
  FFactoryMethods := TDictionary<TKey, TFactoryMethod<TEntity>>.Create;
end;

destructor TFactory<TKey, TEntity>.Destroy;
begin
  FFactoryMethods.Free;
  inherited;
end;

function TFactory<TKey, TEntity>.GetCount: Integer;
begin
  if Assigned(FFactoryMethods) then
    Result := FFactoryMethods.Count;
end;

function TFactory<TKey, TEntity>.GetInstance(Key: TKey): TEntity;
var
  FactoryMethod : TFactoryMethod<TEntity>;
begin
  if not IsRegistered(Key) then
    raise TFactoryMethodKeyNotRegisteredException.Create('');

  FactoryMethod := FFactoryMethods.Items[Key];
  if Assigned(FactoryMethod) then
    Result := FactoryMethod;
end;

function TFactory<TKey, TEntity>.IsRegistered(Key: TKey): boolean;
begin
  Result := FFactoryMethods.ContainsKey(Key);
end;

procedure TFactory<TKey, TEntity>.RegisterFactoryMethod(Key: TKey;
  FactoryMethod: TFactoryMethod<TEntity>);
begin
  if IsRegistered(Key) then
    raise TFactoryMethodKeyAlreadyRegisteredException.Create('');

  FFactoryMethods.Add(Key, FactoryMethod);
end;

procedure TFactory<TKey, TEntity>.UnRegisterFactoryMethod(Key: TKey);
begin
  if not IsRegistered(Key) then
    raise TFactoryMethodKeyNotRegisteredException.Create('');

  FFactoryMethods.Remove(Key);
end;

end.
