unit Dominio.Entidades.TTotalizadorMensal;

interface

type

  TTotalizadorMensalItem = class
  private
    FAno: Integer;
    FMes: Integer;
    FDescricao: string;
    FQuantidade: Integer;
    FTotal: Currency;
  public
    property Ano: Integer read FAno write FAno;
    property Mes: Integer read FMes write FMes;
    property Descricao: string read FDescricao write FDescricao;
    property Quantidade: Integer read FQuantidade write FQuantidade;
    property Total: Currency read FTotal write FTotal;

    constructor Create(aAno, aMes: Integer; const aDescricao: string;
      aQuantidade: Integer; aTotal: Currency);
  end;

implementation

constructor TTotalizadorMensalItem.Create(aAno, aMes: Integer;
  const aDescricao: string; aQuantidade: Integer; aTotal: Currency);
begin
  inherited Create;
  FAno := aAno;
  FMes := aMes;
  FDescricao := aDescricao;
  FQuantidade := aQuantidade;
  FTotal := aTotal;
end;

end.
