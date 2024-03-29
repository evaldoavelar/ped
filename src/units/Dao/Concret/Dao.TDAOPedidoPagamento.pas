unit Dao.TDAOPedidoPagamento;

interface

uses System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dao.TDaoBase,
  Dao.IDAOPedidoPagamento;

type
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
  private
    procedure GravaParcelas(aPagto: TPEDIDOPAGAMENTO);

  public

    class function New(Connection: TFDConnection): IDAOPedidoPagamento;

  end;

implementation

uses Dominio.Entidades.TFactory, Util.Exceptions, Dao.TDaoParcelas, Dominio.Entidades.TParcelas;
{ TClasseBase }

procedure TDAOPedidoPagamento.GravaParcelas(aPagto: TPEDIDOPAGAMENTO);
VAR
  DAOParcelas: TDaoParcelas;
  parcela: TParcelas;
begin
  DAOParcelas := TDaoParcelas.Create(Self.FConnection);

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

  qry := TFactory.Query();
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

      qry.ExecSQL;

      GravaParcelas(aPagto);
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Atualiza Condicao Pagtos: ' + E.Message);
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

  qry := TFactory.Query();
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
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro n�o pode ser exclu�do porque est� amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ExcluirCliente: ' + E.Message);
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

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  PEDIDOPAGAMENTO '
        + 'WHERE '
        + '     idpedido = :idpedido';

      qry.ParamByName('idpedido').AsInteger := idpedido;
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro n�o pode ser exclu�do porque est� amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ExcluirCliente: ' + E.Message);
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

  qry := TFactory.Query();
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
      qry.open;

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
        raise TDaoException.Create('Falha GeTPEDIDOPAGAMENTO: ' + E.Message);
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
  qry := TFactory.Query();
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
      qry.ExecSQL;

      GravaParcelas(aPagto);
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Pagamento Cliente: ' + E.Message);
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
  DAOParcelas := TDaoParcelas.Create(FConnection);

  qry := TFactory.Query();
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
      qry.open;

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
      raise TDaoException.Create('Falha Listar Pagto: ' + E.Message);
    end;
  end;
end;

class function TDAOPedidoPagamento.New(Connection: TFDConnection): IDAOPedidoPagamento;
begin
  Result := TDAOPedidoPagamento.Create(Connection);
end;

procedure TDAOPedidoPagamento.Validar(aPagto: TPEDIDOPAGAMENTO);
begin
  if aPagto.DESCRICAO = '' then
    raise Exception.Create('Descri��o do Pagamento n�o informado');

  if aPagto.Valor <= 0 then
    raise Exception.Create('Valor do pagamento precisa ser maior que zero');
end;

end.
