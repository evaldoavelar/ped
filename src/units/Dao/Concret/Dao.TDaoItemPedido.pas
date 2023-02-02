unit Dao.TDaoItemPedido;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TItemPedido;

type

  TDaoItemPedido = class(TDaoBase)
  private
    procedure ObjectToParams(ds: TFDQuery; ItemPedido: TItemPedido);
    function ParamsToObject(ds: TFDQuery): TItemPedido;
    procedure ValidaItem(ItemPedido: TItemPedido);
  public
    procedure IncluiItemPedido(ItemPedido: TItemPedido);
    procedure ExcluiItemPedido(SEQ, IDPEDIDO: Integer);
    procedure AtualizaItemPedido(ItemPedido: TItemPedido);
    function GeTItemPedido(SEQ, IDPEDIDO: Integer): TItemPedido;
    function GeTItemsPedido(IDPEDIDO: Integer): TObjectList<TItemPedido>;
    function GeraID: Integer;
  end;

implementation

uses
  Util.Exceptions, Factory.Dao, Dao.TDaoProdutos;

{ TDaoVendedor }

procedure TDaoItemPedido.AtualizaItemPedido(ItemPedido: TItemPedido);
begin

end;

procedure TDaoItemPedido.ExcluiItemPedido(SEQ, IDPEDIDO: Integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  ItemPedido '
        + 'WHERE '
        + '     SEQ = :SEQ'
        + '     and IDPEDIDO = :IDPEDIDO';

      qry.ParamByName('SEQ').AsInteger := SEQ;
      qry.ParamByName('IDPEDIDO').AsInteger := IDPEDIDO;
      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluiItemPedido: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoItemPedido.GeraID: Integer;
begin

end;

function TDaoItemPedido.GeTItemPedido(SEQ, IDPEDIDO: Integer): TItemPedido;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  ItemPedido '
        + 'WHERE '
        + '     SEQ = :SEQ'
        + '     and IDPEDIDO = :IDPEDIDO';

      qry.ParamByName('SEQ').AsInteger := SEQ;
      qry.ParamByName('IDPEDIDO').AsInteger := IDPEDIDO;
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
        raise TDaoException.Create('Falha GeTItemPedido: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoItemPedido.GeTItemsPedido(IDPEDIDO: Integer): TObjectList<TItemPedido>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try

    try
      Result := TObjectList<TItemPedido>.Create();

      qry.SQL.Text := ''
        + 'select *  '
        + 'from  ItemPedido '
        + 'WHERE '
        + '     IDPEDIDO = :IDPEDIDO';

      qry.ParamByName('IDPEDIDO').AsInteger := IDPEDIDO;
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
        raise TDaoException.Create('Falha GeTItemsPedido: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoItemPedido.IncluiItemPedido(ItemPedido: TItemPedido);
var
  qry: TFDQuery;
begin
  ValidaItem(ItemPedido);

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'INSERT INTO ITEMPEDIDO '
      + '            (SEQ, '
      + '             IDPEDIDO, '
      + '             CODPRODUTO, '
      + '             DESCRICAO, '
      + '             UND, '
      + '             QTD, '
      + '             VALOR_UNITA, '
      + '             VALOR_DESCONTO, '
      + '             VALOR_TOTAL) '
      + 'VALUES      ( :SEQ, '
      + '              :IDPEDIDO, '
      + '              :CODPRODUTO, '
      + '              :DESCRICAO, '
      + '              :UND, '
      + '              :QTD, '
      + '              :VALOR_UNITA, '
      + '              :VALOR_DESCONTO, '
      + '              :VALOR_TOTAL)';

    ObjectToParams(qry, ItemPedido);

    try

      FConnection.StartTransaction;
      TLog.d(qry);
      qry.ExecSQL;

      FConnection.Commit;
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        FConnection.Rollback;
        raise TDaoException.Create('Falha ao Gravar TItemPedido: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoItemPedido.ObjectToParams(ds: TFDQuery; ItemPedido: TItemPedido);
begin
  try
    EntityToParams(ds, ItemPedido);
    // if ds.Params.FindParam('SEQ') <> nil then
    // ds.Params.ParamByName('SEQ').AsInteger := ItemPedido.SEQ;
    // if ds.Params.FindParam('IDPEDIDO') <> nil then
    // ds.Params.ParamByName('IDPEDIDO').AsInteger := ItemPedido.IDPEDIDO;
    // if ds.Params.FindParam('CODPRODUTO') <> nil then
    // ds.Params.ParamByName('CODPRODUTO').AsString := ItemPedido.CODPRODUTO;
    // if ds.Params.FindParam('DESCRICAO') <> nil then
    // ds.Params.ParamByName('DESCRICAO').AsString := ItemPedido.DESCRICAO;
    // if ds.Params.FindParam('UND') <> nil then
    // ds.Params.ParamByName('UND').AsString := ItemPedido.UND;
    // if ds.Params.FindParam('QTD') <> nil then
    // ds.Params.ParamByName('QTD').AsCurrency := ItemPedido.QTD;
    // if ds.Params.FindParam('VALOR_UNITA') <> nil then
    // ds.Params.ParamByName('VALOR_UNITA').AsCurrency := ItemPedido.VALOR_UNITA;
    // if ds.Params.FindParam('VALOR_DESCONTO') <> nil then
    // ds.Params.ParamByName('VALOR_DESCONTO').AsCurrency := ItemPedido.VALOR_DESCONTO;
    // if ds.Params.FindParam('VALOR_TOTAL') <> nil then
    // ds.Params.ParamByName('VALOR_TOTAL').AsCurrency := ItemPedido.VALOR_TOTAL;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TItemPedido: ' + E.message);
    end;
  end;
end;

function TDaoItemPedido.ParamsToObject(ds: TFDQuery): TItemPedido;
begin
  try

    Result := TItemPedido.Create();
    FieldsToEntity(ds, Result);

    // Result.SEQ := ds.FieldByName('SEQ').AsInteger;
    // Result.IDPEDIDO := ds.FieldByName('SEQ').AsInteger;
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
      raise TDaoException.Create('Falha no ParamsToObject ItemPedido: ' + E.message);
    end;
  end;

end;

procedure TDaoItemPedido.ValidaItem(ItemPedido: TItemPedido);
begin
  if ItemPedido.VALOR_TOTAL <= 0 then
    raise TValidacaoException.Create('O valor total do Item está zerado');
end;

end.
