unit Helper.TProdutoVenda;

interface

type

  TProdutoVenda = class
  private
    FDescricao: string;
    FTotal: Currency;
    FQuantidade: Double;
    function getQuantidade: Double;
    procedure setQuantidade(const Value: Double);
    procedure SetDescricao(const Value: string);
    procedure SetTotal(const Value: Currency);
  public

    property Quantidade: Double read getQuantidade write setQuantidade;
    property Total: Currency read FTotal write SetTotal;
    property Descricao: string read FDescricao write SetDescricao;

    constructor Create(AQuantidade: Double; ATotal: Currency; ADescricao: string);
  end;

implementation

{ TProdutoVenda }

constructor TProdutoVenda.Create(AQuantidade: Double; ATotal: Currency; ADescricao: string);
begin
   Self.Descricao := ADescricao;
   Self.Quantidade := AQuantidade;
   Self.Total := ATotal;
end;

function TProdutoVenda.getQuantidade: Double;
begin
  result := FQuantidade;
end;

procedure TProdutoVenda.SetDescricao(const Value: string);
begin
  FDescricao := Value;
end;

procedure TProdutoVenda.setQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TProdutoVenda.SetTotal(const Value: Currency);
begin
  FTotal := Value;
end;

end.
