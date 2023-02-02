unit Dao.TDaoPedido;

interface

uses
  System.Generics.Collections, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB, FireDAC.Comp.Client, Dao.IDaoPedido,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TPedido, Dominio.Entidades.TParcelas,
  Helper.TProdutoVenda, Dao.IDaoParceiro, Dao.TDaoParceiro, Dao.TDaoParceiroVenda,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dominio.Entidades.Pedido.Pagamentos;

type

  TDaoPedido = class(TDaoBase, IDaoPedido)
  private
    FProperty1: Integer;
    procedure ObjectToParams(ds: TFDQuery; Pedido: TPedido);
    function ParamsToObject(ds: TFDQuery): TPedido;
    procedure Valida(Pedido: TPedido);
    function AtualizarEstoque(Pedido: TPedido): Integer;

  public
    procedure AbrePedido(Pedido: TPedido);
    procedure VendeItem(Item: TItemPedido);
    procedure ExcluiItem(Item: TItemPedido);
    procedure GravaPgamento(Pagamentos: TPAGAMENTOS);
    procedure AtualizaPedido(Pedido: TPedido);
    procedure AdicionaComprovante(Pedido: TPedido);
    procedure FinalizaPedido(Pedido: TPedido);
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
  Util.Exceptions, Dao.TDaoItemPedido, Dao.TDaoParcelas, Dao.TDaoVendedor, Dao.TDaoCliente, Factory.Dao, Dao.TDaoFormaPagto, Dao.TDAOPedidoPagamento,
  Dominio.Entidades.TEstoqueProduto, Utils.ArrayUtil, IFactory.Dao;

{ TDaoPedido }

function TDaoPedido.ProdutosVendidos(dataInicio, dataFim: TDate): TList<TProdutoVenda>;
var
  qry: TFDQuery;

begin
  result := TList<TProdutoVenda>.Create;

  qry := Self.Query();
  try
    qry.SQL.Text := ''
      + 'SELECT pr.codigo, '
      + '       pr.descricao, '
      + '       Sum(it.qtd) quantidade, '
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
      TLog.d(qry);
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
        TLog.d(E.message);
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoPedido.AdicionaComprovante(Pedido: TPedido);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    qry.SQL.Text := ''
      + 'UPDATE pedido '
      + 'SET    COMPROVANTE = :COMPROVANTE '
      + 'WHERE  id = :id';

    ObjectToParams(qry, Pedido);

    try
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoPedido.AtualizaPedido(Pedido: TPedido);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
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
      + '       TROCO = :TROCO, '
      + '       VALORACRESCIMO = :VALORACRESCIMO, '
      + '       STATUS = :STATUS '
      + 'WHERE  id = :id';

    ObjectToParams(qry, Pedido);

    try
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.message);
      end;
    end;

    if Pedido.STATUS = 'C' then
      AtualizarEstoque(Pedido);

  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoPedido.ExcluiItem(Item: TItemPedido);
var
  DaoItemPedido: TDaoItemPedido;
begin
  DaoItemPedido := TDaoItemPedido.Create(Self.FConnection, true);
  DaoItemPedido.ExcluiItemPedido(Item.SEQ, Item.IDPEDIDO);
  DaoItemPedido.Free;

end;

procedure TDaoPedido.FinalizaPedido(Pedido: TPedido);
var
  qry: TFDQuery;
begin

  Valida(Pedido);

  // if pedido.Cliente.CODIGO = '000000' then
  // raise TValidacaoException.Create('O Consulmidor do pedido precisa ser identificado');

  qry := Self.Query();
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
      + '       TROCO = :TROCO, '
      + '       VALORACRESCIMO = :VALORACRESCIMO, '
      + '       codcliente = :codcliente '
      + 'WHERE  id = :id';

    ObjectToParams(qry, Pedido);

    try
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.message);
      end;
    end;

    AtualizarEstoque(Pedido);
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoPedido.AtualizarEstoque(Pedido: TPedido): Integer;
var
  LFactory: IFactoryDao;
