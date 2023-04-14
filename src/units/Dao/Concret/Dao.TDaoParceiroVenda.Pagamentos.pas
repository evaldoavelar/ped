unit Dao.TDaoParceiroVenda.Pagamentos;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes, Data.DB,
  Dao.TDaoBase, Sistema.TLog, FireDAC.Comp.Client, FireDAC.Stan.Error,
  Dominio.Entidades.TParceiroVenda.Pagamentos,
  Dao.IDoParceiroVenda.Pagamentos;

type

  TDaoParceiroVendaPagto = class(TDaoBase, IDaoParceiroVendaPagto)
    procedure ObjectToParams(ds: TFDQuery; ParceiroVendaPagto: TParceiroVendaPagto);
    function ParamsToObject(ds: TFDQuery): TParceiroVendaPagto;

  public
    procedure ExcluirParceiroVendaPagto(id: Integer);
    procedure IncluiPagto(ParceiroVendaPagtos: TParceiroVendaPagto);
    procedure ValidaParceiroVenda(ParceiroVendaPagto: TParceiroVendaPagto);
    procedure AtualizaParceiroVendaPagtos(ParceiroVendaPagtos: TParceiroVendaPagto);
    function GeTParceiroVendaPagto(seq, idParceiroVenda: Integer): TParceiroVendaPagto;
    function Lista(idParceiroVenda: Integer): TDataSet;
    function ListaObject(idParceiroVenda: Integer): TObjectList<TParceiroVendaPagto>;
    function TotalizadorPorParceiro(codParceiro: string; DataInicio, DataFim: TDate): TDataSet;
  end;

implementation

uses Util.Exceptions;

{ TDaoParceiroVendaPagto }

procedure TDaoParceiroVendaPagto.AtualizaParceiroVendaPagtos(ParceiroVendaPagtos: TParceiroVendaPagto);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update PARCEIROVENDAPAGTO '
        + '  set'
        + '     DESCRICAO = :DESCRICAO, '
        + '     IDPARCEIROFORMAPAGTO = :IDPARCEIROFORMAPAGTO '
        + '     VALORPAGAMENTO = :VALORPAGAMENTO, '
        + '     COMISSAOPERCENTUAL = :COMISSAOPERCENTUAL, '
        + '     COMISSAOVALOR = :COMISSAOVALOR '
        + 'where       '
        + '     SEQ = :SEQ '
        + '     and IDPARCEIROVENDA = :IDPARCEIROVENDA ';

      ValidaParceiroVenda(ParceiroVendaPagtos);
      ObjectToParams(qry, ParceiroVendaPagtos);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaParceiroVendaPagtos: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParceiroVendaPagto.IncluiPagto(ParceiroVendaPagtos: TParceiroVendaPagto);
