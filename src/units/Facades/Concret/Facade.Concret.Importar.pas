unit Facade.Concret.Importar;

interface

uses Facades.Abstract.Importar,

  Factory.Dao, FireDAC.Comp.Client,
  Data.DB,
  Dominio.Mapeamento.Atributos,


  Dominio.Entidades.TVendedor,
  Dominio.Entidades.TCliente,

  Dominio.Entidades.TParceiro.FormaPagto,
  Dominio.Entidades.TParceiro,

  System.Generics.Collections, IFactory.Dao,
  Sistema.TParametros,
  Dominio.Mapeamento.Atributos.Funcoes, Facades.Abstract.Observer,
  Facades.Abstract.Observable, Dao.TDaoBase, Winapi.Windows;

type

  TFacadeImportar = class(TDaoBase, IFacadeImportar)
  private
    FParametros: TParametros;
    FFactoryLocal: IFactoryDao;
    FFactoryRemoto: IFactoryDao;
    FErros: TDictionary<TClass, string>;
    FObserves: TList<IFacadeObserver>;
  private
    procedure ExecultaImportacao<T: class>();
    function RetornaSQLSelect<T: class>(aNomeTabela: string): string;
    procedure AtualizarLocal<T: class>(aQryRemoto: TFDQuery; aNomeTabela: string);

  public
    function ImportarEmitente: IFacadeImportar;
    function ImportarCliente: IFacadeImportar;
    function ImportarVendedor: IFacadeImportar;
    function ImportarFornecedor: IFacadeImportar;
    function ImportarFormaPagto: IFacadeImportar;
    function ImportarProduto: IFacadeImportar;
    function ImportarParceiro: IFacadeImportar;
    function ImportarCondicaodepagto: IFacadeImportar;
    function ImportarParceiroFormaPagto: IFacadeImportar;
    function ImportarEstoqueProduto: IFacadeImportar;
  public
    procedure addObserver(obs: IFacadeObserver);
    procedure removeObserver(obs: IFacadeObserver);
    procedure NotifyObservers(aValue: string);
  public
    constructor Create();
    destructor Destroy; override;
    class function New(): IFacadeImportar;
  end;

const
  PAGINA = 11;

var
  csCriticalSection: TRTLCriticalSection;

implementation

uses





  Dominio.Entidades.TEmitente, Dominio.Entidades.TFornecedor, Dominio.Entidades.TFormaPagto, Dominio.Entidades.TProduto, Dominio.Entidades.CondicaoPagto,
  Dominio.Entidades.TEstoqueProduto, Sistema.TLog,
  Sistema.TBancoDeDados, System.SysUtils, System.Rtti,
  Dominio.Entidades.TImportacao, Utils.Rtti;

{ TFacadeImportar }

constructor TFacadeImportar.Create;
var
  LBancoDeDados: TParametrosBancoDeDados;

begin
  TLog.d('>>> Entrando em  TFacadeImportar.Create ');
  self.FErros := TDictionary<TClass, string>.Create();
  self.FObserves := TList<IFacadeObserver>.Create;
  self.FFactoryLocal := TFactory.New(nil, true);
  FParametros := self.FFactoryLocal.DaoParametros.GetParametros;

  LBancoDeDados := TParametrosBancoDeDados.Create(
    FParametros.SERVIDORDATABASE,
    FParametros.SERVIDORUSUARIO,
    FParametros.SERVIDORSENHA
    );

  self.FFactoryRemoto := TFactory.New(nil, true);
  self.FFactoryRemoto.Conexao(LBancoDeDados);

  TLog.d('<<< Saindo de TFacadeImportar.Create ');
end;

destructor TFacadeImportar.Destroy;
begin
  TLog.d('>>> Entrando em  TFacadeImportar.Destroy ');
  self.FFactoryLocal.close;
  self.FFactoryRemoto.close;
  self.FObserves.free;

  if FParametros <> nil then
    FreeAndNil(FParametros);
  inherited;
  TLog.d('<<< Saindo de TFacadeImportar.Destroy ');
