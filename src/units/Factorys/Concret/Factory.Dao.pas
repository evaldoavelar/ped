unit Factory.Dao;

interface

uses SysUtils,
  Classes, Math, DateUtils, ACBrPosPrinter, FireDAC.Stan.Def, FireDAC.Stan.Async,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.DApt,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.FBDef, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  Dominio.Entidades.TPedido, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TProduto, Dominio.Entidades.TParcelas, Dominio.Entidades.TFormaPagto,
  Dao.TDaoPedido, Dao.IDaoPedido, Dao.IDaoVendedor, Dao.TDaoVendedor, Dao.IDaoProdutos, Dao.TDaoProdutos, Dao.TDaoCliente, Dao.IDaoCliente, Dao.IDaoFormaPagto, Dao.TDaoFormaPagto,
  Dao.TDaoParcelas, Dao.IDaoParcelas, Dominio.Entidades.TFornecedor, Dao.IDaoFornecedor, Dao.TDaoFornecedor,
  Dao.IDaoEmitente, Dao.TDaoEmitente, Dominio.Entidades.TEmitente,
  Sistema.TParametros, Dao.IDaoParametros, Dao.TDaoParametros, Dao.IDAOPedidoPeriodo,
  Dao.TDaoPedidoPeriodo, Dominio.Entidades.TOrcamento, Dao.IDaoOrcamento, Dao.TDaoOrcamento, FireDAC.Comp.Script, Dao.IDaoParceiro, Dao.TDaoParceiro,
  Dominio.Entidades.TParceiro, Dao.IDaoParceiro.FormaPagto, Dao.TDaoParceiro.FormaPagto, Dominio.Entidades.TParceiro.FormaPagto, Dominio.Entidades.TParceiroVenda,
  Dao.IDaoParceiroVenda, Dao.TDaoEstoqueProduto,
  Dao.IDoParceiroVenda.Pagamentos, Dao.TDaoParceiroVenda.Pagamentos, Dao.TDaoParceiroVenda,
  Dao.TDAOPedidoPagamento, Dao.IDAOPedidoPagamento, Dao.IDAOTSangriaSuprimento,
  Dao.IDaoEstoqueProduto, Dao.IDaoFiltroEstoque, IFactory.Dao,
  Dao.IDaoParametrosBancoDeDados, Sistema.TBancoDeDados, Dao.TParametrosBancoDeDados;

type

  TFactory = class(TInterfacedObject, IFactoryDao)
  strict private
    FConnection: TFDConnection;
    class var FDadosEmitente: TEmitente;

    function GetDataBase: string;
    function CreateDatabase(path: string): Boolean;
    function GetPathDB: string;
    function getDadosEmitente: TEmitente;
  private
    FKeepConection: Boolean;

  public

    function DaoEmitente(): IDaoEmitente;
    function DaoCliente(): IDaoCliente;
    function DaoFornecedor(): IDaoFornecedor;
    function DaoProduto(): IDaoProdutos;
    function DaoOrcamento(): IDaoOrcamento;
    function DaoFormaPagto(): IDaoFormaPagto;
    function DaoPedido(): IDaoPedido;
    function DaoParcelas(): IDaoParcelas;
    function DaoVendedor(): IDaoVendedor;
    function DaoParametros(): IDaoParametros;
    function DaoPedidoPeriodo(): IDAOPedidoPeriodo;
    function DaoParceiro(): IDaoParceiro;
    function DaoParceiroFormaPagto(): IDaoParceiroFormaPagto;
    function DaoParceiroVendaPagto(): IDaoParceiroVendaPagto;
    function DaoParceiroVenda(): IDaoParceiroVenda;
    function DAOPedidoPagamento(): IDAOPedidoPagamento;
    function DAOTSangriaSuprimento(): IDAOTSangriaSuprimento;
    function DaoEstoqueProduto(): IDaoEstoqueProduto;
    function DaoFiltroEstoque(): IDaoEstoqueFiltro;
    function DaoParametrosBancoDeDados: IDaoParametrosBancoDeDados;

    property DadosEmitente: TEmitente read getDadosEmitente;

    function Conexao(aBancoDeDados: TParametrosBancoDeDados = nil): TFDConnection;
    function Query(): TFDQuery;
    procedure Close();
  public
    constructor Create(aConnection: TFDConnection = nil; aKeepConection: Boolean = false);
    destructor destroy; override;
    class function New(aConnection: TFDConnection = nil; aKeepConection: Boolean = false): IFactoryDao;
  end;

implementation


{ TFactory }

uses Util.Funcoes, Dao.TSangriaSuprimento, Dao.TDaoEstoqueFiltro, Sistema.TLog;

procedure TFactory.Close;
begin
  TLog.d('>>> Entrando em  TFactory.Close FKeepConection: %s ', [FKeepConection.ToString(true)]);
  if FKeepConection then
    if Assigned(FConnection) then
    begin
      FConnection.Close;
      FreeAndNil(FConnection);
    end;
  TLog.d('<<< Saindo de TFactory.Close ');
