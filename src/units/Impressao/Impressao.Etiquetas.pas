unit Impressao.Etiquetas;

interface

type

  TImpressaoEtiquetas = class
  public
  private
    FCodigo: string;
    FPeso: string;
    FHora: TDateTime;
    FDescricao: string;
    FPreco: string;
    FValidade: Tdate;
    FData: Tdate;
    procedure SetCodigo(const Value: string);
    procedure SetData(const Value: Tdate);
    procedure SetDescricao(const Value: string);
    procedure SetHora(const Value: TDateTime);
    procedure SetPeso(const Value: string);
    procedure SetPreco(const Value: string);
    procedure SetValidade(const Value: Tdate);

  public
    property Hora: TDateTime read FHora write SetHora;
    property Data: Tdate read FData write SetData;
    property Validade: Tdate read FValidade write SetValidade;
    property Peso: string read FPeso write SetPeso;
    property Codigo: string read FCodigo write SetCodigo;
    property Preco: string read FPreco write SetPreco;
    property Descricao: string read FDescricao write SetDescricao;
  end;

implementation

{ TImpressaoEtiquetas }

procedure TImpressaoEtiquetas.SetCodigo(const Value: string);
begin
  FCodigo := Value;
end;

procedure TImpressaoEtiquetas.SetData(const Value: Tdate);
begin
  FData := Value;
end;

procedure TImpressaoEtiquetas.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TImpressaoEtiquetas.SetHora(const Value: TDateTime);
begin
  FHora := Value;
end;

procedure TImpressaoEtiquetas.SetPeso(const Value: string);
begin
  FPeso := Value;
end;

procedure TImpressaoEtiquetas.SetPreco(const Value: string);
begin
  FPreco := Value;
end;

procedure TImpressaoEtiquetas.SetValidade(const Value: Tdate);
begin
  FValidade := Value;
end;

end.
