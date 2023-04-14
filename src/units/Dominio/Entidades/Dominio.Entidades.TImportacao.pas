unit Dominio.Entidades.TImportacao;

interface

uses Dominio.Entidades.TEntity, Dominio.Mapeamento.Atributos,
  Dominio.Mapeamento.Tipos;

type

  [Tabela('IMPORTACAO')]
  TImportacao = class(TEntity)
  private
    FTabela: string;
    FDATAIMPORTACAO: TDateTime;
    procedure SetDATAIMPORTACAO(const Value: TDateTime);
    procedure SetTabela(const Value: string);
  public
    [campo('TABELA', tpVARCHAR, 40)]
    property Tabela: string read FTabela write SetTabela;

    [campo('DATAIMPORTACAO', tpTIMESTAMP)]
    property DATAIMPORTACAO: TDateTime read FDATAIMPORTACAO write SetDATAIMPORTACAO;

  public

    destructor Destroy; override;
    class function NEW(aTabela: string; aDATAIMPORTACAO: TDateTime): TImportacao;
  end;

implementation

{ TImportacao }



destructor TImportacao.Destroy;
begin

  inherited;
end;

class function TImportacao.NEW(aTabela: string;
  aDATAIMPORTACAO: TDateTime): TImportacao;
begin
  result := TImportacao.create;
  result.DATAIMPORTACAO := aDATAIMPORTACAO;
  result.Tabela := aTabela;
end;

procedure TImportacao.SetDATAIMPORTACAO(const Value: TDateTime);
begin
  FDATAIMPORTACAO := Value;
end;

procedure TImportacao.SetTabela(const Value: string);
begin
  FTabela := Value;
end;

end.
