unit Dominio.Entidades.TCliente;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('CLIENTE')]
  TCliente = class(TEntity)
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
    FCOB_ENDERECO: string;
    FCOB_NUMERO: string;
    FCOB_COMPLEMENTO: string;
    FCOB_BAIRRO: string;
    FCOB_CIDADE: string;
    FCOB_UF: string;
    FCOB_CEP: string;
    FTELEFONE: string;
    FCELULAR: string;
    FFAX: string;
    FEMAIL: string;
    FRENDA: currency;
    FCADASTRO: TDateTime;
    FULTIMA_VENDA: TDateTime;
    FOBSERVACOES: string;
    FNASCIMENTO: TDate;
    FEST_CIVIL: string;
    FPAI: string;
    FMAE: string;
    FNATURALIDADE: string;
    FLOCTRA: string;
    FLOCAL: string;
    FPROFISSAO: string;
    FCONJUGE: string;
    FBLOQUEADO: boolean;

    procedure setCODIGO(value: string);
    procedure setNOME(value: string);
    procedure setFANTASIA(value: string);
    procedure setCONTATO(value: string);
    procedure setCNPJ_CNPF(value: string);
    procedure setIE_RG(value: string);
    procedure setIM(value: string);
    procedure setENDERECO(value: string);
    procedure setNUMERO(value: string);
    procedure setCOMPLEMENTO(value: string);
    procedure setBAIRRO(value: string);
    procedure setCIDADE(value: string);
    procedure setUF(value: string);
    procedure setCEP(value: string);
    procedure setCOB_ENDERECO(value: string);
    procedure setCOB_NUMERO(value: string);
    procedure setCOB_COMPLEMENTO(value: string);
    procedure setCOB_BAIRRO(value: string);
    procedure setCOB_CIDADE(value: string);
    procedure setCOB_UF(value: string);
    procedure setCOB_CEP(value: string);
    procedure setTELEFONE(value: string);
    procedure setCELULAR(value: string);
    procedure setFAX(value: string);
    procedure setEMAIL(value: string);
    procedure setRENDA(value: currency);
    procedure setCADASTRO(value: TDateTime);
    procedure setULTIMA_VENDA(value: TDateTime);
    procedure setOBSERVACOES(value: string);
    procedure setNASCIMENTO(value: TDate);
    procedure setEST_CIVIL(value: string);
    procedure setPAI(value: string);
    procedure setMAE(value: string);
    procedure setNATURALIDADE(value: string);
    procedure setLOCTRA(value: string);
    procedure setLOCAL(value: string);
    procedure setPROFISSAO(value: string);
    procedure setCONJUGE(value: string);

    function getCODIGO: string;
    function getNOME: string;
    function getFANTASIA: string;
    function getCONTATO: string;
    function getCNPJ_CNPF: string;
    function getIE_RG: string;
    function getIM: string;
    function getENDERECO: string;
    function getNUMERO: string;
    function getCOMPLEMENTO: string;
    function getBAIRRO: string;
    function getCIDADE: string;
    function getUF: string;
    function getCEP: string;
    function getCOB_ENDERECO: string;
    function getCOB_NUMERO: string;
    function getCOB_COMPLEMENTO: string;
    function getCOB_BAIRRO: string;
    function getCOB_CIDADE: string;
    function getCOB_UF: string;
    function getCOB_CEP: string;
    function getTELEFONE: string;
    function getCELULAR: string;
    function getFAX: string;
    function getEMAIL: string;
    function getRENDA: currency;
    function getCADASTRO: TDateTime;
    function getULTIMA_VENDA: TDateTime;
    function getOBSERVACOES: string;
    function getNASCIMENTO: TDate;
    function getEST_CIVIL: string;
    function getPAI: string;
    function getMAE: string;
    function getNATURALIDADE: string;
    function getLOCTRA: string;
    function getLOCAL: string;
    function getPROFISSAO: string;
    function getCONJUGE: string;

  published

    [campo('CODIGO', tpVARCHAR, 10, 0, True)]
    [PrimaryKey('CLI_PRIMARY', 'CODIGO')]
    property CODIGO: string read getCODIGO write setCODIGO;

    [campo('NOME', tpVARCHAR, 60)]
    property Nome: string read getNOME write setNOME;

    [campo('FANTASIA', tpVARCHAR, 30)]
    property FANTASIA: string read getFANTASIA write setFANTASIA;

    [campo('CONTATO', tpVARCHAR, 40)]
    property CONTATO: string read getCONTATO write setCONTATO;

    [campo('CNPJ_CNPF', tpVARCHAR, 18)]
    property CNPJ_CNPF: string read getCNPJ_CNPF write setCNPJ_CNPF;

    [campo('IE_RG', tpVARCHAR, 20)]
    property IE_RG: string read getIE_RG write setIE_RG;

    [campo('IM', tpVARCHAR, 20)]
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

    [campo('COB_ENDERECO', tpVARCHAR, 40)]
    property COB_ENDERECO: string read getCOB_ENDERECO write setCOB_ENDERECO;

    [campo('COB_NUMERO', tpVARCHAR, 10)]
    property COB_NUMERO: string read getCOB_NUMERO write setCOB_NUMERO;

    [campo('COB_COMPLEMENTO', tpVARCHAR, 40)]
    property COB_COMPLEMENTO: string read getCOB_COMPLEMENTO write setCOB_COMPLEMENTO;

    [campo('COB_BAIRRO', tpVARCHAR, 30)]
    property COB_BAIRRO: string read getCOB_BAIRRO write setCOB_BAIRRO;

    [campo('COB_CIDADE', tpVARCHAR, 35)]
    property COB_CIDADE: string read getCOB_CIDADE write setCOB_CIDADE;

    [campo('COB_UF', tpVARCHAR, 2)]
    property COB_UF: string read getCOB_UF write setCOB_UF;

    [campo('COB_CEP', tpVARCHAR, 9)]
    property COB_CEP: string read getCOB_CEP write setCOB_CEP;

    [campo('TELEFONE', tpVARCHAR, 16)]
    property TELEFONE: string read getTELEFONE write setTELEFONE;

    [campo('CELULAR', tpVARCHAR, 17)]
    property CELULAR: string read getCELULAR write setCELULAR;

    [campo('FAX', tpVARCHAR, 16)]
    property FAX: string read getFAX write setFAX;

    [campo('EMAIL', tpVARCHAR, 60)]
    property EMAIL: string read getEMAIL write setEMAIL;

    [campo('RENDA', tpNUMERIC, 15, 4)]
    property RENDA: currency read getRENDA write setRENDA;

    [campo('CADASTRO', tpDATE)]
    property CADASTRO: TDateTime read getCADASTRO write setCADASTRO;

    [campo('ULTIMA_VENDA', tpDATE)]
    property ULTIMA_VENDA: TDateTime read getULTIMA_VENDA write setULTIMA_VENDA;

    [campo('OBSERVACOES', tpVARCHAR, 1000)]
    property OBSERVACOES: string read getOBSERVACOES write setOBSERVACOES;

    [campo('NASCIMENTO', tpDATE)]
    property NASCIMENTO: TDate read getNASCIMENTO write setNASCIMENTO;

    [campo('EST_CIVIL', tpVARCHAR, 13)]
    property EST_CIVIL: string read getEST_CIVIL write setEST_CIVIL;

    [campo('PAI', tpVARCHAR, 40)]
    property PAI: string read getPAI write setPAI;

    [campo('MAE', tpVARCHAR, 40)]
    property MAE: string read getMAE write setMAE;

    [campo('NATURALIDADE', tpVARCHAR, 30)]
    property NATURALIDADE: string read getNATURALIDADE write setNATURALIDADE;

    [campo('LOCTRA', tpVARCHAR, 40)]
    property LOCTRA: string read getLOCTRA write setLOCTRA;

    [campo('LOCAL', tpVARCHAR, 15)]
    property LOCAL: string read getLOCAL write setLOCAL;

    [campo('PROFISSAO', tpVARCHAR, 30)]
    property PROFISSAO: string read getPROFISSAO write setPROFISSAO;

    [campo('CONJUGE', tpVARCHAR, 40)]
    property CONJUGE: string read getCONJUGE write setCONJUGE;

    [campo('BLOQUEADO', tpINTEGER,0,0)]
    property BLOQUEADO: boolean read FBLOQUEADO write FBLOQUEADO;

  public
    constructor create();
    destructor Destroy; override;
    class function CreateCliente(pCodigo, pNome, pFANTASIA: string): TCliente;

  end;