BEGIN
  LFactory := TFactory.new(FConnection,true);

  for var ProdutoServicoOS in Pedido.itens do
  begin

    VAR
    ESTOQUE := TEstoqueProduto.Create;
    ESTOQUE.SEQPRODUTOPEDIDO := ProdutoServicoOS.SEQ;
    ESTOQUE.IDPEDIDO := Pedido.id;
    ESTOQUE.CODIGOPRD := ProdutoServicoOS.CODPRODUTO;
    ESTOQUE.DESCRICAO := ProdutoServicoOS.DESCRICAO;
    ESTOQUE.NOTAFISCAL := '';
    ESTOQUE.QUANTIDADE := ProdutoServicoOS.QTD;
    ESTOQUE.TIPO := 'S';
    ESTOQUE.STATUS := 'A';
    ESTOQUE.Data := now;
    ESTOQUE.StatusBD := TEstoqueProduto.TStatusBD.stCriar;
    ESTOQUE.USUARIOCRIACAO := Pedido.Vendedor.NOME;

    if Pedido.STATUS = 'C' then
    begin
      // Flog.d('PRODUTO DELETADO REMOVER ENTRADA DO ESTOQUE %d', [ProdutoServicoOS.DESCRICAO]);
      LFactory.DaoEstoqueProduto.Delete(ESTOQUE);
      // Flog.d('DEVOLVER O SALDO');
      LFactory.DaoProduto.EntradaSaidaEstoque(ESTOQUE.CODIGOPRD, (ESTOQUE.QUANTIDADE), false);
    end
    else
    begin
      LFactory.DaoEstoqueProduto.Inclui(ESTOQUE);
      // // Flog.d('BAIXAR O ESTOQUE');
      LFactory.DaoProduto.EntradaSaidaEstoque(ESTOQUE.CODIGOPRD, (ESTOQUE.QUANTIDADE * -1), false);
    end;

    FreeAndNil(ESTOQUE);
  end;

END;

function TDaoPedido.GeraID: Integer;
begin
  try
    FConnection.StartTransaction;
    result := AutoIncremento('PEDIDO', 'ID');
    FConnection.Commit;
  except
    on E: Exception do
    begin
      FConnection.Rollback;
      raise;
    end;
  end;
end;

function TDaoPedido.getPedido(id: Integer): TPedido;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  PEDIDO '
        + 'WHERE '
        + '     ID = :ID';

      qry.ParamByName('ID').AsInteger := id;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        result := nil
      else
        result := ParamsToObject(qry);

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

procedure TDaoPedido.GravaPgamento(Pagamentos: TPAGAMENTOS);
var
  DaoFormaPagto: TDAOPedidoPagamento;
  pagto: TPEDIDOPAGAMENTO;
begin
  DaoFormaPagto := TDAOPedidoPagamento.Create(Self.FConnection, true);

  for pagto in Pagamentos.FormasDePagamento do
  begin
    if DaoFormaPagto.GetPAGTO(pagto.SEQ, pagto.IDPEDIDO) = nil then
      DaoFormaPagto.Inclui(pagto)
    else
      DaoFormaPagto.Atualiza(pagto);
  end;

  FreeAndNil(DaoFormaPagto);

end;

function TDaoPedido.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

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
    TLog.d(qry);
    qry.Open;

    result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pedido: ' + E.message);
    end;
  end;

end;

