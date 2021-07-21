unit Helper.TParcelasCliente;

interface

type
  TParcelasCliente = class
  private
    FNome: string;
    FNumParcelas: Integer;
    FTotal: Currency;
  public
    property Nome: string read FNome write FNome;
    property NumParcelas: Integer read FNumParcelas write FNumParcelas;
    property Total: Currency read FTotal write FTotal;
  end;

implementation

end.
