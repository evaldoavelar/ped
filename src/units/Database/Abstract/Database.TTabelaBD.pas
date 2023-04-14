unit Database.TTabelaBD;

interface

uses
  System.SysUtils, System.Classes,
  System.Generics.Collections,
  System.Rtti,


  Dominio.Mapeamento.Atributos;

type
  TTabelaBD = class
  public
    Tabela: TabelaAttribute;
    Campos: TObjectList<CampoAttribute>;
    Pks: TObjectList<PrimaryKeyAttribute>;
    Fks: TObjectList<ForeignKeyAttribute>;

    function toScript: TStringList; virtual; abstract;
    constructor Create;
    destructor destroy;
  end;

implementation

{ ITabelaBD }

constructor TTabelaBD.Create;
begin
  Campos := TObjectList<CampoAttribute>.Create();
  Fks := TObjectList<ForeignKeyAttribute>.Create();
  Pks := TObjectList<PrimaryKeyAttribute>.Create();
end;

destructor TTabelaBD.destroy;
begin
  Campos.Clear;
  FreeAndNil(Campos);

  Fks.Clear;
  FreeAndNil(Fks);

  Pks.Clear;
  FreeAndNil(Pks);

end;

end.
