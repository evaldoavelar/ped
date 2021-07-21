unit Dominio.Mapeamento.Atributos;

interface

uses
  Classes,
  SysUtils,
  DB,
  Rtti,
  Dominio.Mapeamento.Tipos;

type

  DescriptionAttribute = class(TCustomAttribute)
  protected
    FDescription: string;
  public
    constructor Create(ADescription: string = '');
    property Description: string read FDescription;
  end;

  TabelaAttribute = class(TCustomAttribute)
  private
    FTabela: string;
  public
    constructor Create(ATabela: string = '');
    property Tabela: string read FTabela write FTabela;
  end;

  CampoAttribute = class(TCustomAttribute)
  private
    FCampo: string;
    FTamanho: Integer;
    FPrecisao: Integer;
    FTipo: TTipoCampo;
    FNotNull: Boolean;
    FDefaultValue: string;
  public

    constructor Create(ACampo: string = ''; ATipo: TTipoCampo = tpNull; ATamanho: Integer = 0; APrecisao: Integer = 0; ANotNull: Boolean = False;
      ADefaultValue: string = '');
    property Campo: string read FCampo write FCampo;
    property Tipo: TTipoCampo read FTipo write FTipo;
    property Tamanho: Integer read FTamanho write FTamanho;
    property Precisao: Integer read FPrecisao write FPrecisao;
    property NotNull: Boolean read FNotNull write FNotNull;
    property DefaultValue: string read FDefaultValue write FDefaultValue;
  end;

  PrimaryKeyAttribute = class(DescriptionAttribute)
  private
    FColumns: TArray<string>;
    FSortingOrder: TSortingOrder;
    FUnique: Boolean;
    FSequenceType: TSequenceType;
    FName: string;
  public
    constructor Create(AName , AColumns, ADescription: string); overload;
    constructor Create(AName:string;  AColumns: string; ASequenceType: TSequenceType = NotInc; ASortingOrder: TSortingOrder = NoSort; AUnique: Boolean = False;
      ADescription: string = ''); overload;
    function CatColumns: string;

    property Name: string read FName write FName;
    property Columns: TArray<string> read FColumns;
    property SortingOrder: TSortingOrder read FSortingOrder;
    property Unique: Boolean read FUnique;
    property SequenceType: TSequenceType read FSequenceType write FSequenceType;
  end;

  /// ForeignKey
  ForeignKeyAttribute = class(DescriptionAttribute)
  private
    FReferenceTableName: string;
    FReferenceFieldName: string;
    FRuleUpdate: TRuleAction;
    FRuleDelete: TRuleAction;
    FName : string;
    FColumns: string;
  public
    constructor Create(AName: string; AColumns:string;  AReferenceTableName: string; AReferenceFieldName: string; ARuleDelete, ARuleUpdate: TRuleAction; ADescription: string = '');

    property Name: string read FName write FName;
    property Columns: string read FColumns write FColumns;
    property ReferenceTableName: string read FReferenceTableName;
    property ReferenceFieldName: string read FReferenceFieldName;
    property RuleDelete: TRuleAction read FRuleDelete;
    property RuleUpdate: TRuleAction read FRuleUpdate;

  end;

implementation

{ CampoAttribute }

uses Util.Funcoes;

constructor CampoAttribute.Create(ACampo: string; ATipo: TTipoCampo; ATamanho,
  APrecisao: Integer; ANotNull: Boolean; ADefaultValue: string);
begin
  Self.FCampo := ACampo;
  Self.FTamanho := ATamanho;
  Self.FPrecisao := APrecisao;
  Self.Tipo := ATipo;
  Self.FNotNull := ANotNull;
  Self.DefaultValue := ADefaultValue;
end;

{ PrimaryKey }

constructor PrimaryKeyAttribute.Create(AName ,AColumns, ADescription: string);
begin
  Create(AName ,AColumns, NotInc, NoSort, False, ADescription);
end;

function PrimaryKeyAttribute.CatColumns: string;
var
  iFor: Integer;
begin
  for iFor := Low(FColumns) to High(FColumns) do
  begin
    if iFor > 0 then
      result := ',' + FColumns[iFor]
    else
      result := FColumns[iFor];
  end;
end;

constructor PrimaryKeyAttribute.Create(AName :string; AColumns: string; ASequenceType: TSequenceType;
  ASortingOrder: TSortingOrder; AUnique: Boolean; ADescription: string);
var
  rColumns: TStrArray;
  iFor: Integer;
begin
  inherited Create(ADescription);
  if Length(AColumns) > 0 then
  begin
    SetLength(FColumns, TUtil.Explode(rColumns, ';', AColumns));
    for iFor := Low(rColumns) to High(rColumns) do
      FColumns[iFor] := rColumns[iFor];
  end;

  FName := AName;
  FSequenceType := ASequenceType;
  FSortingOrder := ASortingOrder;
  FUnique := AUnique;
end;

{ ForeignKeyAttribute }

constructor ForeignKeyAttribute.Create(AName: string; AColumns, AReferenceTableName,
  AReferenceFieldName: string; ARuleDelete, ARuleUpdate: TRuleAction;
  ADescription: string);
begin
  inherited Create(ADescription);
  FName := AName;
  FColumns := AColumns;
  FReferenceTableName := AReferenceTableName;
  FReferenceFieldName := AReferenceFieldName;
  FRuleDelete := ARuleDelete;
  FRuleUpdate := ARuleUpdate;
end;

{ DescriptionAttribute }

constructor DescriptionAttribute.Create(ADescription: string);
begin
  Self.FDescription := ADescription;
end;

{ TabelaAttribute }

constructor TabelaAttribute.Create(ATabela: string);
begin
  Self.FTabela := ATabela;
end;

end.
