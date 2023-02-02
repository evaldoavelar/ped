unit Dao.TDaoItemOrcamento;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TItemOrcamento;

type

  TDaoItemOrcamento = class(TDaoBase)
  private
    procedure ObjectToParams(ds: TFDQuery; ItemOrcamento: TItemOrcamento);
    function ParamsToObject(ds: TFDQuery): TItemOrcamento;
    procedure ValidaItem(ItemOrcamento: TItemOrcamento);
  public
    procedure IncluiItemOrcamento(ItemOrcamento: TItemOrcamento);
    procedure ExcluiItemOrcamento(SEQ, IDOrcamento: Integer);
    procedure AtualizaItemOrcamento(ItemOrcamento: TItemOrcamento);
    function GeTItemOrcamento(SEQ, IDOrcamento: Integer): TItemOrcamento;
    function GeTItemsOrcamento(IDOrcamento: Integer): TObjectList<TItemOrcamento>;
    function GeraID: Integer;
  end;

implementation

uses
  Util.Exceptions, Factory.Dao, Dao.TDaoProdutos;

{ TDaoVendedor }

procedure TDaoItemOrcamento.AtualizaItemOrcamento(ItemOrcamento: TItemOrcamento);
begin

end;

procedure TDaoItemOrcamento.ExcluiItemOrcamento(SEQ, IDOrcamento: Integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  ItemOrcamento '
        + 'WHERE '
        + '     SEQ = :SEQ'
        + '     and IDOrcamento = :IDOrcamento';

      qry.ParamByName('SEQ').AsInteger := SEQ;
      qry.ParamByName('IDOrcamento').AsInteger := IDOrcamento;
      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluiItemOrcamento: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoItemOrcamento.GeraID: Integer;
begin

end;

function TDaoItemOrcamento.GeTItemOrcamento(SEQ, IDOrcamento: Integer): TItemOrcamento;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  ItemOrcamento '
        + 'WHERE '
        + '     SEQ = :SEQ'
        + '     and IDOrcamento = :IDOrcamento';

      qry.ParamByName('SEQ').AsInteger := SEQ;
      qry.ParamByName('IDOrcamento').AsInteger := IDOrcamento;
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
        raise TDaoException.Create('Falha GeTItemOrcamento: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoItemOrcamento.GeTItemsOrcamento(IDOrcamento: Integer): TObjectList<TItemOrcamento>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try

    try
      Result := TObjectList<TItemOrcamento>.Create();

      qry.SQL.Text := ''
        + 'select *  '
        + 'from  ItemOrcamento '
        + 'WHERE '
        + '     IDOrcamento = :IDOrcamento';

      qry.ParamByName('IDOrcamento').AsInteger := IDOrcamento;
      TLog.d(qry);
      qry.Open;

      while not qry.eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.Next;
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTItemsOrcamento: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoItemOrcamento.IncluiItemOrcamento(ItemOrcamento: TItemOrcamento);
var
  qry: TFDQuery;
begin
  ValidaItem(ItemOrcamento);

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'INSERT INTO ITEMOrcamento '
      + '            (SEQ, '
      + '             IDOrcamento, '
      + '             CODPRODUTO, '
      + '             DESCRICAO, '
      + '             UND, '
      + '             QTD, '
      + '             VALOR_UNITA, '
      + '             VALOR_DESCONTO, '
      + '             VALOR_LIQUIDO, '
      + '             VALOR_BRUTO) '
      + 'VALUES      ( :SEQ, '
      + '              :IDOrcamento, '
      + '              :CODPRODUTO, '
      + '              :DESCRICAO, '
      + '              :UND, '
      + '              :QTD, '
      + '              :VALOR_UNITA, '
      + '              :VALOR_DESCONTO, '
      + '              :VALOR_LIQUIDO, '
      + '              :VALOR_BRUTO)';

    ObjectToParams(qry, ItemOrcamento);

    try

      FConnection.StartTransaction;
      TLog.d(qry);
      qry.ExecSQL;

      FConnection.Commit;
    except
      on E: Exception do
      begin
        FConnection.Rollback;
        TLog.d(E.message);
        raise TDaoException.Create('Falha ao Gravar TItemOrcamento: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoItemOrcamento.ObjectToParams(ds: TFDQuery; ItemOrcamento: TItemOrcamento);
begin
  try
    EntityToParams(ds, ItemOrcamento);
    // if ds.Params.FindParam('SEQ') <> nil then
    // ds.Params.ParamByName('SEQ').AsInteger := ItemOrcamento.SEQ;
    // if ds.Params.FindParam('IDOrcamento') <> nil then
    // ds.Params.ParamByName('IDOrcamento').AsInteger := ItemOrcamento.IDOrcamento;
    // if ds.Params.FindParam('CODPRODUTO') <> nil then
    // ds.Params.ParamByName('CODPRODUTO').AsString := ItemOrcamento.CODPRODUTO;
    // if ds.Params.FindParam('DESCRICAO') <> nil then
    // ds.Params.ParamByName('DESCRICAO').AsString := ItemOrcamento.DESCRICAO;
    // if ds.Params.FindParam('UND') <> nil then
    // ds.Params.ParamByName('UND').AsString := ItemOrcamento.UND;
    // if ds.Params.FindParam('QTD') <> nil then
    // ds.Params.ParamByName('QTD').AsCurrency := ItemOrcamento.QTD;
    // if ds.Params.FindParam('VALOR_UNITA') <> nil then
    // ds.Params.ParamByName('VALOR_UNITA').AsCurrency := ItemOrcamento.VALOR_UNITA;
    // if ds.Params.FindParam('VALOR_DESCONTO') <> nil then
    // ds.Params.ParamByName('VALOR_DESCONTO').AsCurrency := ItemOrcamento.VALOR_DESCONTO;
    // if ds.Params.FindParam('VALOR_TOTAL') <> nil then
    // ds.Params.ParamByName('VALOR_TOTAL').AsCurrency := ItemOrcamento.VALOR_TOTAL;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TItemOrcamento: ' + E.message);
    end;
  end;
end;

function TDaoItemOrcamento.ParamsToObject(ds: TFDQuery): TItemOrcamento;
begin
  try

    Result := TItemOrcamento.Create();
    FieldsToEntity(ds, Result);

    // Result.SEQ := ds.FieldByName('SEQ').AsInteger;
    // Result.IDOrcamento := ds.FieldByName('SEQ').AsInteger;
    // Result.CODPRODUTO := ds.FieldByName('CODPRODUTO').AsString;
    // Result.DESCRICAO := ds.FieldByName('DESCRICAO').AsString;
    // Result.UND := ds.FieldByName('UND').AsString;;
    // Result.QTD := ds.FieldByName('QTD').AsFloat;
    // Result.VALOR_UNITA := ds.FieldByName('VALOR_UNITA').AsCurrency;
    // Result.VALOR_DESCONTO := ds.FieldByName('VALOR_DESCONTO').AsCurrency;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject ItemOrcamento: ' + E.message);
    end;
  end;

end;

procedure TDaoItemOrcamento.ValidaItem(ItemOrcamento: TItemOrcamento);
begin
  if ItemOrcamento.VALOR_BRUTO <= 0 then
    raise TValidacaoException.Create('O valor total do Item está zerado');
end;

end.
