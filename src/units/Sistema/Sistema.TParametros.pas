unit Sistema.TParametros;

interface

uses
  system.SysUtils, Vcl.ExtCtrls,
  Dominio.Entidades.TEntity,
  Sistema.TFormaPesquisa,
  Impressao.Parametros.Impressora.Termica,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, Impressao.Parametros.Impressora.Tinta;

type

  [Tabela('PARAMETROS')]
  TParametros = class(TEntity)
  private
    FBACKUPDIARIO: Boolean;
    FVENDECLIENTEBLOQUEADO: Boolean;
    FATUALIZACLIENTENAVENDA: Boolean;
    FBLOQUEARCLIENTECOMATRASO: Boolean;

    FVERSAOBD: string;
    FImpressora: TParametrosImpressoraTermica;
    FVALIDADEORCAMENTO: Integer;
    FPESQUISAPRODUTOPOR: Integer;
    FINFORMARPARCEIRONAVENDA: Boolean;
    FLOGOMARCAETIQUETA: TImage;
    FImpressoraTinta: TParametrosImpressoraTinta;
    FDIRETORIORELATORIOS: string;
    FNUMCAIXA: string;
    FSERVIDORSENHA: string;
    FSERVIDORDATABASE: string;
    FSERVIDORUSUARIO: string;
    FFUNCIONARCOMOCLIENTE: Boolean;

    function getVENDECLIENTEBLOQUEADO: Boolean;
    procedure setVENDECLIENTEBLOQUEADO(const Value: Boolean);
    function getATUALIZACLIENTENAVENDA: Boolean;
    procedure setATUALIZACLIENTENAVENDA(const Value: Boolean);
    function getImpressora: TParametrosImpressoraTermica;
    procedure setImpressora(const Value: TParametrosImpressoraTermica);
    function getBACKUPDIARIO: Boolean;
    procedure setBACKUPDIARIO(const Value: Boolean);
    function getVERSAOBD: string;
    procedure setVERSAOBD(const Value: string);
    function getBLOQUEARCLIENTECOMATRASO: Boolean;
    procedure setBLOQUEARCLIENTECOMATRASO(const Value: Boolean);
    procedure SetVALIDADEORCAMENTO(const Value: Integer);
    procedure SetPESQUISAPRODUTOPOR(const Value: Integer);
    function getPESQUISAPRODUTOPOR: Integer;
    procedure SetINFORMARPARCEIRONAVENDA(const Value: Boolean);
    procedure SetImpressoraTinta(const Value: TParametrosImpressoraTinta);
    procedure SetDIRETORIORELATORIOS(const Value: string);
    function GETDIRETORIORELATORIOS: string;
    procedure SetNUMCAIXA(const Value: string);
    procedure SetSERVIDORDATABASE(const Value: string);
    procedure SetSERVIDORSENHA(const Value: string);
    procedure SetSERVIDORUSUARIO(const Value: string);
    procedure SetFUNCIONARCOMOCLIENTE(const Value: Boolean);
    function GetSERVIDORSENHAProxy: string;
    procedure SetSERVIDORSENHAProxy(const Value: string);

  public

    [campo('VENDECLIENTEBLOQUEADO', tpINTEGER)]
    property VENDECLIENTEBLOQUEADO: Boolean read getVENDECLIENTEBLOQUEADO write setVENDECLIENTEBLOQUEADO;

    [campo('ATUALIZACLIENTENAVENDA', tpINTEGER)]
    property ATUALIZACLIENTENAVENDA: Boolean read getATUALIZACLIENTENAVENDA write setATUALIZACLIENTENAVENDA;

    property ImpressoraTermica: TParametrosImpressoraTermica read getImpressora write setImpressora;
    property ImpressoraTinta: TParametrosImpressoraTinta read FImpressoraTinta write SetImpressoraTinta;

    [campo('BACKUPDIARIO', tpSMALLINT, 0, 0, True, '0')]
    property BACKUPDIARIO: Boolean read getBACKUPDIARIO write setBACKUPDIARIO;

    [campo('VERSAOBD', tpVARCHAR, 30)]
    property VERSAOBD: string read getVERSAOBD write setVERSAOBD;

    [campo('BLOQUEARCLIENTECOMATRASO', tpINTEGER)]
    property BLOQUEARCLIENTECOMATRASO: Boolean read getBLOQUEARCLIENTECOMATRASO write setBLOQUEARCLIENTECOMATRASO;

    [campo('VALIDADEORCAMENTO', tpINTEGER, 0, 0, True, '15')]
    property VALIDADEORCAMENTO: Integer read FVALIDADEORCAMENTO write SetVALIDADEORCAMENTO;

    [campo('PESQUISAPRODUTOPOR', tpINTEGER, 0, 0, True, '0')]
    property PESQUISAPRODUTOPOR: Integer read getPESQUISAPRODUTOPOR write SetPESQUISAPRODUTOPOR;

    [campo('INFORMARPARCEIRONAVENDA', tpINTEGER, 0, 0, True, '1')]
    property INFORMARPARCEIRONAVENDA: Boolean read FINFORMARPARCEIRONAVENDA write SetINFORMARPARCEIRONAVENDA;

    [campo('LOGOMARCAETIQUETA', tpBLOB, 0, 9048)]
    property LOGOMARCAETIQUETA: TImage read FLOGOMARCAETIQUETA write FLOGOMARCAETIQUETA;

    [campo('DIRETORIORELATORIOS', tpVARCHAR, 2000)]
    property DIRETORIORELATORIOS: string read GETDIRETORIORELATORIOS;

    [campo('NUMCAIXA', tpVARCHAR, 10, 0, True, 'caixa-01')]
    property NUMCAIXA: string read FNUMCAIXA write SetNUMCAIXA;

    [campo('SERVIDORDATABASE', tpVARCHAR, 300)]
    property SERVIDORDATABASE: string read FSERVIDORDATABASE write SetSERVIDORDATABASE;

    [campo('SERVIDORUSUARIO', tpVARCHAR, 60)]
    property SERVIDORUSUARIO: string read FSERVIDORUSUARIO write SetSERVIDORUSUARIO;

    [campo('SERVIDORSENHA', tpVARCHAR, 60)]
    property SERVIDORSENHA: string read FSERVIDORSENHA write SetSERVIDORSENHA;
    property SERVIDORSENHAProxy: string read GetSERVIDORSENHAProxy write SetSERVIDORSENHAProxy;

    [campo('FUNCIONARCOMOCLIENTE', tpINTEGER, 0, 0, FALSE, '0')]
    property FUNCIONARCOMOCLIENTE: Boolean read FFUNCIONARCOMOCLIENTE write SetFUNCIONARCOMOCLIENTE;

    constructor create; override;
    destructor Destroy; override;

  end;

