unit Dao.TDaoParceiro;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Error, System.Generics.Collections,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog, Dao.IDaoParceiro,
  Dominio.Entidades.TParceiro;

type

  TDaoParceiro = class(TDaoBase, IDaoParceiro)
  private
    procedure ObjectToParams(ds: TFDQuery; Parceiro: TParceiro);
    function ParamsToObject(ds: TFDQuery): TParceiro;

  public
    procedure ExcluirParceiro(codigo: string);
    procedure IncluiParceiro(Parceiro: TParceiro);
    procedure ValidaParceiro(Parceiro: TParceiro);
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(aNome: string): TObjectList<TParceiro>; overload;
    function Listar(): TList<TParceiro>; overload;
    function ListarAtivos(): TObjectList<TParceiro>; overload;
    procedure AtualizaParceiro(Parceiro: TParceiro);
    function GetParceiro(idpedido: Integer): TParceiro; overload;
    function GetParceiro(codigo: string): TParceiro; overload;
    function GetParceirobyNome(nome: string): TParceiro;

    function GeraID: string;
  end;

implementation

uses
  Util.Exceptions, Dominio.Entidades.TFactory;

{ TDaoParceiro }

procedure TDaoParceiro.ExcluirParceiro(codigo: string);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  Parceiro '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro não pode ser excluído porque está amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluirParceiro: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParceiro.AtualizaParceiro(Parceiro: TParceiro);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update Parceiro '
        + '  set'
        + '     NOME = :NOME, '
        + '     INATIVO = :INATIVO '
        + 'where       '
        + '     CODIGO = :CODIGO ';

      ValidaParceiro(Parceiro);
      ObjectToParams(qry, Parceiro);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaParceiro: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiro.GeraID: string;
begin
  Result := Format('%.3d', [AutoIncremento('Parceiro', 'CODIGO')]);
end;

function TDaoParceiro.GetParceiro(codigo: string): TParceiro;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Parceiro '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetParceiro: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiro.GetParceiro(idpedido: Integer): TParceiro;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Parceiro '
        + 'WHERE '
        + '     idpedido = :idpedido';

      qry.ParamByName('idpedido').AsInteger := idpedido;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetParceiro: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiro.GetParceirobyNome(nome: string): TParceiro;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Parceiro '
        + 'WHERE '
        + '     NOME = :NOME';

      qry.ParamByName('NOME').AsString := nome;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ao GetParceirobyNome: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParceiro.IncluiParceiro(Parceiro: TParceiro);
var
  qry: TFDQuery;
begin

  if Self.GetParceirobyNome(Parceiro.nome) <> nil then
    raise Exception.Create('Parceiro Já existe já existe');

  Parceiro.codigo := Self.GeraID;

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO  Parceiro '
        + '            (CODIGO, '
        + '             NOME,  '
        + '             INATIVO) '
        + 'VALUES      (:CODIGO, '
        + '             :NOME,'
        + '             :INATIVO)';

      ValidaParceiro(Parceiro);
      ObjectToParams(qry, Parceiro);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha IncluiParceiro: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiro.Listar: TList<TParceiro>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  Result := TList<TParceiro>.Create();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   Parceiro '
      + 'order by NOME';

    TLog.d(qry);
    qry.Open;

    while not qry.Eof do
    begin
      Result.Add(ParamsToObject(qry));
      qry.Next;
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Parceiro: ' + E.message);
    end;
  end;

end;

function TDaoParceiro.Listar(aNome: string): TObjectList<TParceiro>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  Result := TObjectList<TParceiro>.Create();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   Parceiro '
      + ' UPPER( NOME) like  UPPER( :NOME ) '
      + ' order by nome ';

    if Length(aNome) > 60 then
      aNome := copy(aNome, 0, 60);

    qry.ParamByName('NOME').AsString := aNome + '%';
    TLog.d(qry);
    qry.Open;

    while not qry.Eof do
    begin
      Result.Add(ParamsToObject(qry));
      qry.Next;
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Parceiro: ' + E.message);
    end;
  end;

end;

function TDaoParceiro.ListarAtivos: TObjectList<TParceiro>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  Result := TObjectList<TParceiro>.Create();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   Parceiro '
      + 'where (inativo <> 1 or inativo is null)'
      + 'order by NOME';

    TLog.d(qry);
    qry.Open;

    while not qry.Eof do
    begin
      Result.Add(ParamsToObject(qry));
      qry.Next;
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Parceiro: ' + E.message);
    end;
  end;

end;

function TDaoParceiro.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   Parceiro '
      + 'WHERE '
      + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + 'order by NOME';

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Parceiro: ' + E.message);
    end;
  end;

end;

procedure TDaoParceiro.ObjectToParams(ds: TFDQuery; Parceiro: TParceiro);
begin
  try

    EntityToParams(ds, Parceiro);
    // ds.Params.ParamByName('PODEACESSARCADASTROParceiro').AsBoolean := Parceiro.PODEACESSARCADASTROParceiro;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TDaoParceiro: ' + E.message);
    end;
  end;
end;

function TDaoParceiro.ParamsToObject(ds: TFDQuery): TParceiro;
begin
  try
    Result := TParceiro.Create();
    FieldsToEntity(ds, Result);

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject: ' + E.message);
    end;
  end;

end;

procedure TDaoParceiro.ValidaParceiro(Parceiro: TParceiro);
begin
  if Trim(Parceiro.nome) = '' then
    raise Exception.Create('Nome não informado');
end;

end.
