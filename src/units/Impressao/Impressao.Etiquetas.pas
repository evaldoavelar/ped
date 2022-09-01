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
    FContem: string;
    FObservacao: string;
    FContemDescricao: string;
    FImprimirValidade: boolean;
    procedure SetCodigo(const Value: string);
    procedure SetData(const Value: Tdate);
    procedure SetDescricao(const Value: string);
    procedure SetHora(const Value: TDateTime);
    procedure SetPeso(const Value: string);
    procedure SetPreco(const Value: string);
    procedure SetValidade(const Value: Tdate);
    procedure SetContem(const Value: string);
    procedure SetContemDescricao(const Value: string);
    procedure SetObservacao(const Value: string);
    procedure SetImprimirValidade(const Value: boolean);

  public
    property Hora: TDateTime read FHora write SetHora;
    property Data: Tdate read FData write SetData;
    property Validade: Tdate read FValidade write SetValidade;
    property Peso: string read FPeso write SetPeso;
    property Codigo: string read FCodigo write SetCodigo;
    property Preco: string read FPreco write SetPreco;
    property Descricao: string read FDescricao write SetDescricao;
    property Contem: string read FContem write SetContem;
    property ContemDescricao: string read FContemDescricao write SetContemDescricao;
    property Observacao: string read FObservacao write SetObservacao;
    property ImprimirValidade: boolean read FImprimirValidade write SetImprimirValidade;
  end;

implementation

{ TImpressaoEtiquetas }

procedure TImpressaoEtiquetas.SetCodigo(const Value: string);
begin
  FCodigo := Value;
end;

procedure TImpressaoEtiquetas.SetContem(const Value: string);
begin
  FContem := Value;
end;

procedure TImpressaoEtiquetas.SetContemDescricao(const Value: string);
begin
  FContemDescricao := Value;
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

procedure TImpressaoEtiquetas.SetImprimirValidade(const Value: boolean);
begin
  FImprimirValidade := Value;
end;

procedure TImpressaoEtiquetas.SetObservacao(const Value: string);
begin
  FObservacao := Value;
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
