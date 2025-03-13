unit Dao.TDAOParcelaPagamento;

interface

uses System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error, Dominio.Entidades.Pedido.Parcela.Pagamentos, Dao.IDaoParcelas, Dao.TDaoParcelas,
  Dominio.Entidades.Pedido.Pagamentos, Dao.TDAOPedidoPagamento, Dao.IDAOPedidoPagamento,
  Data.DB, FireDAC.Comp.Client, Dao.IDAOParcelaPagamento, Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dao.TDaoBase, Sistema.TLog;

type
  TDAOParcelaPagamento = class(TDaoBase, IDAOParcelaPagamento)
  private
    FDAOPedidoPagamento: IDAOPedidoPagamento;
    FDaoParcelas: IDaoParcelas;
    procedure GerarRelac(aParcelaPagto: TParcelaPagamentos);
  public
    procedure Excluir(aIdPedido: integer; aNumParcela: integer);
    procedure Incluir(aParcelaPagto: TParcelaPagamentos);
    function GetPagamentos(idpedido: integer): TList<TPEDIDOPAGAMENTO>;
  public
    class function New(Connection: TFDConnection; aKeepConection: Boolean): IDAOParcelaPagamento;
    constructor Create(Connection: TFDConnection; aKeepConection: Boolean); override;
  end;

implementation

uses
  Util.Exceptions;

{ TDaoSangriaSuprimento }

constructor TDAOParcelaPagamento.Create(Connection: TFDConnection;
  aKeepConection: Boolean);
begin
  inherited Create(Connection, aKeepConection);

  FDAOPedidoPagamento := TDAOPedidoPagamento.New(Connection, aKeepConection);
  FDaoParcelas := TDaoParcelas.New(Connection, aKeepConection);
end;

procedure TDAOParcelaPagamento.Excluir(aIdPedido: integer; aNumParcela: integer);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.Connection.StartTransaction;
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  RELACPARCELAPAGAMENTOS '
        + 'WHERE '
        + '     IDPEDIDO = :IDPEDIDO'
        + '     NUMPARCELA = :NUMPARCELA';

      qry.ParamByName('IDPEDIDO').AsInteger := aIdPedido;
      qry.ParamByName('NUMPARCELA').AsInteger := aNumParcela;
      TLog.d(qry);
      qry.ExecSQL;

      qry.Connection.Commit;
    except
      on E: EFDDBEngineException do
      begin
        qry.Connection.Rollback;
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro não pode ser excluído porque está amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        qry.Connection.Rollback;
        raise TDaoException.Create('Falha ExcluirVendedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDAOParcelaPagamento.GetPagamentos(idpedido: integer): TList<TPEDIDOPAGAMENTO>;
VAR
  qry: TFDQuery;
  condicao: TPEDIDOPAGAMENTO;
begin

  qry := Self.Query();
  Result := TList<TPEDIDOPAGAMENTO>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PARCELAPAGAMENTOS '
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
        Result.Add(condicao);
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

procedure TDAOParcelaPagamento.GerarRelac(aParcelaPagto: TParcelaPagamentos);
var
  qry: TFDQuery;
begin
  qry := Self.Query();
  try
    try

      for var Parcela in aParcelaPagto.Parcelas do
      begin
        for var pagto in aParcelaPagto.Pagamentos.FormasDePagamento do
        begin

          qry.SQL.Text := ''
            + 'INSERT INTO RELACPARCELAPAGAMENTOS '
            + '            (SEQPAGTO, '
            + '             IDPEDIDO, '
            + '             NUMPARCELA) '
            + 'VALUES      (:SEQPAGTO, '
            + '             :IDPEDIDO, '
            + '             :NUMPARCELA )';

          EntityToParams(qry, pagto);
          qry.ParamByName('NUMPARCELA').AsInteger := Parcela.NUMPARCELA;
          qry.ParamByName('IDPEDIDO').AsInteger := Parcela.idpedido;
          qry.ParamByName('SEQPAGTO').AsInteger := pagto.SEQ;
          TLog.d(qry);
          qry.ExecSQL;

        end;

      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Pagamento Parcela: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDAOParcelaPagamento.Incluir(aParcelaPagto: TParcelaPagamentos);
var
  qry: TFDQuery;
begin
  qry := Self.Query();
  try
    try
      qry.Connection.StartTransaction;

      for var pagto in aParcelaPagto.Pagamentos.FormasDePagamento do
      begin
        qry.SQL.Text := ''
          + 'INSERT INTO PARCELAPAGAMENTOS '
          + '            (SEQ, '
          + '             IDPEDIDO, '
          + '             IDPAGTO, '
          + '             IDCONDICAO, '
          + '             DESCRICAO, '
          + '             CONDICAO, '
          + '             TIPO, '
          + '             QUANTASVEZES, '
          + '             TROCO, '
          + '             ACRESCIMO, '
          + '             DATAALTERACAO, '
          + '             VALOR ) '
          + 'VALUES      (:SEQ, '
          + '             :IDPEDIDO, '
          + '             :IDPAGTO, '
          + '             :IDCONDICAO, '
          + '             :DESCRICAO, '
          + '             :CONDICAO, '
          + '             :TIPO, '
          + '             :QUANTASVEZES, '
          + '             :TROCO, '
          + '             :ACRESCIMO, '
          + '             :DATAALTERACAO, '
          + '             :VALOR )';

        EntityToParams(qry, pagto);
        TLog.d(qry);
        qry.ExecSQL;
      end;

      GerarRelac(aParcelaPagto);

      for var Parcela in aParcelaPagto.Parcelas do
      begin
        Parcela.DATABAIXA := now;
        Parcela.RECEBIDO := 'S';

        FDaoParcelas.BaixaParcelas(Parcela);
      end;

      qry.Connection.Commit;
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        qry.Connection.Rollback;
        raise TDaoException.Create('Falha Pagamento Parcela: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

class function TDAOParcelaPagamento.New(Connection: TFDConnection;
  aKeepConection: Boolean): IDAOParcelaPagamento;
begin
  Result := TDAOParcelaPagamento.Create(Connection, aKeepConection);
end;

end.
