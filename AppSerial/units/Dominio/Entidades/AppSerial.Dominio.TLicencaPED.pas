unit AppSerial.Dominio.TLicencaPED;

interface

uses Dominio.Entidades.TEntity;

type

  TLicencaPED = class(TEntity)
  private
    FCODIGO: string;
    FSERIAL: string;
    FVENCIMENTO: TDATE;
    FDATAGERACAO: TDATE;
    FDATAINICIO: TDATE;
    FCODIGOCLIENTE: string;
    procedure SetCODIGO(const Value: string);
    procedure SetCODIGOCLIENTE(const Value: string);
    procedure SetDATAGERACAO(const Value: TDATE);
    procedure SetDATAINICIO(const Value: TDATE);
    procedure SetSERIAL(const Value: string);
    procedure SetVENCIMENTO(const Value: TDATE);
  public

    property CODIGO: string read FCODIGO write SetCODIGO;
    property CODIGOCLIENTE: string read FCODIGOCLIENTE write SetCODIGOCLIENTE;
    property DATAINICIO: TDATE read FDATAINICIO write SetDATAINICIO;
    property VENCIMENTO: TDATE read FVENCIMENTO write SetVENCIMENTO;
    property SERIAL: string read FSERIAL write SetSERIAL;
    property DATAGERACAO: TDATE read FDATAGERACAO write SetDATAGERACAO;
  end;

implementation

{ TLicencaPED }

procedure TLicencaPED.SetCODIGO(const Value: string);
begin
  FCODIGO := Value;
end;

procedure TLicencaPED.SetCODIGOCLIENTE(const Value: string);
begin
  FCODIGOCLIENTE := Value;
end;

procedure TLicencaPED.SetDATAGERACAO(const Value: TDATE);
begin
  FDATAGERACAO := Value;
end;

procedure TLicencaPED.SetDATAINICIO(const Value: TDATE);
begin
  FDATAINICIO := Value;
end;

procedure TLicencaPED.SetSERIAL(const Value: string);
begin
  FSERIAL := Value;
end;

procedure TLicencaPED.SetVENCIMENTO(const Value: TDATE);
begin
  FVENCIMENTO := Value;
end;

end.
