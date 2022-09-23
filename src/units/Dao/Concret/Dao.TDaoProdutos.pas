unit Dao.TDaoProdutos;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  System.Generics.Collections,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TProduto, Dao.IDaoFornecedor, Dao.IDaoProdutos;

type

  TDaoProduto = class(TDaoBase, IDaoProdutos)
  private
    procedure ObjectToParams(ds: TFDQuery; Produto: TProduto);
    function ParamsToObject(ds: TFDQuery): TProduto;
  public
    procedure ExcluirProduto(codigo: string);
    procedure IncluiProduto(Produto: TProduto);
    procedure AtualizaProduto(Produto: TProduto);
    function GetProdutoPorCodigo(codigo: string): TProduto;
    function GetProdutoPorDescricao(descricao: string): TProduto;
    function GetProdutosPorDescricao(descricao: string): TObjectList<TProduto>;
    function GetProdutosPorDescricaoParcial(descricao: string): TObjectList<TProduto>;
    function Listar(campo, valor: string): TDataSet;
    procedure ValidaProduto(Produto: TProduto);
    function GetProdutoPorCodigoBarras(codBarras: string): TProduto;
    function GeraID: string;
    function EntradaSaidaEstoque(aCODIGO: string; aQuantidade: Double; aAutoCommit: Boolean): integer;

  end;

implementation

uses
  Util.Exceptions, Dominio.Entidades.TFactory;

{ TDaoProduto }

function TDaoProduto.EntradaSaidaEstoque(aCODIGO: string; aQuantidade: Double; aAutoCommit: Boolean): integer;
var
  aCampoValor: TDictionary<string, Variant>;
  qry: TFDQuery;
begin
  qry := TFactory.Query();
  try

    aCampoValor := TDictionary<string, Variant>.Create();
    try
      if aAutoCommit then
        FConnection.StartTransaction;

      qry.SQL.Append('update PRODUTO ');
      qry.SQL.Append('set  ESTOQUE = ESTOQUE + :QUANTIDADE  ');
      qry.SQL.Append('WHERE  CODIGO = :CODIGO ');

      qry.ParamByName('CODIGO').AsString := aCODIGO;
      qry.ParamByName('QUANTIDADE').AsFloat := aQuantidade;

      TLog.d(qry);
      qry.ExecSQL;

      result := qry.RowsAffected;

      if aAutoCommit then
        FConnection.Commit;
    except
      on E: Exception do
      begin
        // FLog.d(E.Message);
        if aAutoCommit then
          FConnection.Rollback;
        TLog.d(E.message);
        raise TDaoException.Create(' TDaoProduto.EntradaSaidaEstoque: ' + E.message);
      end;

    end;
  finally
    aCampoValor.Free;
    FreeAndNil(qry);
  end;
end;

procedure TDaoProduto.ExcluirProduto(codigo: string);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  produto '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro não pode ser excluído porque está amarrado a outro registro, possívelmente uma venda.')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluirProduto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoProduto.AtualizaProduto(Produto: TProduto);
var
  qry: TFDQuery;
  ProdutoTeste: TProduto;
begin

  qry := TFactory.Query();
  try
    try

      if Trim(Produto.BARRAS) <> '' then
      begin
        ProdutoTeste := Self.GetProdutoPorCodigoBarras(Produto.BARRAS);

        // verificar se está atualizando um produto com codigo de barras de outro produtoexistente
        if Assigned(ProdutoTeste) then
        begin
          if (ProdutoTeste.codigo <> Produto.codigo) and (Produto.BARRAS = ProdutoTeste.BARRAS) then
          begin
            FreeAndNil(ProdutoTeste);
            raise Exception.Create('Já existe um produto com este código de barras no banco de dados');
          end;
          FreeAndNil(ProdutoTeste);
        end;
      end;

      if Trim(Produto.descricao) <> '' then
      begin
        ProdutoTeste := Self.GetProdutoPorDescricao(Produto.descricao);

        // verificar se está atualizando um produto com codigo de barras de outro produtoexistente
        if Assigned(ProdutoTeste) then
        begin
          if (ProdutoTeste.codigo <> Produto.codigo) and (Produto.descricao = ProdutoTeste.descricao) then
          begin
            FreeAndNil(ProdutoTeste);
            raise Exception.Create('Já existe um produto com essa descrição cadastrado no banco de dados');
          end;
          FreeAndNil(ProdutoTeste);
        end;
      end;

      qry.SQL.Text := ''
        + 'UPDATE produto '
        + 'SET     '
        + '       barras = :BARRAS, '
        + '       descricao = :DESCRICAO, '
        + '       und = :UND, '
        + '       codfornecedor = :CODFORNECEDOR, '
        + '       custo_medio = :CUSTO_MEDIO, '
        + '       preco_custo = :PRECO_CUSTO, '
        + '       preco_venda = :PRECO_VENDA, '
        + '       preco_atacado = :PRECO_ATACADO, '
        + '       margem_lucro = :MARGEM_LUCRO, '
        + '       alteracao_preco = :ALTERACAO_PRECO, '
        + '       ultima_compra = :ULTIMA_COMPRA, '
        + '       ultima_venda = :ULTIMA_VENDA, '
        + '       data_cadastro = :DATA_CADASTRO, '
        + '       BLOQUEADO = :BLOQUEADO, '
        + '       QUANTIDADEFRACIONADA = :QUANTIDADEFRACIONADA, '
        + '       ESTOQUE = :ESTOQUE, '
        + '       ESTOQUEMINIMO = :ESTOQUEMINIMO, '
        + '       AVISARESTOQUEBAIXO = :AVISARESTOQUEBAIXO, '
        + '       INATIVO = :INATIVO, '
        + '       observacoes = :OBSERVACOES '
        + 'where ' +
        '        CODIGO = :CODIGO ';

      ObjectToParams(qry, Produto);
      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaProduto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoProduto.GeraID: string;
