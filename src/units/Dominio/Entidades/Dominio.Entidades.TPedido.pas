unit Dominio.Entidades.TPedido;

interface

uses
  System.Generics.Collections, classes, System.SysUtils,
  Vcl.Graphics, Vcl.ExtCtrls,
  Dominio.Entidades.TCliente,
  Dominio.Entidades.TVendedor,
  Dominio.Entidades.TItemPedido,
  Dominio.Entidades.TEntity,
  Dominio.Entidades.TParcelas,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos,
  Dominio.Entidades.TParceiro,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dominio.Entidades.Pedido.Pagamentos,
  Dominio.Entidades.Observe,
  Dominio.IEntidade;

type
  TTipoDesconto = (tpPercentual, tpValor);
  TOnVendeItem = reference to procedure(Item: TItemPedido);
  TOnExcluiItem = reference to procedure(Item: TItemPedido);
  TOnChange = reference to procedure(ValorLiquido, ValorBruto: currency; Volume: Double);
  TOnParcela = reference to procedure(parcelas: TObjectList<TParcelas>);
  TOnEstoqueBaixo = reference to procedure(aMsg: string);

  [Tabela('Pedido')]
  TPedido = class(TEntity, IEntityObservable)
  private
    FID: Integer;
    FNUMERO: string;
    FDATAPEDIDO: TDateTime;
    FHORAPEDIDO: TTime;
    FOBSERVACAO: string;
    FVALORDESC: currency;
    FVALORENTRADA: currency;
    FSTATUS: string;
    FCliente: TCliente;
    FVendedor: TVendedor;
    FItens: TObjectList<TItemPedido>;

    FOnVendeItem: TOnVendeItem;
    FOnExcluiItem: TOnExcluiItem;
    FOnChange: TOnChange;
    FOnParcela: TOnParcela;
    FCOMPROVANTE: TImage;
    FVendedorCancelamento: TVendedor;
    FDATACANCELAMENTO: TDateTime;
    FParceiro: TParceiro;
    FPagamentos: TPAGAMENTOS;
    FTROCO: currency;
    FVALORDESCONTO: currency;
    FVALORACRESCIMO: currency;
    FOnEstoqueBaixo: TOnEstoqueBaixo;
    FNUMCAIXA: string;

    function GetValorBruto: currency;
    function getValorLiquido: currency;
    function getTotalParcelas: currency;
    function GetItens: TObjectList<TItemPedido>;
    function getItemCount: Integer;
    function getDesconto: currency;
    procedure SetDesconto(const Value: currency);
    function getVolume: Double;
    function getOBSERVACAO: string;
    procedure setOBSERVACAO(const Value: string);
    function getVALORENTRADA: currency;
    procedure setVALORENTRADA(const Value: currency);
    procedure SetVendedorCancelamento(const Value: TVendedor);
    procedure SetDATACANCELAMENTO(const Value: TDateTime);
    function getDATACANCELAMENTO: TDateTime;
    procedure SetParceiro(const Value: TParceiro);
    procedure SetPagamentos(const Value: TPAGAMENTOS);
    procedure SetTROCO(const Value: currency);
    procedure SetVALORDESCONTO(const Value: currency);
    procedure OnEfetuaPagamento(ValorRecebido, aValorAcrescimo, ValorRestante,
      Troco: currency);
    function getTotalAcrescimoPagamentos: currency;
    procedure SetVALORACRESCIMO(const Value: currency);
    procedure SetOnEstoqueBaixo(const Value: TOnEstoqueBaixo);

  public
    constructor create;
    destructor destroy; override;
    procedure VendeItem(Item: TItemPedido);
    procedure AddParceiro(const Value: TParceiro);
    procedure ExcluiItem(seq: Integer);
    procedure AssignedItens(itens: TObjectList<TItemPedido>);
    procedure setDescontos(aTipo: TTipoDesconto; aValor: currency);

  published
    [campo('ID', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_PEDIDO', 'ID')]
    property ID: Integer read FID write FID;
    [campo('NUMERO', tpVARCHAR, 10)]
    property NUMERO: string read FNUMERO write FNUMERO;
    [campo('NUMCAIXA', tpVARCHAR, 10,0,true,'caixa-01')]
    property NUMCAIXA: string read FNUMCAIXA write FNUMCAIXA;
    [campo('DATAPEDIDO', tpDATE)]
    property DATAPEDIDO: TDateTime read FDATAPEDIDO write FDATAPEDIDO;
    [campo('HORAPEDIDO', tpTIME)]
    property HORAPEDIDO: TTime read FHORAPEDIDO write FHORAPEDIDO;
    [campo('OBSERVACAO', tpVARCHAR, 1000)]
    property OBSERVACAO: string read getOBSERVACAO write setOBSERVACAO;
    [campo('VALORBRUTO', tpNUMERIC, 15, 4)]
    property ValorBruto: currency read GetValorBruto;
    property ItemCount: Integer read getItemCount;
    [campo('VALORDESC', tpNUMERIC, 15, 4)]
    property VALORDESC: currency read getDesconto write SetDesconto;
    [campo('VALORENTRADA', tpNUMERIC, 15, 4, True, '0')]
    property ValorEntrada: currency read getVALORENTRADA write setVALORENTRADA;
    [campo('VALORLIQUIDO', tpNUMERIC, 15, 4)]
    property ValorLiquido: currency read getValorLiquido;
    property TOTALPARCELAS: currency read getTotalParcelas;
    [campo('STATUS', tpVARCHAR, 1)]
    property STATUS: string read FSTATUS write FSTATUS;

    [campo('VALORDESCONTO', tpNUMERIC, 15, 4, True, '0')]
    property VALORDESCONTO: currency read FVALORDESCONTO write SetVALORDESCONTO;

    [campo('TROCO', tpNUMERIC, 15, 4, True, '0')]
    property Troco: currency read FTROCO write SetTROCO;
    [campo('VALORACRESCIMO', tpNUMERIC, 15, 4, True, '0')]
    property VALORACRESCIMO: currency read FVALORACRESCIMO write SetVALORACRESCIMO;

    [campo('CODCLIENTE', tpVARCHAR, 10)]
    [ForeignKeyAttribute('FKPEDCLIENTE', 'CODCLIENTE', 'CLIENTE', 'CODIGO', None, None)]
    property Cliente: TCliente read FCliente write FCliente;

    [campo('CODVEN', tpVARCHAR, 10)]
    [ForeignKeyAttribute('FKPEDVEN', 'CODVEN', 'VENDEDOR', 'CODIGO', None, None)]
    property Vendedor: TVendedor read FVendedor write FVendedor;

    [campo('CODVENCANCELAMENTO', tpVARCHAR, 10)]
    property VendedorCancelamento: TVendedor read FVendedorCancelamento write SetVendedorCancelamento;

    [campo('DATACANCELAMENTO', tpDATE)]
    property DATACANCELAMENTO: TDateTime read getDATACANCELAMENTO write SetDATACANCELAMENTO;

    property itens: TObjectList<TItemPedido> read GetItens;
    property Pagamentos: TPAGAMENTOS read FPagamentos write SetPagamentos;

    property Volume: Double read getVolume;

    [ForeignKeyAttribute('FKPEDIDOPARCEIRO', 'CODPARCEIRO', 'PARCEIRO', 'CODIGO', None, None)]
    [campo('CODPARCEIRO', tpVARCHAR, 10)]
    [campo('NOMEPARCEIRO', tpVARCHAR, 35)]
    property ParceiroVenda: TParceiro read FParceiro write SetParceiro;

    [campo('COMPROVANTE', tpBLOB, 0, 9048)]
    property COMPROVANTE: TImage read FCOMPROVANTE write FCOMPROVANTE;

    property OnVendeItem: TOnVendeItem read FOnVendeItem write FOnVendeItem;
    property OnChange: TOnChange read FOnChange write FOnChange;
    property OnParcela: TOnParcela read FOnParcela write FOnParcela;
    property OnExcluiItem: TOnExcluiItem read FOnExcluiItem write FOnExcluiItem;
    property OnEstoqueBaixo: TOnEstoqueBaixo read FOnEstoqueBaixo write SetOnEstoqueBaixo;
    procedure Update(const ModelBase: IEntity);

  end;

implementation

uses
  Util.Funcoes, Util.Exceptions, Dominio.Entidades.TParceiroVenda.Pagamentos,
  Dominio.Entidades.TFormaPagto.Tipo, Dao.TDaoPedido;

{ TPedido }

procedure TPedido.AddParceiro(const Value: TParceiro);
begin
  Self.ParceiroVenda := Value;
  // if Assigned(Self.ParceiroVenda) then
  // Self.ParceiroVenda.IDPEDIDO := Self.ID;
  // Self.ParceiroVenda.TotalPagamento := Self.ValorLiquido;
end;

procedure TPedido.AssignedItens(itens: TObjectList<TItemPedido>);
begin
  Self.FItens := itens;
end;

constructor TPedido.create;
begin
  inherited;
  Self.InicializarPropriedades(nil);
  Self.FItens := TObjectList<TItemPedido>.create;
  Self.FItens.OwnsObjects := True;
  Self.DATACANCELAMENTO := 0;
  Self.FPagamentos := TPAGAMENTOS.create();
  // Self.FPagamentos.addObserver(Self);
end;

function TPedido.getTotalAcrescimoPagamentos: currency;
begin
  result := 0;
  for var pagto in Pagamentos.FormasDePagamento do
  begin
    result := result + pagto.ACRESCIMO;
  end;
end;

procedure TPedido.OnEfetuaPagamento(ValorRecebido: currency; aValorAcrescimo: currency; ValorRestante: currency; Troco: currency);
begin
  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.Volume);
end;

destructor TPedido.destroy;
begin
  // Self.FPagamentos.removeObserver(Self);
  Self.FPagamentos.Clear;
  Self.FPagamentos.Free;

  Self.FItens.OwnsObjects := True;
  Self.FItens.Clear;
  FreeAndNil(Self.FItens);

  if Assigned(FCliente) then
    FreeAndNil(FCliente);

  if Assigned(FVendedor) then
    FreeAndNil(FVendedor);

  if Assigned(FVendedorCancelamento) then
    FreeAndNil(FVendedorCancelamento);

  if Assigned(FCOMPROVANTE) then
  begin
    // FCOMPROVANTE.Picture.Graphic.Free;
    // FCOMPROVANTE.Picture.Graphic := nil;
    FreeAndNil(FCOMPROVANTE);
  end;

  inherited;
end;

procedure TPedido.ExcluiItem(seq: Integer);
var
  Item: TItemPedido;
  removido: Boolean;
begin

  removido := False;
  for Item in FItens do
  begin
    if Item.seq = seq then
    begin
      if Assigned(FOnExcluiItem) then
        Self.OnExcluiItem(Item);
      FItens.Remove(Item);
      removido := True;
      Break;
    end;
  end;

  if not removido then
    raise TValidacaoException.create('Numero do Item Inválido ou Item já cancelado');

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.Volume);

