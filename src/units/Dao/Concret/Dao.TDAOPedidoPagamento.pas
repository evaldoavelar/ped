unit Dao.TDAOPedidoPagamento;

interface

uses System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dao.TDaoBase, Sistema.TLog,
  Dao.IDAOPedidoPagamento;

type
  TArrayInterger = array of Integer;

  TDAOPedidoPagamento = class(TDaoBase, IDAOPedidoPagamento)
  public
  public
    procedure Excluir(id: Integer; idpedido: Integer);
    procedure ExcluirPorPedido(idpedido: Integer);
    procedure Inclui(aPagto: TPEDIDOPAGAMENTO);
    procedure Validar(aPagto: TPEDIDOPAGAMENTO);
    procedure Atualiza(aPagto: TPEDIDOPAGAMENTO);
    function GetPAGTO(SEQ: Integer; idpedido: Integer): TPEDIDOPAGAMENTO;
    function ListaObject(idpedido: Integer): tLIST<TPEDIDOPAGAMENTO>;
    function TiposPagamento(idpedido: Integer): TArray<Integer>;
  private
    procedure GravaParcelas(aPagto: TPEDIDOPAGAMENTO);

  public

    class function New(Connection: TFDConnection; aKeepConection: Boolean): IDAOPedidoPagamento;

  end;

implementation

uses Factory.Dao, Util.Exceptions, Dao.TDaoParcelas, Dominio.Entidades.TParcelas, Utils.ArrayUtil;
{ TClasseBase }

procedure TDAOPedidoPagamento.GravaParcelas(aPagto: TPEDIDOPAGAMENTO);
VAR
  DAOParcelas: TDaoParcelas;
  parcela: TParcelas;
begin
  DAOParcelas := TDaoParcelas.Create(Self.FConnection, true);

  for parcela in aPagto.Parcelas do
  begin
    parcela.SEQPAGTO := aPagto.SEQ;
    if DAOParcelas.GeTParcela(parcela.NUMPARCELA, parcela.idpedido) = nil then
      DAOParcelas.IncluiParcelas(parcela)
    else
      DAOParcelas.AtualizaParcelas(parcela);
  end;

  FreeAndNil(DAOParcelas);
end;

