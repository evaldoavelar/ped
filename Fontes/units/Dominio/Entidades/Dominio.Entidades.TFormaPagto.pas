unit Dominio.Entidades.TFormaPagto;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('FORMAPAGTO')]
  TFormaPagto = class(TEntity)
  private
    FID: integer;
    FDESCRICAO: string;
    FQUANTASVEZES: integer;
    FJUROS: Currency;
    function getID: integer;
    procedure setID(const Value: integer);
    function getDESCRICAO: string;
    procedure setDESCRICAO(const Value: string);
    function getQUANTASVEZES: integer;
    procedure setQUANTASVEZES(const Value: integer);
    function getJUROS: Currency;
    procedure setJUROS(const Value: Currency);
  public

    [campo('ID', tpINTEGER, 0, 0, True)]
    [PrimaryKey('PK_FORMAPAGTO', 'ID')]
    property ID: integer read getID write setID;

    [campo('DESCRICAO', tpVARCHAR, 200)]
    property DESCRICAO: string read getDESCRICAO write setDESCRICAO;

    [campo('QUANTASVEZES', tpINTEGER, 0, 0, True)]
    property QUANTASVEZES: integer read getQUANTASVEZES write setQUANTASVEZES;

    [campo('JUROS', tpNUMERIC, 15, 4)]
    property JUROS: Currency read getJUROS write setJUROS;

    constructor create;
  end;

implementation

{ TFormaPagto }

constructor TFormaPagto.create;
begin
  inherited;
  Self.InicializarPropriedades(nil);
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

end.
