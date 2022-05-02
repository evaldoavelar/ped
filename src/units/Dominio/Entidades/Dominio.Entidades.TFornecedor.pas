unit Dominio.Entidades.TFornecedor;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('FORNECEDOR')]
  TFornecedor = class(TEntity)
  private
    FCODIGO: string;
    FNOME: string;
    FFANTASIA: string;
    FCONTATO: string;
    FCNPJ_CNPF: string;
    FIE_RG: string;
    FIM: string;
    FENDERECO: string;
    FNUMERO: string;
    FCOMPLEMENTO: string;
    FBAIRRO: string;
    FCIDADE: string;
    FUF: string;
    FCEP: string;
    FTELEFONE: string;
    FCELULAR: string;
    FFAX: string;
    FPAIS_BACEN: string;
    FPAIS_NOME: string;
    FSITUACAO: string;
    FEMAIL: string;
    FOBSERVACOES: string;

    function getCODIGO: string;
    procedure setCODIGO(const Value: string);
    function getBAIRRO: string;
    function getCELULAR: string;
    function getCEP: string;
    function getCIDADE: string;
    function getCNPJ_CNPF: string;
    function getCONTATO: string;
    function getEMAIL: string;
    function getENDERECO: string;
    function getFANTASIA: string;
    function getFAX: string;
    function getIE_RG: string;
    function getIM: string;
    function getNOME: string;
    function getNUMERO: string;
    function getOBSERVACOES: string;
    function getPAIS_BACEN: string;
    function getPAIS_NOME: string;
    function getSITUACAO: string;
    function getTELEFONE: string;
    function getUF: string;
    procedure setBAIRRO(const Value: string);
    procedure setCELULAR(const Value: string);
    procedure setCEP(const Value: string);
    procedure setCIDADE(const Value: string);
    procedure setCNPJ_CNPF(const Value: string);
    procedure setCOMPLEMENTO(const Value: string);
    procedure setCONTATO(const Value: string);
    procedure setEMAIL(const Value: string);
    procedure setENDERECO(const Value: string);
    procedure setFANTASIA(const Value: string);
    procedure setFAX(const Value: string);
    procedure setIE_RG(const Value: string);
    procedure setIM(const Value: string);
    procedure setNOME(const Value: string);
    procedure setNUMERO(const Value: string);
    procedure setOBSERVACOES(const Value: string);
    procedure setPAIS_BACEN(const Value: string);
    procedure setPAIS_NOME(const Value: string);
    procedure setSITUACAO(const Value: string);
    procedure setTELEFONE(const Value: string);
    procedure setUF(const Value: string);
    function getCOMPLEMENTO: string;
  published
    [campo('CODIGO  ', tpVARCHAR, 10, 0, True)]
    [PrimaryKey('FOR_PRIMARY', 'CODIGO')]
    property CODIGO: string read getCODIGO write setCODIGO;

    [campo('NOME', tpVARCHAR, 60)]
    property NOME: string read getNOME write setNOME;

    [campo('FANTASIA', tpVARCHAR, 40)]
    property FANTASIA: string read getFANTASIA write setFANTASIA;

    [campo('CONTATO', tpVARCHAR, 40)]
    property CONTATO: string read getCONTATO write setCONTATO;

    [campo('CNPJ_CNPF', tpVARCHAR, 18)]
    property CNPJ_CNPF: string read getCNPJ_CNPF write setCNPJ_CNPF;

    [campo('IE_RG', tpVARCHAR, 20)]
    property IE_RG: string read getIE_RG write setIE_RG;

    [campo('IM', tpVARCHAR, 16)]
    property IM: string read getIM write setIM;

    [campo('ENDERECO', tpVARCHAR, 60)]
    property ENDERECO: string read getENDERECO write setENDERECO;

    [campo('NUMERO', tpVARCHAR, 10)]
    property NUMERO: string read getNUMERO write setNUMERO;

    [campo('COMPLEMENTO', tpVARCHAR, 40)]
    property COMPLEMENTO: string read getCOMPLEMENTO write setCOMPLEMENTO;

    [campo('BAIRRO', tpVARCHAR, 30)]
    property BAIRRO: string read getBAIRRO write setBAIRRO;

    [campo('CIDADE', tpVARCHAR, 35)]
    property CIDADE: string read getCIDADE write setCIDADE;

    [campo('UF', tpVARCHAR, 2)]
    property UF: string read getUF write setUF;

    [campo('CEP', tpVARCHAR, 9)]
    property CEP: string read getCEP write setCEP;

    [campo('TELEFONE', tpVARCHAR, 16)]
    property TELEFONE: string read getTELEFONE write setTELEFONE;

    [campo('CELULAR', tpVARCHAR, 21)]
    property CELULAR: string read getCELULAR write setCELULAR;

    [campo('FAX', tpVARCHAR, 16)]
    property FAX: string read getFAX write setFAX;

    [campo('PAIS_BACEN', tpVARCHAR, 4)]
    property PAIS_BACEN: string read getPAIS_BACEN write setPAIS_BACEN;

    [campo('PAIS_NOME', tpVARCHAR, 30)]
    property PAIS_NOME: string read getPAIS_NOME write setPAIS_NOME;

    [campo('SITUACAO', tpVARCHAR, 7)]
    property SITUACAO: string read getSITUACAO write setSITUACAO;

    [campo('EMAIL', tpVARCHAR, 60)]
    property EMAIL: string read getEMAIL write setEMAIL;

    [campo('OBSERVACOES', tpBLOB, 80)]
    property OBSERVACOES: string read getOBSERVACOES write setOBSERVACOES;
  public
    constructor create();
    destructor Destroy; override;

  end;

