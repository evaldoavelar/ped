unit Dao.TDaoPedido;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB, FireDAC.Comp.Client, Dao.IDaoPedido,
  Dao.TDaoBase,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TPedido, Dominio.Entidades.TParcelas, Helper.TProdutoVenda, Dao.IDaoParceiro, Dao.TDaoParceiro, Dao.TDaoParceiroVenda;

type

  TDaoPedido = class(TDaoBase, IDaoPedido)
  private
    FProperty1: Integer;
    procedure ObjectToParams(ds: TFDQuery; pedido: TPedido);
    function ParamsToObject(ds: TFDQuery): TPedido;
    procedure Valida(pedido: TPedido);
    procedure SetProperty1(val: Integer);
  public
    procedure AbrePedido(pedido: TPedido);
    procedure VendeItem(Item: TItemPedido);
    procedure ExcluiItem(Item: TItemPedido);
    procedure GravaParcelas(parcelas: TObjectList<TParcelas>);
    procedure AtualizaPedido(pedido: TPedido);
    procedure AdicionaComprovante(pedido: TPedido);
    procedure FinalizaPedido(pedido: TPedido);
    function getPedido(id: Integer): TPedido;
    function GeraID: Integer;
    function Listar(campo, valor: string; dataInicio, dataFim: TDate): TDataSet; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(dataInicio, dataFim: TDate): TDataSet; overload;
    function Totais(dataInicio, dataFim: TDate): TList<TPair<string, string>>; overload;
    function Totais(dataInicio, dataFim: TDate; CodVen: string): TList<TPair<string, string>>; overload;
    // function Totais(dataInicio, dataFim: TDate; CodVen: string): TList<TPair<string, string>>; overload;
    function ProdutosVendidos(dataInicio, dataFim: TDate): TList<TProdutoVenda>;
    function TotaisParceiro(dataInicio, dataFim: TDate; CodParceiro: string): TList<TPair<string, Currency>>;
  end;

implementation

uses
  Util.Exceptions, Dao.TDaoItemPedido, Dao.TDaoParcelas, Dao.TDaoVendedor, Dao.TDaoCliente, Dominio.Entidades.TFactory;

{ TDaoPedido }

function TDaoPedido.ProdutosVendidos(dataInicio, dataFim: TDate): TList<TProdutoVenda>;
var
  qry: TFDQuery;

begin
  result := TList<TProdutoVenda>.Create;

  qry := TFactory.Query();
  try
    qry.SQL.Text := ''
      + 'SELECT pr.codigo, '
      + '       pr.descricao, '
      + '       Count(it.codproduto) quantidade, '
      + '       Sum(it.valor_total)  total '
      + 'FROM   produto pr, '
      + '       itempedido it, '
      + '       pedido pe '
      + 'WHERE  it.idpedido = pe.id '
      + '       AND pr.codigo = it.codproduto '
      + '       AND pe.status = ''F'' '
      + '       AND pe.datapedido >= :dataInicio '
      + '       AND pe.datapedido <= :dataFim '
      + 'GROUP  BY pr.codigo, '
      + '          pr.descricao';

    qry.ParamByName('dataInicio').AsDate := dataInicio;
    qry.ParamByName('dataFim').AsDate := dataFim;

    try
      qry.Open;

      while not qry.Eof do
      begin
        result.Add(
          TProdutoVenda.Create(
          qry.FieldByName('quantidade').AsFloat,
          qry.FieldByName('total').AsCurrency,
          qry.FieldByName('descricao').AsString
          )
          );

        qry.Next;
      end;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoPedido.AdicionaComprovante(pedido: TPedido);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    qry.SQL.Text := ''
      + 'UPDATE pedido '
      + 'SET    COMPROVANTE = :COMPROVANTE '
      + 'WHERE  id = :id';

    ObjectToParams(qry, pedido);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoPedido.AtualizaPedido(pedido: TPedido);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    qry.SQL.Text := ''
      + 'UPDATE pedido '
      + 'SET    numero = :NUMERO, '
      + '       datapedido = :DATAPEDIDO, '
      + '       OBSERVACAO = :OBSERVACAO,'
      + '       valorbruto = :VALORBRUTO, '
      + '       valordesc = :VALORDESC, '
      + '       VALORENTRADA = :VALORENTRADA, '
      + '       valorliquido = :VALORLIQUIDO, '
      + '       codven = :CODVEN, '
      + '       CODVENCANCELAMENTO = :CODVENCANCELAMENTO, '
      + '       DATACANCELAMENTO = :DATACANCELAMENTO,'
      + '       codcliente = :CODCLIENTE, '
      + '       HORAPEDIDO = :HORAPEDIDO, '
      + '       STATUS = :STATUS '
      + 'WHERE  id = :id';

    ObjectToParams(qry, pedido);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoPedido.ExcluiItem(Item: TItemPedido);
