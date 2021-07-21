unit Dao.TDaoBase;

interface

uses
  System.Rtti,
  System.SysUtils, System.Classes,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param,
  Dominio.Entidades.TEntity;

type

  TDaoBase = class(TInterfacedObject)

  protected
    FConnection: TFDConnection;
    function DataSetToObject<T: class>(ds: TDataSet): T;
    function AutoIncremento(tabela, campo: string): Integer;
    procedure EntityToParams(ds: TFDQuery; Entity: TEntity); virtual;
    procedure FieldsToEntity(ds: TDataSet; Entity: TEntity); virtual;
  public

    constructor Create(Connection: TFDConnection);virtual;
  end;

implementation

uses
  Util.Exceptions;

{ TDaoBase }

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
      qry.SQL.Add('SELECT VALOR FROM AUTOINC WHERE CAMPO = ' + QuotedStr(campo));
      qry.SQL.Add('      AND  TABELA = ' + QuotedStr(tabela));
      qry.Open;
      if qry.IsEmpty then
      begin
        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('SELECT MAX(' + campo + ') PROX FROM ' + tabela);
        qry.Open;

        if qry.IsEmpty or  qry.FieldByName('PROX').IsNull then
          inResult := 1
        else
          inResult := qry.FieldByName('PROX').AsInteger + 1;

        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('INSERT INTO AUTOINC (CAMPO, VALOR,TABELA ) VALUES (' + QuotedStr(campo) + ',' + IntToStr(inResult) + ',' + QuotedStr(tabela) + ')');
        qry.ExecSQL;
      end
      else
      begin
        if qry.FieldByName('VALOR').IsNull or
          (qry.FieldByName('VALOR').AsFloat = 0) then
        begin
          qry.Close;
          qry.SQL.Clear;
          qry.SQL.Add('SELECT MAX(' + campo + ') PROX FROM ' + tabela);
          qry.Open;
          inResult := qry.FieldByName('PROX').AsInteger + 1;
        end
        else
          inResult := qry.FieldByName('VALOR').AsInteger + 1;

        qry.Close;
        qry.SQL.Clear;
        qry.SQL.Add('UPDATE AUTOINC SET VALOR = ' + IntToStr(inResult));
        qry.SQL.Add('WHERE CAMPO = ' + QuotedStr(campo));
        qry.SQL.Add('      AND  TABELA = ' + QuotedStr(tabela));
        qry.ExecSQL;
      end;

      Result := inResult;

    finally
      FreeAndNil(qry);
    end;
  except
    on E: Exception do
      raise TDaoException.Create('Falha ao gerar ID: ' + E.Message);
  end;
end;

constructor TDaoBase.Create(Connection: TFDConnection);
begin
  self.FConnection := Connection;
end;

function TDaoBase.DataSetToObject<T>(ds: TDataSet): T;
begin

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
  // for field in rType.GetFields do
  // ;//do something here
  // for method in rType.GetMethods do
  // ;//do something here
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

      // Param.Value := prop.GetValue(Entity).AsVariant;

      // case prop.PropertyType.TypeKind of
      // tkUnknown:
      // ds.Params.ParamByName(prop.Name).Value := prop.GetValue(Entity).AsVariant;
      // tkInteger:
      // ds.Params.ParamByName(prop.Name).AsInteger := prop.GetValue(Entity).AsInteger;
      // tkChar:
      // ds.Params.ParamByName(prop.Name).AsString := prop.GetValue(Entity).AsString;
      // tkEnumeration:
      // ds.Params.ParamByName(prop.Name).Value := prop.GetValue(Entity).AsVariant;
      // tkFloat:
      // ds.Params.ParamByName(prop.Name).AsFloat := prop.GetValue(Entity).AsVariant;
      // tkString:
      // prop.SetValue(Entity, TValue.From(''));
      // tkSet:
      // raise Exception.Create('Tipo Não Suportado');
      // tkClass:
      // raise Exception.Create('Tipo Não Suportado');
      // tkMethod:
      // raise Exception.Create('Tipo Não Suportado');
      // tkWChar:
      // ds.Params.ParamByName(prop.Name).AsString := prop.GetValue(Entity).AsString;
      // tkLString:
      // ds.Params.ParamByName(prop.Name).AsString := prop.GetValue(Entity).AsString;
      // tkWString:
      // ds.Params.ParamByName(prop.Name).AsString := prop.GetValue(Entity).AsString;
      // tkVariant:
      // ds.Params.ParamByName(prop.Name).Value := prop.GetValue(Entity).AsVariant;
      // tkArray:
      // raise Exception.Create('Tipo Não Suportado');
      // tkRecord:
      // raise Exception.Create('Tipo Não Suportado');
      // tkInterface:
      // raise Exception.Create('Tipo Não Suportado');
      // tkInt64:
      // ds.Params.ParamByName(prop.Name).AsInteger := prop.GetValue(Entity).AsInt64;
      // tkDynArray:
      // raise Exception.Create('Tipo Não Suportado');
      // tkUString:
      // ds.Params.ParamByName(prop.Name).AsString := prop.GetValue(Entity).AsString;
      // tkClassRef:
      // raise Exception.Create('Tipo Não Suportado');
      // tkPointer:
      // raise Exception.Create('Tipo Não Suportado');
      // tkProcedure:
      // raise Exception.Create('Tipo Não Suportado');
      // end;
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
      if Field <> nil then
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
        else
          prop.SetValue(Entity, TValue.FromVariant(Field.Value));
      end;

    end;
  end;

end;

end.
