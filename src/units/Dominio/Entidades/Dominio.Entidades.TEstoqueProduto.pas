unit Dominio.Entidades.TEstoqueProduto;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos, System.SysUtils;

type

  [Tabela('ESTOQUEPRODUTO')]
  TEstoqueProduto = class(TEntity)
  PRIVATE
    FSEQPRODUTOPEDIDO: integer;
    FCODIGOPRD: string;
    FDESCRICAO: string;
    FID: integer;
    FStatus: string;
    FQUANTIDADE: double;
    FIDPEDIDO: integer;
    FUSUARIOCRIACAO: string;
    FTIPO: string;
    FDATA: TDate;
    FNOTAFISCAL: string;
    FDATAALTERACAO: TDateTime;
    procedure SetCODIGOPRD(const Value: string);
    procedure SetDATA(const Value: TDate);
    procedure SetDESCRICAO(const Value: string);
    procedure SetID(const Value: integer);
    procedure SetIDPEDIDO(const Value: integer);
    procedure SetQUANTIDADE(const Value: double);
    procedure SetSEQPRODUTOPEDIDO(const Value: integer);
    procedure SetStatus(const Value: string);
    procedure SetTIPO(const Value: string);
    procedure SetUSUARIOCRIACAO(const Value: string);
    procedure SetNOTAFISCAL(const Value: string);
    procedure SetDATAALTERACAO(const Value: TDateTime);

  public
    [AutoInc('AUTOINC')]
    [PrimaryKey('PKESTOQUEPRODUTO', 'ID')]
    [Campo('ID', tpINTEGER, 0, 0, True)]
    property ID: integer read FID write SetID;

    [Campo('IDPEDIDO', tpINTEGER)]
    property IDPEDIDO: integer read FIDPEDIDO write SetIDPEDIDO;

    [Campo('SEQPRODUTOPEDIDO', tpINTEGER)]
    property SEQPRODUTOPEDIDO: integer read FSEQPRODUTOPEDIDO write SetSEQPRODUTOPEDIDO;

    [ForeignKeyAttribute('FK_ESTOQ_PRODUTOS', 'CODIGOPRD', 'PRODUTO', 'CODIGO', None, None)]
    [Campo('CODIGOPRD', tpVarchar, 40)]
    property CODIGOPRD: string read FCODIGOPRD write SetCODIGOPRD;

    [Campo('DESCRICAO', tpVarchar, 300)]
    property DESCRICAO: string read FDESCRICAO write SetDESCRICAO;

    [Campo('NOTAFISCAL', tpVarchar, 40)]
    property NOTAFISCAL: string read FNOTAFISCAL write SetNOTAFISCAL;

    [Campo('QUANTIDADE', tpNUMERIC, 15, 4, True)]
    property QUANTIDADE: double read FQUANTIDADE write SetQUANTIDADE;

    [Campo('TIPO', tpVarchar, 1)]
    property TIPO: string read FTIPO write SetTIPO;

    [Campo('STATUS', tpVarchar, 1)]
    property Status: string read FStatus write SetStatus;

    [Campo('DATA', tpDATE)]
    property DATA: TDate read FDATA write SetDATA;

    [Campo('USUARIOCRIACAO', tpVarchar, 15)]
    property USUARIOCRIACAO: string read FUSUARIOCRIACAO write SetUSUARIOCRIACAO;

    [Campo('DATAALTERACAO', tpTIMESTAMP)]
    property DATAALTERACAO: TDateTime read FDATAALTERACAO write SetDATAALTERACAO;

  public
    constructor create; override;
  end;

implementation

{ TEstoqueProduto }

constructor TEstoqueProduto.create;
begin
  inherited;

end;

procedure TEstoqueProduto.SetCODIGOPRD(const Value: string);
begin
  FCODIGOPRD := Value;
end;

procedure TEstoqueProduto.SetDATA(const Value: TDate);
begin
  FDATA := Value;
end;

procedure TEstoqueProduto.SetDATAALTERACAO(const Value: TDateTime);
begin
  FDATAALTERACAO := Value;
end;

procedure TEstoqueProduto.SetDESCRICAO(const Value: string);
begin
  FDESCRICAO := Value;
end;

procedure TEstoqueProduto.SetID(const Value: integer);
begin
  FID := Value;
end;

procedure TEstoqueProduto.SetIDPEDIDO(const Value: integer);
begin
  FIDPEDIDO := Value;
end;

procedure TEstoqueProduto.SetNOTAFISCAL(const Value: string);
begin
  FNOTAFISCAL := Value;
end;

procedure TEstoqueProduto.SetQUANTIDADE(const Value: double);
begin
  FQUANTIDADE := Value;
end;

procedure TEstoqueProduto.SetSEQPRODUTOPEDIDO(const Value: integer);
begin
  FSEQPRODUTOPEDIDO := Value;
end;

procedure TEstoqueProduto.SetStatus(const Value: string);
begin
  FStatus := Value;
end;

procedure TEstoqueProduto.SetTIPO(const Value: string);
begin
  FTIPO := Value;
end;

procedure TEstoqueProduto.SetUSUARIOCRIACAO(const Value: string);
begin
  FUSUARIOCRIACAO := Value;
end;

end.
