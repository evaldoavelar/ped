unit Dao.TDaoBase;

interface

uses
  System.Rtti, Sistema.TLog,
  System.SysUtils, System.Classes,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos.Funcoes;

type

  TDaoBase = class(TInterfacedObject)
  private
    FKeepConection: Boolean;

  protected
    FConnection: TFDConnection;
    function Query: TFDQuery;
    function DataSetToObject<T: class>(ds: TDataSet): T;
    function AutoIncremento(tabela, campo: string): Integer;
    procedure EntityToParams(ds: TFDQuery; Entity: TEntity); virtual;
    procedure FieldsToEntity(ds: TDataSet; Entity: TEntity); virtual;

    function RetornaSQLUpdate<T: class>(aNomeTabela: string): string;
    function RetornaSQLInsert<T: class>(aNomeTabela: string): string;
    function CampoIsPk<T: class>(pks: TProperties; key: string): Boolean;
    function RetornaWhere<T: class>(): string;
    procedure CopiarParametros(aQryRemoto, aQry: TFDQuery);
    function SetarAutoInc<T: class>(aQry: TFDQuery): string;
  public

    constructor Create(Connection: TFDConnection; aKeepConection: Boolean); virtual;
    destructor destroy; override;
  end;

implementation

uses
  Util.Exceptions, Utils.Rtti, Dominio.Mapeamento.Atributos;

{ TDaoBase }

function TDaoBase.Query: TFDQuery;
begin
  result := TFDQuery.Create(nil);
  result.Connection := FConnection;
end;

function TDaoBase.SetarAutoInc<T>(aQry: TFDQuery): string;
var
  props: TProperties;
  prop: TRttiProperty;
  valor: Integer;
  tabela: string;
  TabelaAutoInc: string;
  campo: string;
  I: Integer;
begin
  // pegar as propriedades anotadas com AutoInc
  props := TAtributosFuncoes.PropertieAutoInc<T>;

  for I := Low(props) to High(props) do
  begin
    TabelaAutoInc := TAtributosFuncoes.tabela<T>();
    campo := TAtributosFuncoes.campo<T>(props[I]);

    TLog.d('AutoIncremento: TabelaAutoInc: %s Tabela Origem:%s Campo:%s', [TabelaAutoInc, tabela, campo]);
    valor := AutoIncremento(TabelaAutoInc, campo);

    TLog.d('AutoIncremento: valor:%d', [valor]);
    aQry.fieldbyName('Campo').AsInteger := valor;
  end;
end;

procedure TDaoBase.CopiarParametros(aQryRemoto: TFDQuery; aQry: TFDQuery);
var
  I: Integer;
begin
  for I := 0 to aQryRemoto.FieldCount - 1 do
  begin
    aQry.paramByName(aQryRemoto.Fields[I].FieldName).DataType := aQryRemoto.Fields[I].DataType;
    aQry.paramByName(aQryRemoto.Fields[I].FieldName).Value := aQryRemoto.Fields[I].Value;
  end;
end;

function TDaoBase.RetornaSQLInsert<T>(aNomeTabela: string): string;
var
  I: Integer;
  LSql: TStringBuilder;
  LCampos: TStringBuilder;
  LValues: TStringBuilder;
begin
  LSql := TStringBuilder.Create;
  LCampos := TStringBuilder.Create;
  LValues := TStringBuilder.Create;

  I := 0;
  TRttiUtil.ForEachProperties<T>(
    procedure(prop: TRttiProperty)
    var
      LCampo: string;
    begin

      if I > 0 then
      begin
        LCampos.AppendFormat(', %s ', [LCampo, LCampo]);
        LValues.AppendFormat(', :%s ', [LCampo, LCampo]);
      end
      else
      begin
        LCampos.AppendFormat(' %s  ', [LCampo, LCampo]);
        LValues.AppendFormat(' :%s  ', [LCampo, LCampo]);
      end;

      inc(I);
    end);

  LSql.AppendFormat(' insert into %s ', [aNomeTabela]);
  LSql.AppendFormat(' ( % ) ', [LCampos.ToString]);
  LSql.AppendFormat(' values ( % ) ', [LValues.ToString]);

  result := LSql.ToString;

  LSql.free;
  LCampos.free;
  LValues.free;
end;