implementation

uses
  Util.Funcoes, Util.TCript, Sistema.Constantes;

{ TParametros }

constructor TParametros.create;
begin
  inherited;
  Self.PESQUISAPRODUTOPOR := 0;
  Self.VALIDADEORCAMENTO := 15;
  Self.ImpressoraTermica := TParametrosImpressoraTermica.create;
  Self.ImpressoraTinta := TParametrosImpressoraTinta.create;
end;

destructor TParametros.Destroy;
begin
  if Assigned(FImpressora) then
    FreeAndNil(FImpressora);

  if Assigned(FImpressoraTinta) then
    FreeAndNil(FImpressoraTinta);
  inherited;
end;

function TParametros.getATUALIZACLIENTENAVENDA: Boolean;
begin
  result := FATUALIZACLIENTENAVENDA;
end;

function TParametros.getBACKUPDIARIO: Boolean;
begin
  result := FBACKUPDIARIO;
end;

function TParametros.getBLOQUEARCLIENTECOMATRASO: Boolean;
begin
  result := FBLOQUEARCLIENTECOMATRASO;
end;

function TParametros.GETDIRETORIORELATORIOS: string;
begin
  result := TUtil.DiretorioApp + 'Relatorios';
end;

function TParametros.getImpressora: TParametrosImpressoraTermica;
begin
  result := FImpressora;
end;

function TParametros.getPESQUISAPRODUTOPOR: Integer;
begin
  result := FPESQUISAPRODUTOPOR;
end;

function TParametros.GetSERVIDORSENHAProxy: string;
begin
  result := TCript.StringDescripty(CHAVE, FSERVIDORSENHA);
end;

function TParametros.getVENDECLIENTEBLOQUEADO: Boolean;
begin
  result := FVENDECLIENTEBLOQUEADO
end;

function TParametros.getVERSAOBD: string;
begin
  result := FVERSAOBD;
