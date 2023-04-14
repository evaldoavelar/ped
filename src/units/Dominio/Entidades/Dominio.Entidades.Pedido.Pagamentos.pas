unit Dominio.Entidades.Pedido.Pagamentos;

interface

uses
  Dominio.Entidades.Pedido.Pagamentos.Pagamento, System.Generics.Collections,
   Dominio.Entidades.TFormaPagto.Tipo,
  Dominio.Entidades.TEntity;

type

  TOnCalculaParcela = reference to procedure(ValorBaixa: Currency);
  TOnEfetuaPagamento = reference to procedure(ValorRecebido: Currency; aValorAcrescimo: Currency; ValorRestante: Currency; Troco: Currency);

  TPAGAMENTOS = class(TEntity)
  private
    FFormasDePagamento: TLIST<TPEDIDOPAGAMENTO>;
    FValorDesc: Currency;
    FValorBaixa: Currency;
    FValorOriginal: Currency;
    FOnEfetuaPagamento: TOnEfetuaPagamento;
    FOnCalculaParcela: TOnCalculaParcela;
    function NextSeqPagamento: integer;
    procedure SetFormasDePagamento(const Value: TLIST<TPEDIDOPAGAMENTO>);
    function getTroco: Currency;
    function getValorRecebido: Currency;
    function getValorRestante: Currency;
    procedure SetValorDesc(const Value: Currency);
    procedure SetValorOriginal(const Value: Currency);
    function getValorBaixa: Currency;
    procedure setValorBaixa(const Value: Currency);
    function getValorAcrescimo: Currency;
  public

    property ValorOriginal: Currency read FValorOriginal write SetValorOriginal;
    property ValorDesc: Currency read FValorDesc write SetValorDesc;
    property ValorBaixa: Currency read getValorBaixa write setValorBaixa;
    property ValorAcrescimo: Currency read getValorAcrescimo;

    property ValorRecebido: Currency read getValorRecebido;
    property ValorRestante: Currency read getValorRestante;
    property Troco: Currency read getTroco;

    property OnCalculaParcela: TOnCalculaParcela read FOnCalculaParcela write FOnCalculaParcela;
    property OnEfetuaPagamento: TOnEfetuaPagamento read FOnEfetuaPagamento write FOnEfetuaPagamento;

    property FormasDePagamento: TLIST<TPEDIDOPAGAMENTO> read FFormasDePagamento write SetFormasDePagamento;

    function NewPagamento(): TPEDIDOPAGAMENTO; overload;
    procedure AddPagamento(pagto: TPEDIDOPAGAMENTO); overload;

    function GetPagamento(seqPagto: integer): TPEDIDOPAGAMENTO;
    function GetSubTotal: Double;

    procedure RemovePagamento(aPagamento: TPEDIDOPAGAMENTO); overload;
    procedure RemovePagamento(index: integer); overload;

    procedure AssignedPagamentos(aFormasDePagamento: TLIST<TPEDIDOPAGAMENTO>);

    function ContemTipo(aTipo: TTipoPagto): boolean;

    procedure Clear;

  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Utils.Rtti, System.SysUtils;

function TPAGAMENTOS.NewPagamento: TPEDIDOPAGAMENTO;
begin
  Result := TPEDIDOPAGAMENTO.Create();
  // Result.IDPEDIDO := Self.ID;
  Result.SEQ := Self.NextSeqPagamento();
  Result.StatusBD := TPEDIDOPAGAMENTO.TStatusBD.stCriar;
  // FFormasDePagamento.Add(Result);

  if Assigned(FOnEfetuaPagamento) then
    FOnEfetuaPagamento(ValorRecebido, ValorAcrescimo, ValorRestante, Troco);

  // NotifyObservers();
end;

procedure TPAGAMENTOS.AddPagamento(pagto: TPEDIDOPAGAMENTO);
begin
  if pagto.Valor <= 0 then
    raise Exception.Create('Valor inválido para o pagamento');

  for var item in Self.FFormasDePagamento do
  begin
    if (item.IDPAGTO = pagto.IDPAGTO)
      and (pagto.TipoPagamento = item.TipoPagamento)
      and (pagto.IDCONDICAO = item.IDCONDICAO)
    then
      raise Exception.Create('Forma de Pagamento já incluso');
  end;

  Self.FFormasDePagamento.add(pagto);

  if Assigned(FOnEfetuaPagamento) then
    FOnEfetuaPagamento(ValorRecebido, ValorAcrescimo, ValorRestante, Troco);

  // NotifyObservers();
end;

procedure TPAGAMENTOS.AssignedPagamentos(
  aFormasDePagamento: TLIST<TPEDIDOPAGAMENTO>);
begin
  TRttiUtil.ListDisposeOf<TPEDIDOPAGAMENTO>(FFormasDePagamento);
  FFormasDePagamento := aFormasDePagamento;
end;

