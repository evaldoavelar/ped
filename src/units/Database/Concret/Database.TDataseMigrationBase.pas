unit Database.TDataseMigrationBase;

interface

uses
  System.SysUtils, System.Classes,
  System.Generics.Collections,
  System.Rtti,
  Data.DB,
  FireDAC.Comp.Client,
  Database.IDataseMigration,
  Database.TTabelaBD,
  Database.TTabelaBDFB,
  Sistema.TParametros,
  Dao.IDaoParametros,
  Dominio.Entidades.TEntity,
  Dominio.Entidades.TFactory,
  Dominio.Mapeamento.Atributos, Util.VclFuncoes,
  Dominio.Entidades.TItemOrcamento, Dominio.Entidades.TOrcamento, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente, Dominio.Entidades.TAUTOINC,
  Dominio.Entidades.TParceiro.FormaPagto,
  Dominio.Entidades.TParceiro, Dominio.Entidades.TParceiroVenda.Pagamentos, Dominio.Entidades.TParceiroVenda, Impressao.Parametros.Impressora.Tinta;

type

  tpBds = (tpMysql, tpFirebird, tpSqlServer, tpOracle);

  TDataseMigrationBase = Class(TInterfacedObject, IDataseMigration)
  private
    FTipoBD: tpBds;
    FErros: TDictionary<TClass, string>;
    function getScript(Entity: TClass): TStringList;
    procedure ExtractedAttributes(var Tabela: TTabelaBD; arAttr: TArray<TCustomAttribute>);
    function Atualiza(AClasse: TClass; AScripts: TStringList): Integer;
    function getTipoTabela: TTabelaBD;
    function CompareVersaoBD: Boolean;
    procedure Seed();
  public
    procedure Migrate();
    function GetErros: TDictionary<TClass, string>;
    constructor create(ATipo: tpBds);
    destructor destroy();
  End;

  { TDataseMigrationFB }

implementation

uses
  Dominio.Entidades.TPedido,
  Dominio.Entidades.TItemPedido,
  Dominio.Entidades.TParcelas,
  Impressao.Parametros.Impressora.Termica,
  Util.Funcoes, Dominio.Entidades.TEmitente, Dominio.Entidades.TFornecedor, Dominio.Entidades.TFormaPagto, Dominio.Entidades.TProduto, Dominio.Entidades.CondicaoPagto,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento, Sangria.Suprimento.Informar, Dominio.Entidades.TSangriaSuprimento, Dominio.Entidades.TEstoqueProduto, Sistema.TLog;

function TDataseMigrationBase.getScript(Entity: TClass): TStringList;
var
  Rtti: TRttiContext;
  ltype: TRttiType;
  attr: TCustomAttribute;
  prop: TRttiProperty;
  FTabela: TTabelaBD;
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.getScript ');
  FTabela := getTipoTabela;

  Rtti := TRttiContext.create;
  ltype := Rtti.GetType((Entity));

  // extrair as anotações das classes
  ExtractedAttributes(FTabela, ltype.GetAttributes);

  for prop in ltype.GetProperties do
  begin
    // extrair das propriedades
    ExtractedAttributes(FTabela, prop.GetAttributes);
  end;

  result := FTabela.toScript();

  FreeAndNil(FTabela);
  TLog.d('<<< Saindo de TDataseMigrationBase.getScript ');
end;

procedure TDataseMigrationBase.Migrate;
const
  Objetos: array [0 .. 22] of TClass = (
    TAUTOINC,
    TEmitente,
    TCliente,
    TVendedor,
    TFornecedor,
    TFormaPagto,
    TProduto,
    TParceiro,
    TPedido,
    TItemPedido,
    TCONDICAODEPAGTO,
    TPEDIDOPAGAMENTO,
    TParcelas,
    TParametros,
    TParametrosImpressoraTermica,
    TParametrosImpressoraTinta,
    TOrcamento,
    TItemOrcamento,
    TParceiroFormaPagto,
    TParceiroVenda,
    TParceiroVendaPagto,
    TSangriaSuprimento,
    TEstoqueProduto
    );
var
  scripts: TStringList;
  classe: TClass;
  I: Integer;
  Parametros: TParametros;
  Dao: IDaoParametros;
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.Migrate ');
  self.FErros.clear;

  if CompareVersaoBD() then
  begin
    try
      try
        for I := Low(Objetos) to High(Objetos) do
        begin
          classe := Objetos[I];
          scripts := getScript(classe);
          Atualiza(classe, scripts);
        end;
      finally
        if Assigned(scripts) then
          FreeAndNil(scripts);
      end;

      if FErros.Count = 0 then
      begin
        Parametros := TFactory.Parametros();
        Dao := TFactory.DaoParametros();

        if Parametros = nil then
        begin
          Parametros := TParametros.create;
          Parametros.VERSAOBD := TVclFuncoes.VersaoEXE;
          Dao.IncluiParametros(Parametros);
          Seed();
        end
        else
        begin
          Parametros.VERSAOBD := TVclFuncoes.VersaoEXE;
          Dao.AtualizaParametros(Parametros);
        end;

      end;

    except
      on E: Exception do
      begin
        TLog.d(E.Message);
        raise Exception.create('Migrate: ' + classe.ClassName + ' - ' + E.Message);
      end;
    end;
  end;
  TLog.d('<<< Saindo de TDataseMigrationBase.Migrate ');
end;