end;

function TPedido.getDATACANCELAMENTO: TDateTime;
begin
  result := FDATACANCELAMENTO;
end;

function TPedido.getDesconto: currency;
begin
  result := FVALORDESC;
end;

function TPedido.getItemCount: Integer;
begin
  result := Self.FItens.Count;
end;

function TPedido.GetItens: TObjectList<TItemPedido>;
begin
  result := Self.FItens;
end;

function TPedido.getOBSERVACAO: string;
begin
  result := FOBSERVACAO;
end;

function TPedido.getTotalParcelas: currency;
var
  Item: TParcelas;
  Pagtos: TPEDIDOPAGAMENTO;
begin
  result := 0;

  for Pagtos in Self.Pagamentos.FormasDePagamento do
    if Pagtos.TipoPagamento = TTipoPagto.Crediario then
      for Item in Pagtos.parcelas do
        result := result + Item.VALOR;

end;

function TPedido.GetValorBruto: currency;
var
  Item: TItemPedido;
begin
  result := 0;
  try

    if not Assigned(Self.FItens) then
      Exit;

    for Item in Self.FItens do
    begin
      result := result + Item.VALOR_TOTAL;
    end;

    result := TUtil.Truncar(result, 2);
  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Valor Bruto ' + E.Message);
  end;
