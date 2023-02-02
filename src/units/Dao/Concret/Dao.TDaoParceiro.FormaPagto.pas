unit Dao.TDaoParceiro.FormaPagto;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog, Dao.IDaoParceiro.FormaPagto,
  Dominio.Entidades.TParceiro.FormaPagto;

type

  TDaoParceiroFormaPagto = class(TDaoBase, IDaoParceiroFormaPagto)
  private
    procedure ObjectToParams(ds: TFDQuery; ParceiroFormaPagtos: TParceiroFormaPagto);
    function ParamsToObject(ds: TFDQuery): TParceiroFormaPagto;

  public
    procedure ExcluirParceiroFormaPagto(id: Integer);
    procedure IncluiPagto(ParceiroFormaPagtos: TParceiroFormaPagto);
    procedure ValidaForma(ParceiroFormaPagtos: TParceiroFormaPagto);
    procedure AtualizaParceiroFormaPagtos(ParceiroFormaPagtos: TParceiroFormaPagto);
    function GeTParceiroFormaPagto(id: Integer): TParceiroFormaPagto;
    function GeTFormaByDescricao(DESCRICAO: string): TParceiroFormaPagto;
    function Lista(): TDataSet;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(aNome: string): TObjectList<TParceiroFormaPagto>; overload;
    function ListaObject(): TObjectList<TParceiroFormaPagto>; overload;
    function ListarAtivasObject(): TObjectList<TParceiroFormaPagto>; overload;
    function GeraID: Integer;

  end;

implementation

{ TDaoParceiroFormaPagto }

uses Factory.Dao, Util.Exceptions;

procedure TDaoParceiroFormaPagto.ExcluirParceiroFormaPagto(id: Integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  PARCEIROFORMAPAGTO '
        + 'WHERE '
        + '     id = :id';

      qry.ParamByName('id').AsInteger := id;
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
        raise TDaoException.Create('Falha ExcluirCliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParceiroFormaPagto.AtualizaParceiroFormaPagtos(ParceiroFormaPagtos: TParceiroFormaPagto);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update PARCEIROFORMAPAGTO '
        + '  set'
        + '     DESCRICAO = :DESCRICAO, '
        + '     COMISSAOPERCENTUAL = :COMISSAOPERCENTUAL '
        + 'where       '
        + '     id = :id ';

      ValidaForma(ParceiroFormaPagtos);
      ObjectToParams(qry, ParceiroFormaPagtos);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaParceiroFormaPagtos: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiroFormaPagto.GeraID: Integer;
begin
  Result := AutoIncremento('ParceiroFormaPagto', 'ID');
end;

function TDaoParceiroFormaPagto.GeTFormaByDescricao(DESCRICAO: string): TParceiroFormaPagto;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PARCEIROFORMAPAGTO '
        + 'where  '
        + '    DESCRICAO = :DESCRICAO ';

      qry.ParamByName('DESCRICAO').AsString := DESCRICAO;
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
        raise TDaoException.Create('Falha GeTParceiroFormaPagto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiroFormaPagto.GeTParceiroFormaPagto(id: Integer): TParceiroFormaPagto;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PARCEIROFORMAPAGTO '
        + 'where  '
        + '    id = :id ';

      qry.ParamByName('ID').AsInteger := id;
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
        raise TDaoException.Create('Falha GeTParceiroFormaPagto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParceiroFormaPagto.IncluiPagto(ParceiroFormaPagtos: TParceiroFormaPagto);
var
  qry: TFDQuery;
begin

  if Self.GeTFormaByDescricao(ParceiroFormaPagtos.DESCRICAO) <> nil then
    raise Exception.Create('Forma de pagamento já existe');

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO ParceiroFormaPagto '
        + '            (id, '
        + '             DESCRICAO, '
        + '            COMISSAOPERCENTUAL) '
        + 'VALUES      (:id, '
        + '             :DESCRICAO, '
        + '            :COMISSAOPERCENTUAL )';

      ValidaForma(ParceiroFormaPagtos);
      ObjectToParams(qry, ParceiroFormaPagtos);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Pagamento Cliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiroFormaPagto.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  ParceiroFormaPagto '
      + 'WHERE '
      + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + 'order by descricao';

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;

end;

function TDaoParceiroFormaPagto.Listar(
  aNome: string): TObjectList<TParceiroFormaPagto>;
var
  qry: TFDQuery;
begin
  qry := Self.Query();
  Result := TObjectList<TParceiroFormaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  ParceiroFormaPagto '
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
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;

end;

function TDaoParceiroFormaPagto.ListarAtivasObject: TObjectList<TParceiroFormaPagto>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  Result := TObjectList<TParceiroFormaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  ParceiroFormaPagto '
        + 'where ativo = 1 '
        + 'order by descricao';

      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;

end;

function TDaoParceiroFormaPagto.Lista: TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  ParceiroFormaPagto '
      + 'order by descricao';

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;
end;

function TDaoParceiroFormaPagto.ListaObject: TObjectList<TParceiroFormaPagto>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  Result := TObjectList<TParceiroFormaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  ParceiroFormaPagto '
        + 'order by descricao';

      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;

end;

procedure TDaoParceiroFormaPagto.ObjectToParams(ds: TFDQuery; ParceiroFormaPagtos: TParceiroFormaPagto);
begin
  try
    EntityToParams(ds, ParceiroFormaPagtos);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TParceiroFormaPagto: ' + E.message);
    end;
  end;
end;

function TDaoParceiroFormaPagto.ParamsToObject(ds: TFDQuery): TParceiroFormaPagto;
begin
  try
    Result := TParceiroFormaPagto.Create();
    FieldsToEntity(ds, Result);

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject TParceiroFormaPagto: ' + E.message);
    end;
  end;
end;

procedure TDaoParceiroFormaPagto.ValidaForma(ParceiroFormaPagtos: TParceiroFormaPagto);
begin
  if ParceiroFormaPagtos.DESCRICAO = '' then
    raise Exception.Create('Descrição do Pagamento não informado');

  if ParceiroFormaPagtos.COMISSAOPERCENTUAL < 0 then
    raise Exception.Create('Valor inválido para comissão');

end;

end.