procedure TDataseMigrationBase.Seed;
var
  Emitente: TEmitente;
  FormaPagto: TFormaPagto;
  Produto: TProduto;
  Cliente: TCliente;
  Vendedor: TVendedor;
  I: Integer;
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.Seed ');
  try
    Emitente := TEmitente.create;
    Emitente.RAZAO_SOCIAL := 'EMPRESA DE TESTE';
    Emitente.FANTASIA := 'TESTE';
    Emitente.CNPJ := '11111111111111';
    TFactory.DaoEmitente.IncluiEmitente(Emitente);
    FreeAndNil(Emitente);

    FormaPagto := TFormaPagto.create;

    FormaPagto.ID := TFactory.DaoFormaPagto.GeraID;
    FormaPagto.DESCRICAO := 'DINHEIRO';

    with FormaPagto.AddCondicao do
    begin
      IDPAGTO := FormaPagto.ID;
      DESCRICAO := 'À VISTA';
      QUANTASVEZES := 1;
      ACRESCIMO := 0;
    end;

    TFactory.DaoFormaPagto.IncluiPagto(FormaPagto);

    FreeAndNil(FormaPagto);

    Produto := TFactory.Produto;
    Produto.CODIGO := '000001';
    Produto.DESCRICAO := 'Produto de Teste';
    Produto.UND := 'UND';
    Produto.PRECO_VENDA := 11.99;
    Produto.DATA_CADASTRO := Now;
    Produto.ULTIMA_COMPRA := Now;
    Produto.ULTIMA_VENDA := Now;
    Produto.OBSERVACOES := 'Produto para testes';
    Produto.QUANTIDADEFRACIONADA := False;
    Produto.BLOQUEADO := False;

    TFactory.DaoProduto.IncluiProduto(Produto);
    FreeAndNil(Produto);

    Cliente := TFactory.Cliente;
    Cliente.Nome := 'Consumidor';
    Cliente.CODIGO := '000000';

    TFactory.DaoCliente.IncluiCliente(Cliente);
    FreeAndNil(Cliente);

    Vendedor := TFactory.Vendedor;
    Vendedor.CODIGO := '000';
    Vendedor.Nome := 'Admin';
    Vendedor.PODERECEBERPARCELA := True;
    Vendedor.PODECANCELARPEDIDO := True;
    Vendedor.PODECANCELARORCAMENTO := True;

    TFactory.DaoVendedor.IncluiVendedor(Vendedor);
    FreeAndNil(Vendedor);
  except

    on E: Exception do
    begin
      TLog.d(E.Message);
      raise Exception.create('SEED: ' + ' - ' + E.Message);
    end;
  end;
  TLog.d('<<< Saindo de TDataseMigrationBase.Seed ');
end;

function TDataseMigrationBase.Atualiza(AClasse: TClass; AScripts: TStringList): Integer;
var
  qry: TFDQuery;
  sql: string;
begin
  result := 0;

  qry := TFactory.Query;
  try
    for sql in AScripts do
    begin
      try
        qry.sql.Text := sql;
        TLog.d(qry);
        qry.ExecSQL;
      except
        on E: Exception do
        begin
          TLog.d(E.Message);
          self.FErros.Add(AClasse, E.Message + ' - ' + sql);
          Inc(result);
        end;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

function TDataseMigrationBase.CompareVersaoBD: Boolean;
var
  VersaoEXE: string;
  VERSAOBD: string;
  Parametros: TParametros;
begin

  result := False;
  try
    Parametros := TFactory.Parametros();
    if (Parametros = nil) or (Parametros.VERSAOBD = '') then
      VERSAOBD := '0.0.0.0'
    else
      VERSAOBD := Parametros.VERSAOBD;
  except
    on E: Exception do
    begin
      // if Pos('not found', E.Message) > 0 then
      VERSAOBD := '0.0.0.0';
      // else
      // raise;
    end;
  end;

  VersaoEXE := TVclFuncoes.VersaoEXE;

  if (TVclFuncoes.CompararVersao(VersaoEXE, VERSAOBD) < 0) or (VersaoEXE = '0.0.0.0') then
    result := True;

end;

constructor TDataseMigrationBase.create(ATipo: tpBds);
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.create ');
  self.FTipoBD := ATipo;
  self.FErros := TDictionary<TClass, string>.create();
  TLog.d('<<< Saindo de TDataseMigrationBase.create ');
end;

destructor TDataseMigrationBase.destroy;
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.destroy ');
  self.FErros.clear;
  self.FErros.Free;
  TLog.d('<<< Saindo de TDataseMigrationBase.destroy ');
end;

function TDataseMigrationBase.getTipoTabela: TTabelaBD;
begin
  case FTipoBD of
    tpMysql:
      ;

    tpFirebird:
      result := TTabelaBDFB.create;
    tpSqlServer:
      ;

    tpOracle:
      ;

  end;
end;

procedure TDataseMigrationBase.ExtractedAttributes(var Tabela: TTabelaBD; arAttr: TArray<TCustomAttribute>);
var
  attr: TCustomAttribute;
begin
  for attr in arAttr do
  begin
    if attr is TabelaAttribute then
    begin
      Tabela.Tabela := TabelaAttribute(attr);
    end
    else if attr is CampoAttribute then
    begin
      Tabela.Campos.Add(CampoAttribute(attr));
    end
    else if attr is PrimaryKeyAttribute then
    begin
      Tabela.Pks.Add(PrimaryKeyAttribute(attr));
    end
    else if attr is ForeignKeyAttribute then
    begin
      Tabela.Fks.Add(ForeignKeyAttribute(attr));
    end;
  end;
end;

function TDataseMigrationBase.GetErros: TDictionary<TClass, string>;
begin
  result := FErros;
end;

end.