implementation

{ TFornecedor }

function TFornecedor.getCOMPLEMENTO: string;
begin
  result := FCOMPLEMENTO;
end;

constructor TFornecedor.create;
begin
  inherited;
  Self.InicializarPropriedades(nil);
end;

destructor TFornecedor.Destroy;
begin
  //
  inherited;
end;

function TFornecedor.getBAIRRO: string;
begin
  result := FBAIRRO;
end;

function TFornecedor.getCELULAR: string;
begin
  result := FCELULAR;
end;

function TFornecedor.getCEP: string;
begin
  result := FCEP;
end;

function TFornecedor.getCIDADE: string;
begin
  result := FCIDADE;
end;

function TFornecedor.getCNPJ_CNPF: string;
begin
  result := FCNPJ_CNPF;
end;

function TFornecedor.getCODIGO: string;
begin
  result := FCODIGO;
end;

function TFornecedor.getCONTATO: string;
begin
  result := FCONTATO;
end;

function TFornecedor.getEMAIL: string;
begin
  result := FEMAIL;
end;

function TFornecedor.getENDERECO: string;
begin
  result := FENDERECO;
end;

function TFornecedor.getFANTASIA: string;
begin
  result := FFANTASIA;
end;

function TFornecedor.getFAX: string;
begin
  result := FFAX;
end;

function TFornecedor.getIE_RG: string;
begin
  result := FIE_RG;
end;

function TFornecedor.getIM: string;
begin
  result := FIM;
end;

function TFornecedor.getNOME: string;
begin
  result := FNOME;
end;

function TFornecedor.getNUMERO: string;
begin
  result := FNUMERO;
end;

function TFornecedor.getOBSERVACOES: string;
begin
  result := FOBSERVACOES;
end;

function TFornecedor.getPAIS_BACEN: string;
begin
  result := FPAIS_BACEN;
end;

function TFornecedor.getPAIS_NOME: string;
begin
  result := FPAIS_NOME;
end;

function TFornecedor.getSITUACAO: string;
begin
  result := FSITUACAO;
end;

function TFornecedor.getTELEFONE: string;
begin
  result := FTELEFONE;
end;

function TFornecedor.getUF: string;
begin
  result := FUF;
end;

procedure TFornecedor.setBAIRRO(const Value: string);
begin
  if Value <> FBAIRRO then
  begin
    FBAIRRO := Value;
    Notify('BAIRRO');
  end;
end;

