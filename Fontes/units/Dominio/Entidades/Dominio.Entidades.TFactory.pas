unit Dominio.Entidades.TFactory;

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
  Dao.IDaoParceiroVenda,
  Dao.IDoParceiroVenda.Pagamentos, Dao.TDaoParceiroVenda.Pagamentos, Dao.TDaoParceiroVenda,
  Dao.TDAOPedidoPagamento, Dao.IDAOPedidoPagamento;

type

  TFactory = class
  strict private
    class var FConnection: TFDConnection;
    class var FPosPrinter: TACBrPosPrinter;
    class var FParametros: TParametros;
    class var FVendedorLogado: TVendedor;
    class var FDadosEmitente: TEmitente;

    class function getVendedorLogado(): TVendedor; static;
    class procedure setVendedorLogado(vendedor: TVendedor); static;
    class function getDadosEmitente: TEmitente; static;

    class function GetDataBase: string;
    class function CreateDatabase(path: string): Boolean; static;
    class function GetPathDB: string; static;
  public

    class property VendedorLogado: TVendedor read getVendedorLogado write setVendedorLogado;
    class property DadosEmitente: TEmitente read getDadosEmitente;

    constructor Create;
    class destructor destroy; static;

    class function Cliente(): TCliente;
    class function Fornecedor(): TFornecedor;
    class function vendedor(): TVendedor;
    class function Parceiro(): TParceiro;
    class function Pedido(): TPedido;
    class function Orcamento(): TOrcamento;
    class function Parcelas(): TParcelas;
    class function ItemPedido(): TItemPedido;
    class function Produto(): TProduto;
    class function FormaPagto: TFormaPagto;
    class function Emitente: TEmitente;
    class function ParceiroFormaPagto: TParceiroFormaPagto;

    class function DaoEmitente(): IDaoEmitente;
    class function DaoCliente(): IDaoCliente;
    class function DaoFornecedor(): IDaoFornecedor;
    class function DaoProduto(): IDaoProdutos;
    class function DaoOrcamento(): IDaoOrcamento;
    class function DaoFormaPagto(): IDaoFormaPagto;
    class function DaoPedido(): IDaoPedido;
    class function DaoParcelas(): IDaoParcelas;
    class function DaoVendedor(): IDaoVendedor;
    class function DaoParametros(): IDaoParametros;
    class function DaoPedidoPeriodo(): IDAOPedidoPeriodo;
    class function DaoParceiro(): IDaoParceiro;
    class function DaoParceiroFormaPagto(): IDaoParceiroFormaPagto;
    class function DaoParceiroVendaPagto(): IDaoParceiroVendaPagto;
    class function DaoParceiroVenda(): IDaoParceiroVenda;
    class function DAOPedidoPagamento(): IDAOPedidoPagamento;


    class function PosPrinter(): TACBrPosPrinter;

    class function Conexao(nova: Boolean = false): TFDConnection;
    class function Query(): TFDQuery;
    class function Parametros(): TParametros;

  end;

implementation


{ TFactory }

uses Util.Funcoes;

class function TFactory.Conexao(nova: Boolean = false): TFDConnection;
var
  oParams: TFDPhysFBConnectionDefParams;
begin
  if (FConnection = nil) or nova then
  begin
    if not SysUtils.DirectoryExists(GetPathDB()) then
      SysUtils.CreateDir(GetPathDB());

    FConnection := TFDConnection.Create(nil);
    FConnection.DriverName := 'FB';
    FConnection.Params.Add('OpenMode=OpenOrCreate');
    FConnection.Params.UserName := 'sysdba';
    FConnection.Params.Password := 'masterkey';
    FConnection.Params.Database := GetPathDB() + GetDataBase();
    // FConnection.Params.Add( 'CharacterSet=ISO8859_1');
    FConnection.FetchOptions.Mode := fmAll;
    FConnection.ResourceOptions.AutoConnect := true;
    FConnection.Open();
  end;

  result := FConnection;
end;

constructor TFactory.Create;
begin

end;

class function TFactory.DaoCliente: IDaoCliente;
begin
  result := TDaoCliente.Create(TFactory.Conexao());
end;

class function TFactory.DaoEmitente: IDaoEmitente;
begin
  result := TDaoEmitente.Create(TFactory.Conexao);
end;

class function TFactory.DaoFormaPagto: IDaoFormaPagto;
begin
  result := TDaoFormaPagto.Create(TFactory.Conexao);
end;

class function TFactory.DaoFornecedor: IDaoFornecedor;
begin
  result := TDaoFornecedor.Create(TFactory.Conexao);
end;

class function TFactory.DaoOrcamento: IDaoOrcamento;
begin
  result := TDaoOrcamento.Create(TFactory.Conexao);
end;

class function TFactory.DaoParametros: IDaoParametros;
begin
  result := TDaoParametros.Create(TFactory.Conexao());
end;

class function TFactory.DaoParceiro: IDaoParceiro;
begin
  result := TDaoParceiro.Create(TFactory.Conexao());
end;

class function TFactory.DaoParceiroFormaPagto: IDaoParceiroFormaPagto;
begin
  result := TDaoParceiroFormaPagto.Create(TFactory.Conexao);