implementation

{ TCliente }

uses Util.Funcoes;

constructor TCliente.create();
begin
  inherited;
  Self.InicializarPropriedades(nil);
end;

class function TCliente.CreateCliente(pCodigo, pNome, pFANTASIA: string): TCliente;
begin
  result := TCliente.create;
  result.FCODIGO := pCodigo;
  result.FNOME := pNome;
  result.FFANTASIA := pFANTASIA;

end;

destructor TCliente.Destroy;
begin
  inherited;
end;

function TCliente.getBAIRRO: string;
begin
  result := FBAIRRO;
end;

function TCliente.getCADASTRO: TDateTime;
begin
  result := FCADASTRO;
end;

function TCliente.getCELULAR: string;
begin
  result := (FCELULAR);
end;

function TCliente.getCEP: string;
begin
  result := FCEP;
end;

function TCliente.getCIDADE: string;
begin
  result := FCIDADE;
end;

function TCliente.getCNPJ_CNPF: string;
begin
  result := TUtil.MAskCNPJCpf(FCNPJ_CNPF);
end;

function TCliente.getCOB_BAIRRO: string;
begin
  result := FCOB_BAIRRO;
end;

function TCliente.getCOB_CEP: string;
begin
  result := FCOB_CEP;
end;

function TCliente.getCOB_CIDADE: string;
begin
  result := FCOB_CIDADE;