end;

function TPedido.getVALORENTRADA: currency;
begin
  result := Self.FVALORENTRADA;
end;

function TPedido.getValorLiquido: currency;
begin
  result := Self.ValorBruto - Self.FVALORDESC - Self.FVALORENTRADA;
  result := TUtil.Truncar(result, 2);
end;

function TPedido.getVolume: Double;
var
  Item: TItemPedido;
begin
  result := 0;
  try

    for Item in Self.FItens do
    begin
      result := result + Item.QTD;
    end;

  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Volume ' + E.Message);
  end;

end;

procedure TPedido.SetDATACANCELAMENTO(const Value: TDateTime);
begin

  if Value <> FDATACANCELAMENTO then
  begin
    FDATACANCELAMENTO := Value;
    Notify('DATACANCELAMENTO');
  end;
end;

procedure TPedido.SetDesconto(const Value: currency);
begin
  if Value < 0 then
    raise TValidacaoException.create('Valor do Desconto é Inválido');

  Self.FVALORDESC := Value;

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.Volume);
end;

procedure TPedido.setDescontos(aTipo: TTipoDesconto; aValor: currency);
begin
  case aTipo of
    tpPercentual:
      begin
        FVALORDESC := ValorBruto * (aValor / 100);
      end;
    tpValor:
      begin
        FVALORDESC := aValor;
      end;
  end;

  FVALORDESC := TUtil.Truncar(FVALORDESC, 2);
