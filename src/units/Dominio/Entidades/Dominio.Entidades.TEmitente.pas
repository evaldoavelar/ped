unit Dominio.Entidades.TEmitente;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('EMITENTE')]
  TEmitente = class(TEntity)
  private
    FRAZAO_SOCIAL: string;
    FFANTASIA: string;
    FRESPONSAVEL: string;
    FENDERECO: string;
    FCOMPLEMENTO: string;
    FNUM: string;
    FBAIRRO: string;
    FCIDADE: string;
    FUF: string;
    FCEP: string;
    FCNPJ: string;
    FIE: string;
    FIM: string;
    FTELEFONE: string;
    FFAX: string;
    FEMAIL: string;
    FDATAALTERACAO: TDateTime;

    function getBAIRRO: string;
    function getCEP: string;
    function getCIDADE: string;
    function getCNPJ: string;
    function getCOMPLEMENTO: string;
    function getEMAIL: string;
    function getENDERECO: string;
    function getFANTASIA: string;
    function getFAX: string;
    function getIE: string;
    function getIM: string;
    function getNUM: string;
    function getRAZAO_SOCIAL: string;
    function getRESPONSAVEL: string;
    function getTELEFONE: string;
    function getUF: string;
    procedure setBAIRRO(const Value: string);
    procedure setCEP(const Value: string);
    procedure setCIDADE(const Value: string);
    procedure setCNPJ(const Value: string);
    procedure setCOMPLEMENTO(const Value: string);
    procedure setEMAIL(const Value: string);
    procedure setENDERECO(const Value: string);
    procedure setFANTASIA(const Value: string);
    procedure setFAX(const Value: string);
    procedure setIE(const Value: string);
    procedure setIM(const Value: string);
    procedure setNUM(const Value: string);
    procedure setRAZAO_SOCIAL(const Value: string);
    procedure setRESPONSAVEL(const Value: string);
    procedure setTELEFONE(const Value: string);
    procedure setUF(const Value: string);
    procedure SetDATAALTERACAO(const Value: TDateTime);
  public
    [campo('RAZAO_SOCIAL', tpVARCHAR, 60)]
    property RAZAO_SOCIAL: string read getRAZAO_SOCIAL write setRAZAO_SOCIAL;

    [campo('FANTASIA', tpVARCHAR, 40)]
    property FANTASIA: string read getFANTASIA write setFANTASIA;

    [campo('RESPONSAVEL', tpVARCHAR, 40)]
    property RESPONSAVEL: string read getRESPONSAVEL write setRESPONSAVEL;

    [campo('ENDERECO', tpVARCHAR, 40)]
    property ENDERECO: string read getENDERECO write setENDERECO;

    [campo('COMPLEMENTO', tpVARCHAR, 40)]
    property COMPLEMENTO: string read getCOMPLEMENTO write setCOMPLEMENTO;

    [campo('NUM', tpVARCHAR, 5)]
    property NUM: string read getNUM write setNUM;

    [campo('BAIRRO', tpVARCHAR, 25)]
    property BAIRRO: string read getBAIRRO write setBAIRRO;

    [campo('CIDADE', tpVARCHAR, 35)]
    property CIDADE: string read getCIDADE write setCIDADE;

    [campo('UF', tpVARCHAR, 2)]
    property UF: string read getUF write setUF;

    [campo('CEP', tpVARCHAR,9)]
    property CEP: string read getCEP write setCEP;

    [campo('CNPJ', tpVARCHAR,18)]
    property CNPJ: string read getCNPJ write setCNPJ;

    [campo('IE', tpVARCHAR,20)]
    property IE: string read getIE write setIE;

    [campo('IM', tpVARCHAR,15)]
    property IM: string read getIM write setIM;

    [campo('TELEFONE', tpVARCHAR,18)]
    property TELEFONE: string read getTELEFONE write setTELEFONE;

    [campo('FAX', tpVARCHAR,16)]
    property FAX: string read getFAX write setFAX;

    [campo('EMAIL', tpVARCHAR,40)]
    property EMAIL: string read getEMAIL write setEMAIL;

    [campo('DATAALTERACAO', tpTIMESTAMP)]
    property DATAALTERACAO: TDateTime  read FDATAALTERACAO write SetDATAALTERACAO;

    constructor Create();
  end;

implementation

{ TEmitente }

constructor TEmitente.Create;
begin
  inherited;
  Self.InicializarPropriedades();
end;

