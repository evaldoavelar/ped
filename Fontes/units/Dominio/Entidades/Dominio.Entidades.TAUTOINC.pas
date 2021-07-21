unit Dominio.Entidades.TAUTOINC;

interface


uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('AUTOINC')]
  TAUTOINC = class(TEntity)
  private
    FCODIGO: string;
    FVALOR: STRING;
    FTabela: string;
    procedure SetCODIGO(const Value: string);
    procedure SetTabela(const Value: string);
    procedure SetVALOR(const Value: STRING);
  published

    [campo('CAMPO', tpVARCHAR, 40, 0, True)]
    property CAMPO: string read FCODIGO write SetCODIGO;

    [campo('VALOR', tpINTEGER, 0, 0, True)]
    property VALOR: STRING read FVALOR write SetVALOR;

    [PrimaryKey('PK_AUTOINC', 'CAMPO, VALOR, TABELA')]
    [campo('TABELA', tpVARCHAR, 40, 0, True)]
    property Tabela: string read FTabela write SetTabela;
  end;

implementation

{ TAUTOINC }

procedure TAUTOINC.SetCODIGO(const Value: string);
begin
  FCODIGO := Value;
end;

procedure TAUTOINC.SetTabela(const Value: string);
begin
  FTabela := Value;
end;

procedure TAUTOINC.SetVALOR(const Value: STRING);
begin
  FVALOR := Value;
end;

end.