var
  DaoItemPedido: TDaoItemPedido;
begin
  DaoItemPedido := TDaoItemPedido.Create(Self.FConnection);
  DaoItemPedido.ExcluiItemPedido(Item.SEQ, Item.IDPEDIDO);
  DaoItemPedido.Free;

end;

procedure TDaoPedido.FinalizaPedido(pedido: TPedido);
var
  qry: TFDQuery;
begin

  Valida(pedido);

  if pedido.Cliente.CODIGO = '000000' then
    raise TValidacaoException.Create('O Consulmidor do pedido precisa ser identificado');

  qry := TFactory.Query();
  try
    qry.SQL.Text := ''
      + 'UPDATE pedido '
      + 'SET   '
      + '       valordesc = :VALORDESC, '
      + '       VALORENTRADA = :VALORENTRADA, '
      + '       valorliquido = :VALORLIQUIDO, '
      + '       OBSERVACAO = :OBSERVACAO, '
      + '       status = :STATUS, '
      + '       CODPARCEIRO = :CODPARCEIRO, '
      + '       NOMEPARCEIRO = :NOMEPARCEIRO, '
      + '       codcliente = :codcliente '
      + 'WHERE  id = :id';

    ObjectToParams(qry, pedido);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoPedido.GeraID: Integer;
begin
  result := AutoIncremento('PEDIDO', 'ID');
end;

function TDaoPedido.getPedido(id: Integer): TPedido;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PEDIDO '
        + 'WHERE '
        + '     ID = :ID';

      qry.ParamByName('ID').AsInteger := id;
      qry.Open;

      if qry.IsEmpty then
        result := nil
      else
        result := ParamsToObject(qry);

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

procedure TDaoPedido.GravaParcelas(parcelas: TObjectList<TParcelas>);
VAR
  DAOParcelas: TDaoParcelas;
  I: Integer;
begin
  DAOParcelas := TDaoParcelas.Create(Self.FConnection);

  for I := 0 to parcelas.Count - 1 do
  begin
    if DAOParcelas.GeTParcela(parcelas.Items[I].NUMPARCELA, parcelas.Items[I].IDPEDIDO) = nil then
      DAOParcelas.IncluiParcelas(parcelas.Items[I])
    else
      DAOParcelas.AtualizaParcelas(parcelas.Items[I]);
  end;

  FreeAndNil(DAOParcelas);
end;

function TDaoPedido.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT pe.*, '
      + '       c.nome '
      + 'FROM   pedido pe, '
      + '       cliente c '
      + 'WHERE  pe.codcliente = c.codigo ';

    if valor <> '' then
      qry.SQL.Add(' and upper( ' + campo + ') LIKE ' + QuotedStr(UpperCase(valor + '%')));

    qry.SQL.Add(' order by pe.id');
    qry.Open;

    result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Pedido: ' + E.Message);
    end;
  end;

end;