end;

function TFacadeImportar.ImportarCliente: IFacadeImportar;
begin
  NotifyObservers('* Importando Cliente...');
  result := self;
  try
    ExecultaImportacao<TCliente>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TCliente, E.Message);
    end;
  end;

end;

function TFacadeImportar.ImportarCondicaodepagto: IFacadeImportar;
begin
  NotifyObservers('* Importando Condição de Pagamento...');
  result := self;
  try
    ExecultaImportacao<TCONDICAODEPAGTO>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TCONDICAODEPAGTO, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarEmitente: IFacadeImportar;
begin
  result := self;
  try
    NotifyObservers('* Importando Emitente...');
    ExecultaImportacao<TEmitente>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TEmitente, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarEstoqueProduto: IFacadeImportar;
begin
  result := self;
  try
    NotifyObservers('* Importando Estoque de Produto...');
    ExecultaImportacao<TEstoqueProduto>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TEstoqueProduto, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarFormaPagto: IFacadeImportar;
begin
  result := self;
  try
    NotifyObservers('* Importando Forma de Pagamento...');
    ExecultaImportacao<TFormaPagto>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TFormaPagto, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarFornecedor: IFacadeImportar;
begin
  result := self;
  NotifyObservers('* Importando Fornecedor...');
  try
    ExecultaImportacao<TFornecedor>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TFornecedor, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarParceiro: IFacadeImportar;
begin
  result := self;
  NotifyObservers('* Importando Parceiro...');
  try
    ExecultaImportacao<TParceiro>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TParceiro, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarParceiroFormaPagto: IFacadeImportar;
begin
  result := self;
  NotifyObservers('* Importando Parceiro Forma de Pagamento...');
  try
    ExecultaImportacao<TParceiroFormaPagto>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TParceiroFormaPagto, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarProduto: IFacadeImportar;
begin
  result := self;
  NotifyObservers('* Importando produto...');
  try
    ExecultaImportacao<TProduto>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TProduto, E.Message);
    end;
  end;
end;

function TFacadeImportar.ImportarVendedor: IFacadeImportar;
begin
  result := self;
  try
    NotifyObservers('* Importando Vendedor...');
    ExecultaImportacao<TVendedor>();
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      FErros.Add(TVendedor, E.Message);
    end;
  end;
end;

procedure TFacadeImportar.ExecultaImportacao<T>();
var
  LTotalDeRegistros: Integer;
  I: Integer;
  qryRemoto: TFDQuery;
  Rtti: TRttiContext;
  ltype: TRttiType;
  LImportacao: TImportacao;
  LClassAtributos: TArray<TCustomAttribute>;
  LNomeTabela: string;
begin
  Rtti := TRttiContext.Create;
  ltype := Rtti.GetType(T);
  LClassAtributos := ltype.GetAttributes;
  LNomeTabela := TAtributosFuncoes.Tabela<T>();
  LImportacao := FFactoryLocal.DaoImportacao.Select(LNomeTabela);

  qryRemoto := FFactoryRemoto.Query;
  qryRemoto.sql.Text := Format('Select count(*) from %s', [LNomeTabela]);
  qryRemoto.sql.Append(' where  ');
  qryRemoto.sql.Append('   dataalteracao is not null  ');
  qryRemoto.sql.Append('   and dataalteracao > :data   ');
  qryRemoto.ParamByName('data').AsDateTime := LImportacao.DATAIMPORTACAO;
  TLog.d(qryRemoto);
  qryRemoto.open;

  LTotalDeRegistros := qryRemoto.Fields[0].AsInteger;

  if LImportacao = nil then
    LImportacao := TImportacao.New(LNomeTabela, 0);

  I := 0;
  while I <= LTotalDeRegistros do
  begin
    qryRemoto.sql.Text := RetornaSQLSelect<T>(LNomeTabela);
    qryRemoto.ParamByName('data').AsDateTime := LImportacao.DATAIMPORTACAO;
    qryRemoto.ParamByName('first').AsInteger := I + PAGINA;
    qryRemoto.ParamByName('skip').AsInteger := I;
    TLog.d(qryRemoto);
    qryRemoto.open;

    AtualizarLocal<T>(qryRemoto, LNomeTabela);

    I := I + PAGINA + 1;
  end;

  LImportacao.DATAIMPORTACAO := now;
  FFactoryLocal.DaoImportacao.AtualizaDataImportacao(LImportacao);

  qryRemoto.free;
  LImportacao.free;
