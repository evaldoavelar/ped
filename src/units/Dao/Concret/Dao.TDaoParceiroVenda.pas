unit Dao.TDaoParceiroVenda;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog, Dao.IDaoParceiroVenda,
  Dominio.Entidades.TParceiroVenda,
  Dominio.Entidades.TParceiroVenda.Pagamentos,
  Dao.IDoParceiroVenda.Pagamentos;

type

  TDaoParceiroVenda = class(TDaoBase, IDaoParceiroVenda)
  private
    FDaoParceiroVendaPagto: IDaoParceiroVendaPagto;
    procedure ObjectToParams(ds: TFDQuery; ParceiroVendas: TParceiroVenda);
    function ParamsToObject(ds: TFDQuery): TParceiroVenda;
    procedure ValidaParceiroVenda(ParceiroVendas: TParceiroVenda);
  public
    procedure ExcluirParceiroVenda(id: Integer);
    procedure IncluiPagto(ParceiroVendas: TParceiroVenda);
    procedure AtualizaParceiroVendas(ParceiroVendas: TParceiroVenda);
    function GeTParceiroVenda(id: Integer): TParceiroVenda;
    function Lista(): TDataSet; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(campo, valor: string; dataInicio, dataFim: TDate): TDataSet; overload;
    function Listar(dataInicio, dataFim: TDate): TDataSet; overload;
    function ListaObject(): TObjectList<TParceiroVenda>;
    function GeraID: Integer;

    constructor Create(Connection: TFDConnection); override;
  end;

implementation

uses Dominio.Entidades.TFactory, Util.Exceptions;

{ TDaoParceiroVenda }

procedure TDaoParceiroVenda.AtualizaParceiroVendas(ParceiroVendas: TParceiroVenda);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update PARCEIROVENDA '
        + '  set'
        + '     CODPARCEIRO = :CODPARCEIRO, '
        + '     NOME = :NOME, '
        + '     IDPEDIDO = :IDPEDIDO, '
        + '     DATA = :DATA, '
        + '     CODVEN = :CODVEN, '
        + '     TOTALCOMISSAO = :TOTALCOMISSAO, '
        + '     TOTALPAGAMENTO = :TOTALPAGAMENTO, '
        + '     STATUS = :STATUS, '
        + '     CODVENCANCELAMENTO = :CODVENCANCELAMENTO, '
        + '     DATACANCELAMENTO = :DATACANCELAMENTO '
        + 'where       '
        + '     id = :id ';

      ValidaParceiroVenda(ParceiroVendas);
      ObjectToParams(qry, ParceiroVendas);

      TLog.d(qry);
      qry.ExecSQL;

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

procedure TDaoParceiroVenda.IncluiPagto(ParceiroVendas: TParceiroVenda);
var
  qry: TFDQuery;
  pagto: TParceiroVendaPagto;
