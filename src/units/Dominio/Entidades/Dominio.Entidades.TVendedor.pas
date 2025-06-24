unit Dominio.Entidades.TVendedor;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('VENDEDOR')]
  TVendedor = class(TEntity)
  private
    FCODIGO: string;
    FSenha: string;
    FNOME: string;
    FCOMISSAOV: currency;
    FCOMISSAOP: currency;
    FPODERECEBERPARCELA: Boolean;
    FPODECANCELARPEDIDO: Boolean;
    FPODECANCELARORCAMENTO: Boolean;
    FPODEACESSARCADASTROVENDEDOR: Boolean;
    FPODEACESSARPARAMETROS: Boolean;
    FDATAALTERACAO: TDateTime;

    function getCODIGO: string;
    procedure setCODIGO(const Value: string);
    function getSenha: string;
    procedure setSenha(const Value: string);
    function geTPODERECERPARCELA: Boolean;
    procedure setPODERECEBERPARCELA(const Value: Boolean);
    function getPODECANCELARPEDIDO: Boolean;
    procedure setPODECANCELARPEDIDO(const Value: Boolean);
    function getPODEACESSARCADASTROVENDEDOR: Boolean;
    procedure setPODEACESSARCADASTROVENDEDOR(const Value: Boolean);
    function getPODECANCELARORCAMENTO: Boolean;
    procedure setPODECANCELARORCAMENTO(const Value: Boolean);
    function getPODEACESSARPARAMETROS: Boolean;
    procedure setPODEACESSARPARAMETROS(const Value: Boolean);
    procedure SetDATAALTERACAO(const Value: TDateTime);
  published

    [campo('CODIGO', tpVARCHAR, 10, 0, True)]
    [PrimaryKey('INTEG_36', 'CODIGO')]
    property CODIGO: string read getCODIGO write setCODIGO;

    [campo('NOME', tpVARCHAR, 35)]
    property NOME: string read FNOME write FNOME;

    [campo('COMISSAOV', tpNUMERIC, 15, 4)]
    property COMISSAOV: currency read FCOMISSAOV write FCOMISSAOV;

    [campo('COMISSAOP', tpNUMERIC, 15, 4)]
    property COMISSAOP: currency read FCOMISSAOP write FCOMISSAOP;

    [campo('SENHA', tpVARCHAR, 40)]
    property SENHA: string read getSenha write setSenha;

    [campo('PODERECEBERPARCELA', tpSMALLINT, 0, 0, True, '1')]
    property PODERECEBERPARCELA: Boolean read geTPODERECERPARCELA write setPODERECEBERPARCELA;

    [campo('PODECANCELARPEDIDO', tpSMALLINT, 0, 0, True, '1')]
    property PODECANCELARPEDIDO: Boolean read getPODECANCELARPEDIDO write setPODECANCELARPEDIDO;

    [campo('PODEACESSARCADASTROVENDEDOR', tpSMALLINT, 0, 0, True, '1')]
    property PODEACESSARCADASTROVENDEDOR: Boolean read getPODEACESSARCADASTROVENDEDOR write setPODEACESSARCADASTROVENDEDOR;

    [campo('PODECANCELARORCAMENTO', tpSMALLINT, 0, 0, True, '1')]
    property PODECANCELARORCAMENTO: Boolean read getPODECANCELARORCAMENTO write setPODECANCELARORCAMENTO;

    [campo('PODEACESSARPARAMETROS', tpSMALLINT, 0, 0, True, '1')]
    property PODEACESSARPARAMETROS: Boolean read getPODEACESSARPARAMETROS write setPODEACESSARPARAMETROS;

    [campo('DATAALTERACAO', tpTIMESTAMP)]
    property DATAALTERACAO: TDateTime read FDATAALTERACAO write SetDATAALTERACAO;
  public
    constructor create();
    class function CreateVendedor(pCodigo, pNome: string; pCOMISSAOV, pCOMISSAOP: currency): TVendedor;
  end;

implementation

{ TVendedor }

constructor TVendedor.create();
begin
  inherited;
  Self.InicializarPropriedades(nil);
end;

class function TVendedor.CreateVendedor(pCodigo, pNome: string; pCOMISSAOV, pCOMISSAOP: currency): TVendedor;
begin
  result := TVendedor.create();
  result.FNOME := pNome;
  result.FCOMISSAOV := pCOMISSAOV;
  result.FCODIGO := pCodigo;
  result.FCOMISSAOP := pCOMISSAOP;
end;

function TVendedor.getCODIGO: string;
begin
  result := Self.FCODIGO;
end;

function TVendedor.getPODEACESSARCADASTROVENDEDOR: Boolean;
begin
  result := FPODEACESSARCADASTROVENDEDOR;
end;

function TVendedor.getPODEACESSARPARAMETROS: Boolean;
begin
  result := FPODEACESSARPARAMETROS;
end;

function TVendedor.getPODECANCELARORCAMENTO: Boolean;
begin
  result := FPODECANCELARORCAMENTO;
end;

function TVendedor.getPODECANCELARPEDIDO: Boolean;
begin
  result := FPODECANCELARPEDIDO;
end;

function TVendedor.geTPODERECERPARCELA: Boolean;
begin
  result := FPODERECEBERPARCELA;
end;

function TVendedor.getSenha: string;
begin
  result := FSenha;
end;

procedure TVendedor.setCODIGO(const Value: string);
begin
  if Value <> FCODIGO then
  begin
    FCODIGO := Value;
    Notify('CODIGO');
  end;
end;

procedure TVendedor.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TVendedor.setPODEACESSARCADASTROVENDEDOR(const Value: Boolean);
begin
  if Value <> FPODEACESSARCADASTROVENDEDOR then
  begin
    FPODEACESSARCADASTROVENDEDOR := Value;
    Notify('PODEACESSARCADASTROVENDEDOR');
  end;
end;

procedure TVendedor.setPODEACESSARPARAMETROS(const Value: Boolean);
begin
  if Value <> FPODEACESSARPARAMETROS then
  begin
    FPODEACESSARPARAMETROS := Value;
    Notify('PODEACESSARPARAMETROS');
  end;
end;

procedure TVendedor.setPODECANCELARORCAMENTO(const Value: Boolean);
begin
  if Value <> FPODECANCELARORCAMENTO then
  begin
    FPODECANCELARORCAMENTO := Value;
    Notify('PODECANCELARORCAMENTO');
  end;
end;

procedure TVendedor.setPODECANCELARPEDIDO(const Value: Boolean);
begin
  if Value <> FPODECANCELARPEDIDO then
  begin
    FPODECANCELARPEDIDO := Value;
    Notify('PODECANCELARPEDIDO');
  end;

end;

procedure TVendedor.setPODERECEBERPARCELA(const Value: Boolean);
begin
  if Value <> FPODERECEBERPARCELA then
  begin
    FPODERECEBERPARCELA := Value;
    Notify('PODERECEBERPARCELA');
  end;
end;

procedure TVendedor.setSenha(const Value: string);
begin
  if Value <> FSenha then
  begin
    FSenha := Value;
    Notify('SENHA');
  end;
end;

end.
