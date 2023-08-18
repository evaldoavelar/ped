unit Dominio.Entidades.Pedido.Pagamentos.Pagamento;

interface


uses
  Dominio.Entidades.TEntity,
  Dominio.Mapeamento.Atributos, Dominio.Entidades.TParcelas,
  Dominio.Mapeamento.Tipos, System.Generics.Collections, Dominio.Entidades.TFormaPagto.Tipo;

type

  [Tabela('PEDIDOPAGAMENTO')]
  TPEDIDOPAGAMENTO = class(TEntity)
  private
    FACRESCIMO: Currency;
    FVALOR: Currency;
    FDESCRICAO: string;
    FSEQ: integer;
    FCONDICAO: string;
    FIDPEDIDO: integer;
    FTipo: integer;
    FIDPAGTO: integer;
    Fparcelas: TObjectList<TParcelas>;
    FIDCONDICAO: integer;
    FQUANTASVEZES: integer;
    FTROCO: Currency;
    procedure SetACRESCIMO(const Value: Currency);
    procedure SetCONDICAO(const Value: string);
    procedure SetDESCRICAO(const Value: string);
    procedure SetSEQ(const Value: integer);
    procedure SetIDPAGTO(const Value: integer);
    procedure SetIDPEDIDO(const Value: integer);
    procedure SetTipo(const Value: integer);
    procedure SetVALOR(const Value: Currency);
    procedure Setparcelas(const Value: TObjectList<TParcelas>);
    function getTipoPagamento: TTipoPagto;
    function getTIPOPROXY: string;
    procedure SetTipoPagamento(const Value: TTipoPagto);
    procedure SetIDCONDICAO(const Value: integer);
    procedure SetQUANTASVEZES(const Value: integer);
    procedure SetTROCO(const Value: Currency);
  public
    procedure ParcelarPedido(aCodigoCliente: string; NumParcelas: integer;
      VencimentoPrimeiraParcela: TDate);
    function RetornaVencimentoParcela(data: TDate; dias: integer): TDate;
  public
    [AutoInc('AUTOINC')]
    [PrimaryKey('PKPEDIDOPAGAMENTOS', 'SEQ,IDPEDIDO')]
    [campo('SEQ', tpINTEGER, 0, 0, True)]
    property SEQ: integer read FSEQ write SetSEQ;
    [campo('IDPEDIDO', tpINTEGER, 0, 0, True)]
    property IDPEDIDO: integer read FIDPEDIDO write SetIDPEDIDO;
    [campo('DESCRICAO', tpVARCHAR, 200)]
    property DESCRICAO: string read FDESCRICAO write SetDESCRICAO;
    [campo('CONDICAO', tpVARCHAR, 60, 0, True)]
    property CONDICAO: string read FCONDICAO write SetCONDICAO;
    [campo('IDCONDICAO', tpINTEGER, 0, 0, True)]
    property IDCONDICAO: integer read FIDCONDICAO write SetIDCONDICAO;
    [IGNORE(true)]
    [campo('TIPO', tpINTEGER, 0, 0, True)]
    property TIPOPROXY: string read getTIPOPROXY;
    property TipoPagamento: TTipoPagto read getTipoPagamento write SetTipoPagamento;
    property Tipo: integer read FTipo write SetTipo;
    [campo('IDPAGTO', tpINTEGER, 0, 0, True)]
    property IDPAGTO: integer read FIDPAGTO write SetIDPAGTO;
    [campo('ACRESCIMO', tpNUMERIC, 15, 4, True, '0')]
    property ACRESCIMO: Currency read FACRESCIMO write SetACRESCIMO;
    [campo('VALOR', tpNUMERIC, 15, 4, True, '0')]
    property Valor: Currency read FVALOR write SetVALOR;
    [campo('TROCO', tpNUMERIC, 15, 4, True, '0')]
    property TROCO: Currency read FTROCO write SetTROCO;
    [campo('QUANTASVEZES', tpINTEGER)]
    property QUANTASVEZES: integer read FQUANTASVEZES write SetQUANTASVEZES;

    property Parcelas: TObjectList<TParcelas> read Fparcelas write Setparcelas;

    procedure AssignParcelas(aParcelas: TObjectList<TParcelas>);

    constructor create;
    destructor destroy; override;
  end;

implementation

uses
  System.SysUtils, Util.Funcoes, Util.Exceptions;

{ TPEDIDOPAGAMENTO }

procedure TPEDIDOPAGAMENTO.ParcelarPedido(aCodigoCliente: string; NumParcelas: integer; VencimentoPrimeiraParcela: TDate);
var
  ValorParcelas: Currency;
  SomaParcelas: Currency;
  SomaPedido: Currency;
  i: integer;
  vencimento: TDate;