end;

class function TFactory.DaoParceiroVenda: IDaoParceiroVenda;
begin
  result := TDaoParceiroVenda.Create(TFactory.Conexao);
end;

class function TFactory.DaoParceiroVendaPagto: IDaoParceiroVendaPagto;
begin
  result := TDaoParceiroVendaPagto.Create(TFactory.Conexao);
end;

class function TFactory.DaoParcelas: IDaoParcelas;
begin
  result := TDaoParcelas.Create(TFactory.Conexao);
end;

class function TFactory.DaoPedido: IDaoPedido;
begin
  result := TDaoPedido.Create(TFactory.Conexao);
end;

class function TFactory.DAOPedidoPagamento: IDAOPedidoPagamento;
begin
  result := TDAOPedidoPagamento.Create(TFactory.Conexao);
end;

class function TFactory.DaoPedidoPeriodo: IDAOPedidoPeriodo;
begin
  result := TDaoPedidoPeriodo.Create(TFactory.Conexao);
end;

class function TFactory.DaoProduto: IDaoProdutos;
begin
  result := TDaoProduto.Create(TFactory.Conexao);
end;

class function TFactory.DaoVendedor: IDaoVendedor;
begin
  result := TDaoVendedor.Create(TFactory.Conexao());
end;

class destructor TFactory.destroy;
begin
  if Assigned(FConnection) then
  begin
    FConnection.Close;
    FreeAndNil(FConnection);
  end;

  if Assigned(FDadosEmitente) then
    FreeAndNil(FDadosEmitente);

  if Assigned(FPosPrinter) then
    FreeAndNil(FPosPrinter);

  if Assigned(FParametros) then
    FreeAndNil(FParametros);

  if Assigned(FVendedorLogado) then
    FreeAndNil(FVendedorLogado);

end;

class function TFactory.Emitente: TEmitente;
begin
  result := TEmitente.Create;
end;

class function TFactory.FormaPagto: TFormaPagto;
begin
  result := TFormaPagto.Create;
end;

class function TFactory.Fornecedor: TFornecedor;
begin
  result := TFornecedor.Create;
end;

class function TFactory.getDadosEmitente: TEmitente;
var
  DaoEmitente: IDaoEmitente;
begin
  try
    if Assigned(FDadosEmitente) then
      FreeAndNil(FDadosEmitente);

    DaoEmitente := TFactory.DaoEmitente();
    FDadosEmitente := DaoEmitente.GetEmitente();

    result := FDadosEmitente;
  except
    on E: Exception do
      raise Exception.Create('Falha ao recuperar dados do Emitente: ' + E.Message);
  end;

end;

class function TFactory.getVendedorLogado: TVendedor;
begin
  result := FVendedorLogado;
end;

class function TFactory.Cliente: TCliente;
begin
  result := TCliente.Create;
end;

class function TFactory.ItemPedido: TItemPedido;
begin
  result := TItemPedido.Create;
end;

class function TFactory.Orcamento: TOrcamento;
begin
  result := TOrcamento.Create;
end;

class function TFactory.Parametros: TParametros;
var
  Dao: IDaoParametros;
begin
  if Assigned(FParametros) then
    FreeAndNil(FParametros);

  Dao := TFactory.DaoParametros;
  FParametros := Dao.GetParametros();

  result := FParametros;
end;

class function TFactory.GetPathDB: string;
begin
  result := TUtil.DiretorioApp + 'db\';
end;

class function TFactory.GetDataBase: string;
begin
  result := 'PED.FDB';
end;

class function TFactory.CreateDatabase(path: string): Boolean;
var
  FDScript1: TFDScript;
begin
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
end;

class function TFactory.Parceiro: TParceiro;
begin
  result := TParceiro.Create;
end;

class function TFactory.ParceiroFormaPagto: TParceiroFormaPagto;
begin
  result := TParceiroFormaPagto.Create;
end;

class function TFactory.Parcelas: TParcelas;
begin
  result := TParcelas.Create;
end;

class function TFactory.Pedido: TPedido;
begin
  result := TPedido.Create;
end;

class function TFactory.PosPrinter: TACBrPosPrinter;
var
  Parametros: TParametros;
begin
  if not Assigned(FPosPrinter) then
  begin
    Parametros := TFactory.Parametros;

    FPosPrinter := TACBrPosPrinter.Create(nil);

    FPosPrinter.Modelo := Parametros.Impressora.ModeloAsModeloAsACBrPosPrinterModelo;
    FPosPrinter.Device.Porta := Parametros.Impressora.PORTAIMPRESSORA;
    FPosPrinter.Device.Baud := StrToIntDef(Parametros.Impressora.VELOCIDADE, 9600);
  end;
  result := FPosPrinter;
end;

class function TFactory.Produto: TProduto;
begin
  result := TProduto.Create;
end;

class function TFactory.Query: TFDQuery;
begin
  result := TFDQuery.Create(nil);
  result.Connection := Conexao;
end;

class procedure TFactory.setVendedorLogado(vendedor: TVendedor);
begin
  FVendedorLogado := vendedor;
end;

class function TFactory.vendedor: TVendedor;
begin
  result := TVendedor.Create;
end;

end.
