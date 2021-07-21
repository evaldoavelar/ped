unit AppSerial.Dominio.TClientePED;

interface

uses Dominio.Entidades.TEntity;

type

  TClientePED = class(TEntity)
  private
    FCNPJ: string;
    FCODIGO: string;
    FCONTATO: string;
    FNOME: string;
    FTELEFONE: string;
    FCELULAR: string;
    procedure SetCELULAR(const Value: string);
    procedure SetCNPJ(const Value: string);
    procedure SetCODIGO(const Value: string);
    procedure SetCONTATO(const Value: string);
    procedure SetNOME(const Value: string);
    procedure SetTELEFONE(const Value: string);
  public
    property CODIGO: string read FCODIGO write SetCODIGO;
    property NOME: string read FNOME write SetNOME;
    property CNPJ: string read FCNPJ write SetCNPJ;
    property TELEFONE: string read FTELEFONE write SetTELEFONE;
    property CELULAR: string read FCELULAR write SetCELULAR;
    property CONTATO: string read FCONTATO write SetCONTATO;
  end;

implementation

{ TCliente }

procedure TClientePED.SetCELULAR(const Value: string);
begin
  FCELULAR := Value;
end;

procedure TClientePED.SetCNPJ(const Value: string);
begin
  FCNPJ := Value;
end;

procedure TClientePED.SetCODIGO(const Value: string);
begin
  FCODIGO := Value;
end;

procedure TClientePED.SetCONTATO(const Value: string);
begin
  FCONTATO := Value;
end;

procedure TClientePED.SetNOME(const Value: string);
begin
  FNOME := Value;
end;

procedure TClientePED.SetTELEFONE(const Value: string);
begin
  FTELEFONE := Value;
end;

end.
