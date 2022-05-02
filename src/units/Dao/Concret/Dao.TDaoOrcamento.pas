unit Dao.TDaoOrcamento;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB, FireDAC.Comp.Client, Dao.IDaoOrcamento,
  Dao.TDaoBase,
  Dominio.Entidades.TItemOrcamento, Dominio.Entidades.TOrcamento, Util.Exceptions,
  Util.Funcoes, Dao.TDaoItemOrcamento, Dao.TDaoVendedor;

type

  TDaoOrcamento = class(TDaoBase, IDaoOrcamento)
  private
    procedure ObjectToParams(ds: TFDQuery; Orcamento: TOrcamento);
    function ParamsToObject(ds: TFDQuery): TOrcamento;
    procedure Valida(Orcamento: TOrcamento);
  public
    procedure AbreOrcamento(Orcamento: TOrcamento);
    procedure VendeItem(Item: TItemOrcamento);
    procedure ExcluiItem(Item: TItemOrcamento);
    procedure AtualizaOrcamento(Orcamento: TOrcamento);
    procedure AtualizaStatus(Orcamento: TOrcamento);
    procedure FinalizaOrcamento(Orcamento: TOrcamento);
    function getOrcamento(id: Integer): TOrcamento;
    function GeraID: Integer;
    function Listar(campo, valor: string; dataInicio, dataFim: TDate): TDataSet; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(dataInicio, dataFim: TDate): TDataSet; overload;
  end;

implementation

uses Dominio.Entidades.TFactory;
{ TDaoOrcamento }

procedure TDaoOrcamento.AtualizaStatus(Orcamento: TOrcamento);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    qry.SQL.Text := ''
      + 'UPDATE Orcamento '
      + 'SET    '
      + '       STATUS = :STATUS '
      + 'WHERE  id = :id';

    ObjectToParams(qry, Orcamento);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Atualizar Status Orcamento: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoOrcamento.AtualizaOrcamento(Orcamento: TOrcamento);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    qry.SQL.Text := ''
      + 'UPDATE Orcamento '
      + 'SET    numero = :NUMERO, '
      + '       dataOrcamento = :DATAOrcamento, '
      + '       OBSERVACAO = :OBSERVACAO,'
      + '       valorbruto = :VALORBRUTO, '
      + '       valordesc = :VALORDESC, '
      + '       volume = :VOLUME, '
      + '       valorliquido = :VALORLIQUIDO, '
      + '       DATAVENCIMENTO = :DATAVENCIMENTO, '
      + '       codven = :CODVEN, '
      + '       cliente = :CLIENTE, '
      + '       telefone = :TELEFONE, '
      + '       HORAOrcamento = :HORAOrcamento, '
      + '       STATUS = :STATUS '
      + 'WHERE  id = :id';

    ObjectToParams(qry, Orcamento);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Atualizar Orcamento: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoOrcamento.ExcluiItem(Item: TItemOrcamento);
var
  DaoItemOrcamento: TDaoItemOrcamento;
begin
  DaoItemOrcamento := TDaoItemOrcamento.Create(Self.FConnection);
  DaoItemOrcamento.ExcluiItemOrcamento(Item.SEQ, Item.IDORCAMENTO);
  DaoItemOrcamento.Free;

end;

procedure TDaoOrcamento.FinalizaOrcamento(Orcamento: TOrcamento);
var
  qry: TFDQuery;
begin

  Valida(Orcamento);

  qry := TFactory.Query();
  try
    qry.SQL.Text := ''
      + 'UPDATE Orcamento '
      + 'SET   '
      + '       status = :STATUS, '
      + '       DATAVENCIMENTO = :DATAVENCIMENTO, '
      + '       OBSERVACAO =:OBSERVACAO,'
      + '       cliente = :cliente, '
      + '       TELEFONE = :TELEFONE '
      + 'WHERE  id = :id';

    ObjectToParams(qry, Orcamento);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Finalizar Orcamento: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoOrcamento.GeraID: Integer;
begin
  Result := AutoIncremento('Orcamento', 'ID');
end;

