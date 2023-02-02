unit Dao.TDaoFormaPagto;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog, Dao.IDaoFormaPagto,
  Dominio.Entidades.TFormaPagto, Dao.TDaoCondicaoPagto, Dao.IDaoCondicaoPagto;

type

  TDaoFormaPagto = class(TDaoBase, IDaoFormaPagto)
  private
    FDaoCondicaoPagto: IDaoCondicaoPagto;
    procedure ObjectToParams(ds: TFDQuery; FormaPagtos: TFormaPagto);
    function ParamsToObject(ds: TFDQuery): TFormaPagto;

  public
    procedure ExcluirFormaPagto(id: Integer);
    procedure IncluiPagto(FormaPagtos: TFormaPagto);
    procedure ValidaForma(FormaPagtos: TFormaPagto);
    procedure AtualizaFormaPagtos(FormaPagtos: TFormaPagto);
    function GeTFormaPagto(id: Integer): TFormaPagto;
    function GeTFormaByDescricao(DESCRICAO: string): TFormaPagto;
    function Lista(): TDataSet;
    function Listar(aDescricao: string): TObjectList<TFormaPagto>; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function ListaObject(): TObjectList<TFormaPagto>;
    function ListaAtivosObject(): TObjectList<TFormaPagto>;
    function GeraID: Integer;
    constructor Create(Connection: TFDConnection; aKeepConection: Boolean); override;
  end;

implementation

{ TDaoFormaPagto }

uses Factory.Dao, Util.Exceptions, Dominio.Entidades.CondicaoPagto;

constructor TDaoFormaPagto.Create(Connection: TFDConnection; aKeepConection: Boolean);
begin
  inherited;

  FDaoCondicaoPagto := TDaoCondicaoPagto.new(Connection, true);
end;