end;

procedure TParametros.setATUALIZACLIENTENAVENDA(const Value: Boolean);
begin
  if Value <> FATUALIZACLIENTENAVENDA then
  begin
    FATUALIZACLIENTENAVENDA := Value;
    Notify('ATUALIZACLIENTENAVENDA');
  end;
end;

procedure TParametros.setBACKUPDIARIO(const Value: Boolean);
begin
  if Value <> FBACKUPDIARIO then
  begin
    FBACKUPDIARIO := Value;
    Notify('BACKUPDIARIO');
  end;
end;

procedure TParametros.setBLOQUEARCLIENTECOMATRASO(const Value: Boolean);
begin

  if Value <> FBLOQUEARCLIENTECOMATRASO then
  begin
    FBLOQUEARCLIENTECOMATRASO := Value;
    Notify('BLOQUEARCLIENTECOMATRASO');
  end;
end;

procedure TParametros.SetDIRETORIORELATORIOS(const Value: string);
begin
  if Value <> FDIRETORIORELATORIOS then
  begin
    FDIRETORIORELATORIOS := Value;
    Notify('DIRETORIORELATORIOS');
  end;
end;

procedure TParametros.SetFUNCIONARCOMOCLIENTE(const Value: Boolean);
begin
  if Value <> FFUNCIONARCOMOCLIENTE then
  begin
    FFUNCIONARCOMOCLIENTE := Value;
    Notify('FUNCIONARCOMOCLIENTE');
  end;
end;

procedure TParametros.setImpressora(const Value: TParametrosImpressoraTermica);
begin
  Self.FImpressora := Value;
end;

procedure TParametros.SetImpressoraTinta(
  const Value: TParametrosImpressoraTinta);
begin
  if Value <> FImpressoraTinta then
  begin
    FImpressoraTinta := Value;
    Notify('ImpressoraTinta');
  end;
end;

procedure TParametros.SetINFORMARPARCEIRONAVENDA(const Value: Boolean);
begin
  if Value <> FINFORMARPARCEIRONAVENDA then
  begin
    FINFORMARPARCEIRONAVENDA := Value;
    Notify('INFORMARPARCEIRONAVENDA');
  end;
end;

procedure TParametros.SetNUMCAIXA(const Value: string);
begin
  FNUMCAIXA := Value;
end;

procedure TParametros.SetPESQUISAPRODUTOPOR(const Value: Integer);
begin
  if Value <> FPESQUISAPRODUTOPOR then
  begin
    FPESQUISAPRODUTOPOR := Value;
    Notify('PESQUISAPRODUTOPOR');
  end;
end;

procedure TParametros.SetSERVIDORDATABASE(const Value: string);
begin
  if Value <> FSERVIDORDATABASE then
  begin
    FSERVIDORDATABASE := Value;
    Notify('SERVIDORDATABASE');
  end;
end;

procedure TParametros.SetSERVIDORSENHA(const Value: string);
begin

  if Value <> FSERVIDORSENHA then
  begin
    FSERVIDORSENHA := Value;
    Notify('SERVIDORSENHA');
  end;
end;

procedure TParametros.SetSERVIDORSENHAProxy(const Value: string);
begin
  FSERVIDORSENHA := TCript.StringEncripty(CHAVE, Value);
end;

procedure TParametros.SetSERVIDORUSUARIO(const Value: string);
begin
  if Value <> FSERVIDORUSUARIO then
  begin
    FSERVIDORUSUARIO := Value;
    Notify('SERVIDORUSUARIO');
  end;

end;

procedure TParametros.SetVALIDADEORCAMENTO(const Value: Integer);
begin
  if Value <> FVALIDADEORCAMENTO then
  begin
    FVALIDADEORCAMENTO := Value;
    Notify('VALIDADEORCAMENTO');
  end;
end;

procedure TParametros.setVENDECLIENTEBLOQUEADO(const Value: Boolean);
begin
  if Value <> FVENDECLIENTEBLOQUEADO then
  begin
    FVENDECLIENTEBLOQUEADO := Value;
    Notify('VENDECLIENTEBLOQUEADO');
  end;
end;

procedure TParametros.setVERSAOBD(const Value: string);
begin
  if Value <> FVERSAOBD then
  begin
    FVERSAOBD := Value;
    Notify('VERSAOBD');
  end;

end;

end.