function TDaoOrcamento.getOrcamento(id: Integer): TOrcamento;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Orcamento '
        + 'WHERE '
        + '     ID = :ID';

      qry.ParamByName('ID').AsInteger := id;
      qry.open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha GeTParcelas: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoOrcamento.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT o.* '
      + 'FROM   Orcamento o '
      + 'WHERE   ';

    if valor <> '' then
      qry.SQL.Add('  upper( ' + campo + ') LIKE ' + QuotedStr(UpperCase(valor + '%')));

    qry.SQL.Add(' order by id');
    qry.open;

    Result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Orcamento: ' + E.Message);
    end;
  end;

end;

function TDaoOrcamento.Listar(dataInicio, dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT o.* '
      + 'FROM   Orcamento o '
      + 'WHERE '
      + '       o.dataOrcamento >= :dataInicio '
      + '       AND o.dataOrcamento <= :dataFim ';

    qry.SQL.Add(' order by id');
    qry.ParamByName('dataInicio').AsDate := dataInicio;
    qry.ParamByName('dataFim').AsDate := dataFim;

    qry.open;

    Result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Orcamento: ' + E.Message);
    end;
  end;

end;

function TDaoOrcamento.Listar(campo, valor: string; dataInicio,
  dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT o.* '
      + 'FROM   Orcamento o '
      + 'WHERE   '
      + '       o.dataOrcamento >= :dataInicio '
      + '       AND o.dataOrcamento <= :dataFim ';

    if valor <> '' then
      qry.SQL.Add(' and upper( ' + campo + ') LIKE ' + QuotedStr(UpperCase(valor) + '%'));

    qry.SQL.Add(' order by id');

    qry.ParamByName('dataInicio').AsDate := dataInicio;
    qry.ParamByName('dataFim').AsDate := dataFim;

    qry.open;

    Result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Orcamento: ' + E.Message);
    end;
  end;

end;

procedure TDaoOrcamento.AbreOrcamento(Orcamento: TOrcamento);
var
  qry: TFDQuery;
begin
  Valida(Orcamento);

  qry := TFactory.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'INSERT INTO Orcamento '
      + '            (id, '
      + '             numero, '
      + '             dataOrcamento, '
      + '             OBSERVACAO, '
      + '             valorbruto, '
      + '             valordesc, '
      + '             valorliquido, '
      + '             status, '
      + '             codven, '
      + '             cliente, '
      + '             TELEFONE, '
      + '             horaOrcamento) '
      + 'VALUES      ( :ID, '
      + '              :NUMERO, '
      + '              :DATAOrcamento, '
      + '              :OBSERVACAO, '
      + '              :VALORBRUTO, '
      + '              :VALORDESC, '
      + '              :VALORLIQUIDO, '
      + '              :STATUS, '
      + '              :CODVEN, '
      + '              :CLIENTE, '
      + '              :TELEFONE,'
      + '              :HORAOrcamento)';

    ObjectToParams(qry, Orcamento);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Gravar Orcamento: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDaoOrcamento.ObjectToParams(ds: TFDQuery; Orcamento: TOrcamento);
begin
  try
    if ds.Params.FindParam('ID') <> nil then
      ds.Params.ParamByName('ID').AsInteger := Orcamento.id;
    if ds.Params.FindParam('NUMERO') <> nil then
      ds.Params.ParamByName('NUMERO').Value := Orcamento.NUMERO;
    if ds.Params.FindParam('DATAORCAMENTO') <> nil then
      ds.Params.ParamByName('DATAORCAMENTO').AsDate := Orcamento.DATAORCAMENTO;
    if ds.Params.FindParam('OBSERVACAO') <> nil then
      ds.Params.ParamByName('OBSERVACAO').AsString := Orcamento.OBSERVACAO;
    if ds.Params.FindParam('VALORBRUTO') <> nil then
      ds.Params.ParamByName('VALORBRUTO').AsCurrency := Orcamento.VALORBRUTO;
    if ds.Params.FindParam('VALORDESC') <> nil then
      ds.Params.ParamByName('VALORDESC').AsCurrency := Orcamento.VALORDESC;
    if ds.Params.FindParam('VALORLIQUIDO') <> nil then
      ds.Params.ParamByName('VALORLIQUIDO').AsCurrency := Orcamento.VALORLIQUIDO;
    if ds.Params.FindParam('STATUS') <> nil then
      ds.Params.ParamByName('STATUS').AsString := Orcamento.STATUS;
    if ds.Params.FindParam('CODVEN') <> nil then
      ds.Params.ParamByName('CODVEN').AsString := Orcamento.Vendedor.CODIGO;
    if ds.Params.FindParam('CLIENTE') <> nil then
      ds.Params.ParamByName('CLIENTE').AsString := Orcamento.Cliente;
    if ds.Params.FindParam('TELEFONE') <> nil then
      ds.Params.ParamByName('TELEFONE').AsString := Orcamento.TELEFONE;
    if ds.Params.FindParam('HORAOrcamento') <> nil then
      ds.Params.ParamByName('HORAOrcamento').AsTime := Orcamento.HORAOrcamento;
    if ds.Params.FindParam('VOLUME') <> nil then
      ds.Params.ParamByName('VOLUME').AsFloat := Orcamento.Volume;
    if ds.Params.FindParam('DATAVENCIMENTO') <> nil then
      ds.Params.ParamByName('DATAVENCIMENTO').AsDate := Orcamento.DATAVENCIMENTO;

  except
    on E: Exception do
      raise TDaoException.Create('Falha ao associar parâmetros Orcamento: ' + E.Message);
  end;
end;

function TDaoOrcamento.ParamsToObject(ds: TFDQuery): TOrcamento;
var
  DaoVendedor: TDaoVendedor;
  DaoItensOrcamento: TDaoItemOrcamento;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  bmp: TBitmap;
begin
  try
    DaoVendedor := TDaoVendedor.Create(Self.FConnection);
    DaoItensOrcamento := TDaoItemOrcamento.Create(Self.FConnection);

    Result := TOrcamento.Create;
    Result.id := ds.FieldByName('ID').AsInteger;
    Result.NUMERO := ds.FieldByName('NUMERO').AsString;
    Result.DATAORCAMENTO := ds.FieldByName('DATAOrcamento').AsDateTime;
    Result.OBSERVACAO := ds.FieldByName('OBSERVACAO').AsString;
    // Result.VALORBRUTO := ds.FieldByName('VALORBRUTO').AsCurrency;
    Result.VALORDESC := ds.FieldByName('VALORDESC').AsCurrency;
    // Result.VALORLIQUIDO := ds.FieldByName('VALORLIQUIDO').AsCurrency;
    Result.STATUS := ds.FieldByName('STATUS').AsString;
    Result.Vendedor := DaoVendedor.GetVendedor(ds.FieldByName('CODVEN').AsString);
    Result.Cliente := (ds.FieldByName('CLIENTE').AsString);
    Result.TELEFONE :=(ds.FieldByName('TELEFONE').AsString);
    Result.HORAOrcamento := ds.FieldByName('HORAOrcamento').AsDateTime;
    Result.AssignedItens(DaoItensOrcamento.GeTItemsOrcamento(Result.id));
    // Result.Volume := ds.FieldByName('STATUS').AsFloat;
    Result.DATAVENCIMENTO := ds.FieldByName('DATAVENCIMENTO').AsDateTime;

    FreeAndNil(DaoVendedor);
    FreeAndNil(DaoItensOrcamento);

  except
    on E: Exception do
      raise TDaoException.Create('Falha ao popular objeto Orcamento: ' + E.Message);
  end;
end;

procedure TDaoOrcamento.Valida(Orcamento: TOrcamento);
begin
  if Orcamento.Vendedor = nil then
    raise TValidacaoException.Create('Vendedor não associado ao Orcamento');

  if Orcamento.Cliente = '' then
    raise TValidacaoException.Create('Cliente não informado no Orcamento');

end;

procedure TDaoOrcamento.VendeItem(Item: TItemOrcamento);
var
  DaoItemOrcamento: TDaoItemOrcamento;
begin
  DaoItemOrcamento := TDaoItemOrcamento.Create(Self.FConnection);
  DaoItemOrcamento.IncluiItemOrcamento(Item);
  FreeAndNil(DaoItemOrcamento);
end;

end.
