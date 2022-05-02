unit Dominio.Entidades.TFormaPagto;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Dominio.Entidades.TFormaPagto.Tipo, System.Classes,
  System.Generics.Collections, Dominio.Entidades.CondicaoPagto;

type

  [Tabela('FORMAPAGTO')]
  TFormaPagto = class(TEntity)
  private
    FID: integer;
    FDESCRICAO: string;
    FQUANTASVEZES: integer;
    FJUROS: Currency;
    FTipoPagamento: TTipoPagto;
    FTipo: integer;
    FATIVO: Boolean;
    FCONDICAODEPAGTO: tLIST<TCONDICAODEPAGTO>;
    FATIVOPROXY: string;
    function getID: integer;
    procedure setID(const Value: integer);
    function getDESCRICAO: string;
    procedure setDESCRICAO(const Value: string);
    function getQUANTASVEZES: integer;
    procedure setQUANTASVEZES(const Value: integer);
    function getJUROS: Currency;
    procedure setJUROS(const Value: Currency);
    function getTIPOPROXY: string;
    procedure SetTipo(const Value: integer);
    procedure SetTipoPagamento(const Value: TTipoPagto);
    function getTipoPagamento: TTipoPagto;
    procedure SetATIVO(const Value: Boolean);
    procedure SetATIVOPROXY(const Value: string);
    procedure SetCONDICAODEPAGTO(const Value: tLIST<TCONDICAODEPAGTO>);
  public
    function AddCondicao: TCONDICAODEPAGTO;
  public

    [campo('ID', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_FORMAPAGTO', 'ID')]
    property ID: integer read getID write setID;

    [campo('DESCRICAO', tpVARCHAR, 200)]
    property DESCRICAO: string read getDESCRICAO write setDESCRICAO;

    [campo('TIPO', tpINTEGER, 0, 0, True)]
    property Tipo: integer read FTipo write SetTipo;
    property TIPOPROXY: string read getTIPOPROXY;
    property TipoPagamento: TTipoPagto read getTipoPagamento write SetTipoPagamento;

    [campo('ATIVO', tpINTEGER, 0, 0, True, '1')]
    property ATIVO: Boolean read FATIVO write SetATIVO;
    property ATIVOPROXY: string read FATIVOPROXY write SetATIVOPROXY;

    property CONDICAODEPAGTO: tLIST<TCONDICAODEPAGTO> read FCONDICAODEPAGTO write SetCONDICAODEPAGTO;

    [campo('QUANTASVEZES', tpINTEGER, 0, 0, True, '1')]
    property QUANTASVEZES: integer read FQUANTASVEZES write SetQUANTASVEZES;

    constructor create;
    destructor destroy; override;
  end;

implementation

uses
  Utils.Rtti;

{ TFormaPagto }

constructor TFormaPagto.create;
begin
  inherited;
  Self.InicializarPropriedades(nil);
  FCONDICAODEPAGTO := tLIST<TCONDICAODEPAGTO>.create;
  FTipo := Ord(TTipoPagto.Nenhum);
  self.ATIVO := true;
  self.FQUANTASVEZES := 1;

end;

destructor TFormaPagto.destroy;
begin
  TRttiUtil.ListDisposeOf<TCONDICAODEPAGTO>(FCONDICAODEPAGTO);
  inherited;
end;

function TFormaPagto.AddCondicao: TCONDICAODEPAGTO;
begin
  result := TCONDICAODEPAGTO.create;
  result.StatusBD := TCONDICAODEPAGTO.TStatusBD.stAdicionado;
  result.IDPAGTO := Self.ID;
  result.QUANTASVEZES := 1;
  result.ACRESCIMO := 0;

  FCONDICAODEPAGTO.Add(result);
end;

function TFormaPagto.getDESCRICAO: string;
begin
  result := FDESCRICAO;
end;

function TFormaPagto.getID: integer;
begin
  result := FID;
end;

function TFormaPagto.getJUROS: Currency;
begin
  result := FJUROS;
end;

function TFormaPagto.getQUANTASVEZES: integer;
begin
  result := FQUANTASVEZES;
end;

function TFormaPagto.getTipoPagamento: TTipoPagto;
begin
  result := TTipoPagto(FTipo);
end;

function TFormaPagto.getTIPOPROXY: string;
begin
  result := TipoPagamento.DESCRICAO;
end;

procedure TFormaPagto.SetATIVO(const Value: Boolean);
begin
  FATIVO := Value;
end;

procedure TFormaPagto.SetATIVOPROXY(const Value: string);
begin
  FATIVOPROXY := Value;
end;

procedure TFormaPagto.SetCONDICAODEPAGTO(const Value: tLIST<TCONDICAODEPAGTO>);
begin
  FCONDICAODEPAGTO := Value;
end;

procedure TFormaPagto.setDESCRICAO(const Value: string);
begin
  if Value <> FDESCRICAO then
  begin
    FDESCRICAO := Value;
    Notify('DESCRICAO');
  end;
end;

procedure TFormaPagto.setID(const Value: integer);
begin
  if Value <> FID then
  begin
    FID := Value;
    Notify('ID');
  end;
end;

procedure TFormaPagto.setJUROS(const Value: Currency);
begin
  if Value <> FJUROS then
  begin
    FJUROS := Value;
    Notify('JUROS');
  end;
end;

procedure TFormaPagto.setQUANTASVEZES(const Value: integer);
begin
  if Value <> FQUANTASVEZES then
  begin
    FQUANTASVEZES := Value;
    Notify('QUANTASVEZES');
  end;
end;

procedure TFormaPagto.SetTipo(const Value: integer);
begin
  FTipo := Value;
end;

procedure TFormaPagto.SetTipoPagamento(const Value: TTipoPagto);
begin
  FTipoPagamento := Value;
  FTipo := Ord(Value);
end;

end.