begin
  result := Format('%.6d', [AutoIncremento('PRODUTO', 'CODIGO')]);
end;

function TDaoProduto.GetProdutoPorCodigo(codigo: string): TProduto;
var
  qry: TFDQuery;

begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Produto '
        + 'WHERE '
        + '     CODIGO = :CODIGO'
        + ' order by descricao ';

      qry.ParamByName('CODIGO').AsString := codigo;
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
        raise TDaoException.Create('Falha GetProdutoPorCodigo: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoProduto.GetProdutoPorCodigoBarras(codBarras: string): TProduto;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Produto '
        + 'WHERE '
        + '     BARRAS = :BARRAS';

      qry.ParamByName('BARRAS').AsString := codBarras;
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
        raise TDaoException.Create('Falha GetProdutoPorCodigoBarras: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoProduto.GetProdutosPorDescricao(descricao: string): TObjectList<TProduto>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Produto '
        + 'WHERE '
        + ' UPPER( descricao) CONTAINING  UPPER( :descricao ) '
        + '  AND ( INATIVO = 0 or INATIVO IS NULL) '
        + ' order by descricao';

      if Length(descricao) > 39 then
        descricao := copy(descricao, 0, 39);

      qry.ParamByName('descricao').AsString := descricao;
      TLog.d(qry);
      qry.Open;

      result := TObjectList<TProduto>.Create();

      while not qry.Eof do
      begin
        result.Add(ParamsToObject(qry));
        qry.Next;
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetProdutoPorDescricao: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoProduto.GetProdutosPorDescricaoParcial(descricao: string): TObjectList<TProduto>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Produto '
        + 'WHERE '
        + '  UPPER( descricao) like  UPPER( :descricao ) '
        + '  AND ( INATIVO = 0 or INATIVO IS NULL) '
        + ' order by descricao';

      if Length(descricao) > 38 then
        descricao := copy(descricao, 0, 38);

      qry.ParamByName('descricao').AsString := descricao + '%';
      TLog.d(qry);
      qry.Open;

      result := TObjectList<TProduto>.Create();

      while not qry.Eof do
      begin
        result.Add(ParamsToObject(qry));
        qry.Next;
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GetProdutosPorDescricaoParcial: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoProduto.GetProdutoPorDescricao(descricao: string): TProduto;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Produto '
        + 'WHERE '
        + '     descricao = :descricao '
        + '  AND ( INATIVO = 0 or INATIVO IS NULL)'
        + ' order by descricao ';

      qry.ParamByName('descricao').AsString := descricao;
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
        raise TDaoException.Create('Falha GetProdutoPorDescricao: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoProduto.IncluiProduto(Produto: TProduto);
var
  qry: TFDQuery;
  ProdutoTeste: TProduto;
  descricao: string;
begin

  qry := TFactory.Query();
  try
    try

      if Trim(Produto.BARRAS) <> '' then
      begin
        ProdutoTeste := Self.GetProdutoPorCodigoBarras(Produto.BARRAS);
        if Assigned(ProdutoTeste) then
        begin
          descricao := ProdutoTeste.descricao;
          FreeAndNil(ProdutoTeste);
          raise Exception.Create('Já existe um produto com este código de barras no banco de dados: ' + descricao);
        end;
      end;

      if Trim(Produto.descricao) <> '' then
      begin
        ProdutoTeste := Self.GetProdutoPorDescricao(Produto.descricao);
        if Assigned(ProdutoTeste) then
        begin
          descricao := ProdutoTeste.descricao;
          FreeAndNil(ProdutoTeste);
          raise Exception.Create('Já existe um produto com esta descrição cadastrado: ' + descricao);
        end;
      end;

      Produto.codigo := Self.GeraID;

      qry.SQL.Text := ''
        + 'INSERT INTO produto '
        + '            (codigo, '
        + '             barras, '
        + '             descricao, '
        + '             und, '
        + '             codfornecedor, '
        + '             custo_medio, '
        + '             preco_custo, '
        + '             preco_venda, '
        + '             preco_atacado, '
        + '             margem_lucro, '
        + '             alteracao_preco, '
        + '             ultima_compra, '
        + '             ultima_venda, '
        + '             data_cadastro, '
        + '             BLOQUEADO, '
        + '             ESTOQUE, '
        + '             ESTOQUEMINIMO, '
        + '             AVISARESTOQUEBAIXO, '
        + '             INATIVO, '
        + '             QUANTIDADEFRACIONADA, '
        + '             observacoes) '
        + 'VALUES     ( :CODIGO, '
        + '             :BARRAS, '
        + '             :DESCRICAO, '
        + '             :UND, '
        + '             :CODFORNECEDOR, '
        + '             :CUSTO_MEDIO, '
        + '             :PRECO_CUSTO, '
        + '             :PRECO_VENDA, '
        + '             :PRECO_ATACADO, '
        + '             :MARGEM_LUCRO, '
        + '             :ALTERACAO_PRECO, '
        + '             :ULTIMA_COMPRA, '
        + '             :ULTIMA_VENDA, '
        + '             :DATA_CADASTRO, '
        + '             :BLOQUEADO, '
        + '             :ESTOQUE, '
        + '             :ESTOQUEMINIMO, '
        + '             :AVISARESTOQUEBAIXO, '
        + '             :INATIVO, '
        + '             :QUANTIDADEFRACIONADA, '
        + '             :OBSERVACOES)';

      ObjectToParams(qry, Produto);
      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha IncluiProduto: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TDaoProduto.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select Produto.*, '
      + 'case INATIVO '
      + '         when 1 then ''Inativo'' '
      + '         else ''Ativo'' '
      + '       end status '
      + 'from  Produto '
      + 'WHERE '
    // + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + ' UPPER( ' + campo + ') CONTAINING  UPPER( ' + QuotedStr(valor) + ') '
      + ' order by descricao';

    TLog.d(qry);
    qry.Open;

    result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Produto: ' + E.message);
    end;
  end;

end;

procedure TDaoProduto.ObjectToParams(ds: TFDQuery; Produto: TProduto);
begin
  try
    if ds.Params.FindParam('CODIGO') <> nil then
      ds.Params.ParamByName('CODIGO').AsString := Produto.codigo;
    if ds.Params.FindParam('BARRAS') <> nil then
      ds.Params.ParamByName('BARRAS').AsString := Produto.BARRAS;
    if ds.Params.FindParam('DESCRICAO') <> nil then
      ds.Params.ParamByName('DESCRICAO').AsString := Produto.descricao;
    if ds.Params.FindParam('UND') <> nil then
      ds.Params.ParamByName('UND').AsString := Produto.UND;
    if ds.Params.FindParam('CODFORNECEDOR') <> nil then
    begin
      if Produto.CODFORNECEDOR = '' then
        ds.Params.ParamByName('CODFORNECEDOR').Clear()
      else
        ds.Params.ParamByName('CODFORNECEDOR').AsString := Produto.CODFORNECEDOR;
    end;
    if ds.Params.FindParam('CUSTO_MEDIO') <> nil then
      ds.Params.ParamByName('CUSTO_MEDIO').AsCurrency := Produto.CUSTO_MEDIO;
    if ds.Params.FindParam('PRECO_CUSTO') <> nil then
      ds.Params.ParamByName('PRECO_CUSTO').AsCurrency := Produto.PRECO_CUSTO;
    if ds.Params.FindParam('PRECO_VENDA') <> nil then
      ds.Params.ParamByName('PRECO_VENDA').AsCurrency := Produto.PRECO_VENDA;
    if ds.Params.FindParam('PRECO_ATACADO') <> nil then
      ds.Params.ParamByName('PRECO_ATACADO').AsCurrency := Produto.PRECO_ATACADO;
    if ds.Params.FindParam('MARGEM_LUCRO') <> nil then
      ds.Params.ParamByName('MARGEM_LUCRO').AsCurrency := Produto.MARGEM_LUCRO;
    if ds.Params.FindParam('ALTERACAO_PRECO') <> nil then
    begin
      if Produto.ALTERACAO_PRECO = 0 then
        ds.Params.FindParam('ALTERACAO_PRECO').Clear()
      else
        ds.Params.ParamByName('ALTERACAO_PRECO').AsDate := Produto.ALTERACAO_PRECO;
    end;
    if ds.Params.FindParam('ULTIMA_COMPRA') <> nil then
    begin
      if Produto.ULTIMA_COMPRA = 0 then
        ds.Params.FindParam('ULTIMA_COMPRA').Clear()
      else
        ds.Params.ParamByName('ULTIMA_COMPRA').AsDate := Produto.ULTIMA_COMPRA;
    end;
    if ds.Params.FindParam('ULTIMA_VENDA') <> nil then
    begin
      if Produto.ULTIMA_VENDA = 0 then
        ds.Params.FindParam('ULTIMA_VENDA').Clear()
      else
        ds.Params.ParamByName('ULTIMA_VENDA').AsDate := Produto.ULTIMA_VENDA;
    end;
    if ds.Params.FindParam('DATA_CADASTRO') <> nil then
    begin
      if Produto.DATA_CADASTRO = 0 then
        ds.Params.FindParam('DATA_CADASTRO').Clear()
      else
        ds.Params.ParamByName('DATA_CADASTRO').AsDate := Produto.DATA_CADASTRO;
    end;
    if ds.Params.FindParam('BLOQUEADO') <> nil then
      ds.Params.ParamByName('BLOQUEADO').AsBoolean := Produto.BLOQUEADO;
    if ds.Params.FindParam('QUANTIDADEFRACIONADA') <> nil then
      ds.Params.ParamByName('QUANTIDADEFRACIONADA').AsBoolean := Produto.QUANTIDADEFRACIONADA;
    if ds.Params.FindParam('OBSERVACOES') <> nil then
      ds.Params.ParamByName('OBSERVACOES').AsString := Produto.OBSERVACOES;

    if ds.Params.FindParam('ESTOQUE') <> nil then
      ds.Params.ParamByName('ESTOQUE').AsFloat := Produto.ESTOQUE;

    if ds.Params.FindParam('ESTOQUEMINIMO') <> nil then
      ds.Params.ParamByName('ESTOQUEMINIMO').AsFloat := Produto.ESTOQUEMINIMO;

    if ds.Params.FindParam('AVISARESTOQUEBAIXO') <> nil then
      ds.Params.ParamByName('AVISARESTOQUEBAIXO').AsBoolean := Produto.AVISARESTOQUEBAIXO;

    if ds.Params.FindParam('INATIVO') <> nil then
      ds.Params.ParamByName('INATIVO').AsBoolean := Produto.INATIVO;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros Produto: ' + E.message);
    end;
  end;
end;

function TDaoProduto.ParamsToObject(ds: TFDQuery): TProduto;
var
  DaoFornecedor: IDaoFornecedor;
begin
  DaoFornecedor := TFactory.DaoFornecedor();

  try

    result := TProduto.Create();
    FieldsToEntity(ds, result);

    // Result.codigo := ds.FieldByName('CODIGO').AsString;
    // Result.BARRAS := ds.FieldByName('BARRAS').AsString;
    // Result.DESCRICAO := ds.FieldByName('DESCRICAO').AsString;
    // Result.UND := ds.FieldByName('UND').AsString;
    // Result.CODFORNECEDOR := ds.FieldByName('CODFORNECEDOR').AsString;
    // Result.CUSTO_MEDIO := ds.FieldByName('CUSTO_MEDIO').AsCurrency;
    // Result.PRECO_CUSTO := ds.FieldByName('PRECO_CUSTO').AsCurrency;
    // Result.PRECO_VENDA := ds.FieldByName('PRECO_VENDA').AsCurrency;
    // Result.PRECO_ATACADO := ds.FieldByName('PRECO_ATACADO').AsCurrency;
    // Result.MARGEM_LUCRO := ds.FieldByName('MARGEM_LUCRO').AsCurrency;
    // Result.ALTERACAO_PRECO := ds.FieldByName('ALTERACAO_PRECO').AsDateTime;
    // Result.ULTIMA_COMPRA := ds.FieldByName('ULTIMA_COMPRA').AsDateTime;
    // Result.ULTIMA_VENDA := ds.FieldByName('ULTIMA_VENDA').AsDateTime;
    // Result.DATA_CADASTRO := ds.FieldByName('DATA_CADASTRO').AsDateTime;
    // Result.BLOQUEADO := ds.FieldByName('BLOQUEADO').AsInteger = 1;
    // Result.QUANTIDADEFRACIONADA := ds.FieldByName('QUANTIDADEFRACIONADA').AsInteger = 1;
    // Result.OBSERVACOES := ds.FieldByName('OBSERVACOES').AsString;

    result.Fornecedor := DaoFornecedor.GeFornecedor(result.CODFORNECEDOR);

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject Produto: ' + E.message);
    end;
  end;

end;

procedure TDaoProduto.ValidaProduto(Produto: TProduto);
begin
  if Produto.descricao = '' then
    raise Exception.Create('Produto sem descrição');

end;

end.