end;

function TFactory.Conexao(aBancoDeDados: TParametrosBancoDeDados = nil): TFDConnection;
var
  oParams: TFDPhysFBConnectionDefParams;
begin
 // TLog.d('>>> Entrando em  TFactory.Conexao FKeepConection: %s ', [FKeepConection.ToString(true)]);
  if (FConnection = nil) then
  begin
    // if not SysUtils.DirectoryExists(GetPathDB()) then
    // SysUtils.CreateDir(GetPathDB());

    if aBancoDeDados = nil then
      aBancoDeDados := DaoParametrosBancoDeDados.Carregar;

    FConnection := TFDConnection.Create(nil);
    FConnection.DriverName := 'FB';
    FConnection.Params.Add('OpenMode=OpenOrCreate');
    FConnection.Params.UserName := aBancoDeDados.Usuario;
    FConnection.Params.Password := aBancoDeDados.SenhaProxy;
    FConnection.Params.Database := aBancoDeDados.Database;
    // FConnection.Params.Add( 'CharacterSet=ISO8859_1');
    FConnection.FetchOptions.Mode := fmAll;
    FConnection.ResourceOptions.AutoConnect := true;
    FConnection.Open();
  end;

  result := FConnection;
 // TLog.d('<<< Saindo de TFactory.Conexao ');
end;

constructor TFactory.Create(aConnection: TFDConnection = nil; aKeepConection: Boolean = false);
begin
  TLog.d('>>> Entrando em  TFactory.Create ');
  FConnection := aConnection;
  FKeepConection := aKeepConection;
  TLog.d('<<< Saindo de TFactory.Create ');
end;

function TFactory.DaoCliente: IDaoCliente;
begin
  TLog.d('>>> Entrando em  TFactory.DaoCliente ');
  result := TDaoCliente.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoCliente ');
end;

function TFactory.Query: TFDQuery;
begin
 // TLog.d('>>> Entrando em  TFactory.Query ');
  result := TFDQuery.Create(nil);
  result.Connection := Conexao;
 // TLog.d('<<< Saindo de TFactory.Query ');

end;

function TFactory.getDadosEmitente: TEmitente;
begin
  TLog.d('>>> Entrando em  TFactory.getDadosEmitente ');
  try
    if Assigned(FDadosEmitente) then
      FreeAndNil(FDadosEmitente);

    FDadosEmitente := DaoEmitente.GetEmitente();

    result := FDadosEmitente;
  except
    on E: Exception do
      raise Exception.Create('Falha ao recuperar dados do Emitente: ' + E.Message);
  end;
  TLog.d('<<< Saindo de TFactory.getDadosEmitente ');
end;

