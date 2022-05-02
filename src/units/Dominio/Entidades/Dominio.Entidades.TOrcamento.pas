unit Dominio.Entidades.TOrcamento;

interface

uses
  System.Generics.Collections, classes, System.SysUtils,
  Vcl.Graphics, Vcl.ExtCtrls,
  Dominio.Entidades.TCliente,
  Dominio.Entidades.TVendedor,
  Dominio.Entidades.TEntity,
  Dominio.Entidades.TItemOrcamento,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Util.Exceptions, Util.Funcoes;

type
  TOnVendeItem = reference to procedure(Item: TItemOrcamento);
  TOnExcluiItem = reference to procedure(Item: TItemOrcamento);
  TOnChange = reference to procedure(ValorLiquido, ValorBruto, Desconto: currency; Volume: Double);

  [Tabela('ORCAMENTO')]
  TOrcamento = class(TEntity)
  private
    FID: Integer;
    FNUMERO: string;
    FDATAORCAMENTO: TDateTime;
    FHORAORCAMENTO: TTime;
    FOBSERVACAO: string;
    FVALORDESC: currency;
    FVALORENTRADA: currency;
    FSTATUS: string;
    FCliente: string;
    FTELEFONE :string;
    FVendedor: TVendedor;
    FItens: TObjectList<TItemOrcamento>;

    FOnVendeItem: TOnVendeItem;
    FOnExcluiItem: TOnExcluiItem;
    FOnChange: TOnChange;
    FDATAVENCIMENTO: TDateTime;

    function GetValorBruto: currency;
    function getValorLiquido: currency;
    function GetItens: TObjectList<TItemOrcamento>;
    function getItemCount: Integer;
    function getDesconto: currency;
    procedure SetDesconto(const Value: currency);
    function getVolume: Double;
    function getOBSERVACAO: string;
    procedure setOBSERVACAO(const Value: string);
    function getUltimoSequencial: Integer;
    function getTELEFONE: string;
    procedure setTELEFONE(const Value: string);

  public
    constructor create;
    destructor destroy; override;

    procedure VendeItem(Item: TItemOrcamento);
    procedure ExcluiItem(seq: Integer);
    procedure AssignedItens(itens: TObjectList<TItemOrcamento>);

  published
    [campo('ID', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_ORCAMENTO', 'ID')]
    property ID: Integer read FID write FID;

    [campo('NUMERO', tpVARCHAR, 10)]
    property NUMERO: string read FNUMERO write FNUMERO;

    [campo('DATAORCAMENTO', tpDATE)]
    property DATAORCAMENTO: TDateTime read FDATAORCAMENTO write FDATAORCAMENTO;

    [campo('HORAORCAMENTO', tpTIME)]
    property HORAORCAMENTO: TTime read FHORAORCAMENTO write FHORAORCAMENTO;

    [campo('DATAVENCIMENTO', tpDATE)]
    property DATAVENCIMENTO: TDateTime read FDATAVENCIMENTO write FDATAVENCIMENTO;

    [campo('OBSERVACAO', tpVARCHAR, 1000)]
    property OBSERVACAO: string read getOBSERVACAO write setOBSERVACAO;

    [campo('VALORBRUTO', tpNUMERIC, 15, 4)]
    property ValorBruto: currency read GetValorBruto;

    property ItemCount: Integer read getItemCount;

    property UltimoSequencial: Integer read getUltimoSequencial;

    [campo('VALORDESC', tpNUMERIC, 15, 4)]
    property VALORDESC: currency read getDesconto write SetDesconto;

    [campo('VALORLIQUIDO', tpNUMERIC, 15, 4)]
    property ValorLiquido: currency read getValorLiquido;

    [campo('STATUS', tpVARCHAR, 1)]
    property STATUS: string read FSTATUS write FSTATUS;

    [campo('CLIENTE', tpVARCHAR, 40)]
    property CLIENTE: string read FCliente write FCliente;

     [campo('TELEFONE', tpVARCHAR, 21)]
    property TELEFONE: string read getTELEFONE write setTELEFONE;

    [campo('CODVEN', tpVARCHAR,10)]
    [ForeignKeyAttribute('FK_ORC_VENDEDOR', 'CODVEN', 'VENDEDOR', 'CODIGO', None, None)]
    property Vendedor: TVendedor read FVendedor write FVendedor;

    property itens: TObjectList<TItemOrcamento> read GetItens;

    [campo('VOLUME', tpNUMERIC, 15, 4)]
    property Volume: Double read getVolume;


    property OnVendeItem: TOnVendeItem read FOnVendeItem write FOnVendeItem;
    property OnChange: TOnChange read FOnChange write FOnChange;
    property OnExcluiItem: TOnExcluiItem read FOnExcluiItem write FOnExcluiItem;
  end;

implementation

{ TOrcamento }

procedure TOrcamento.AssignedItens(itens: TObjectList<TItemOrcamento>);
begin
  Self.FItens := itens;
end;

constructor TOrcamento.create;
begin
  Self.InicializarPropriedades(nil);
  Self.FItens := TObjectList<TItemOrcamento>.create;
  Self.FItens.OwnsObjects := True;

end;

destructor TOrcamento.destroy;
begin

  Self.FItens.Clear;
  FreeAndNil(Self.FItens);

  if Assigned(FVendedor) then
  begin
    FreeAndNil(FVendedor);
  end;

  inherited;
end;

procedure TOrcamento.ExcluiItem(seq: Integer);
var
  Item: TItemOrcamento;
  removido: Boolean;
begin

  removido := False;
  for Item in FItens do
  begin
    if Item.seq = seq then
    begin
      FItens.Remove(Item);
      if Assigned(FOnExcluiItem) then
        Self.OnExcluiItem(Item);
      removido := True;
      Break;
    end;
  end;

  if not removido then
    raise TValidacaoException.create('Numero do Item Inválido ou Item já cancelado');

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.VALORDESC, Self.Volume);

end;

function TOrcamento.getDesconto: currency;
var
  Item: TItemOrcamento;
begin
  result := 0;
  try
    if not Assigned(Self.FItens) then
      Exit;

    for Item in Self.FItens do
    begin
      result := result + Item.VALOR_DESCONTO;
    end;

    // valor do desconto dos itens mais o desconto geral
    result := TUtil.Truncar(result, 2) + FVALORDESC;
  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Valor do Desconto: ' + E.Message);
  end;
end;

function TOrcamento.getItemCount: Integer;
begin
  result := Self.FItens.Count;
end;

function TOrcamento.GetItens: TObjectList<TItemOrcamento>;
begin
  result := Self.FItens;
end;

function TOrcamento.getOBSERVACAO: string;
begin
  result := FOBSERVACAO;
end;

function TOrcamento.getTELEFONE: string;
begin
   result := FTELEFONE;
end;

function TOrcamento.getUltimoSequencial: Integer;
var
  Item: TItemOrcamento;
begin
  result := 1;
  try
    if not Assigned(Self.FItens) then
      Exit;

    for Item in Self.FItens do
    begin
      if Item.seq > result then
        result := Item.seq;
    end;

  except
    on E: Exception do
      raise TCalculoException.create('Falha getUltimoSequencial ' + E.Message);
  end;
end;

function TOrcamento.GetValorBruto: currency;
var
  Item: TItemOrcamento;
begin
  result := 0;
  try
    if not Assigned(Self.FItens) then
      Exit;

    for Item in Self.FItens do
    begin
      result := result + Item.VALOR_BRUTO;
    end;

    result := TUtil.Truncar(result, 2);
  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Valor Bruto ' + E.Message);
  end;

end;

function TOrcamento.getValorLiquido: currency;
begin
  result := Self.ValorBruto - Self.VALORDESC;
  result := TUtil.Truncar(result, 2);
end;

function TOrcamento.getVolume: Double;
var
  Item: TItemOrcamento;
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

procedure TOrcamento.SetDesconto(const Value: currency);
begin
  if Value < 0 then
    raise TValidacaoException.create('Valor do Desconto é Inválido');

  Self.FVALORDESC := Value;

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.VALORDESC, Self.Volume);
end;

procedure TOrcamento.setOBSERVACAO(const Value: string);
begin
  if Value <> FOBSERVACAO then
  begin
    FOBSERVACAO := Value;
    Notify('OBSERVACAO');
  end;
end;

procedure TOrcamento.setTELEFONE(const Value: string);
begin
   Self.FTELEFONE := Value;
end;

procedure TOrcamento.VendeItem(Item: TItemOrcamento);
begin
  if Item.VALOR_UNITA <= 0 then
    raise TValidacaoException.create('Valor do Produto Zerado! ' + CurrToStr(Item.VALOR_UNITA));

  if Trim(Item.DESCRICAO) = '' then
    raise TValidacaoException.create('Produto sem descrição! ');

  Item.IDORCAMENTO := Self.ID;

  Self.FItens.Add(Item);

  if Assigned(Self.FOnVendeItem) then
    Self.FOnVendeItem(Item);

  if Assigned(Self.FOnChange) then
    Self.FOnChange(Self.ValorLiquido, Self.ValorBruto, Self.VALORDESC, Self.Volume);
end;

end.