procedure TPAGAMENTOS.Clear;
begin
  TRttiUtil.ListDisposeOf<TPEDIDOPAGAMENTO>(FFormasDePagamento);
  FFormasDePagamento := TLIST<TPEDIDOPAGAMENTO>.Create;
end;

function TPAGAMENTOS.ContemTipo(aTipo: TTipoPagto): boolean;
begin
  Result := false;
  for var item in Self.FFormasDePagamento do
  begin
    if (item.TipoPagamento = aTipo) then
    begin
      Result := true;
      Break;
    end;
  end;
end;

constructor TPAGAMENTOS.Create;
begin
  inherited;
  FFormasDePagamento := TLIST<TPEDIDOPAGAMENTO>.Create;
end;

destructor TPAGAMENTOS.Destroy;
begin
  TRttiUtil.ListDisposeOf<TPEDIDOPAGAMENTO>(FFormasDePagamento);
  FFormasDePagamento := nil;
  inherited;
end;

function TPAGAMENTOS.GetPagamento(seqPagto: integer): TPEDIDOPAGAMENTO;
begin
  for var item in Self.FFormasDePagamento do
  begin
    if (item.SEQ = seqPagto) then
    begin
      Result := item;
      Break;
    end;
  end;
end;

function TPAGAMENTOS.GetSubTotal: Double;
begin
  Result := ValorBaixa;
end;

function TPAGAMENTOS.getTroco: Currency;
begin
  try
    Result := ValorRecebido - ValorBaixa - ValorAcrescimo;

    if Result < 0 then
      Result := 0;
  except
    on e: Exception do
      raise Exception.Create('Erro no cálculo do troco: ' + e.message);
  end;
end;

function TPAGAMENTOS.getValorAcrescimo: Currency;
begin
  try
    Result := 0;

    if Assigned(FFormasDePagamento) then
    begin
      for var item in FFormasDePagamento do
      begin
        Result := Result + item.ACRESCIMO;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create('Erro no cálculo do valor recebido: ' + e.message);
  end;
end;

function TPAGAMENTOS.getValorBaixa: Currency;
begin
  try
    FValorBaixa := ValorOriginal - ValorDesc;
    Result := FValorBaixa;
  except
    on e: Exception do
      raise Exception.Create('Erro no cálculo do valor da baixa: ' + e.message);
  end;
end;

function TPAGAMENTOS.getValorRecebido: Currency;
begin
  try
    Result := 0;

    if Assigned(FFormasDePagamento) then
    begin
      for var item in FFormasDePagamento do
      begin
        Result := Result + item.Valor;
      end;
    end;
  except
    on e: Exception do
      raise Exception.Create('Erro no cálculo do valor recebido: ' + e.message);
  end;
end;

function TPAGAMENTOS.getValorRestante: Currency;
begin
  try
    Result := ValorBaixa - ValorRecebido + ValorAcrescimo;

    if Result < 0 then
      Result := 0;
  except
    on e: Exception do
      raise Exception.Create('Erro no cálculo do valor restante: ' + e.message);
  end;
end;

procedure TPAGAMENTOS.RemovePagamento(aPagamento: TPEDIDOPAGAMENTO);
begin
  for var pagto in Self.FFormasDePagamento do
  begin
    if (aPagamento.SEQ = pagto.SEQ) then
    begin
      FFormasDePagamento.Remove(pagto);
      Break;
    end;
  end;
  if Assigned(FOnEfetuaPagamento) then
    FOnEfetuaPagamento(ValorRecebido, ValorAcrescimo, ValorRestante, Troco);

  // NotifyObservers;
end;

function TPAGAMENTOS.NextSeqPagamento: integer;
begin
  Result := 0;

  for var pagto in Self.FFormasDePagamento do
  begin
    if (Result < pagto.SEQ) then
      Result := pagto.SEQ;
  end;
  Result := Result + 1;
end;

procedure TPAGAMENTOS.RemovePagamento(index: integer);
begin
  Self.RemovePagamento(FFormasDePagamento.Items[index]);
end;

procedure TPAGAMENTOS.SetFormasDePagamento(const Value: TLIST<TPEDIDOPAGAMENTO>);
begin
  FFormasDePagamento := Value;
end;

procedure TPAGAMENTOS.setValorBaixa(const Value: Currency);
begin
  if Value < 0 then
    raise Exception.Create('Valor Inválido da Baixa');

  FValorBaixa := Value;

  if Assigned(FOnCalculaParcela) then
    FOnCalculaParcela(ValorBaixa);
end;

procedure TPAGAMENTOS.SetValorDesc(const Value: Currency);
begin
  if Value < 0 then
    raise Exception.Create('Valor Inválido do desconto');

  FValorDesc := Value;

  if Assigned(FOnCalculaParcela) then
    FOnCalculaParcela(ValorBaixa);
end;

procedure TPAGAMENTOS.SetValorOriginal(const Value: Currency);
begin
  FValorOriginal := Value;
end;

end.
