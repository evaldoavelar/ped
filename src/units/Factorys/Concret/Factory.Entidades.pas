unit Factory.Entidades;

interface

uses IFactory.Entidades,
  Dominio.Entidades.TPedido, Dominio.Entidades.TVendedor, Dominio.Entidades.TCliente,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TProduto, Dominio.Entidades.TParcelas, Dominio.Entidades.TFormaPagto,
  ACBrPosPrinter, Sistema.TParametros, Dominio.Entidades.TEmitente,
  Dominio.Entidades.TFornecedor, Dominio.Entidades.TParceiro,
  Dominio.Entidades.TOrcamento, Dominio.Entidades.TParceiro.FormaPagto;

type
  TFactoryEntidades = class(TInterfacedObject, IFactoryEntidades)
  private
    class var FPosPrinter: TACBrPosPrinter;
    class var FParametros: TParametros;
    class var FVendedorLogado: TVendedor;
    function getVendedorLogado(): TVendedor;
    procedure setVendedorLogado(vendedor: TVendedor);

  protected
    property VendedorLogado: TVendedor read getVendedorLogado write setVendedorLogado;
    function Cliente(): TCliente;
    function Fornecedor(): TFornecedor;
    function vendedor(): TVendedor;
    function Parceiro(): TParceiro;
    function Pedido(): TPedido;
    function Orcamento(): TOrcamento;
    function Parcelas(): TParcelas;
    function ItemPedido(): TItemPedido;
    function Produto(): TProduto;
    function FormaPagto: TFormaPagto;
    function Emitente: TEmitente;
    function ParceiroFormaPagto: TParceiroFormaPagto;

    function PosPrinter(): TACBrPosPrinter;
  public
    class function Parametros: TParametros;
    class procedure SetParametros(value: TParametros);
    constructor Create;
    destructor Destroy; override;
    class function New: IFactoryEntidades;
  published

  end;

implementation

uses
  System.SysUtils, Factory.Dao;

{ TFactoryEntidades }

constructor TFactoryEntidades.Create;
begin
  inherited;

end;

class function TFactoryEntidades.Parametros: TParametros;
begin
  result := FParametros;
end;

function TFactoryEntidades.Parceiro: TParceiro;
begin
  result := TParceiro.Create;
end;

function TFactoryEntidades.ParceiroFormaPagto: TParceiroFormaPagto;
begin
  result := TParceiroFormaPagto.Create;
end;

function TFactoryEntidades.Parcelas: TParcelas;
begin
  result := TParcelas.Create;
end;

function TFactoryEntidades.Pedido: TPedido;
begin
  result := TPedido.Create;
end;

function TFactoryEntidades.PosPrinter: TACBrPosPrinter;

begin
  if not Assigned(FPosPrinter) then
  begin

    FPosPrinter := TACBrPosPrinter.Create(nil);

    FPosPrinter.Modelo := Parametros.ImpressoraTermica.ModeloAsModeloAsACBrPosPrinterModelo;
    FPosPrinter.Device.Porta := Parametros.ImpressoraTermica.PORTAIMPRESSORA;
    FPosPrinter.Device.Baud := StrToIntDef(Parametros.ImpressoraTermica.VELOCIDADE, 9600);
  end;
  result := FPosPrinter;
end;

function TFactoryEntidades.Produto: TProduto;
begin
  result := TProduto.Create;
end;

class procedure TFactoryEntidades.SetParametros(value: TParametros);
begin
  FParametros := value;
end;

procedure TFactoryEntidades.setVendedorLogado(vendedor: TVendedor);
begin
  FVendedorLogado := vendedor;
end;

function TFactoryEntidades.vendedor: TVendedor;
begin
  result := TVendedor.Create;
end;

destructor TFactoryEntidades.Destroy;
begin
  //
  // if Assigned(FPosPrinter) then
  // FreeAndNil(FPosPrinter);
  //
  // if Assigned(FVendedorLogado) then
  // FreeAndNil(FVendedorLogado);

  inherited;
end;

function TFactoryEntidades.Emitente: TEmitente;
begin
  result := TEmitente.Create;
end;

function TFactoryEntidades.FormaPagto: TFormaPagto;
begin
  result := TFormaPagto.Create;
end;

function TFactoryEntidades.Fornecedor: TFornecedor;
begin
  result := TFornecedor.Create;
end;

function TFactoryEntidades.getVendedorLogado: TVendedor;
begin
  result := FVendedorLogado;
end;

function TFactoryEntidades.Cliente: TCliente;
begin
  result := TCliente.Create;
end;

function TFactoryEntidades.ItemPedido: TItemPedido;
begin
  result := TItemPedido.Create;
end;

class function TFactoryEntidades.New: IFactoryEntidades;
begin
  result := TFactoryEntidades.Create;
end;

function TFactoryEntidades.Orcamento: TOrcamento;
begin
  result := TOrcamento.Create;
end;

end.