end;

function TCliente.getCOB_COMPLEMENTO: string;
begin
  result := FCOB_COMPLEMENTO;
end;

function TCliente.getCOB_ENDERECO: string;
begin
  result := FCOB_ENDERECO;
end;

function TCliente.getCOB_NUMERO: string;
begin
  result := FCOB_NUMERO;
end;

function TCliente.getCOB_UF: string;
begin
  result := FCOB_UF;
end;

function TCliente.getCODIGO: string;
begin
  result := FCODIGO;
end;

function TCliente.getCOMPLEMENTO: string;
begin
  result := FCOMPLEMENTO;
end;

function TCliente.getCONJUGE: string;
begin
  result := FCONJUGE;
end;

function TCliente.getCONTATO: string;
begin
  result := FCONTATO;
end;

function TCliente.getEMAIL: string;
begin
  result := FEMAIL;
end;

function TCliente.getENDERECO: string;
begin
  result := FENDERECO;
end;

function TCliente.getEST_CIVIL: string;
begin
  result := FEST_CIVIL;
end;

function TCliente.getFANTASIA: string;
begin
  result := FFANTASIA;
end;

function TCliente.getFAX: string;
begin
  result := FFAX;
end;

function TCliente.getIE_RG: string;
begin
  result := FIE_RG;
end;

function TCliente.getIM: string;
begin
  result := FIM;
end;

function TCliente.getLOCAL: string;
begin
  result := FLOCAL;
end;

function TCliente.getLOCTRA: string;
begin
  result := FLOCTRA;
end;

function TCliente.getMAE: string;
begin
  result := FMAE;
end;

function TCliente.getNASCIMENTO: TDate;
begin
  result := FNASCIMENTO;
end;

function TCliente.getNATURALIDADE: string;
begin
  result := FNATURALIDADE;
end;

function TCliente.getNOME(): string;
begin
  result := FNOME