begin
  Self.Parcelas.Clear;
  SomaPedido := Self.FVALOR;
  ValorParcelas := SomaPedido / NumParcelas;
  ValorParcelas := TUtil.Truncar(ValorParcelas, 2);

  try
    Self.Parcelas.Clear;
    SomaParcelas := 0;
    for i := 1 to NumParcelas do
    begin
      SomaParcelas := SomaParcelas + ValorParcelas;
      // se for ultima parcela
      if i = NumParcelas then
      begin
        // se o somatório das parcelas é menor que o valor do pedido
        if SomaParcelas < SomaPedido then
        begin
          // a ultima parcela recebe a diferença
          ValorParcelas := ValorParcelas + SomaPedido - SomaParcelas;
        end;
      end;

      Self.Parcelas.Add(
        TParcelas.CreateParcela(
        i,
        Self.IDPEDIDO,
        Self.SEQ,
        ValorParcelas,
        RetornaVencimentoParcela(VencimentoPrimeiraParcela, i - 1), // calcular a data de vencimento
        aCodigoCliente
        ));
    end;

  except
    on E: Exception do
    begin
      raise TCalculoException.create('Erro no calculo de parcelas: ' + E.Message);
    end;
  end;

  // if Assigned(FOnParcela) then
  // FOnParcela(Self.parcelas);
end;

function TPEDIDOPAGAMENTO.RetornaVencimentoParcela(data: TDate; dias: integer): TDate;
var
  dataParcela: TDate;
begin
  // data := EncodeDate( YearOf(data),MonthOf(data),diaVencimento ) ;

  dataParcela := data;

  result := IncMonth(dataParcela, dias);

  if DayOfWeek(result) = 7 then
    result := result + 2
  else if DayOfWeek(result) = 1 then
    result := result + 1;
end;

procedure TPEDIDOPAGAMENTO.AssignParcelas(aParcelas: TObjectList<TParcelas>);
begin
  Self.Fparcelas.OwnsObjects := True;
  Self.Fparcelas.Clear;
  FreeAndNil(Self.Fparcelas);
  Self.Fparcelas := aParcelas;
end;

constructor TPEDIDOPAGAMENTO.create;
begin
  inherited;
  Self.Fparcelas := TObjectList<TParcelas>.create;
  Self.Fparcelas.OwnsObjects := True;
end;

destructor TPEDIDOPAGAMENTO.destroy;
begin
  Self.Fparcelas.OwnsObjects := True;
  Self.Fparcelas.Clear;
  FreeAndNil(Self.Fparcelas);
  inherited;
end;

function TPEDIDOPAGAMENTO.getTipoPagamento: TTipoPagto;
begin
  result := TTipoPagto(FTipo);
end;

function TPEDIDOPAGAMENTO.getTIPOPROXY: string;
begin
  result := TipoPagamento.DESCRICAO;
end;

procedure TPEDIDOPAGAMENTO.SetACRESCIMO(const Value: Currency);
begin
  FACRESCIMO := Value;
end;

procedure TPEDIDOPAGAMENTO.SetCONDICAO(const Value: string);
begin
  FCONDICAO := Value;
end;

procedure TPEDIDOPAGAMENTO.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TPEDIDOPAGAMENTO.SetSEQ(const Value: integer);
begin
  FSEQ := Value;
end;

procedure TPEDIDOPAGAMENTO.SetIDCONDICAO(const Value: integer);
begin
  FIDCONDICAO := Value;
end;

procedure TPEDIDOPAGAMENTO.SetIDPAGTO(const Value: integer);
begin
  FIDPAGTO := Value;
end;

procedure TPEDIDOPAGAMENTO.SetIDPEDIDO(const Value: integer);
begin
  FIDPEDIDO := Value;
end;

procedure TPEDIDOPAGAMENTO.Setparcelas(const Value: TObjectList<TParcelas>);
begin
  Fparcelas := Value;
end;

procedure TPEDIDOPAGAMENTO.SetQUANTASVEZES(const Value: integer);
begin
  FQUANTASVEZES := Value;
end;

procedure TPEDIDOPAGAMENTO.SetTipo(const Value: integer);
begin
  FTipo := Value;
end;

procedure TPEDIDOPAGAMENTO.SetTipoPagamento(const Value: TTipoPagto);
begin
  FTipo := Ord(Value);
end;

procedure TPEDIDOPAGAMENTO.SetTROCO(const Value: Currency);
begin
  FTROCO := Value;
end;

procedure TPEDIDOPAGAMENTO.SetVALOR(const Value: Currency);
begin
  FVALOR := Value;
end;

end.