end;

procedure TPedido.setOBSERVACAO(const Value: string);
begin
  if Value <> FOBSERVACAO then
  begin
    FOBSERVACAO := Value;
    Notify('OBSERVACAO');
  end;
end;

procedure TPedido.SetOnEstoqueBaixo(const Value: TOnEstoqueBaixo);
begin
  FOnEstoqueBaixo := Value;
end;

procedure TPedido.SetPagamentos(const Value: TPAGAMENTOS);
begin
  FPagamentos := Value;
end;

procedure TPedido.SetParceiro(const Value: TParceiro);
begin
  FParceiro := Value;
end;

procedure TPedido.SetTROCO(const Value: currency);
begin
  if Value <> FTROCO then
  begin
    FTROCO := Value;
    Notify('TROCO');
  end;
end;

procedure TPedido.SetVALORACRESCIMO(const Value: currency);
begin
  if Value <> FVALORACRESCIMO then
  begin
    FVALORACRESCIMO := Value;
    Notify('VALORACRESCIMO');
  end;
end;

procedure TPedido.SetVALORDESCONTO(const Value: currency);
begin
  if Value <> FVALORDESCONTO then
  begin
    FVALORDESCONTO := Value;
    Notify('VALORDESCONTO');
  end;
end;

procedure TPedido.setVALORENTRADA(const Value: currency);
begin
  if Value < 0 then
    raise TValidacaoException.create('Valor da Entrada precisa ser mair que zero! ' + CurrToStr(Value));

  if (Value >= Self.ValorLiquido) and (Self.ValorLiquido > 0) then
    raise TValidacaoException.create('O Valor da Entrada precisa ser menor que o valor do Pedido! ' + CurrToStr(Value));

  Self.FVALORENTRADA := Value;

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.Volume);

end;

procedure TPedido.SetVendedorCancelamento(const Value: TVendedor);
begin
  FVendedorCancelamento := Value;
end;

procedure TPedido.Update(const ModelBase: IEntity);
begin
  Self.Troco := Self.Pagamentos.Troco;
  Self.VALORACRESCIMO := getTotalAcrescimoPagamentos;

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.Volume);
end;

procedure TPedido.VendeItem(Item: TItemPedido);
begin
  if Item.VALOR_UNITA <= 0 then
    raise TValidacaoException.create('Valor do Produto Zerado! ' + CurrToStr(Item.VALOR_UNITA));

  if Trim(Item.DESCRICAO) = '' then
    raise TValidacaoException.create('Produto sem descrição! ');

  Item.IDPEDIDO := Self.ID;

  Self.FItens.Add(Item);

  if Assigned(Self.FOnVendeItem) then
    Self.FOnVendeItem(Item);

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.Volume);

end;

end.