function TFactory.DaoEmitente: IDaoEmitente;
begin
  TLog.d('>>> Entrando em  TFactory.DaoEmitente ');
  result := TDaoEmitente.Create(Conexao, FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoEmitente ');
end;

function TFactory.DaoEstoqueProduto: IDaoEstoqueProduto;
begin
  TLog.d('>>> Entrando em  TFactory.DaoEstoqueProduto ');
  result := TDaoEstoqueProduto.Create(Conexao, FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoEstoqueProduto ');
end;

function TFactory.DaoFiltroEstoque: IDaoEstoqueFiltro;
begin
  TLog.d('>>> Entrando em  TFactory.DaoFiltroEstoque ');
  result := TDaoEstoqueFiltro.Create();
  TLog.d('<<< Saindo de TFactory.DaoFiltroEstoque ');
end;

function TFactory.DaoFormaPagto: IDaoFormaPagto;
begin
  TLog.d('>>> Entrando em  TFactory.DaoFormaPagto ');
  result := TDaoFormaPagto.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoFormaPagto ');
end;

function TFactory.DaoFornecedor: IDaoFornecedor;
begin
  TLog.d('>>> Entrando em  TFactory.DaoFornecedor ');
  result := TDaoFornecedor.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoFornecedor ');
end;

function TFactory.DaoOrcamento: IDaoOrcamento;
begin
  TLog.d('>>> Entrando em  TFactory.DaoOrcamento ');
  result := TDaoOrcamento.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoOrcamento ');
end;

function TFactory.DaoParametros: IDaoParametros;
begin
  TLog.d('>>> Entrando em  TFactory.DaoParametros ');
  result := TDaoParametros.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoParametros ');
end;

function TFactory.DaoParametrosBancoDeDados: IDaoParametrosBancoDeDados;
begin
  TLog.d('>>> Entrando em  TFactory.DaoParametrosBancoDeDados ');
  result := TDaoParametrosBancoDeDados.Create(TUtil.DiretorioApp + 'config.ini');
  TLog.d('<<< Saindo de TFactory.DaoParametrosBancoDeDados ');
end;

function TFactory.DaoParceiro: IDaoParceiro;
begin
  TLog.d('>>> Entrando em  TFactory.DaoParceiro ');
  result := TDaoParceiro.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoParceiro ');
end;

function TFactory.DaoParceiroFormaPagto: IDaoParceiroFormaPagto;
begin
  TLog.d('>>> Entrando em  TFactory.DaoParceiroFormaPagto ');
  result := TDaoParceiroFormaPagto.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoParceiroFormaPagto ');
end;

function TFactory.DaoParceiroVenda: IDaoParceiroVenda;
begin
  TLog.d('>>> Entrando em  TFactory.DaoParceiroVenda ');
  result := TDaoParceiroVenda.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoParceiroVenda ');
end;

function TFactory.DaoParceiroVendaPagto: IDaoParceiroVendaPagto;
begin
  TLog.d('>>> Entrando em  TFactory.DaoParceiroVendaPagto ');
  result := TDaoParceiroVendaPagto.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoParceiroVendaPagto ');
end;

function TFactory.DaoParcelas: IDaoParcelas;
begin
  TLog.d('>>> Entrando em  TFactory.DaoParcelas ');
  result := TDaoParcelas.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoParcelas ');
end;

function TFactory.DaoPedido: IDaoPedido;
begin
  TLog.d('>>> Entrando em  TFactory.DaoPedido ');
  result := TDaoPedido.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoPedido ');
end;

function TFactory.DAOPedidoPagamento: IDAOPedidoPagamento;
begin
  TLog.d('>>> Entrando em  TFactory.DAOPedidoPagamento ');
  result := TDAOPedidoPagamento.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DAOPedidoPagamento ');
end;

function TFactory.DaoPedidoPeriodo: IDAOPedidoPeriodo;
begin
  TLog.d('>>> Entrando em  TFactory.DaoPedidoPeriodo ');
  result := TDaoPedidoPeriodo.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoPedidoPeriodo ');
end;

function TFactory.DaoProduto: IDaoProdutos;
begin
  TLog.d('>>> Entrando em  TFactory.DaoProduto ');
  result := TDaoProduto.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoProduto ');
end;

function TFactory.DAOTSangriaSuprimento: IDAOTSangriaSuprimento;
begin
  TLog.d('>>> Entrando em  TFactory.DAOTSangriaSuprimento ');
  result := TDAOSangriaSuprimento.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DAOTSangriaSuprimento ');
end;

function TFactory.DaoVendedor: IDaoVendedor;
begin
  TLog.d('>>> Entrando em  TFactory.DaoVendedor ');
  result := TDaoVendedor.Create(Conexao(), FKeepConection);
  TLog.d('<<< Saindo de TFactory.DaoVendedor ');
end;

destructor TFactory.destroy;
begin
  TLog.d('>>> Entrando em  TFactory.destroy ');
  // if Assigned(FConnection) then
  // begin
  // FConnection.Close;
  // FreeAndNil(FConnection);
  // end;
  if Assigned(FDadosEmitente) then
    FreeAndNil(FDadosEmitente);

  inherited;
  TLog.d('<<< Saindo de TFactory.destroy ');
end;

function TFactory.GetPathDB: string;
begin
  TLog.d('>>> Entrando em  TFactory.GetPathDB ');
  result := TUtil.DiretorioApp + 'db\';
  TLog.d('<<< Saindo de TFactory.GetPathDB ');
end;

class function TFactory.New(aConnection: TFDConnection = nil; aKeepConection: Boolean = false): IFactoryDao;
begin
  result := TFactory.Create(aConnection, aKeepConection);
end;

function TFactory.GetDataBase: string;
begin
  result := 'PED.FDB';
end;

function TFactory.CreateDatabase(path: string): Boolean;
var
  FDScript1: TFDScript;
begin
  TLog.d('>>> Entrando em  TFactory.CreateDatabase ');
  FDScript1 := TFDScript.Create(nil);
  try
    with FDScript1 do
    begin
      SQLScripts.Clear;
      SQLScripts.Add;
      with SQLScripts[0].SQL do
      begin
        Add('SET SQL DIALECT 3;');
        Add('SET NAMES UTF8;');

        // Add( 'SET CLIENTLIB ''C:\fb25\bin\fbclient.dll'';');

        Add('CREATE DATABASE ' + path);

        Add('  USER ''sysdba'' PASSWORD ''masterkey'' ');
        Add('  PAGE_SIZE 16384 ');
        Add('  DEFAULT CHARACTER SET NONE;');
        Add('SET TERM ^ ;');
      end;
      ValidateAll;
      ExecuteAll;
    end;
  finally
    FreeAndNil(FDScript1);
  end;
  TLog.d('<<< Saindo de TFactory.CreateDatabase ');
end;

end.