function TDaoPedido.Listar(dataInicio, dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT pe.*, '
      + '       c.nome '
      + 'FROM   pedido pe, '
      + '       cliente c '
      + 'WHERE  pe.codcliente = c.codigo '
      + '       AND pe.datapedido >= :dataInicio '
      + '       AND pe.datapedido <= :dataFim '
      + 'order by pe.id ';
    qry.ParamByName('dataInicio').AsDate := dataInicio;
    qry.ParamByName('dataFim').AsDate := dataFim;

    qry.Open;

    result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Pedido: ' + E.Message);
    end;
  end;

end;

function TDaoPedido.Listar(campo, valor: string; dataInicio,
  dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try

    qry.SQL.Text := ''
      + 'SELECT pe.*, '
      + '       c.nome '
      + 'FROM   pedido pe, '
      + '       cliente c '
      + 'WHERE  pe.codcliente = c.codigo '
      + '       AND pe.datapedido >= :dataInicio '
      + '       AND pe.datapedido <= :dataFim ';

    if valor <> '' then
      qry.SQL.Add(' and upper( ' + campo + ') LIKE ' + QuotedStr(UpperCase(valor) + '%'));

    qry.SQL.Add(' order by pe.id');

    qry.ParamByName('dataInicio').AsDate := dataInicio;
    qry.ParamByName('dataFim').AsDate := dataFim;

    qry.Open;

    result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Pedido: ' + E.Message);
    end;
  end;

end;

procedure TDaoPedido.AbrePedido(pedido: TPedido);
var
  qry: TFDQuery;
begin
  Valida(pedido);

  qry := TFactory.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'INSERT INTO pedido '
      + '            (id, '
      + '             numero, '
      + '             datapedido, '
      + '             OBSERVACAO, '
      + '             valorbruto, '
      + '             valordesc, '
      + '             VALORENTRADA, '
      + '             valorliquido, '
      + '             status, '
      + '             codven, '
      + '             CODVENCANCELAMENTO,'
      + '             DATACANCELAMENTO, '
      + '             codcliente, '
      + '             CODPARCEIRO, '
      + '             horapedido) '
      + 'VALUES      ( :ID, '
      + '              :NUMERO, '
      + '              :DATAPEDIDO, '
      + '              :OBSERVACAO, '
      + '              :VALORBRUTO, '
      + '              :VALORDESC, '
      + '              :VALORENTRADA, '
      + '              :VALORLIQUIDO, '
      + '              :STATUS, '
      + '              :CODVEN, '
      + '              :CODVENCANCELAMENTO,'
      + '              :DATACANCELAMENTO,'
      + '              :CODCLIENTE, '
      + '              :CODPARCEIRO, '
      + '              :HORAPEDIDO)';

    ObjectToParams(qry, pedido);

    try
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.Message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDaoPedido.ObjectToParams(ds: TFDQuery; pedido: TPedido);
begin
  try
    if ds.Params.FindParam('ID') <> nil then
      ds.Params.ParamByName('ID').AsInteger := pedido.id;
    if ds.Params.FindParam('NUMERO') <> nil then
      ds.Params.ParamByName('NUMERO').Value := pedido.NUMERO;
    if ds.Params.FindParam('DATAPEDIDO') <> nil then
      ds.Params.ParamByName('DATAPEDIDO').AsDate := pedido.DATAPEDIDO;
    if ds.Params.FindParam('OBSERVACAO') <> nil then
      ds.Params.ParamByName('OBSERVACAO').AsString := pedido.OBSERVACAO;
    if ds.Params.FindParam('VALORBRUTO') <> nil then
      ds.Params.ParamByName('VALORBRUTO').AsCurrency := pedido.VALORBRUTO;
    if ds.Params.FindParam('VALORDESC') <> nil then
      ds.Params.ParamByName('VALORDESC').AsCurrency := pedido.VALORDESC;
    if ds.Params.FindParam('VALORENTRADA') <> nil then
      ds.Params.ParamByName('VALORENTRADA').AsCurrency := pedido.ValorEntrada;
    if ds.Params.FindParam('VALORLIQUIDO') <> nil then
      ds.Params.ParamByName('VALORLIQUIDO').AsCurrency := pedido.VALORLIQUIDO;
    if ds.Params.FindParam('STATUS') <> nil then
      ds.Params.ParamByName('STATUS').AsString := pedido.STATUS;
    if ds.Params.FindParam('CODVEN') <> nil then
      ds.Params.ParamByName('CODVEN').AsString := pedido.Vendedor.CODIGO;
    if ds.Params.FindParam('CODVENCANCELAMENTO') <> nil then
    begin
      if Assigned(pedido.VendedorCancelamento) then
      begin
        ds.Params.ParamByName('CODVENCANCELAMENTO').AsString := pedido.VendedorCancelamento.CODIGO
      end
      else
      begin
        ds.Params.ParamByName('CODVENCANCELAMENTO').DataType := ftString;
        ds.Params.ParamByName('CODVENCANCELAMENTO').Clear();
      end;
    end;

    if (ds.Params.FindParam('DATACANCELAMENTO') <> nil) and (pedido.DATACANCELAMENTO <> 0) then
      ds.Params.ParamByName('DATACANCELAMENTO').AsDate := pedido.DATAPEDIDO;

    if ds.Params.FindParam('CODCLIENTE') <> nil then
      ds.Params.ParamByName('CODCLIENTE').AsString := pedido.Cliente.CODIGO;
    if ds.Params.FindParam('HORAPEDIDO') <> nil then
      ds.Params.ParamByName('HORAPEDIDO').AsTime := pedido.HORAPEDIDO;
    if ds.Params.FindParam('COMPROVANTE') <> nil then
      ds.Params.ParamByName('COMPROVANTE').Assign(pedido.COMPROVANTE.Picture.Graphic);

    if (ds.Params.FindParam('CODPARCEIRO') <> nil) and (pedido.ParceiroVenda <> nil) then
      ds.Params.ParamByName('CODPARCEIRO').AsString := pedido.ParceiroVenda.CODIGO;

    if (ds.Params.FindParam('NOMEPARCEIRO') <> nil) and (pedido.ParceiroVenda <> nil) then
      ds.Params.ParamByName('NOMEPARCEIRO').AsString := pedido.ParceiroVenda.NOME;

  except
    on E: Exception do
      raise TDaoException.Create('Falha ao associar parâmetros Pedido: ' + E.Message);
  end;
end;

Procedure LoadBitmapFromBlob(Bitmap: TBitmap; Blob: TBlobField);
var
  ms, ms2: TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    Blob.SaveToStream(ms);
    ms.Position := 0;
    Bitmap.LoadFromStream(ms);
  finally
    ms.Free;
  end;
end;

function TDaoPedido.ParamsToObject(ds: TFDQuery): TPedido;
var
  DaoVendedor: TDaoVendedor;
  DaoParceiro: TDaoParceiro;
  DaoCliente: TDaoCliente;
  DaoItensPedido: TDaoItemPedido;
  DAOParcelas: TDaoParcelas;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  bmp: TBitmap;
begin
  try
    DaoVendedor := TDaoVendedor.Create(Self.FConnection);
    DaoCliente := TDaoCliente.Create(Self.FConnection);
    DaoItensPedido := TDaoItemPedido.Create(Self.FConnection);
    DAOParcelas := TDaoParcelas.Create(Self.FConnection);
    DaoParceiro := TDaoParceiro.Create(Self.FConnection);

    result := TPedido.Create;
    result.id := ds.FieldByName('ID').AsInteger;
    result.NUMERO := ds.FieldByName('NUMERO').AsString;
    result.DATAPEDIDO := ds.FieldByName('DATAPEDIDO').AsDateTime;
    result.OBSERVACAO := ds.FieldByName('OBSERVACAO').AsString;
    // Result.VALORBRUTO := ds.FieldByName('VALORBRUTO').AsCurrency;
    result.VALORDESC := ds.FieldByName('VALORDESC').AsCurrency;
    result.ValorEntrada := ds.FieldByName('VALORENTRADA').AsCurrency;
    // Result.VALORLIQUIDO := ds.FieldByName('VALORLIQUIDO').AsCurrency;
    result.STATUS := ds.FieldByName('STATUS').AsString;
    result.Vendedor := DaoVendedor.GetVendedor(ds.FieldByName('CODVEN').AsString);
    result.VendedorCancelamento := DaoVendedor.GetVendedor(ds.FieldByName('CODVENCANCELAMENTO').AsString);
    result.Cliente := DaoCliente.GeTCliente(ds.FieldByName('CODCLIENTE').AsString);
    result.HORAPEDIDO := ds.FieldByName('HORAPEDIDO').AsDateTime;
    result.AssignedItens(DaoItensPedido.GeTItemsPedido(result.id));
    result.parcelas := DAOParcelas.GeTParcelas(result.id);
    result.ParceiroVenda := DaoParceiro.GetParceiro(ds.FieldByName('CODPARCEIRO').AsString);

    if not ds.FieldByName('DATACANCELAMENTO').IsNull then
      result.DATACANCELAMENTO := ds.FieldByName('DATACANCELAMENTO').AsDateTime;

    if not ds.FieldByName('COMPROVANTE').IsNull then
    begin
      result.COMPROVANTE := TImage.Create(nil);
      result.COMPROVANTE.Picture.Graphic := TJpegimage.Create;

      Stream := TMemoryStream.Create;
      // TBlobField(ds.FieldByName('COMPROVANTE')).SaveToStream(Stream);

      result.COMPROVANTE.Picture.Graphic.Assign(ds.FieldByName('COMPROVANTE'));

      FreeAndNil(Stream);
      //
      // Result.COMPROVANTE.Picture.Bitmap := TBitmap.Create;
      // Result.COMPROVANTE.Picture.Graphic.LoadFromStream(Stream);

      // bmp := TBitmap.Create;
      // try
      // LoadBitmapFromBlob(bmp, TBlobField(ds.FieldByName('COMPROVANTE')));
      // Result.COMPROVANTE.Picture.Assign(bmp);
      // finally
      // bmp.Free;
      // end;
    end;

    FreeAndNil(DaoVendedor);
    FreeAndNil(DaoItensPedido);
    FreeAndNil(DAOParcelas);
    FreeAndNil(DaoCliente);
    FreeAndNil(DaoParceiro);
  except
    on E: Exception do
      raise TDaoException.Create('Falha ao popular objeto Pedido: ' + E.Message);
  end;
end;

function TDaoPedido.Totais(dataInicio, dataFim: TDate; CodVen: string): TList<TPair<string, string>>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  result := TList < TPair < string, string >>.Create();

  try
    try
      qry.SQL.Text := ''

        + 'SELECT ''Venda Bruta''     Titulo, '
        + '       Sum(p.valorbruto) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.codven = :codven '

        + 'UNION ALL '

        + 'SELECT ''Total Entradas'' Titulo, '
        + '       Sum(p.valorentrada) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.codven = :codven '

        + 'UNION ALL '

        + 'SELECT ''Total Parcelado''    Titulo, '
        + '       Sum(p.valorliquido) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.codven = :codven '

        + 'UNION ALL '

        + 'SELECT ''Total Parcelas Recebidas''    Titulo, '
        + '       sum(pa.valor) AS Total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.recebido = ''S'''
        + '       AND pa.databaixa >= :dataInicio '
        + '       AND pa.databaixa <= :dataFim '
        + '       and pa.CODVENRECEBIMENTO = :codven ';

      qry.ParamByName('dataInicio').AsDate := dataInicio;
      qry.ParamByName('dataFim').AsDate := dataFim;
      qry.ParamByName('codven').AsString := CodVen;

      qry.Open;

      while not qry.Eof do
      begin
        result.Add(TPair<string, string>.Create(qry.FieldByName('Titulo').AsString, FormatCurr('R$ 0.,00', qry.FieldByName('Total').AsCurrency)));
        qry.Next;
      end;

      qry.SQL.Text := ''
        + 'SELECT ''Numero de Cancelamentos'' AS Titulo, '
        + '       count(p.id)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''C'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.codven = :CODVENCANCELAMENTO '

        + 'UNION ALL '

        + 'SELECT ''Numero de Parcelas Recebidas''    Titulo, '
        + '       count(pa.idpedido) AS Total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.recebido = ''S'''
        + '       AND pa.databaixa >= :dataInicio '
        + '       AND pa.databaixa <= :dataFim '
        + '       and pa.CODVENRECEBIMENTO = :codven ';

      qry.ParamByName('dataInicio').AsDate := dataInicio;
      qry.ParamByName('dataFim').AsDate := dataFim;
      qry.ParamByName('codven').AsString := CodVen;

      qry.Open;

      while not qry.Eof do
      begin
        result.Add(TPair<string, string>.Create(qry.FieldByName('Titulo').AsString, qry.FieldByName('Total').AsString));
        qry.Next;
      end;
    finally
      FreeAndNil(qry);
    end;
  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha ao calcular Totais: ' + E.Message);
    end;
  end;

end;

function TDaoPedido.Totais(dataInicio, dataFim: TDate): TList<TPair<string, string>>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  result := TList < TPair < string, string >>.Create();

  try
    try
      qry.SQL.Text := ''

        + 'SELECT ''Venda Bruta''     Titulo, '
        + '       Sum(p.valorbruto) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '
        + 'SELECT ''Entradas'' Titulo, '
        + '       Sum(p.valorentrada) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '
        + 'SELECT ''Total Parcelado''    Titulo, '
        + '       Sum(p.valorliquido) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '
        + 'SELECT ''Total de Parcelas Recebidas''    Titulo, '
        + '       Sum(pa.valor) AS Total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.recebido = ''S'''
        + '       AND pa.databaixa >= :dataInicio '
        + '       AND pa.databaixa <= :dataFim '
        ;

      qry.ParamByName('dataInicio').AsDate := dataInicio;
      qry.ParamByName('dataFim').AsDate := dataFim;

      qry.Open;

      while not qry.Eof do
      begin
        result.Add(TPair<string, string>.Create(qry.FieldByName('Titulo').AsString, FormatCurr('R$ 0.,00', qry.FieldByName('Total').AsCurrency)));
        qry.Next;
      end;

      qry.SQL.Text := ''
        + 'SELECT ''Numero de Pedidos Concluídos'' AS Titulo, '
        + '       count(p.id)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '

        + 'SELECT ''Numero de Cancelamentos'' AS Titulo, '
        + '       count(p.id)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''C'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '

        + 'SELECT ''Numero de Pedidos Não Finalizados'' AS Titulo, '
        + '       count(p.id)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''A'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '

        + 'SELECT ''Numero de Parcelas Recebidas''    Titulo, '
        + '       count(pa.valor) AS Total '
        + 'FROM   parcelas pa, '
        + '       pedido pe '
        + 'WHERE  pa.idpedido = pe.id '
        + '       AND pe.status = ''F'' '
        + '       AND pa.recebido = ''S'''
        + '       AND pa.databaixa >= :dataInicio '
        + '       AND pa.databaixa <= :dataFim '
        ;

      qry.ParamByName('dataInicio').AsDate := dataInicio;
      qry.ParamByName('dataFim').AsDate := dataFim;

      qry.Open;

      while not qry.Eof do
      begin
        result.Add(TPair<string, string>.Create(qry.FieldByName('Titulo').AsString, qry.FieldByName('Total').AsString));
        qry.Next;
      end;
    finally
      FreeAndNil(qry);
    end;
  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha ao calcular Totais: ' + E.Message);
    end;
  end;

end;

procedure TDaoPedido.Valida(pedido: TPedido);
begin
  if pedido.Vendedor = nil then
    raise TValidacaoException.Create('Vendedor não associado ao pedido');

  if pedido.Cliente = nil then
    raise TValidacaoException.Create('Cliente não associado ao pedido');

end;

procedure TDaoPedido.VendeItem(Item: TItemPedido);
var
  DaoItemPedido: TDaoItemPedido;
begin
  DaoItemPedido := TDaoItemPedido.Create(Self.FConnection);
  DaoItemPedido.IncluiItemPedido(Item);
  FreeAndNil(DaoItemPedido);
end;

procedure TDaoPedido.SetProperty1(val: Integer);
begin
end;

function TDaoPedido.TotaisParceiro(dataInicio, dataFim: TDate; CodParceiro: string): TList<TPair<string, Currency>>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  result := TList < TPair < string, Currency >>.Create();

  try
    try
      qry.SQL.Text := ''

        + 'SELECT ''CREDIÁRIO''    Titulo, '
        + '       Sum(p.valorliquido) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.CODPARCEIRO = :CODPARCEIRO '    ;

      qry.ParamByName('dataInicio').AsDate := dataInicio;
      qry.ParamByName('dataFim').AsDate := dataFim;
      qry.ParamByName('CODPARCEIRO').AsString := CodParceiro;

      qry.Open;

      while not qry.Eof do
      begin
        result.Add(TPair<string, Currency>.Create(qry.FieldByName('Titulo').AsString,  qry.FieldByName('Total').AsCurrency));
        qry.Next;
      end;

    finally
      FreeAndNil(qry);
    end;
  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha ao calcular Totais: ' + E.Message);
    end;
  end;

end;

end.