end;

function TCliente.getNUMERO: string;
begin
  result := FNUMERO;
end;

function TCliente.getOBSERVACOES: string;
begin
  result := FOBSERVACOES;
end;

function TCliente.getPAI: string;
begin
  result := FPAI;
end;

function TCliente.getPROFISSAO: string;
begin
  result := FPROFISSAO;
end;

function TCliente.getRENDA: currency;
begin
  result := FRENDA;
end;

function TCliente.getTELEFONE: string;
begin
  result := FTELEFONE;
end;

function TCliente.getUF: string;
begin
  result := FUF;
end;

function TCliente.getULTIMA_VENDA: TDateTime;
begin
  result := FULTIMA_VENDA;
end;

procedure TCliente.setBAIRRO(value: string);
begin
  if value <> FBAIRRO then
  begin
    FBAIRRO := value;
    Notify('BAIRRO');
  end;
end;

procedure TCliente.setCADASTRO(value: TDateTime);
begin
  if value <> FCADASTRO then
  begin
    FCADASTRO := value;
    Notify('CADASTRO');
  end;
end;

procedure TCliente.setCELULAR(value: string);
begin
  if value <> FCELULAR then
  begin
    FCELULAR := (value);
    Notify('CELULAR');
  end;
end;

procedure TCliente.setCEP(value: string);
begin
  if value <> FCEP then
  begin
    FCEP := value;
    Notify('CEP');
  end;
end;

procedure TCliente.setCIDADE(value: string);
begin
  if value <> FCIDADE then
  begin
    FCIDADE := value;
    Notify('CIDADE');
  end;
end;

procedure TCliente.setCNPJ_CNPF(value: string);
begin
  if value <> FCNPJ_CNPF then
  begin
    FCNPJ_CNPF := (value);
    Notify('CNPJ_CNPF');
  end;
end;

procedure TCliente.setCOB_BAIRRO(value: string);
begin
  if value <> FCOB_BAIRRO then
  begin
    FCOB_BAIRRO := value;
    Notify('COB_BAIRRO');
  end;
end;

procedure TCliente.setCOB_CEP(value: string);
begin
  if value <> FCOB_CEP then
  begin
    FCOB_CEP := value;
    Notify('COB_CEP');
  end;
end;

procedure TCliente.setCOB_CIDADE(value: string);
begin
  if value <> FCOB_CIDADE then
  begin
    FCOB_CIDADE := value;
    Notify('COB_CIDADE');
  end;
end;

procedure TCliente.setCOB_COMPLEMENTO(value: string);
begin
  if value <> FCOB_COMPLEMENTO then
  begin
    FCOB_COMPLEMENTO := value;
    Notify('COB_COMPLEMENTO');
  end;
end;

procedure TCliente.setCOB_ENDERECO(value: string);
begin
  if value <> FCOB_ENDERECO then
  begin
    FCOB_ENDERECO := value;
    Notify('COB_ENDERECO');
  end;
end;

procedure TCliente.setCOB_NUMERO(value: string);
begin
  if value <> FCOB_NUMERO then
  begin
    FCOB_NUMERO := value;
    Notify('COB_NUMERO');
  end;
end;

procedure TCliente.setCOB_UF(value: string);
begin
  if value <> FCOB_UF then
  begin
    FCOB_UF := value;
    Notify('COB_UF');
  end;
end;

procedure TCliente.setCODIGO(value: string);
begin
  if value <> FCODIGO then
  begin
    FCODIGO := value;
    Notify('CODIGO');
  end;
end;

procedure TCliente.setCOMPLEMENTO(value: string);
begin
  if value <> FCOMPLEMENTO then
  begin
    FCOMPLEMENTO := value;
    Notify('COMPLEMENTO');
  end;
end;

procedure TCliente.setCONJUGE(value: string);
begin
  if value <> FCONJUGE then
  begin
    FCONJUGE := value;
    Notify('CONJUGE');
  end;
end;

