unit Dao.TSangriaSuprimento;

interface

uses System.Generics.Collections,
  System.SysUtils, System.Classes, Dominio.Entidades.TFactory,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client, Dao.IDAOTSangriaSuprimento,
  Dao.TDaoBase, Dominio.Entidades.TSangriaSuprimento;

type
  TDaoSangriaSuprimento = class(TDaoBase, IDAOTSangriaSuprimento)

  public

    procedure Inclui(aObj: TSangriaSuprimento);
    procedure Valida(aObj: TSangriaSuprimento);
    function ListaObject(aData: TDate): TObjectList<TSangriaSuprimento>;
  private
    function GeraID: Integer;
  public

    class function New(Connection: TFDConnection): IDAOTSangriaSuprimento;
  end;

implementation

uses
  Util.Exceptions;

{ TDaoCondicaoPagto }

function TDaoSangriaSuprimento.GeraID: Integer;
begin
  Result := AutoIncremento('SANGRIASUPRIMENTO', 'ID');
end;

procedure TDaoSangriaSuprimento.Inclui(aObj: TSangriaSuprimento);

var
  qry: TFDQuery;
begin
  qry := TFactory.Query();
  try
    try
      Valida(aObj);
      aObj.ID := GeraID;

      qry.SQL.Text := ''
        + 'INSERT INTO SANGRIASUPRIMENTO '
        + '            (id, '
        + '             TIPO, '
        + '             HISTORICO, '
        + '             CODVEN, '
        + '             VALOR, '
        + '             FORMA, '
        + '             HORA, '
        + '             DATA ) '
        + 'VALUES      (:id, '
        + '             :TIPO, '
        + '             :HISTORICO, '
        + '             :CODVEN, '
        + '             :VALOR, '
        + '             :FORMA, '
        + '             :HORA, '
        + '             :DATA )';

      EntityToParams(qry, aObj);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha SANGRIA SUPRIMENTO: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TDaoSangriaSuprimento.ListaObject(
  aData: TDate): TObjectList<TSangriaSuprimento>;
var
  qry: TFDQuery;
  LSangriaSuprimento: TSangriaSuprimento;
begin

  qry := TFactory.Query();
  Result := TObjectList<TSangriaSuprimento>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  SANGRIASUPRIMENTO '
        + 'where  '
        + '    DATA = :DATA '
        + 'order by HORA';

      qry.ParamByName('DATA').AsDate := aData;
      qry.open;

      while not qry.Eof do
      begin
        LSangriaSuprimento := TSangriaSuprimento.Create();
        FieldsToEntity(qry, LSangriaSuprimento);
        Result.Add(LSangriaSuprimento);
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar SANGRIASUPRIMENTO: ' + E.Message);
    end;
  end;

end;

class function TDaoSangriaSuprimento.New(
  Connection: TFDConnection): IDAOTSangriaSuprimento;
begin
  Result := TDaoSangriaSuprimento.Create(Connection);
end;

procedure TDaoSangriaSuprimento.Valida(aObj: TSangriaSuprimento);
begin
  if aObj.HISTORICO = '' then
    raise Exception.Create('HISTÓRICO não informado');

  if aObj.Valor <= 0 then
    raise Exception.Create('Valor inválido');
end;

end.
