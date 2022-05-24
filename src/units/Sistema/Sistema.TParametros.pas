unit Sistema.TParametros;

interface

uses
  system.SysUtils,   Vcl.ExtCtrls,
  Dominio.Entidades.TEntity,
  Sistema.TFormaPesquisa,
  Impressao.TParametrosImpressora,
  Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('PARAMETROS')]
  TParametros = class(TEntity)
  private
    FBACKUPDIARIO: Boolean;
    FVENDECLIENTEBLOQUEADO: Boolean;
    FATUALIZACLIENTENAVENDA: Boolean;
    FBLOQUEARCLIENTECOMATRASO: Boolean;

    FVERSAOBD: string;
    FImpressora: TParametrosImpressora;
    FVALIDADEORCAMENTO: Integer;
    FPESQUISAPRODUTOPOR: Integer;
    FINFORMARPARCEIRONAVENDA: Boolean;
    FLOGOMARCAETIQUETA: TImage;

    function getVENDECLIENTEBLOQUEADO: Boolean;
    procedure setVENDECLIENTEBLOQUEADO(const Value: Boolean);
    function getATUALIZACLIENTENAVENDA: Boolean;
    procedure setATUALIZACLIENTENAVENDA(const Value: Boolean);
    function getImpressora: TParametrosImpressora;
    procedure setImpressora(const Value: TParametrosImpressora);
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

  public
    destructor Destroy; override;
    [campo('VENDECLIENTEBLOQUEADO', tpINTEGER)]
    property VENDECLIENTEBLOQUEADO: Boolean read getVENDECLIENTEBLOQUEADO write setVENDECLIENTEBLOQUEADO;

    [campo('ATUALIZACLIENTENAVENDA', tpINTEGER)]
    property ATUALIZACLIENTENAVENDA: Boolean read getATUALIZACLIENTENAVENDA write setATUALIZACLIENTENAVENDA;

    property Impressora: TParametrosImpressora read getImpressora write setImpressora;

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

    constructor create; override;

  end;

implementation

{ TParametros }

constructor TParametros.create;
begin
  inherited;
  Self.PESQUISAPRODUTOPOR := 0;
  Self.VALIDADEORCAMENTO := 15;
  Self.Impressora := TParametrosImpressora.create;
end;

destructor TParametros.Destroy;
begin
  if Assigned(FImpressora) then
    FreeAndNil(FImpressora);
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

function TParametros.getImpressora: TParametrosImpressora;
begin
  result := FImpressora;
end;

function TParametros.getPESQUISAPRODUTOPOR: Integer;
begin
  result := FPESQUISAPRODUTOPOR;
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

procedure TParametros.setImpressora(const Value: TParametrosImpressora);
begin
  Self.FImpressora := Value;
end;

procedure TParametros.SetINFORMARPARCEIRONAVENDA(const Value: Boolean);
begin
  if Value <> FINFORMARPARCEIRONAVENDA then
  begin
    FINFORMARPARCEIRONAVENDA := Value;
    Notify('INFORMARPARCEIRONAVENDA');
  end;
end;

procedure TParametros.SetPESQUISAPRODUTOPOR(const Value: Integer);
begin
  if Value <> FPESQUISAPRODUTOPOR then
  begin
    FPESQUISAPRODUTOPOR := Value;
    Notify('PESQUISAPRODUTOPOR');
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