function TEmitente.getBAIRRO: string;
begin
  result := FBAIRRO;
end;

function TEmitente.getCEP: string;
begin
  result := FCEP;
end;

function TEmitente.getCIDADE: string;
begin
  result := FCIDADE;
end;

function TEmitente.getCNPJ: string;
begin
  result := FCNPJ;
end;

function TEmitente.getCOMPLEMENTO: string;
begin
  result := FCOMPLEMENTO;
end;

function TEmitente.getEMAIL: string;
begin
  result := FEMAIL;
end;

function TEmitente.getENDERECO: string;
begin
  result := FENDERECO;
end;

function TEmitente.getFANTASIA: string;
begin
  result := FFANTASIA;
end;

function TEmitente.getFAX: string;
begin
  result := FFAX;
end;

function TEmitente.getIE: string;
begin
  result := FIE;
end;

function TEmitente.getIM: string;
begin
  result := FIM;
end;

function TEmitente.getNUM: string;
begin
  result := FNUM;
end;

function TEmitente.getRAZAO_SOCIAL: string;
begin
  result := FRAZAO_SOCIAL;
end;

function TEmitente.getRESPONSAVEL: string;
begin
  result := FRESPONSAVEL;
end;

function TEmitente.getTELEFONE: string;
begin
  result := FTELEFONE;
end;

function TEmitente.getUF: string;
begin
  result := FUF;
end;

procedure TEmitente.setBAIRRO(const Value: string);
begin
  if Value <> FBAIRRO then
  begin
    FBAIRRO := Value;
    Notify('BAIRRO');
  end;
end;

procedure TEmitente.setCEP(const Value: string);
begin
  if Value <> FCEP then
  begin
    FCEP := Value;
    Notify('CEP');
  end;
end;

procedure TEmitente.setCIDADE(const Value: string);
begin
  if Value <> FCIDADE then
  begin
    FCIDADE := Value;
    Notify('CIDADE');
  end;
end;

procedure TEmitente.setCNPJ(const Value: string);
begin
  if Value <> FCNPJ then
  begin
    FCNPJ := Value;
    Notify('CNPJ');
  end;
end;

procedure TEmitente.setCOMPLEMENTO(const Value: string);
begin
  if Value <> FCOMPLEMENTO then
  begin
    FCOMPLEMENTO := Value;
    Notify('COMPLEMENTO');
  end;
end;

procedure TEmitente.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TEmitente.setEMAIL(const Value: string);
begin
  if Value <> FEMAIL then
  begin
    FEMAIL := Value;
    Notify('EMAIL');
  end;
end;

procedure TEmitente.setENDERECO(const Value: string);
begin
  if Value <> FENDERECO then
  begin
    FENDERECO := Value;
    Notify('ENDERECO');
  end;
end;

procedure TEmitente.setFANTASIA(const Value: string);
begin
  if Value <> FFANTASIA then
  begin
    FFANTASIA := Value;
    Notify('FANTASIA');
  end;
end;

procedure TEmitente.setFAX(const Value: string);
begin
  if Value <> FFAX then
  begin
    FFAX := Value;
    Notify('FAX');
  end;
end;

procedure TEmitente.setIE(const Value: string);
begin
  if Value <> FIE then
  begin
    FIE := Value;
    Notify('IE');
  end;
end;

procedure TEmitente.setIM(const Value: string);
begin
  if Value <> FIM then
  begin
    FIM := Value;
    Notify('IM');
  end;
end;

procedure TEmitente.setNUM(const Value: string);
begin
  if Value <> FNUM then
  begin
    FNUM := Value;
    Notify('NUM');
  end;
end;

procedure TEmitente.setRAZAO_SOCIAL(const Value: string);
begin
  if Value <> FRAZAO_SOCIAL then
  begin
    FRAZAO_SOCIAL := Value;
    Notify('RAZAO_SOCIAL');
  end;
end;

procedure TEmitente.setRESPONSAVEL(const Value: string);
begin
  if Value <> FRESPONSAVEL then
  begin
    FRESPONSAVEL := Value;
    Notify('RESPONSAVEL');
  end;
end;

procedure TEmitente.setTELEFONE(const Value: string);
begin
  if Value <> FTELEFONE then
  begin
    FTELEFONE := Value;
    Notify('TELEFONE');
  end;
end;

procedure TEmitente.setUF(const Value: string);
begin
  if Value <> FUF then
  begin
    FUF := Value;
    Notify('UF');
  end;
end;

end.
