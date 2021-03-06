unit Dao.TDaoPedidoPeriodo;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase,
  Helper.TPedidoPeriodo,
  Dao.IDAOPedidoPeriodo;

type

  TDaoPedidoPeriodo = class(TDaoBase, IDAOPedidoPeriodo)
  public
    function GetTotaisBrutoPedido(DataInicio: TDate; DataFim: TDate): TListaPeriodoPedido;
    function GetTotaisParcelado(DataInicio: TDate; DataFim: TDate): TListaPeriodoPedido;
  end;

implementation

{ TDaoPedidoPeriodo }

uses Util.Exceptions, Dominio.Entidades.TFactory;

function TDaoPedidoPeriodo.GetTotaisBrutoPedido(DataInicio, DataFim: TDate): TListaPeriodoPedido;
var
  qry: TFDQuery;
  periodo: TPedidoPeriodo;
begin

  qry := TFactory.Query();
  try

    qry.SQL.Text := ''
      + 'SELECT Sum(valorbruto) valor, '
      + '       datapedido      data '
      + 'FROM   pedido '
      + 'where '
      + '       datapedido >= :dataInicial '
      + '       AND datapedido <= :dataFinal '
      + 'GROUP  BY datapedido '
      + 'ORDER  BY datapedido';

    qry.ParamByName('dataInicial').AsDate := DataInicio;
    qry.ParamByName('dataFinal').AsDate := DataFim;
    qry.open;

    Result := TListaPeriodoPedido.Create();

    while not qry.Eof do
    begin
      Result.Periodos.Add(
        TPedidoPeriodo.Create(
        qry.FieldByName('data').AsDateTime,
        qry.FieldByName('valor').AsCurrency)
        );
      qry.Next;
    end;

    FreeAndNil(qry);

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha GetPorPeriodo: ' + E.Message);
    end;
  end;

end;

function TDaoPedidoPeriodo.GetTotaisParcelado(DataInicio, DataFim: TDate):TListaPeriodoPedido;
var
  qry: TFDQuery;
  periodo: TPedidoPeriodo;
begin

  qry := TFactory.Query();
  try

    qry.SQL.Text := ''
      + 'SELECT Sum(valorliquido) valor, '
      + '       datapedido      data '
      + 'FROM   pedido '
      + 'where '
      + '       datapedido >= :dataInicial '
      + '       AND datapedido <= :dataFinal '
      + 'GROUP  BY datapedido '
      + 'ORDER  BY datapedido';

    qry.ParamByName('dataInicial').AsDate := DataInicio;
    qry.ParamByName('dataFinal').AsDate := DataFim;
    qry.open;

    Result := TListaPeriodoPedido.Create();

    while not qry.Eof do
    begin
      Result.Periodos.Add(
        TPedidoPeriodo.Create(
        qry.FieldByName('data').AsDateTime,
        qry.FieldByName('valor').AsCurrency)
        );
      qry.Next;
    end;

    FreeAndNil(qry);

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha GetPorPeriodo: ' + E.Message);
    end;
  end;

end;

end.