function TDaoBase.RetornaSQLUpdate<T>(aNomeTabela: string): string;
var
  I: Integer;
  LSql: TStringBuilder;
  pks: TProperties;
begin
  LSql := TStringBuilder.Create;
  LSql.Append(' update ' + aNomeTabela);
  LSql.Append(' set ');

  pks := TAtributosFuncoes.PropertiePk<T>;

  I := 0;
  TRttiUtil.ForEachProperties<T>(
    procedure(prop: TRttiProperty)
    var
      LCampo: string;
      attr: TCustomAttribute;
    begin
      LCampo := TAtributosFuncoes.campo<T>(prop);
      if CampoIsPk<T>(pks, LCampo) then
        exit;

      attr := TAtributosFuncoes.IndexOfAttribute(prop, IGNOREAttribute);
      if (attr is IGNOREAttribute) or (LCampo = 'RefCount') then
        exit;

      if I > 0 then
        LSql.AppendFormat(', %s = :%s ', [LCampo, LCampo])
      else
        LSql.AppendFormat(' %s = :%s ', [LCampo, LCampo]);

      inc(I);
    end);

  LSql.Append(RetornaWhere<T>());

  result := LSql.ToString;
  LSql.free;

end;

function TDaoBase.RetornaWhere<T>(): string;
var
  I: Integer;
  LSql: TStringBuilder;
  pks: TProperties;
begin
  LSql := TStringBuilder.Create;
  LSql.Append(' where ');
  I := 0;
  pks := TAtributosFuncoes.PropertiePk<T>;

  TRttiUtil.ForEachProperties<T>(
    procedure(prop: TRttiProperty)
    var
      LCampo: string;
    begin
      LCampo := TAtributosFuncoes.campo<T>(prop);
      if not CampoIsPk<T>(pks, LCampo) then
        exit;

      if I > 0 then
        LSql.AppendFormat('and %s = :%s ', [TAtributosFuncoes.campo<T>(prop), TAtributosFuncoes.campo<T>(prop)])
      else
        LSql.AppendFormat(' %s = :%s ', [TAtributosFuncoes.campo<T>(prop), TAtributosFuncoes.campo<T>(prop)]);

      inc(I);
    end);

  result := LSql.ToString;
  LSql.free;
end;

function TDaoBase.CampoIsPk<T>(pks: TProperties; key: string): Boolean;
var
  prop: TRttiProperty;
  campo: string;
begin
  try
    result := false;
    // pecorrer as primary keys do objeto
    for prop in pks do
    begin
      // pegar o nome do campo
      campo := TAtributosFuncoes.campo<T>(prop);

      // se o campo for igual
      if key.ToUpper = campo.ToUpper then
      begin
        result := true;
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create('TDaoBase.CampoIsPk<T>: ' + E.Message);
  end;
end;

function TDaoBase.AutoIncremento(tabela, campo: string): Integer;
var
  qry: TFDQuery;
  inResult: Integer;
begin
  try

    try
      qry := TFDQuery.Create(nil);
      qry.Connection := FConnection;

      qry.SQL.Clear;
      qry.SQL.Add('SELECT VALOR FROM AUTOINC WHERE CAMPO = ' +
        QuotedStr(campo));
      qry.SQL.Add('      AND  TABELA = ' + QuotedStr(tabela));
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
      begin
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT MAX(' + campo + ') PROX FROM ' + tabela);
        TLog.d(qry);
        qry.Open;

        if qry.IsEmpty or qry.fieldbyName('PROX').IsNull then
          inResult := 1
        else
          inResult := qry.fieldbyName('PROX').AsInteger + 1;

        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('INSERT INTO AUTOINC (CAMPO, VALOR,TABELA ) VALUES (' +
          QuotedStr(campo) + ',' + IntToStr(inResult) + ',' +
          QuotedStr(tabela) + ')');
        TLog.d(qry);
        qry.ExecSQL;
      end
      else
      begin
        if qry.fieldbyName('VALOR').IsNull or
          (qry.fieldbyName('VALOR').AsFloat = 0) then
        begin
          qry.Close;
          qry.SQL.Clear;
          qry.SQL.Add('SELECT MAX(' + campo + ') PROX FROM ' + tabela);
          TLog.d(qry);
          qry.Open;
          inResult := qry.fieldbyName('PROX').AsInteger + 1;
        end
        else
          inResult := qry.fieldbyName('VALOR').AsInteger + 1;

        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('UPDATE AUTOINC SET VALOR = ' + IntToStr(inResult));
        qry.SQL.Add('WHERE CAMPO = ' + QuotedStr(campo));
        qry.SQL.Add('      AND  TABELA = ' + QuotedStr(tabela));
        TLog.d(qry);
        qry.ExecSQL;
      end;

      result := inResult;

    finally
      FreeAndNil(qry);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      raise TDaoException.Create('Falha ao gerar ID: ' + E.Message);
    end;
  end;