procedure TFornecedor.setCELULAR(const Value: string);
begin
  if Value <> FCELULAR then
  begin
    FCELULAR := Value;
    Notify('CELULAR');
  end;
end;

procedure TFornecedor.setCEP(const Value: string);
begin
  if Value <> FCEP then
  begin
    FCEP := Value;
    Notify('CEP');
  end;
end;

procedure TFornecedor.setCIDADE(const Value: string);
begin
  if Value <> FCIDADE then
  begin
    FCIDADE := Value;
    Notify('CIDADE');
  end;
end;

procedure TFornecedor.setCNPJ_CNPF(const Value: string);
begin
  if Value <> FCNPJ_CNPF then
  begin
    FCNPJ_CNPF := Value;
    Notify('CNPJ_CNPF');
  end;
end;

procedure TFornecedor.setCODIGO(const Value: string);
begin
  if Value <> FCODIGO then
  begin
    FCODIGO := Value;
    Notify('CODIGO');
  end;
end;

procedure TFornecedor.setCOMPLEMENTO(const Value: string);
begin
  if Value <> FCOMPLEMENTO then
  begin
    FCOMPLEMENTO := Value;
    Notify('COMPLEMENTO');
  end;
end;

procedure TFornecedor.setCONTATO(const Value: string);
begin
  if Value <> FCONTATO then
  begin
    FCONTATO := Value;
    Notify('CONTATO');
  end;
end;

procedure TFornecedor.setEMAIL(const Value: string);
begin
  if Value <> FEMAIL then
  begin
    FEMAIL := Value;
    Notify('EMAIL');
  end;
end;

procedure TFornecedor.setENDERECO(const Value: string);
begin
  if Value <> FENDERECO then
  begin
    FENDERECO := Value;
    Notify('ENDERECO');
  end;
end;

procedure TFornecedor.setFANTASIA(const Value: string);
begin
  if Value <> FFANTASIA then
  begin
    FFANTASIA := Value;
    Notify('FANTASIA');
  end;
end;

procedure TFornecedor.setFAX(const Value: string);
begin
  if Value <> FFAX then
  begin
    FFAX := Value;
    Notify('FAX');
  end;
end;

procedure TFornecedor.setIE_RG(const Value: string);
begin
  if Value <> FIE_RG then
  begin
    FIE_RG := Value;
    Notify('IE_RG');
  end;
end;

procedure TFornecedor.setIM(const Value: string);
begin
  if Value <> FIM then
  begin
    FIM := Value;
    Notify('IM');
  end;
end;

procedure TFornecedor.setNOME(const Value: string);
begin
  if Value <> FNOME then
  begin
    FNOME := Value;
    Notify('NOME');
  end;
end;

procedure TFornecedor.setNUMERO(const Value: string);
begin
  if Value <> FNUMERO then
  begin
    FNUMERO := Value;
    Notify('NUMERO');
  end;
end;

procedure TFornecedor.setOBSERVACOES(const Value: string);
begin
  if Value <> FOBSERVACOES then
  begin
    FOBSERVACOES := Value;
    Notify('OBSERVACOES');
  end;
end;

procedure TFornecedor.setPAIS_BACEN(const Value: string);
begin
  if Value <> FPAIS_BACEN then
  begin
    FPAIS_BACEN := Value;
    Notify('PAIS_BACEN');
  end;
end;

procedure TFornecedor.setPAIS_NOME(const Value: string);
begin
  if Value <> FPAIS_NOME then
  begin
    FPAIS_NOME := Value;
    Notify('PAIS_NOME');
  end;
end;

procedure TFornecedor.setSITUACAO(const Value: string);
begin
  if Value <> FSITUACAO then
  begin
    FSITUACAO := Value;
    Notify('SITUACAO');
  end;
end;

procedure TFornecedor.setTELEFONE(const Value: string);
begin
  if Value <> FTELEFONE then
  begin
    FTELEFONE := Value;
    Notify('TELEFONE');
  end;
end;

procedure TFornecedor.setUF(const Value: string);
begin
  if Value <> FUF then
  begin
    FUF := Value;
    Notify('UF');
  end;
end;

end.
