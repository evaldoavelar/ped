unit Dominio.Entidades.TParceiroVenda;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Dominio.Entidades.TParceiro,
  System.Generics.Collections, System.SysUtils, Dominio.Entidades.TParceiroVenda.Pagamentos,
  Util.Exceptions, Dominio.Entidades.TVendedor;

type

  TOnAddPgamento = reference to procedure(Item: TParceiroVendaPagto);
  TOnAddParceiro = reference to procedure(Item: TParceiro);
  TOnRemovePagamento = reference to procedure(Index: Integer);

  [Tabela('PARCEIROVENDA')]
  TParceiroVenda = class(TEntity)
  private
    FCOMISSAOP: currency;
    FParceiro: TParceiro;
    FID: Integer;
    FIDPEDIDO: Integer;
    FNOME: string;
    FDATA: TDate;
    FPagamentos: TList<TParceiroVendaPagto>;
    FOnAddParceiro: TOnAddParceiro;
    FOnAddPgamento: TOnAddPgamento;
    FVendedor: TVendedor;
    FOnRemovePagamento: TOnRemovePagamento;
    FSTATUS: string;
    FVendedorCancelamento: TVendedor;
    FDATACANCELAMENTO: TDate;
    FDATAALTERACAO: TDateTime;
    procedure SetCOMISSAOP(const Value: currency);
    procedure SetDATA(const Value: TDate);
    procedure SetID(const Value: Integer);
    procedure SetIDPEDIDO(const Value: Integer);
    procedure SetNOME(const Value: string);
    procedure SetParceiro(const Value: TParceiro);
    function GetPagamentos: TList<TParceiroVendaPagto>;
    function getTotalPercentual: Double;
    function GetSequencial: Integer;
    function getTotalComissao: currency;
    function getTotalPagamento: currency;
    procedure SetSTATUS(const Value: string);
    procedure SetDATACANCELAMENTO(const Value: TDate);
    procedure SetVendedorCancelamento(const Value: TVendedor);
    procedure SetDATAALTERACAO(const Value: TDateTime);
  public
    [AutoInc('AUTOINC')]
    [campo('ID', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PKPARCEIROVENDA', 'ID')]
    property ID: Integer read FID write SetID;

    [campo('CODPARCEIRO', tpVARCHAR, 10)]
    [ForeignKeyAttribute('FKPARCEIRO', 'CODPARCEIRO', 'PARCEIRO', 'CODIGO', TRuleAction.None, TRuleAction.None)]
    property Parceiro: TParceiro read FParceiro write SetParceiro;

    [campo('NOME', tpVARCHAR, 35)]
    property NOME: string read FNOME write SetNOME;

    [campo('IDPEDIDO', tpINTEGER)]
    [ForeignKeyAttribute('FKPARCEIROPED', 'IDPEDIDO', 'PEDIDO', 'ID', TRuleAction.None, TRuleAction.None)]
    property IDPEDIDO: Integer read FIDPEDIDO write SetIDPEDIDO;

    [campo('DATA', tpDATE)]
    property DATA: TDate read FDATA write SetDATA;

    [campo('CODVEN', tpVARCHAR, 10)]
    [ForeignKeyAttribute('FKPEDVEN', 'CODVEN', 'VENDEDOR', 'CODIGO', TRuleAction.None, TRuleAction.None)]
    property Vendedor: TVendedor read FVendedor write FVendedor;

    property Pagamentos: TList<TParceiroVendaPagto> read GetPagamentos;

    [campo('TOTALPAGAMENTO', tpNUMERIC, 15, 4)]
    property TotalPagamento: currency read getTotalPagamento;
    [campo('TOTALCOMISSAO', tpNUMERIC, 15, 4)]
    property TotalComissao: currency read getTotalComissao;

    [campo('STATUS', tpVARCHAR, 1)]
    property STATUS: string read FSTATUS write SetSTATUS;

    [campo('CODVENCANCELAMENTO', tpVARCHAR, 10)]
    property VendedorCancelamento: TVendedor read FVendedorCancelamento write SetVendedorCancelamento;

    [campo('DATACANCELAMENTO', tpDATE)]
    property DATACANCELAMENTO: TDate read FDATACANCELAMENTO write SetDATACANCELAMENTO;

    [campo('DATAALTERACAO', tpTIMESTAMP)]
    property DATAALTERACAO: TDateTime read FDATAALTERACAO write SetDATAALTERACAO;

    property OnAddParceiro: TOnAddParceiro read FOnAddParceiro write FOnAddParceiro;
    property OnAddPgamento: TOnAddPgamento read FOnAddPgamento write FOnAddPgamento;
    property OnRemovePagamento: TOnRemovePagamento read FOnRemovePagamento write FOnRemovePagamento;
  public

    procedure AddParceiro(aParceiro: TParceiro);
    procedure AddPagameto(pagto: TParceiroVendaPagto);
    procedure RemoveUltimoPagamento();

    constructor create; override;
    destructor Destroy;
  end;

implementation

{ TParceiroVenda }

procedure TParceiroVenda.AddPagameto(pagto: TParceiroVendaPagto);
begin
  if Assigned(FParceiro) = false then
    raise Exception.create('O Parceiro deve ser informado antes de informar o pagamento');

  pagto.seq := Self.Pagamentos.Count + 1;

  Self.FPagamentos.Add(pagto);

  if Assigned(Self.FOnAddPgamento) then
    Self.FOnAddPgamento(pagto);
end;

procedure TParceiroVenda.AddParceiro(aParceiro: TParceiro);
begin
  if Assigned(Self.FParceiro) then
    FreeAndNil(Self.FParceiro);

  Self.FParceiro := aParceiro;
  Self.FNOME := aParceiro.NOME;

  if Assigned(Self.FOnAddParceiro) then
    Self.FOnAddParceiro(aParceiro);

end;

constructor TParceiroVenda.create;
begin
  inherited;
  FPagamentos := TList<TParceiroVendaPagto>.create;
end;

destructor TParceiroVenda.Destroy;
var
  pagto: TParceiroVendaPagto;
begin
  for pagto in FPagamentos do
  begin
    pagto.Free;
  end;

  FPagamentos.Free;

  if Assigned(Self.FParceiro) then
    FreeAndNil(Self.FParceiro);

  if Assigned(Self.FVendedor) then
    FreeAndNil(FVendedor);
end;

function TParceiroVenda.GetSequencial: Integer;
var
  pagto: TParceiroVendaPagto;
begin
  Result := 0;

  for pagto in FPagamentos do
  begin
    if pagto.seq > Result then
    begin
      Result := pagto.seq;
    end;
  end;

  Inc(Result);
end;

function TParceiroVenda.getTotalComissao: currency;
var
  pagto: TParceiroVendaPagto;
begin
  Result := 0;
  try

    for pagto in Pagamentos do
    begin
      Result := Result + pagto.COMISSAOVALOR;
    end;

  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Total da Comissao ' + E.Message);
  end;

end;

function TParceiroVenda.getTotalPagamento: currency;
var
  pagto: TParceiroVendaPagto;
begin
  Result := 0;
  try

    for pagto in Pagamentos do
    begin
      Result := Result + pagto.VALORPAGAMENTO;
    end;

  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Total do pagamento ' + E.Message);
  end;

end;

function TParceiroVenda.getTotalPercentual: Double;
var
  pagto: TParceiroVendaPagto;
begin
  Result := 0;
  try

    for pagto in Pagamentos do
    begin
      Result := Result + pagto.COMISSAOPERCENTUAL;
    end;

  except
    on E: Exception do
      raise TCalculoException.create('Falha no Calculo do Volume ' + E.Message);
  end;

end;

procedure TParceiroVenda.RemoveUltimoPagamento;
var
  i: Integer;
begin
  i := Pagamentos.Count - 1;

  if i >= 0 then
    Pagamentos.Delete(i);

  if Assigned(Self.FOnRemovePagamento) then
    Self.FOnRemovePagamento(i);
end;

function TParceiroVenda.GetPagamentos: TList<TParceiroVendaPagto>;
begin
  Result := FPagamentos;
end;

procedure TParceiroVenda.SetCOMISSAOP(const Value: currency);
begin
  FCOMISSAOP := Value;
end;

procedure TParceiroVenda.SetDATA(const Value: TDate);
begin
  FDATA := Value;
end;

procedure TParceiroVenda.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TParceiroVenda.SetDATACANCELAMENTO(const Value: TDate);
begin
  FDATACANCELAMENTO := Value;
end;

procedure TParceiroVenda.SetID(const Value: Integer);
var
  pagto: TParceiroVendaPagto;
begin
  FID := Value;

  try

    for pagto in Pagamentos do
    begin
      pagto.IDPARCEIROVENDA := FID;
    end;

  except
    on E: Exception do
      raise TCalculoException.create('Falha no SetID ' + E.Message);
  end;
end;

procedure TParceiroVenda.SetIDPEDIDO(const Value: Integer);
begin
  FIDPEDIDO := Value;
end;

procedure TParceiroVenda.SetNOME(const Value: string);
begin
  FNOME := Value;
end;

procedure TParceiroVenda.SetParceiro(const Value: TParceiro);
begin
  FParceiro := Value;
end;

procedure TParceiroVenda.SetSTATUS(const Value: string);
begin
  FSTATUS := Value;
end;

procedure TParceiroVenda.SetVendedorCancelamento(const Value: TVendedor);
begin
  FVendedorCancelamento := Value;
end;

end.
