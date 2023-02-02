unit Dao.TDaoParcelas;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TParcelas, Dao.IDaoParcelas;

type

  TDaoParcelas = class(TDaoBase, IDaoParcelas)
  private
    procedure ObjectToParams(ds: TFDQuery; Parcelas: TParcelas);
    function ParamsToObject(ds: TDataSet): TParcelas;
    procedure ValidaItem(Parcelas: TParcelas);

  public
    procedure IncluiParcelas(Parcelas: TParcelas);
    procedure AtualizaParcelas(Parcelas: TParcelas);
    procedure BaixaParcelas(Parcelas: TParcelas);
    procedure ExtornaParcelas(Parcelas: TParcelas);
    function GeTParcela(NUMPARCELA, IDPEDIDO: Integer): TParcelas;
    function GeTParcelas(IDPEDIDO: Integer): TObjectList<TParcelas>; overload;
    function GeTParcelas(IDPEDIDO: Integer; SEQPAGTO: Integer): TObjectList<TParcelas>; overload;
    function GeTParcelasPorCliente(CODCLiente: string; status: string): TObjectList<TParcelas>; overload;
    function GeTParcelasVencidasPorCliente(CODCLiente: string; dataAtual: TDate): TObjectList<TParcelas>; overload;
    function GeTParcelasVencendoPorCliente(CODCLiente: string; dataAtual: TDate): TObjectList<TParcelas>; overload;

    function GeTParcelas(dataInicial, dataFinal: TDate): TDataSet; overload;
    function GeTParcelas(campo: string; valor: string; dataInicial, dataFinal: TDate): TDataSet; overload;
    function GeTParcelasTotal(CODCLiente: string; status: string): currency;

    function GetNumeroDeParcelasVencendo(dataInicial, dataFinal: TDate): Integer;
    function GetNumeroDeParcelasVencidas(dataAtual: TDate): Integer; overload;
    function GetNumeroDeParcelasVencidas(dataAtual: TDate; CODCLiente: string): Integer; overload;

    function GetParcelaVencidasDS(campo: string; valor: string; dataAtual: TDate): TDataSet; overload;
    function GetParcelaVencidasDS(dataAtual: TDate): TDataSet; overload;

    function GetParcelaVencendoDS(dataInicial, dataFinal: TDate): TDataSet;

    function GetParcelaVencidasObj(dataAtual: TDate): TObjectList<TParcelas>;
    function GetParcelaVencendoObj(dataInicial, dataFinal: TDate): TObjectList<TParcelas>;

    function GeTParcelas(campo: string; valor: string): TDataSet; overload;

  end;

implementation

uses
  Util.Exceptions, Factory.Dao;

{ TDaoVendedor }

procedure TDaoParcelas.AtualizaParcelas(Parcelas: TParcelas);
var
  qry: TFDQuery;
begin
  ValidaItem(Parcelas);

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'update Parcelas '
      + '     set '
      + '     VALOR = :VALOR, '
      + '     VENCIMENTO = :VENCIMENTO '
      + 'where  '
      + '     NUMPARCELA = :NUMPARCELA '
      + '     and IDPEDIDO = :IDPEDIDO ';

    ObjectToParams(qry, Parcelas);

    try
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        FConnection.Rollback;
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaParcelas - Parcela:' + IntToStr(Parcelas.NUMPARCELA) + ' - ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParcelas.BaixaParcelas(Parcelas: TParcelas);
var
  qry: TFDQuery;
begin
  ValidaItem(Parcelas);

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'update Parcelas '
      + '     set '
      + '     DATABAIXA = :DATABAIXA, '
      + '     CODVENRECEBIMENTO =:CODVENRECEBIMENTO,'
      + '     RECEBIDO = :RECEBIDO '
      + 'where  '
      + '     NUMPARCELA = :NUMPARCELA '
      + '     and IDPEDIDO = :IDPEDIDO ';

    ObjectToParams(qry, Parcelas);

    try
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        FConnection.Rollback;
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaParcelas - Parcela:' + IntToStr(Parcelas.NUMPARCELA) + ' - ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParcelas.ExtornaParcelas(Parcelas: TParcelas);
var
  qry: TFDQuery;