function TDaoPedido.Listar(dataInicio, dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

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

    TLog.d(qry);
    qry.Open;

    result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pedido: ' + E.message);
    end;
  end;

end;

function TDaoPedido.Listar(campo, valor: string; dataInicio,
  dataFim: TDate): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

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

    TLog.d(qry);
    qry.Open;

    result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pedido: ' + E.message);
    end;
  end;

end;

procedure TDaoPedido.AbrePedido(Pedido: TPedido);
var
  qry: TFDQuery;
begin
  Valida(Pedido);

  qry := Self.Query();
  try
    qry.Connection := FConnection;
    qry.SQL.Text := ''
      + 'INSERT INTO pedido '
      + '            (id, '
      + '             numero, '
      + '             NUMCAIXA, '
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
      + '              :NUMCAIXA, '
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

    ObjectToParams(qry, Pedido);

    try
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ao Gravar Pedido: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDaoPedido.ObjectToParams(ds: TFDQuery; Pedido: TPedido);
begin
  try
    if ds.Params.FindParam('ID') <> nil then
      ds.Params.ParamByName('ID').AsInteger := Pedido.id;
    if ds.Params.FindParam('NUMERO') <> nil then
      ds.Params.ParamByName('NUMERO').Value := Pedido.NUMERO;
    if ds.Params.FindParam('DATAPEDIDO') <> nil then
      ds.Params.ParamByName('DATAPEDIDO').AsDate := Pedido.DATAPEDIDO;
    if ds.Params.FindParam('OBSERVACAO') <> nil then
      ds.Params.ParamByName('OBSERVACAO').AsString := Pedido.OBSERVACAO;
    if ds.Params.FindParam('VALORBRUTO') <> nil then
      ds.Params.ParamByName('VALORBRUTO').AsCurrency := Pedido.VALORBRUTO;
    if ds.Params.FindParam('TROCO') <> nil then
      ds.Params.ParamByName('TROCO').AsCurrency := Pedido.TROCO;
    if ds.Params.FindParam('VALORACRESCIMO') <> nil then
      ds.Params.ParamByName('VALORACRESCIMO').AsCurrency := Pedido.VALORACRESCIMO;
    if ds.Params.FindParam('VALORDESC') <> nil then
      ds.Params.ParamByName('VALORDESC').AsCurrency := Pedido.VALORDESC;
    if ds.Params.FindParam('VALORENTRADA') <> nil then
      ds.Params.ParamByName('VALORENTRADA').AsCurrency := Pedido.ValorEntrada;
    if ds.Params.FindParam('VALORLIQUIDO') <> nil then
      ds.Params.ParamByName('VALORLIQUIDO').AsCurrency := Pedido.VALORLIQUIDO;
    if ds.Params.FindParam('STATUS') <> nil then
      ds.Params.ParamByName('STATUS').AsString := Pedido.STATUS;
    if ds.Params.FindParam('CODVEN') <> nil then
      ds.Params.ParamByName('CODVEN').AsString := Pedido.Vendedor.CODIGO;
    if ds.Params.FindParam('CODVENCANCELAMENTO') <> nil then
    begin
      if Assigned(Pedido.VendedorCancelamento) then
      begin
        ds.Params.ParamByName('CODVENCANCELAMENTO').AsString := Pedido.VendedorCancelamento.CODIGO
      end
      else
      begin
        ds.Params.ParamByName('CODVENCANCELAMENTO').DataType := ftString;
        ds.Params.ParamByName('CODVENCANCELAMENTO').Clear();
      end;
    end;

    if (ds.Params.FindParam('DATACANCELAMENTO') <> nil) and (Pedido.DATACANCELAMENTO <> 0) then
      ds.Params.ParamByName('DATACANCELAMENTO').AsDate := Pedido.DATAPEDIDO;

    if ds.Params.FindParam('CODCLIENTE') <> nil then
      ds.Params.ParamByName('CODCLIENTE').AsString := Pedido.Cliente.CODIGO;
    if ds.Params.FindParam('HORAPEDIDO') <> nil then
      ds.Params.ParamByName('HORAPEDIDO').AsTime := Pedido.HORAPEDIDO;
    if ds.Params.FindParam('COMPROVANTE') <> nil then
      ds.Params.ParamByName('COMPROVANTE').Assign(Pedido.COMPROVANTE.Picture.Graphic);

    if (ds.Params.FindParam('CODPARCEIRO') <> nil) and (Pedido.ParceiroVenda <> nil) then
      ds.Params.ParamByName('CODPARCEIRO').AsString := Pedido.ParceiroVenda.CODIGO;

    if (ds.Params.FindParam('NOMEPARCEIRO') <> nil) and (Pedido.ParceiroVenda <> nil) then
      ds.Params.ParamByName('NOMEPARCEIRO').AsString := Pedido.ParceiroVenda.NOME;

    if (ds.Params.FindParam('NUMCAIXA') <> nil) and (Pedido.NUMCAIXA <> '') then
      ds.Params.ParamByName('NUMCAIXA').AsString := Pedido.NUMCAIXA;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros Pedido: ' + E.message);
    end;
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
  DaoPagamentos: TDAOPedidoPagamento;
  DaoItensPedido: TDaoItemPedido;
  DAOParcelas: TDaoParcelas;
  Stream: TMemoryStream;
  BlobField: TBlobField;
  bmp: TBitmap;
begin
  try
    DaoVendedor := TDaoVendedor.Create(Self.FConnection, true);
    DaoCliente := TDaoCliente.Create(Self.FConnection, true);
    DaoItensPedido := TDaoItemPedido.Create(Self.FConnection, true);
    DAOParcelas := TDaoParcelas.Create(Self.FConnection, true);
    DaoParceiro := TDaoParceiro.Create(Self.FConnection, true);
    DaoPagamentos := TDAOPedidoPagamento.Create(Self.FConnection, true);

    result := TPedido.Create;
    result.id := ds.FieldByName('ID').AsInteger;
    result.NUMERO := ds.FieldByName('NUMERO').AsString;
    result.NUMCAIXA := ds.FieldByName('NUMCAIXA').AsString;
    result.DATAPEDIDO := ds.FieldByName('DATAPEDIDO').AsDateTime;
    result.OBSERVACAO := ds.FieldByName('OBSERVACAO').AsString;
    // Result.VALORBRUTO := ds.FieldByName('VALORBRUTO').AsCurrency;
    result.VALORDESC := ds.FieldByName('VALORDESC').AsCurrency;
    result.ValorEntrada := ds.FieldByName('VALORENTRADA').AsCurrency;
    result.TROCO := ds.FieldByName('TROCO').AsCurrency;
    result.VALORACRESCIMO := ds.FieldByName('VALORACRESCIMO').AsCurrency;
    result.STATUS := ds.FieldByName('STATUS').AsString;
    result.Vendedor := DaoVendedor.GetVendedor(ds.FieldByName('CODVEN').AsString);
    result.VendedorCancelamento := DaoVendedor.GetVendedor(ds.FieldByName('CODVENCANCELAMENTO').AsString);
    result.Cliente := DaoCliente.GeTCliente(ds.FieldByName('CODCLIENTE').AsString);
    result.HORAPEDIDO := ds.FieldByName('HORAPEDIDO').AsDateTime;
    result.AssignedItens(DaoItensPedido.GeTItemsPedido(result.id));
    result.ParceiroVenda := DaoParceiro.GetParceiro(ds.FieldByName('CODPARCEIRO').AsString);
    result.Pagamentos.AssignedPagamentos(DaoPagamentos.ListaObject(ds.FieldByName('ID').AsInteger));

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
    FreeAndNil(DaoPagamentos);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao popular objeto Pedido: ' + E.message);
    end;
  end;
end;

function TDaoPedido.Totais(dataInicio, dataFim: TDate; CodVen: string): TList<TPair<string, string>>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  result := TList < TPair < string, string >>.Create();

  try
    try
      qry.SQL.Text := ''

        + 'SELECT ''Total Bruto''     Titulo, '
        + '       Sum(p.valorbruto) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.codven = :codven '

        + 'UNION ALL '

        + 'SELECT ''Descontos'' Titulo, '
        + '       Sum(p.VALORDESC)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.codven = :codven '

        + 'UNION ALL '

        + 'SELECT ''Total Líquido''     Titulo, '
        + '       Sum(p.valorbruto) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       and p.codven = :codven '


      // + 'UNION ALL '
      //
      // + 'SELECT ''Total Entradas'' Titulo, '
      // + '       Sum(p.valorentrada) AS Total '
      // + 'FROM   pedido p '
      // + 'WHERE  p.status = ''F'' '
      // + '       AND p.datapedido >= :dataInicio '
      // + '       AND p.datapedido <= :dataFim '
      // + '       and p.codven = :codven '

        + 'UNION ALL '

        + 'SELECT descricao Titulo, '
        + '       Sum(valor) AS Total '
        + 'FROM   pedidopagamento pg, '
        + '       pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.id = pg.idpedido '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + '       AND p.codven = :codven '
        + 'GROUP  BY descricao, '
        + '          tipo '

        + 'UNION ALL '

        + 'SELECT ''Total Troco'' Titulo, '
        + '       Sum(p.troco)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim'
        + '       AND p.codven = :codven '

        + 'UNION ALL '

        + 'SELECT CASE '
        + '         WHEN tipo = 1 THEN ''Sangria'' '
        + '         WHEN tipo = 2 THEN ''Suprimento'' '
        + '       END        Titulo, '
        + '       Sum(valor) AS Total '
        + 'FROM   sangriasuprimento '
        + 'WHERE  data >= :dataInicio '
        + '       AND data <= :dataFim '
        + '       AND codven = :codven '
        + 'GROUP  BY tipo '

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

      TLog.d(qry);
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

      TLog.d(qry);
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
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao calcular Totais: ' + E.message);
    end;
  end;

end;

function TDaoPedido.Totais(dataInicio, dataFim: TDate): TList<TPair<string, string>>;
var
  qry: TFDQuery;
  saidas: TArray<string>;
  sinal: string;
begin

  qry := Self.Query();
  result := TList < TPair < string, string >>.Create();

  try
    try
      qry.SQL.Text := ''

        + 'SELECT ''Total Bruto''     Titulo, '
        + '       Sum(p.valorbruto) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '

        + 'SELECT ''Descontos'' Titulo, '
        + '       Sum(p.VALORDESC)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '

        + 'SELECT ''Total Líquido''     Titulo, '
        + '       Sum(p.valorliquido) AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '

        + 'SELECT descricao Titulo, '
        + '       Sum(valor) AS Total '
        + 'FROM   pedidopagamento pg, '
        + '       pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.id = pg.idpedido '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '
        + 'GROUP  BY descricao, '
        + '          tipo '

        + 'UNION ALL '

        + 'SELECT ''Troco'' Titulo, '
        + '       Sum(p.troco)  AS Total '
        + 'FROM   pedido p '
        + 'WHERE  p.status = ''F'' '
        + '       AND p.datapedido >= :dataInicio '
        + '       AND p.datapedido <= :dataFim '

        + 'UNION ALL '

        + 'SELECT CASE '
        + '         WHEN tipo = 1 THEN ''Sangria'' '
        + '         WHEN tipo = 2 THEN ''Suprimento'' '
        + '       END        Titulo, '
        + '       Sum(valor) AS Total '
        + 'FROM   sangriasuprimento '
        + 'WHERE  data >= :dataInicio '
        + '       AND data <= :dataFim '
        + 'GROUP  BY tipo '

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

      TLog.d(qry);
      qry.Open;

      TArrayUtil<string>.Append(saidas, 'Troco');
      TArrayUtil<string>.Append(saidas, 'Sangria');
      TArrayUtil<string>.Append(saidas, 'Descontos');

      while not qry.Eof do
      begin
        if TArrayUtil<string>.Indexof(saidas, qry.FieldByName('Titulo').AsString.Trim) > -1 then
          sinal := '-'
        else
          sinal := '';

        result.Add(TPair<string, string>.Create(qry.FieldByName('Titulo').AsString, sinal + FormatCurr('R$ 0.,00', qry.FieldByName('Total').AsCurrency)));
        qry.Next;
      end;

      result.Add(TPair<string, string>.Create('', ''));

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

      TLog.d(qry);
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
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao calcular Totais: ' + E.message);
    end;
  end;

end;

procedure TDaoPedido.Valida(Pedido: TPedido);
begin
  if Pedido.Vendedor = nil then
    raise TValidacaoException.Create('Vendedor não associado ao pedido');

  if Pedido.Cliente = nil then
    raise TValidacaoException.Create('Cliente não associado ao pedido');

end;

procedure TDaoPedido.VendeItem(Item: TItemPedido);
var
  DaoItemPedido: TDaoItemPedido;
begin
  DaoItemPedido := TDaoItemPedido.Create(Self.FConnection, true);
  DaoItemPedido.IncluiItemPedido(Item);
  FreeAndNil(DaoItemPedido);
end;

function TDaoPedido.TotaisParceiro(dataInicio, dataFim: TDate; CodParceiro: string): TList<TPair<string, Currency>>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
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
        + '       and p.CODPARCEIRO = :CODPARCEIRO ';

      qry.ParamByName('dataInicio').AsDate := dataInicio;
      qry.ParamByName('dataFim').AsDate := dataFim;
      qry.ParamByName('CODPARCEIRO').AsString := CodParceiro;

      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        result.Add(TPair<string, Currency>.Create(qry.FieldByName('Titulo').AsString, qry.FieldByName('Total').AsCurrency));
        qry.Next;
      end;

    finally
      FreeAndNil(qry);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao calcular Totais: ' + E.message);
    end;
  end;

end;

end.
