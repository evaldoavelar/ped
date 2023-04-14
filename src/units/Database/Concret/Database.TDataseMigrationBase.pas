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

  Factory.Dao,
  Dominio.Mapeamento.Atributos, Util.VclFuncoes,
  Dominio.Entidades.TItemOrcamento, Dominio.Entidades.TOrcamento, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente, Dominio.Entidades.TAUTOINC,
  Dominio.Entidades.TParceiro.FormaPagto,
  Dominio.Entidades.TParceiro, Dominio.Entidades.TParceiroVenda.Pagamentos, Dominio.Entidades.TParceiroVenda, Impressao.Parametros.Impressora.Tinta,
  IFactory.Dao;

type

  tpBds = (tpMysql, tpFirebird, tpSqlServer, tpOracle);

  TDataseMigrationBase = Class(TInterfacedObject, IDataseMigration)
  private
    FFactory: IFactoryDao;
    FTipoBD: tpBds;
    FParametros: TParametros;
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
    destructor destroy(); override;
  End;

  { TDataseMigrationFB }

implementation

uses
  Dominio.Entidades.TPedido,
  Dominio.Entidades.TItemPedido,
  Dominio.Entidades.TParcelas,
  Impressao.Parametros.Impressora.Termica,
  Dominio.Entidades.TEmitente, Dominio.Entidades.TFornecedor, Dominio.Entidades.TFormaPagto, Dominio.Entidades.TProduto, Dominio.Entidades.CondicaoPagto,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento, Dominio.Entidades.TSangriaSuprimento, Dominio.Entidades.TEstoqueProduto, Sistema.TLog,
  Factory.Entidades, Dominio.Entidades.TImportacao;

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
  Objetos: array [0 .. 23] of TClass = (
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
    TEstoqueProduto,
    TImportacao
    );
var
  scripts: TStringList;
  classe: TClass;
  I: Integer;
  doSeed: Boolean;
  Dao: IDaoParametros;
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.Migrate ');
  self.FErros.clear;
  Dao := FFactory.DaoParametros();
  try

    FParametros := Dao.GetParametros();
    doSeed := false;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);

      if FParametros = nil then
      begin
        FParametros := TParametros.create;
        FParametros.VERSAOBD := '0.0.0.0';
        doSeed := true;
      end
    end;
  end;

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

        if doSeed then
        begin
          FParametros.VERSAOBD := TVclFuncoes.VersaoEXE;
          Dao.IncluiParametros(FParametros);
          Seed();
        end
        else
        begin
          FParametros.VERSAOBD := TVclFuncoes.VersaoEXE;
          Dao.AtualizaParametros(FParametros);
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
    FFactory.DaoEmitente.IncluiEmitente(Emitente);
    FreeAndNil(Emitente);

    FormaPagto := TFormaPagto.create;

    FormaPagto.ID := FFactory.DaoFormaPagto.GeraID;
    FormaPagto.DESCRICAO := 'DINHEIRO';
    FormaPagto.DATAALTERACAO := now;

    with FormaPagto.AddCondicao do
    begin
      IDPAGTO := FormaPagto.ID;
      DESCRICAO := 'À VISTA';
      QUANTASVEZES := 1;
      ACRESCIMO := 0;
    end;

    FFactory.DaoFormaPagto.IncluiPagto(FormaPagto);

    FreeAndNil(FormaPagto);

    Produto := TFactoryEntidades.new.Produto;
    Produto.CODIGO := '000001';
    Produto.DESCRICAO := 'Produto de Teste';
    Produto.UND := 'UND';
    Produto.PRECO_VENDA := 11.99;
    Produto.DATA_CADASTRO := now;
    Produto.ULTIMA_COMPRA := now;
    Produto.ULTIMA_VENDA := now;
    Produto.OBSERVACOES := 'Produto para testes';
    Produto.QUANTIDADEFRACIONADA := false;
    Produto.BLOQUEADO := false;
    Produto.DATAALTERACAO := now;
    FFactory.DaoProduto.IncluiProduto(Produto);
    FreeAndNil(Produto);

    Cliente := TFactoryEntidades.new.Cliente;
    Cliente.Nome := 'Consumidor';
    Cliente.CODIGO := '000000';
    Cliente.DATAALTERACAO := now;
    FFactory.DaoCliente.IncluiCliente(Cliente);
    FreeAndNil(Cliente);

    Vendedor := TFactoryEntidades.new.Vendedor;
    Vendedor.CODIGO := '000';
    Vendedor.Nome := 'Admin';
    Vendedor.PODERECEBERPARCELA := true;
    Vendedor.PODECANCELARPEDIDO := true;
    Vendedor.PODECANCELARORCAMENTO := true;
    Vendedor.DATAALTERACAO := now;
    FFactory.DaoVendedor.IncluiVendedor(Vendedor);
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

  qry := FFactory.Query;
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
begin

  result := false;
  try

    if (FParametros = nil) or (FParametros.VERSAOBD = '') then
      VERSAOBD := '0.0.0.0'
    else
      VERSAOBD := FParametros.VERSAOBD;

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
    result := true;

end;

constructor TDataseMigrationBase.create(ATipo: tpBds);
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.create ');
  self.FTipoBD := ATipo;
  self.FErros := TDictionary<TClass, string>.create();
  FFactory := TFactory.new(nil, true);
  TLog.d('<<< Saindo de TDataseMigrationBase.create ');
end;

destructor TDataseMigrationBase.destroy;
begin
  TLog.d('>>> Entrando em  TDataseMigrationBase.destroy ');
  // self.FErros.clear;
  // self.FErros.free;
  FFactory.close;
  inherited;
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