end;

constructor TDaoBase.Create(Connection: TFDConnection; aKeepConection: Boolean);
begin
  self.FConnection := Connection;
  FKeepConection := aKeepConection;
end;

function TDaoBase.DataSetToObject<T>(ds: TDataSet): T;
begin

end;

destructor TDaoBase.destroy;
begin
  // TLog.d('>>> Entrando em  TDaoBase.destroy ');

  if FKeepConection = false then
    if Assigned(FConnection) then
    begin
      TLog.d('>>> Entrando em  TDaoBase.destroy FConnection');
      FConnection.Close;
      FreeAndNil(FConnection);
      TLog.d('<<< Saindo de TDaoBase.destroy ');
    end;
  inherited;
  // TLog.d('<<< Saindo de TDaoBase.destroy ');
end;

procedure TDaoBase.EntityToParams(ds: TFDQuery; Entity: TEntity);
var
  context: TRttiContext;
  rType: TRttiType;
  Field: TRttiField;
  method: TRttiMethod;
  prop: TRttiProperty;
  Param: TFDParam;
begin
  context := TRttiContext.Create;
  rType := context.GetType(Entity.ClassInfo);

  for prop in rType.GetProperties do
  begin

    Param := ds.Params.FindParam(prop.Name);
    if Param <> nil then
    begin
      if (CompareText('string', prop.PropertyType.Name)) = 0 then
        Param.AsString := prop.GetValue(Entity).AsString
      else if (CompareText('TDateTime', prop.PropertyType.Name)) = 0 then
        Param.AsDateTime := prop.GetValue(Entity).AsVariant
      else if (CompareText('TDate', prop.PropertyType.Name)) = 0 then
        Param.AsDate := prop.GetValue(Entity).AsVariant
      else if (CompareText('TTime', prop.PropertyType.Name)) = 0 then
        Param.AsTime := prop.GetValue(Entity).AsVariant
      else if (CompareText('Boolean', prop.PropertyType.Name)) = 0 then
        Param.AsBoolean := prop.GetValue(Entity).AsBoolean
      else if (CompareText('Currency', prop.PropertyType.Name)) = 0 then
        Param.AsCurrency := prop.GetValue(Entity).AsCurrency
      else
        Param.Value := prop.GetValue(Entity).AsVariant;
    end;

  end;

end;

procedure TDaoBase.FieldsToEntity(ds: TDataSet; Entity: TEntity);
var
  context: TRttiContext;
  rType: TRttiType;
  method: TRttiMethod;
  prop: TRttiProperty;
  Field: TField;
begin
  context := TRttiContext.Create;
  rType := context.GetType(Entity.ClassInfo);

  for prop in rType.GetProperties do
  begin

    if prop.IsWritable then
    begin
      Field := ds.Fields.FindField(prop.Name);
      if ((Field <> nil ) and (not Field.IsNull)) then
      begin
        if (CompareText('string', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsString)
        else if (CompareText('TDateTime', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsDateTime)
        else if (CompareText('TDate', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsDateTime)
        else if (CompareText('TTime', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsDateTime)
        else if (CompareText('Boolean', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsInteger = 1)
        else if (CompareText('Currency', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsCurrency)
        else if (CompareText('Integer', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsInteger)
        else if (CompareText('Double', prop.PropertyType.Name)) = 0 then
          prop.SetValue(Entity, Field.AsFloat)
        else if (prop.PropertyType.TypeKind = TTypeKind.tkClass) then
          Continue
        else
          prop.SetValue(Entity, TValue.FromVariant(Field.Value));
      end;

    end;
  end;

end;

end.