procedure TDAOPedidoPagamento.Atualiza(aPagto: TPEDIDOPAGAMENTO);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update PEDIDOPAGAMENTO '
        + '  set'
        + '     DESCRICAO = :DESCRICAO, '
        + '     ACRESCIMO = :ACRESCIMO, '
        + '     IDPAGTO = :IDPAGTO, '
        + '     IDCONDICAO = :IDCONDICAO, '
        + '     TIPO = :TIPO, '
        + '     VALOR = :VALOR, '
        + '     QUANTASVEZES = :QUANTASVEZES, '
        + '     CONDICAO = :CONDICAO   '
        + 'where       '
        + '    SEQ = :SEQ '
        + '    and IDPEDIDO = :IDPEDIDO ';

      qry.ParamByName('IDPEDIDO').AsInteger := aPagto.idpedido;
      qry.ParamByName('SEQ').AsInteger := aPagto.SEQ;

      Validar(aPagto);
      EntityToParams(qry, aPagto);

      TLog.d(qry);
      qry.ExecSQL;

      GravaParcelas(aPagto);
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Atualiza Condicao Pagtos: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDAOPedidoPagamento.Excluir(id: Integer; idpedido: Integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  PEDIDOPAGAMENTO '
        + 'WHERE '
        + '    SEQ = :SEQ '
        + '    and  IDPEDIDO = :IDPEDIDO ';

      qry.ParamByName('IDPEDIDO').AsInteger := idpedido;
      qry.ParamByName('ID').AsInteger := id;

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

procedure TDAOPedidoPagamento.ExcluirPorPedido(idpedido: Integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  PEDIDOPAGAMENTO '
        + 'WHERE '
        + '     idpedido = :idpedido';

      qry.ParamByName('idpedido').AsInteger := idpedido;
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

function TDAOPedidoPagamento.GetPAGTO(SEQ: Integer; idpedido: Integer): TPEDIDOPAGAMENTO;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PEDIDOPAGAMENTO '
        + 'where  '
        + '    SEQ = :SEQ '
        + '    and IDPEDIDO = :IDPEDIDO ';

      qry.ParamByName('IDPEDIDO').AsInteger := idpedido;
      qry.ParamByName('SEQ').AsInteger := SEQ;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
      begin
        Result := TPEDIDOPAGAMENTO.Create();
        FieldsToEntity(qry, Result);
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTPEDIDOPAGAMENTO: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDAOPedidoPagamento.Inclui(aPagto: TPEDIDOPAGAMENTO);
var
  qry: TFDQuery;
begin
  qry := Self.Query();
  try
    try

      qry.SQL.Text := ''
        + 'INSERT INTO PEDIDOPAGAMENTO '
        + '            (SEQ, '
        + '             IDPEDIDO, '
        + '             IDPAGTO, '
        + '             IDCONDICAO, '
        + '             DESCRICAO, '
        + '             CONDICAO, '
        + '             TIPO, '
        + '             QUANTASVEZES, '
        + '             ACRESCIMO, '
        + '             VALOR ) '
        + 'VALUES      (:SEQ, '
        + '             :IDPEDIDO, '
        + '             :IDPAGTO, '
        + '             :IDCONDICAO, '
        + '             :DESCRICAO, '
        + '             :CONDICAO, '
        + '             :TIPO, '
        + '             :QUANTASVEZES, '
        + '             :ACRESCIMO, '
        + '             :VALOR )';

      Validar(aPagto);
      EntityToParams(qry, aPagto);
      TLog.d(qry);
      qry.ExecSQL;

      GravaParcelas(aPagto);
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

function TDAOPedidoPagamento.ListaObject(idpedido: Integer): tLIST<TPEDIDOPAGAMENTO>;
VAR
  DAOParcelas: TDaoParcelas;
  qry: TFDQuery;
  condicao: TPEDIDOPAGAMENTO;
begin
  DAOParcelas := TDaoParcelas.Create(FConnection, true);

  qry := Self.Query();
  Result := tLIST<TPEDIDOPAGAMENTO>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PEDIDOPAGAMENTO '
        + 'where  '
        + '    IDPEDIDO = :IDPEDIDO '
        + 'order by QUANTASVEZES';

      qry.ParamByName('IDPEDIDO').AsInteger := idpedido;
      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        condicao := TPEDIDOPAGAMENTO.Create();
        FieldsToEntity(qry, condicao);

        condicao.AssignParcelas(DAOParcelas.GeTParcelas(condicao.idpedido, condicao.SEQ));

        Result.Add(condicao);
        qry.next;
      end;

    finally
      FreeAndNil(qry);
      FreeAndNil(DAOParcelas);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;
end;

class function TDAOPedidoPagamento.New(Connection: TFDConnection; aKeepConection: Boolean): IDAOPedidoPagamento;
begin
  Result := TDAOPedidoPagamento.Create(Connection, aKeepConection);
end;

function TDAOPedidoPagamento.TiposPagamento(idpedido: Integer): TArray<Integer>;
var
  qry: TFDQuery;
begin
  qry := Self.Query();

  try
    try
      qry.SQL.Text := ''
        + 'select distinct tipo  '
        + 'from  PEDIDOPAGAMENTO '
        + 'where  '
        + '    IDPEDIDO = :IDPEDIDO ';

      qry.ParamByName('IDPEDIDO').AsInteger := idpedido;
      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        TArrayUtil<Integer>.Append(Result, qry.fieldByname('tipo').AsInteger);
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha TiposPagamento: ' + E.message);
    end;
  end;
end;

procedure TDAOPedidoPagamento.Validar(aPagto: TPEDIDOPAGAMENTO);
begin
  if aPagto.DESCRICAO = '' then
    raise Exception.Create('Descrição do Pagamento não informado');

  if aPagto.Valor <= 0 then
    raise Exception.Create('Valor do pagamento precisa ser maior que zero');
end;

end.