procedure TCliente.setCONTATO(value: string);
begin
  if value <> FCONTATO then
  begin
    FCONTATO := value;
    Notify('CONTATO');
  end;
end;

procedure TCliente.setEMAIL(value: string);
begin
  if value <> FEMAIL then
  begin
    FEMAIL := value;
    Notify('EMAIL');
  end;
end;

procedure TCliente.setENDERECO(value: string);
begin
  if value <> FENDERECO then
  begin
    FENDERECO := value;
    Notify('ENDERECO');
  end;
end;

procedure TCliente.setEST_CIVIL(value: string);
begin
  if value <> FEST_CIVIL then
  begin
    FEST_CIVIL := value;
    Notify('EST_CIVIL');
  end;
end;

procedure TCliente.setFANTASIA(value: string);
begin
  if value <> FFANTASIA then
  begin
    FFANTASIA := value;
    Notify('FANTASIA');
  end;
end;

procedure TCliente.setFAX(value: string);
begin
  if value <> FFAX then
  begin
    FFAX := value;
    Notify('FAX');
  end;
end;

procedure TCliente.setIE_RG(value: string);
begin
  if value <> FIE_RG then
  begin
    FIE_RG := value;
    Notify('IE_RG');
  end;
end;

procedure TCliente.setIM(value: string);
begin
  if value <> FIM then
  begin
    FIM := value;
    Notify('IM');
  end;
end;

procedure TCliente.setLOCAL(value: string);
begin
  if value <> FLOCAL then
  begin
    FLOCAL := value;
    Notify('LOCAL');
  end;
end;

procedure TCliente.setLOCTRA(value: string);
begin
  if value <> FLOCTRA then
  begin
    FLOCTRA := value;
    Notify('LOCTRA');
  end;
end;

procedure TCliente.setMAE(value: string);
begin
  if value <> FMAE then
  begin
    FMAE := value;
    Notify('MAE');
  end;
end;

procedure TCliente.setNASCIMENTO(value: TDate);
begin
  if value <> FNASCIMENTO then
  begin
    FNASCIMENTO := value;
    Notify('NASCIMENTO');
  end;
end;

procedure TCliente.setNATURALIDADE(value: string);
begin
  if value <> FNATURALIDADE then
  begin
    FNATURALIDADE := value;
    Notify('NATURALIDADE');
  end;
end;

procedure TCliente.setNOME(value: string);
begin
  if value <> FNOME then
  begin
    FNOME := value;
    Notify('NOME');
  end;
end;

procedure TCliente.setNUMERO(value: string);
begin
  if value <> FNUMERO then
  begin
    FNUMERO := value;
    Notify('NUMERO');
  end;
end;

procedure TCliente.setOBSERVACOES(value: string);
begin
  if value <> FOBSERVACOES then
  begin
    FOBSERVACOES := value;
    Notify('OBSERVACOES');
  end;
end;

procedure TCliente.setPAI(value: string);
begin
  if value <> FPAI then
  begin
    FPAI := value;
    Notify('PAI');
  end;
end;

procedure TCliente.setPROFISSAO(value: string);
begin
  if value <> FPROFISSAO then
  begin
    FPROFISSAO := value;
    Notify('PROFISSAO');
  end;
end;

procedure TCliente.setRENDA(value: currency);
begin
  if value <> FRENDA then
  begin
    FRENDA := value;
    Notify('RENDA');
  end;
end;

procedure TCliente.setTELEFONE(value: string);
begin
  if value <> FTELEFONE then
  begin
    FTELEFONE := (value);
    Notify('TELEFONE');
  end;
end;

procedure TCliente.setUF(value: string);
begin
  if value <> FUF then
  begin
    FUF := value;
    Notify('UF');
  end;
end;

procedure TCliente.setULTIMA_VENDA(value: TDateTime);
begin
  if value <> FULTIMA_VENDA then
  begin
    FULTIMA_VENDA := value;
    Notify('ULTIMA_VENDA');
  end;
end;

end.