end;

function TFacadeImportar.RetornaSQLSelect<T>(aNomeTabela: string): string;
var
  I: Integer;
  LSql: TStringBuilder;
  attr: TCustomAttribute;
  LCampo: string;
begin
  LSql := TStringBuilder.Create;
  LSql.Append('select ');
  LSql.Append('FIRST :first SKIP :skip ');

  I := 0;
  TRttiUtil.ForEachProperties<T>(
    procedure(prop: TRttiProperty)
    begin
      attr := TAtributosFuncoes.IndexOfAttribute(prop, IGNOREAttribute);
      LCampo := TAtributosFuncoes.Campo<T>(prop);
      // ignorar a propriedade
      if (attr is IGNOREAttribute) or (LCampo = 'RefCount') then
        exit;

      if I > 0 then
        LSql.Append(',' + LCampo)
      else
        LSql.Append(LCampo);

      inc(I);
    end);

  LSql.Append(' from ' + aNomeTabela);
  LSql.Append(' where  ');
  LSql.Append('   dataalteracao is not null  ');
  LSql.Append('   and dataalteracao > :data   ');

  result := LSql.ToString;
  LSql.free;
end;

procedure TFacadeImportar.AtualizarLocal<T>(aQryRemoto: TFDQuery; aNomeTabela: string);
var
  qryLocal: TFDQuery;
  I: Integer;
begin
  qryLocal := FFactoryLocal.Query;
  aQryRemoto.First;

  while not aQryRemoto.eof do
  begin
    qryLocal.sql.Text := RetornaSQLUpdate<T>(aNomeTabela);
    CopiarParametros(aQryRemoto, qryLocal);

    TLog.d(qryLocal);
    qryLocal.ExecSQL;

    if qryLocal.RowsAffected = 0 then
    begin
      TLog.d(' ### Registro não existe - criando ###');

      qryLocal.sql.Text := RetornaSQLInsert<T>(aNomeTabela);
      CopiarParametros(aQryRemoto, qryLocal);
      SetarAutoInc<T>(qryLocal);
      qryLocal.ExecSQL;
    end;

    aQryRemoto.Next;
  end;

  qryLocal.free;
end;

class function TFacadeImportar.New: IFacadeImportar;
begin
  result := TFacadeImportar.Create;
end;

procedure TFacadeImportar.addObserver(obs: IFacadeObserver);
begin
  FObserves.Add(obs);
end;

procedure TFacadeImportar.NotifyObservers(aValue: string);
var
  I: Integer;
begin
  try
    EnterCriticalSection(csCriticalSection);
    for I := 0 to Pred(FObserves.Count) do
    begin
      try
        FObserves[I].FacadeUpdate(aValue);
      except
      end;
    end;
  finally
    LeaveCriticalSection(csCriticalSection);
  end;
end;

procedure TFacadeImportar.removeObserver(obs: IFacadeObserver);
begin
  if (FObserves.IndexOf(obs)) >= 0 then
    FObserves.remove(obs);
end;

initialization

InitializeCriticalSection(csCriticalSection);

finalization

DeleteCriticalSection(csCriticalSection);

end.
