unit Dominio.Entidades.TParceiro;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('PARCEIRO')]
  TParceiro = class(TEntity)
  private
    FCOMISSAOP: currency;
    FCODIGO: string;
    FNOME: string;
    FINATIVO: Boolean;
    procedure SetCODIGO(const Value: string);

    procedure SetNOME(const Value: string);
    procedure SetINATIVO(const Value: Boolean);
  published
    [campo('CODIGO', tpVARCHAR, 10, 0, True)]
    [PrimaryKey('PK_PARCEIRO', 'CODIGO')]
    property CODIGO: string read FCODIGO write SetCODIGO;

    [campo('NOME', tpVARCHAR, 35)]
    property NOME: string read FNOME write SetNOME;

    [campo('INATIVO', tpINTEGER)]
    property INATIVO: Boolean read FINATIVO write SetINATIVO;

  end;

implementation

{ TParceiro }

procedure TParceiro.SetCODIGO(const Value: string);
begin
  FCODIGO := Value;
end;



procedure TParceiro.SetINATIVO(const Value: Boolean);
begin
  FINATIVO := Value;
end;

procedure TParceiro.SetNOME(const Value: string);
begin
  FNOME := Value;
end;

end.