var
  qry: TFDQuery;
  pagto: TParceiroVendaPagto;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO PARCEIROVENDAPAGTO '
        + '            (SEQ, '
        + '             IDPARCEIROVENDA, '
        + '             DESCRICAO, '
        + '             IDPARCEIROFORMAPAGTO, '
        + '             VALORPAGAMENTO, '
        + '             COMISSAOPERCENTUAL, '
        + '             COMISSAOVALOR '
        + '              ) '
        + 'VALUES      (:SEQ, '
        + '             :IDPARCEIROVENDA, '
        + '             :DESCRICAO, '
        + '             :IDPARCEIROFORMAPAGTO, '
        + '             :VALORPAGAMENTO, '
        + '             :COMISSAOPERCENTUAL, '
        + '             :COMISSAOVALOR '
        + '             )';

      ValidaParceiroVenda(ParceiroVendaPagtos);
      ObjectToParams(qry, ParceiroVendaPagtos);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Inclui PARCEIROVENDAPAGTO: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParceiroVendaPagto.ExcluirParceiroVendaPagto(id: Integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  PARCEIROVENDAPAGTO '
        + 'WHERE '
        + '     SEQ = :SEQ '
        + '     and IDPARCEIROVENDA = :IDPARCEIROVENDA ';

      qry.ParamByName('id').AsInteger := id;
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro não pode ser excluído porque está amarrado a outro registro. (ExcluirParceiroVendaPagto)')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluirParceiroVendaPagto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiroVendaPagto.GeTParceiroVendaPagto(seq, idParceiroVenda: Integer): TParceiroVendaPagto;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PARCEIROVENDAPAGTO '
        + 'where  '
        + '     SEQ = :SEQ '
        + '     and IDPARCEIROVENDA = :IDPARCEIROVENDA ';

      qry.ParamByName('SEQ').AsInteger := seq;
      qry.ParamByName('IDPARCEIROVENDA').AsInteger := idParceiroVenda;
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
        raise TDaoException.Create('Falha GeTParceiroVendaPagto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiroVendaPagto.Lista(idParceiroVenda: Integer): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  PARCEIROVENDAPAGTO '
      + 'where  '
      + '     IDPARCEIROVENDA = :IDPARCEIROVENDA '
      + ' order by SEQ ';
    qry.ParamByName('IDPARCEIROVENDA').AsInteger := idParceiroVenda;
    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar PARCEIROVENDAPAGTO: ' + E.message);
    end;
  end;

end;

function TDaoParceiroVendaPagto.ListaObject(idParceiroVenda: Integer): TObjectList<TParceiroVendaPagto>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  Result := TObjectList<TParceiroVendaPagto>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PARCEIROVENDAPAGTO '
        + 'where  '
        + '     IDPARCEIROVENDA = :IDPARCEIROVENDA '
        + ' order by SEQ ';

      qry.ParamByName('IDPARCEIROVENDA').AsInteger := idParceiroVenda;

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
      raise TDaoException.Create('Falha Listar ParceiroVenda: ' + E.message);
    end;
  end;

end;

procedure TDaoParceiroVendaPagto.ObjectToParams(ds: TFDQuery; ParceiroVendaPagto: TParceiroVendaPagto);
begin
  try
    EntityToParams(ds, ParceiroVendaPagto);

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TParceiroVenda: ' + E.message);
    end;
  end;
end;

function TDaoParceiroVendaPagto.ParamsToObject(ds: TFDQuery): TParceiroVendaPagto;
begin
  try
    Result := TParceiroVendaPagto.Create();
    FieldsToEntity(ds, Result);

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject TFormaPagto: ' + E.message);
    end;
  end;
end;

function TDaoParceiroVendaPagto.TotalizadorPorParceiro(codParceiro: string; DataInicio, DataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'SELECT pc.codparceiro, '
      + '       pc.nome, '
      + '       pg.idparceiroformapagto, '
      + '       pg.descricao, '
      + '       Sum(pg.valorpagamento) venda, '
      + '       Sum(pg.comissaovalor)  comissaovalor '
      + 'FROM   parceirovenda pc '
      + '       JOIN parceirovendapagto pg '
      + '         ON pc.id = pg.idparceirovenda '
      + 'WHERE  ( pc.status IS NULL '
      + '          OR ( pc.status <> ''C'' ) ) '
      + '       and pc.codparceiro = :codparceiro  '
      + '        and data >= :dataInicio '
      + '       AND data <= :dataFim '
      + 'GROUP  BY pc.codparceiro, '
      + '          pc.nome, '
      + '          pg.descricao, '
      + '          pg.idparceiroformapagto '
      + 'ORDER  BY pc.nome, '
      + '          pg.descricao';
    qry.ParamByName('codparceiro').AsString := codParceiro;
    qry.ParamByName('dataInicio').AsDate := DataInicio;
    qry.ParamByName('dataFim').AsDate := DataFim;
    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar TotalizadorPorParceiro: ' + E.message);
    end;
  end;

end;

procedure TDaoParceiroVendaPagto.ValidaParceiroVenda(ParceiroVendaPagto: TParceiroVendaPagto);
begin
  if ParceiroVendaPagto.VALORPAGAMENTO <= 0 then
    raise Exception.Create('O Valor do Pagamento precisa ser maior que zero');

  if ParceiroVendaPagto.DESCRICAO = '' then
    raise Exception.Create('A Descrição do pagamento precisa ser informada');
end;

end.