begin
  ValidaItem(Parcelas);

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'update Parcelas '
      + '     set '
      + '     DATABAIXA = null, '
      + '     RECEBIDO = ''N'' '
      + 'where  '
      + '     NUMPARCELA = :NUMPARCELA '
      + '     and IDPEDIDO = :IDPEDIDO ';

    ObjectToParams(qry, Parcelas);

    try
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        FConnection.Rollback;
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaParcelas - Parcela:' + IntToStr(Parcelas.NUMPARCELA) + ' - ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParcelas.GeTParcela(NUMPARCELA, IDPEDIDO: Integer): TParcelas;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Parcelas '
        + 'WHERE '
        + '     NUMPARCELA = :NUMPARCELA'
        + '     and IDPEDIDO = :IDPEDIDO';

      qry.ParamByName('NUMPARCELA').AsInteger := NUMPARCELA;
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
        raise TDaoException.Create('Falha GeTParcelas: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParcelas.GetParcelaVencidasDS(dataAtual: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT c.nome, '
      + '       pa.CODCLIENTE, '
      + '       c.codigo, '
      + '       pe.NUMERO, '
      + '       (pa.numparcela) AS numparcela, '
      + '       pa.vencimento, '
      + '       pe.ID IDPEDIDO, '
      + '       pe.ID, '
      + '       pa.RECEBIDO, '
      + '       pa.CODVENRECEBIMENTO,'
      + '       (pa.valor)      '
      + 'FROM   parcelas pa, '
      + '       pedido pe, '
      + '       cliente c '
      + 'WHERE  pa.idpedido = pe.id '
      + '       AND pe.status = ''F'' '
      + '       AND pa.vencimento < :dataAtual '
      + '       AND pa.recebido = ''N'' '
      + '       AND pa.codcliente = c.codigo '
      + 'order  BY  pa.vencimento,c.nome';

    qry.ParamByName('dataAtual').AsDate := dataAtual;
    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GetParcelasVencendo: ' + E.message);
    end;
  end;

end;

function TDaoParcelas.GetParcelaVencidasDS(campo, valor: string; dataAtual: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT c.nome, '
      + '       pa.CODCLIENTE, '
      + '       c.codigo, '
      + '       pe.NUMERO, '
      + '       (pa.numparcela) AS numparcela, '
      + '       pa.vencimento, '
      + '       pe.ID IDPEDIDO, '
      + '       pe.ID, '
      + '       pa.RECEBIDO, '
      + '       pa.CODVENRECEBIMENTO,'
      + '       (pa.valor)      '
      + 'FROM   parcelas pa, '
      + '       pedido pe, '
      + '       cliente c '
      + 'WHERE  pa.idpedido = pe.id '
      + '       AND pe.status = ''F'' '
      + '       AND pa.vencimento < :dataAtual '
      + '       AND pa.recebido = ''N'' '
      + '       AND pa.codcliente = c.codigo '
      + '       AND upper( ' + campo + ') like ' + QuotedStr(UpperCase(valor) + '%')
      + 'order  BY  pa.vencimento,c.nome';

    qry.ParamByName('dataAtual').AsDate := dataAtual;
    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GetParcelaVencidasDS: ' + E.message);
    end;
  end;

end;

function TDaoParcelas.GetParcelaVencidasObj(dataAtual: TDate): TObjectList<TParcelas>;
var
  ds: TDataSet;
begin

  ds := Self.GetParcelaVencidasDS(dataAtual);
  try
    Result := TObjectList<TParcelas>.Create();

    while not ds.Eof do
    begin
      Result.Add(ParamsToObject(ds));
      ds.Next;
    end;

    FreeAndNil(ds);

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GetParcelaVencidasObj: ' + E.message);
    end;
  end;

end;

function TDaoParcelas.GeTParcelasPorCliente(CODCLiente: string; status: string): TObjectList<TParcelas>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try

    try
      Result := TObjectList<TParcelas>.Create();

      qry.SQL.Text := ''
        + 'SELECT pa.* '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.CODCLIENTE = :CODCLIENTE ';

      if status <> '' then
        qry.SQL.Add('and pa.RECEBIDO =' + QuotedStr(status));

      qry.SQL.Add('order by  pa.vencimento,pa.numparcela');

      qry.ParamByName('CODCLIENTE').AsString := CODCLiente;
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
        raise TDaoException.Create('Falha GeTParcelas: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParcelas.GeTParcelas(dataInicial, dataFinal: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT c.nome, '
      + '       c.codigo, '
      + '       pe.ID, '
      + '       pe.NUMERO, '
      + '       (pa.numparcela) numparcela , '
      + '       (pa.valor) valor, '
      + '       pa.RECEBIDO, '
      + '       pa.CODVENRECEBIMENTO,'
      + '       pa.vencimento '
      + 'FROM   parcelas pa, '
      + '       pedido pe, '
      + '       cliente c '
      + 'WHERE  pa.idpedido = pe.id '
      + '       AND pe.status = ''F'' '
      + '       AND pa.codcliente = c.codigo '
      + '       AND pa.vencimento >= :dataInicial '
      + '       AND pa.vencimento <= :dataFinal '
      + 'ORDER  BY pa.vencimento,c.nome ';

    qry.ParamByName('dataInicial').AsDate := dataInicial;
    qry.ParamByName('dataFinal').AsDate := dataFinal;
    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GeTParcelas: ' + E.message);
    end;
  end;

end;

function TDaoParcelas.GeTParcelas(campo, valor: string; dataInicial, dataFinal: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try

    qry.SQL.Text := ''
      + 'SELECT c.nome, '
      + '       c.codigo, '
      + '       pe.ID, '
      + '       pe.NUMERO, '
      + '       (pa.numparcela) numparcela , '
      + '       (pa.valor) valor, '
      + '       pa.RECEBIDO, '
      + '       pa.CODVENRECEBIMENTO,'
      + '       pa.vencimento '
      + 'FROM   parcelas pa, '
      + '       pedido pe, '
      + '       cliente c '
      + 'WHERE  pa.idpedido = pe.id '
      + '       AND pe.status = ''F'' '
      + '       AND pa.codcliente = c.codigo '
      + '       AND pa.vencimento >= :dataInicial '
      + '       AND pa.vencimento <= :dataFinal '
      + '       AND upper( ' + campo + ') like ' + QuotedStr(UpperCase(valor) + '%')
      + ' ORDER  BY pa.vencimento,c.nome ';

    qry.ParamByName('dataInicial').AsDate := dataInicial;
    qry.ParamByName('dataFinal').AsDate := dataFinal;
    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GeTParcelas: ' + E.message);
    end;
  end;

end;

function TDaoParcelas.GeTParcelasTotal(CODCLiente, status: string): currency;
var
  qry: TFDQuery;
begin

  Result := 0;
  qry := Self.Query();
  try

    try

      qry.SQL.Text := ''
        + 'SELECT sum(pa.VALOR) total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.CODCLIENTE = :CODCLIENTE ';

      if status <> '' then
        qry.SQL.Add('and pa.RECEBIDO =' + QuotedStr(status));

      qry.ParamByName('CODCLIENTE').AsString := CODCLiente;
      TLog.d(qry);
      qry.Open;

      Result := qry.FieldByName('total').AsCurrency;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTParcelasTotal: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParcelas.GeTParcelasVencendoPorCliente(CODCLiente: string; dataAtual: TDate): TObjectList<TParcelas>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    Result := TObjectList<TParcelas>.Create();

    try

      qry.SQL.Text := ''
        + 'SELECT pa.* '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.CODCLIENTE = :CODCLIENTE '
        + '       AND pa.RECEBIDO = ''N'' '
        + '       AND pa.vencimento > :dataAtual '
        + 'order by  pa.vencimento,pa.numparcela';

      qry.ParamByName('CODCLIENTE').AsString := CODCLiente;
      qry.ParamByName('dataAtual').AsDate := dataAtual;
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
        raise TDaoException.Create('Falha GetParcelasVencendo: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TDaoParcelas.GeTParcelasVencidasPorCliente(CODCLiente: string; dataAtual: TDate): TObjectList<TParcelas>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    Result := TObjectList<TParcelas>.Create();

    try

      qry.SQL.Text := ''
        + 'SELECT pa.* '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.CODCLIENTE = :CODCLIENTE '
        + '       AND pa.RECEBIDO = ''N'' '
        + '       AND pa.vencimento < :dataAtual '
        + 'order by  pa.vencimento,pa.numparcela';

      qry.ParamByName('CODCLIENTE').AsString := CODCLiente;
      qry.ParamByName('dataAtual').AsDate := dataAtual;
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
        raise TDaoException.Create('Falha GetParcelasVencendo: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TDaoParcelas.GetParcelaVencendoDS(dataInicial, dataFinal: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT c.nome, '
      + '       pa.CODCLIENTE, '
      + '       pe.NUMERO, '
      + '       pa.CODVENRECEBIMENTO, '
      + '       (pa.numparcela) numparcela , '
      + '       (pa.valor) , '
      + '       pe.ID IDPEDIDO, '
      + '       pa.vencimento '
      + 'FROM   parcelas pa, '
      + '       pedido pe, '
      + '       cliente c '
      + 'WHERE  pa.idpedido = pe.id '
      + '       AND pe.status = ''F'' '
      + '       AND pa.recebido = ''N'' '
      + '       AND pa.codcliente = c.codigo '
      + '       AND pa.vencimento >= :dataInicial '
      + '       AND pa.vencimento <= :dataFinal '
    // + 'GROUP  BY c.nome,c.codigo, '
    // + '          pa.vencimento '
      + 'ORDER  BY pa.vencimento,c.nome ';

    qry.ParamByName('dataInicial').AsDate := dataInicial;
    qry.ParamByName('dataFinal').AsDate := dataFinal;
    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GetParcelaVencendo: ' + E.message);
    end;
  end;

end;

function TDaoParcelas.GetParcelaVencendoObj(dataInicial, dataFinal: TDate): TObjectList<TParcelas>;
var
  ds: TDataSet;
begin

  ds := Self.GetParcelaVencendoDS(dataInicial, dataFinal);
  try
    Result := TObjectList<TParcelas>.Create();

    while not ds.Eof do
    begin
      Result.Add(ParamsToObject(ds));
      ds.Next;
    end;

    FreeAndNil(ds);

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha GetParcelaVencendoObj: ' + E.message);
    end;
  end;
end;

function TDaoParcelas.GetNumeroDeParcelasVencendo(dataInicial, dataFinal: TDate): Integer;
var
  qry: TFDQuery;
begin

  Result := 0;
  qry := Self.Query();
  try

    try

      qry.SQL.Text := ''
        + 'SELECT Count(pa.numparcela) total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.recebido = ''N'''
        + '       AND pa.vencimento >= :dataInicial '
        + '       AND pa.vencimento <= :dataFinal ';

      qry.ParamByName('dataInicial').AsDate := dataInicial;
      qry.ParamByName('dataFinal').AsDate := dataFinal;
      TLog.d(qry);
      qry.Open;

      Result := qry.FieldByName('total').AsInteger;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetParcelasVencendo: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParcelas.GetNumeroDeParcelasVencidas(dataAtual: TDate; CODCLiente: string): Integer;
var
  qry: TFDQuery;
begin

  Result := 0;
  qry := Self.Query();
  try

    try

      qry.SQL.Text := ''
        + 'SELECT Count(pa.numparcela) total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.recebido = ''N'''
        + '       AND pa.vencimento < :dataAtual '
        + '       AND pa.CODCLIENTE = :CODCLIENTE ';

      qry.ParamByName('CODCLIENTE').AsString := CODCLiente;
      qry.ParamByName('dataAtual').AsDate := dataAtual;
      TLog.d(qry);
      qry.Open;

      Result := qry.FieldByName('total').AsInteger;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetNumeroDeParcelasVencidas por Cliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParcelas.GetNumeroDeParcelasVencidas(dataAtual: TDate): Integer;
var
  qry: TFDQuery;
begin

  Result := 0;
  qry := Self.Query();
  try

    try

      qry.SQL.Text := ''
        + 'SELECT Count(pa.numparcela) total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.recebido = ''N'''
        + '       AND pa.vencimento < :dataAtual ';

      qry.ParamByName('dataAtual').AsDate := dataAtual;
      TLog.d(qry);
      qry.Open;

      Result := qry.FieldByName('total').AsInteger;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetParcelasVencendo: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoParcelas.GeTParcelas(IDPEDIDO: Integer): TObjectList<TParcelas>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try

    try
      Result := TObjectList<TParcelas>.Create();

      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Parcelas '
        + 'WHERE '
        + '     IDPEDIDO = :IDPEDIDO '
        + 'order by NUMPARCELA ';

      qry.ParamByName('IDPEDIDO').AsInteger := IDPEDIDO;
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
        raise TDaoException.Create('Falha GeTParcelas: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParcelas.IncluiParcelas(Parcelas: TParcelas);
var
  qry: TFDQuery;
begin
  ValidaItem(Parcelas);

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'INSERT INTO Parcelas '
      + '            (NUMPARCELA, '
      + '             IDPEDIDO, '
      + '             SEQPAGTO, '
      + '             VALOR, '
      + '             VENCIMENTO, '
      + '             CODCLIENTE) '
      + 'VALUES      ( :NUMPARCELA, '
      + '              :IDPEDIDO, '
      + '              :SEQPAGTO, '
      + '              :VALOR, '
      + '              :VENCIMENTO, '
      + '              :CODCLIENTE)';

    ObjectToParams(qry, Parcelas);

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
        raise TDaoException.Create('Falha ao Gravar TParcelas - Parcela:' + IntToStr(Parcelas.NUMPARCELA) + ' - ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoParcelas.ObjectToParams(ds: TFDQuery; Parcelas: TParcelas);
begin
  try
    EntityToParams(ds, Parcelas);
    // if ds.Params.FindParam('NUMPARCELA') <> nil then
    // ds.Params.ParamByName('NUMPARCELA').AsInteger := Parcelas.NUMPARCELA;
    // if ds.Params.FindParam('IDPEDIDO') <> nil then
    // ds.Params.ParamByName('IDPEDIDO').AsInteger := Parcelas.IDPEDIDO;
    // if ds.Params.FindParam('VALOR') <> nil then
    // ds.Params.ParamByName('VALOR').AsCurrency := Parcelas.VALOR;
    // if ds.Params.FindParam('VENCIMENTO') <> nil then
    // ds.Params.ParamByName('VENCIMENTO').AsDate := Parcelas.VENCIMENTO;
    // if ds.Params.FindParam('RECEBIDO') <> nil then
    // ds.Params.ParamByName('RECEBIDO').AsString := Parcelas.RECEBIDO;
    // if ds.Params.FindParam('DATABAIXA') <> nil then
    // ds.Params.ParamByName('DATABAIXA').AsDate := Parcelas.DATABAIXA;
    // if ds.Params.FindParam('CODCLIENTE') <> nil then
    // ds.Params.ParamByName('CODCLIENTE').AsString := Parcelas.CODCLiente;

    if ds.Params.FindParam('CODVENRECEBIMENTO') <> nil then
    begin
      if Assigned(Parcelas.VendedorRecebimento) then
      begin
        ds.Params.ParamByName('CODVENRECEBIMENTO').AsString := Parcelas.VendedorRecebimento.CODIGO
      end
      else
      begin
        ds.Params.ParamByName('CODVENRECEBIMENTO').DataType := ftString;
        ds.Params.ParamByName('CODVENRECEBIMENTO').Clear();
      end;
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TParcelas: ' + E.message);
    end;
  end;
end;

function TDaoParcelas.ParamsToObject(ds: TDataSet): TParcelas;
begin
  try
    Result := TParcelas.Create();
    FieldsToEntity(ds, Result);

    if not(ds.FieldByName('CODVENRECEBIMENTO').IsNull) then
      Result.VendedorRecebimento := TFactory
        .new(FConnection, true)
        .DaoVendedor
        .GetVendedor(ds.FieldByName('CODVENRECEBIMENTO').AsString);

    // Result.NUMPARCELA := ds.FieldByName('NUMPARCELA').AsInteger;
    // Result.IDPEDIDO := ds.FieldByName('IDPEDIDO').AsInteger;
    // Result.VALOR := ds.FieldByName('VALOR').AsCurrency;
    // Result.VENCIMENTO := ds.FieldByName('VENCIMENTO').AsDateTime;
    // Result.RECEBIDO := ds.FieldByName('RECEBIDO').AsString;
    // Result.DATABAIXA := ds.FieldByName('DATABAIXA').AsDateTime;
    // Result.CODCLiente := ds.FieldByName('CODCLIENTE').AsString;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject Parcelas: ' + E.message);
    end;
  end;

end;

procedure TDaoParcelas.ValidaItem(Parcelas: TParcelas);
begin
  if Parcelas.valor <= 0 then
    raise TValidacaoException.Create('O valor total do Item está zerado');
end;

function TDaoParcelas.GeTParcelas(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try

      qry.SQL.Text := ''
        + 'SELECT c.nome, '
        + '       c.codigo, '
        + '       pe.ID, '
        + '       pe.NUMERO, '
        + '       (pa.numparcela) numparcela , '
        + '       (pa.valor) valor, '
        + '       pa.RECEBIDO, '
        + '       pa.vencimento '
        + 'FROM   parcelas pa, '
        + '       pedido pe, '
        + '       cliente c '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.codcliente = c.codigo '
        + '       AND upper( ' + campo + ') like ' + QuotedStr(UpperCase(valor) + '%')
        + ' ORDER  BY pa.vencimento,c.nome ';

      TLog.d(qry);
      qry.Open;

      Result := qry;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTParcelas: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TDaoParcelas.GeTParcelas(IDPEDIDO,
  SEQPAGTO: Integer): TObjectList<TParcelas>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try

    try
      Result := TObjectList<TParcelas>.Create();

      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Parcelas '
        + 'WHERE '
        + '     IDPEDIDO = :IDPEDIDO '
        + '     AND SEQPAGTO = :SEQPAGTO '
        + 'order by NUMPARCELA ';

      qry.ParamByName('IDPEDIDO').AsInteger := IDPEDIDO;
      qry.ParamByName('SEQPAGTO').AsInteger := SEQPAGTO;
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
        raise TDaoException.Create('Falha GeTParcelas: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

end.