begin

  qry := TFactory.Query();
  try
    TFactory.Conexao().StartTransaction;
    try
      qry.SQL.Text := ''
        + 'INSERT INTO PARCEIROVENDA '
        + '            (id, '
        + '             CODPARCEIRO, '
        + '             NOME, '
        + '             DATA, '
        + '             CODVEN, '
        + '             TOTALCOMISSAO, '
        + '             TOTALPAGAMENTO, '
        + '             STATUS, '
        + '             IDPEDIDO ) '
        + 'VALUES      (:id, '
        + '             :CODPARCEIRO, '
        + '             :NOME, '
        + '             :DATA, '
        + '             :CODVEN, '
        + '             :TOTALCOMISSAO, '
        + '             :TOTALPAGAMENTO, '
        + '             :STATUS, '
        + '             :IDPEDIDO )';

      ValidaParceiroVenda(ParceiroVendas);
      ParceiroVendas.id := self.GeraID;
      ObjectToParams(qry, ParceiroVendas);

      TLog.d(qry);
      qry.ExecSQL;

      for pagto in ParceiroVendas.Pagamentos do
      begin
        FDaoParceiroVendaPagto.IncluiPagto(pagto);
      end;

      TFactory.Conexao().Commit;

    except
      on E: Exception do
      begin
        TFactory.Conexao().Rollback;
        TLog.d(E.message);
        raise TDaoException.Create('Falha Inclui Pagto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

constructor TDaoParceiroVenda.Create(Connection: TFDConnection);
begin
  inherited;

  self.FDaoParceiroVendaPagto := TFactory.DaoParceiroVendaPagto;
end;

procedure TDaoParceiroVenda.ExcluirParceiroVenda(id: Integer);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  PARCEIROVENDA '
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
        raise TDaoException.Create('Falha ExcluirParceiroVenda: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiroVenda.GeraID: Integer;
begin
  Result := AutoIncremento('PARCEIROVENDA', 'ID');
end;

function TDaoParceiroVenda.GeTParceiroVenda(id: Integer): TParceiroVenda;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PARCEIROVENDA '
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
        raise TDaoException.Create('Falha GeTParceiroVenda: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParceiroVenda.Lista: TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  PARCEIROVENDA '
      + 'order by id';

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar ParceiroVenda: ' + E.message);
    end;
  end;

end;

function TDaoParceiroVenda.ListaObject: TObjectList<TParceiroVenda>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  Result := TObjectList<TParceiroVenda>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PARCEIROVENDA '
        + 'order by id';

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

function TDaoParceiroVenda.Listar(campo, valor: string; dataInicio,
  dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT * '
      + 'FROM   PARCEIROVENDA '
      + 'WHERE   '
      + '       data >= :dataInicio '
      + '       AND data <= :dataFim ';

    if valor <> '' then
      qry.SQL.Add(' and upper( ' + campo + ') LIKE ' + QuotedStr(UpperCase(valor) + '%'));

    qry.SQL.Add(' order by id');

    qry.ParamByName('dataInicio').AsDate := dataInicio;
    qry.ParamByName('dataFim').AsDate := dataFim;

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar ParceiroVenda: ' + E.message);
    end;
  end;

end;

function TDaoParceiroVenda.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  PARCEIROVENDA '
      + 'WHERE '
      + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + 'order by id';

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

procedure TDaoParceiroVenda.ObjectToParams(ds: TFDQuery; ParceiroVendas: TParceiroVenda);
begin
  try
    EntityToParams(ds, ParceiroVendas);

    if (ds.Params.FindParam('CODVEN') <> nil) and (ParceiroVendas.Vendedor <> nil) then
      ds.Params.ParamByName('CODVEN').AsString := ParceiroVendas.Vendedor.CODIGO;

    if (ds.Params.FindParam('CODPARCEIRO') <> nil) and (ParceiroVendas.Parceiro <> nil) then
      ds.Params.ParamByName('CODPARCEIRO').AsString := ParceiroVendas.Parceiro.CODIGO;

    if (ds.Params.FindParam('IDPEDIDO') <> nil) and (ParceiroVendas.IDPEDIDO = 0) then
      ds.Params.ParamByName('IDPEDIDO').Clear;

    if (ds.Params.FindParam('CODVENCANCELAMENTO') <> nil) and (ParceiroVendas.VendedorCancelamento <> nil) then
      ds.Params.ParamByName('CODVENCANCELAMENTO').AsString := ParceiroVendas.VendedorCancelamento.CODIGO;


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
      raise TDaoException.Create('Falha ao associar parâmetros TParceiroVenda: ' + E.message);
    end;
  end;
end;

function TDaoParceiroVenda.ParamsToObject(ds: TFDQuery): TParceiroVenda;
begin
  try
    Result := TParceiroVenda.Create();
    FieldsToEntity(ds, Result);
    if (ds.FieldByName('CODVEN').IsNull = False) or (ds.FieldByName('CODVEN').AsString <> '') then
      Result.Vendedor := TFactory.DaoVendedor.GetVendedor(ds.FieldByName('CODVEN').AsString);

    if (ds.FieldByName('CODPARCEIRO').IsNull = False) or (ds.FieldByName('CODPARCEIRO').AsString <> '') then
      Result.Parceiro := TFactory.DaoParceiro.GetParceiro(ds.FieldByName('CODPARCEIRO').AsString);

    Result.Pagamentos.AddRange(FDaoParceiroVendaPagto.ListaObject(Result.id));

    // Result.id := ds.FieldByName('ID').AsInteger;
    // Result.DESCRICAO := ds.FieldByName('DESCRICAO').AsString;
    // Result.QUANTASVEZES := ds.FieldByName('QUANTASVEZES').AsInteger;
    // Result.JUROS := ds.FieldByName('JUROS').AsCurrency;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject TParceiroVenda: ' + E.message);
    end;
  end;
end;

procedure TDaoParceiroVenda.ValidaParceiroVenda(ParceiroVendas: TParceiroVenda);
begin
  if ParceiroVendas.Parceiro = nil then
    raise Exception.Create('Parceiro não informado!');

end;

function TDaoParceiroVenda.Listar(dataInicio, dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT * '
      + 'FROM   PARCEIROVENDA '
      + 'WHERE   '
      + '       data >= :dataInicio '
      + '       AND data <= :dataFim ';

    qry.SQL.Add(' order by id');

    qry.ParamByName('dataInicio').AsDate := dataInicio;
    qry.ParamByName('dataFim').AsDate := dataFim;

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar ParceiroVenda: ' + E.message);
    end;
  end;

end;

end.