procedure TDaoFormaPagto.ExcluirFormaPagto(id: Integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try

      FDaoCondicaoPagto.ExcluirPorPagamento(id);

      qry.SQL.Text := ''
        + 'delete  '
        + 'from  FORMAPAGTO '
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

procedure TDaoFormaPagto.AtualizaFormaPagtos(FormaPagtos: TFormaPagto);
var
  qry: TFDQuery;
  condicao: TCONDICAODEPAGTO;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update FORMAPAGTO '
        + '  set'
        + '     DESCRICAO = :DESCRICAO, '
        + '     TIPO = :TIPO '
        + 'where       '
        + '     id = :id ';

      ValidaForma(FormaPagtos);
      ObjectToParams(qry, FormaPagtos);

      TLog.d(qry);
      qry.ExecSQL;

      for condicao in FormaPagtos.CONDICAODEPAGTO do
      begin
        condicao.IDPAGTO := FormaPagtos.id;
        case condicao.StatusBD of
          TCONDICAODEPAGTO.TStatusBD.stAdicionado, TCONDICAODEPAGTO.TStatusBD.stCriar:
            FDaoCondicaoPagto.Inclui(condicao);
          TCONDICAODEPAGTO.TStatusBD.stDeletado:
            FDaoCondicaoPagto.Excluir(condicao.id);
          TCONDICAODEPAGTO.TStatusBD.stAtualizar:
            FDaoCondicaoPagto.Atualiza(condicao);
        end;
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaFormaPagtos: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoFormaPagto.GeraID: Integer;
begin
  Result := AutoIncremento('FORMAPAGTO', 'ID');
end;

function TDaoFormaPagto.GeTFormaByDescricao(DESCRICAO: string): TFormaPagto;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
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
        raise TDaoException.Create('Falha GeTFormaPagto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoFormaPagto.GeTFormaPagto(id: Integer): TFormaPagto;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
        + 'where  '
        + '    id = :id ';

      qry.ParamByName('ID').AsInteger := id;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
      begin
        Result := ParamsToObject(qry);
        Result.CONDICAODEPAGTO := FDaoCondicaoPagto.ListaObject(Result.id);
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTFormaPagto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoFormaPagto.IncluiPagto(FormaPagtos: TFormaPagto);
var
  qry: TFDQuery;
  condicao: TCONDICAODEPAGTO;
begin

  if Self.GeTFormaByDescricao(FormaPagtos.DESCRICAO) <> nil then
    raise Exception.Create('Forma de pagamento já existe');

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO FORMAPAGTO '
        + '            (id, '
        + '             DESCRICAO, '
        + '             QUANTASVEZES, '
        + '            TIPO ) '
        + 'VALUES      (:id, '
        + '             :DESCRICAO, '
        + '             :QUANTASVEZES, '
        + '            :TIPO )';

      ValidaForma(FormaPagtos);
      ObjectToParams(qry, FormaPagtos);

      TLog.d(qry);
      qry.ExecSQL;

      for condicao in FormaPagtos.CONDICAODEPAGTO do
      begin
        condicao.IDPAGTO := FormaPagtos.id;
        case condicao.StatusBD of
          TCONDICAODEPAGTO.TStatusBD.stAdicionado, TCONDICAODEPAGTO.TStatusBD.stCriar:
            FDaoCondicaoPagto.Inclui(condicao);
          TCONDICAODEPAGTO.TStatusBD.stDeletado:
            FDaoCondicaoPagto.Excluir(condicao.id);
          TCONDICAODEPAGTO.TStatusBD.stAtualizar:
            FDaoCondicaoPagto.Atualiza(condicao);
        end;
      end;

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

function TDaoFormaPagto.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  FORMAPAGTO '
      + 'WHERE '
      + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + 'order by DESCRICAO';

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

function TDaoFormaPagto.Lista: TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  FORMAPAGTO '
      + 'order by DESCRICAO';

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

function TDaoFormaPagto.ListaAtivosObject: TObjectList<TFormaPagto>;
var
  qry: TFDQuery;
  pagto: TFormaPagto;
begin

  qry := Self.Query();
  Result := TObjectList<TFormaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
        + 'where ativo = 1 '
        + 'order by DESCRICAO';

      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        pagto := ParamsToObject(qry);
        pagto.CONDICAODEPAGTO := FDaoCondicaoPagto.ListaObject(pagto.id);
        Result.Add(pagto);
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

function TDaoFormaPagto.ListaObject: TObjectList<TFormaPagto>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  Result := TObjectList<TFormaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
        + 'order by DESCRICAO';

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

function TDaoFormaPagto.Listar(aDescricao: string): TObjectList<TFormaPagto>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  Result := TObjectList<TFormaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  FORMAPAGTO '
        + ' where UPPER( DESCRICAO ) like UPPER( ' + QuotedStr('%' + aDescricao + '%') + ')'
        + 'order by DESCRICAO';

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

procedure TDaoFormaPagto.ObjectToParams(ds: TFDQuery; FormaPagtos: TFormaPagto);
begin
  try
    EntityToParams(ds, FormaPagtos);

    // if ds.Params.FindParam('ID') <> nil then
    // ds.Params.ParamByName('ID').AsInteger := FormaPagtos.id;
    // if ds.Params.FindParam('DESCRICAO') <> nil then
    // ds.Params.ParamByName('DESCRICAO').AsString := FormaPagtos.DESCRICAO;
    // if ds.Params.FindParam('QUANTASVEZES') <> nil then
    // ds.Params.ParamByName('QUANTASVEZES').AsInteger := FormaPagtos.QUANTASVEZES;
    // if ds.Params.FindParam('JUROS') <> nil then
    // ds.Params.ParamByName('JUROS').AsCurrency := FormaPagtos.JUROS;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TFormaPagto: ' + E.message);
    end;
  end;
end;

function TDaoFormaPagto.ParamsToObject(ds: TFDQuery): TFormaPagto;
begin
  try
    Result := TFormaPagto.Create();
    FieldsToEntity(ds, Result);

    // Result.id := ds.FieldByName('ID').AsInteger;
    // Result.DESCRICAO := ds.FieldByName('DESCRICAO').AsString;
    // Result.QUANTASVEZES := ds.FieldByName('QUANTASVEZES').AsInteger;
    // Result.JUROS := ds.FieldByName('JUROS').AsCurrency;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject TFormaPagto: ' + E.message);
    end;
  end;
end;

procedure TDaoFormaPagto.ValidaForma(FormaPagtos: TFormaPagto);
begin
  if FormaPagtos.DESCRICAO = '' then
    raise Exception.Create('Descrição do Pagamento não informado');

end;

end.
