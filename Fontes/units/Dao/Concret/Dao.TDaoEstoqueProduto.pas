unit Dao.TDaoEstoqueProduto;

interface

uses System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client, Dao.IDaoFiltroEstoque,
  Dao.TDaoBase, Dao.IDaoEstoqueProduto, Dominio.Entidades.TEstoqueProduto;

type
  TDaoEstoqueProduto = class(TDaoBase, IDaoEstoqueProduto)

  public
    procedure Inclui(aESTOQUEPRODUTO: TEstoqueProduto);
    procedure Delete(aESTOQUEPRODUTO: TEstoqueProduto);
    procedure Valida(aESTOQUEPRODUTO: TEstoqueProduto);
    function UpdateStatus(aIDPEDIDO: Integer; aSEQ: Integer; aStatus: string ): Integer; overload;
    function ListaObject(aFiltro: IDaoEstoqueFiltro): tLIST<TEstoqueProduto>;
  private
    function GeraID: Integer;
  public

    class function New(Connection: TFDConnection): IDaoEstoqueProduto;
  end;

implementation

uses
  Util.Exceptions, Dominio.Entidades.TFactory;

{ TDaoEstoqueProduto }

procedure TDaoEstoqueProduto.Delete(aESTOQUEPRODUTO: TEstoqueProduto);
var
  qry: TFDQuery;
begin
  qry := TFactory.Query();
  try
    try

      qry.SQL.Text := ''
        + 'delete from  ESTOQUEPRODUTO '
        + 'where    id =  :id ';

      qry.ParamByName('ID').AsInteger := aESTOQUEPRODUTO.ID;
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha Delete ESTOQUEPRODUTO: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoEstoqueProduto.GeraID: Integer;
begin
  Result := AutoIncremento('ESTOQUEPRODUTO', 'ID');
end;

procedure TDaoEstoqueProduto.Inclui(aESTOQUEPRODUTO: TEstoqueProduto);

var
  qry: TFDQuery;
begin
  qry := TFactory.Query();
  try
    try
      aESTOQUEPRODUTO.ID := GeraID;

      qry.SQL.Text := ''
        + 'INSERT INTO ESTOQUEPRODUTO '
        + '            (id, '
        + '             IDPEDIDO, '
        + '             SEQPRODUTOPEDIDO, '
        + '             DESCRICAO, '
        + '             NOTAFISCAL, '
        + '             QUANTIDADE, '
        + '             TIPO, '
        + '             STATUS, '
        + '             DATA, '
        + '             CODIGOPRD, '
        + '             USUARIOCRIACAO '
        + '              ) '
        + 'VALUES      (:id, '
        + '             :IDPEDIDO, '
        + '             :SEQPRODUTOPEDIDO, '
        + '             :DESCRICAO, '
        + '             :NOTAFISCAL, '
        + '             :QUANTIDADE, '
        + '             :TIPO, '
        + '             :STATUS, '
        + '             :DATA, '
        + '             :CODIGOPRD, '
        + '             :USUARIOCRIACAO '
        + '              )';

      Valida(aESTOQUEPRODUTO);
      EntityToParams(qry, aESTOQUEPRODUTO);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ESTOQUEPRODUTO: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TDaoEstoqueProduto.ListaObject(aFiltro: IDaoEstoqueFiltro): tLIST<TEstoqueProduto>;
var
  qry: TFDQuery;
  estoque: TEstoqueProduto;
begin

  qry := TFactory.Query();
  Result := tLIST<TEstoqueProduto>.Create();
  try
    try

      qry.SQL.append('SELECT  * ');
      qry.SQL.append('FROM   estoqueproduto ');
      qry.SQL.append('WHERE  (status <> ''C'' or  status is null) ');

      if aFiltro.getDataIncio > 0 then
      begin
        qry.SQL.append('       AND data >= :datainicio ');
        qry.ParamByName('datainicio').AsDateTime := aFiltro.getDataIncio;
      end;

      if aFiltro.getDataIncio > 0 then
      begin
        qry.SQL.append('       AND data <= :datafim ');
        qry.ParamByName('datafim').AsDateTime := aFiltro.getDataFim;
      end;

      if aFiltro.getProduto <> '' then
      begin
        qry.SQL.append('       AND CODIGOPRD = :CODIGOPRD ');
        qry.ParamByName('CODIGOPRD').AsString := aFiltro.getProduto;
      end;

      qry.SQL.append(' order by data');

      qry.open;

      while not qry.Eof do
      begin
        estoque := TEstoqueProduto.Create();
        FieldsToEntity(qry, estoque);
        Result.Add(estoque);
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar estoqueproduto: ' + E.Message);
    end;
  end;

end;

class function TDaoEstoqueProduto.New(
  Connection: TFDConnection): IDaoEstoqueProduto;
begin
  Result := TDaoEstoqueProduto.Create(Connection);
end;

function TDaoEstoqueProduto.UpdateStatus(aIDPEDIDO, aSEQ: Integer;
  aStatus: string): Integer;
var
  qry: TFDQuery;
begin
  qry := TFactory.Query();
  try

    try

      qry.SQL.Add('update ESTOQUEPRODUTO ');
      qry.SQL.Add('set  STATUS = :STATUS ');
      qry.SQL.Add('WHERE  SEQPRODUTOOS = :SEQPRODUTOOS ');
      qry.SQL.Add('       and  IDOS = :IDOS ');

      qry.ParamByName('SEQPRODUTOOS').AsInteger := aSEQ;
      qry.ParamByName('IDOS').AsInteger := aIDPEDIDO;
      qry.ParamByName('STATUS').AsString := aStatus;

      qry.ExecSQL;

      Result := qry.RowsAffected;

    except
      on E: Exception do
      begin
        raise TDaoException.Create(' TDaoProduto.EntradaSaidaEstoque: ' + E.Message);
      end;

    end;
  finally
    qry.Free;
  end;

end;

procedure TDaoEstoqueProduto.Valida(aESTOQUEPRODUTO: TEstoqueProduto);
begin

  if aESTOQUEPRODUTO.QUANTIDADE < 0 then
    raise Exception.Create('QUANTIDADE PRECISA SER MAIOR QUE ZERO');
end;

end.
