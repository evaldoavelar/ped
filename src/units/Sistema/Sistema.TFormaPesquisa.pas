unit Sistema.TFormaPesquisa;

interface


type

  TFormaPesquisa = (FDescricao,FLeitor);

  TFormaPesquisaHelp = record helper for TFormaPesquisa

  private
    function getForma: Integer;
    procedure setForma(const Value: Integer);
  public
    property Forma: Integer read getForma write setForma;
  end;

implementation

{ TFormaPesquisaHelp }

function TFormaPesquisaHelp.getForma: Integer;
begin
   result := Ord(self)
end;

procedure TFormaPesquisaHelp.setForma(const Value: Integer);
begin
   self := TFormaPesquisa(value);
end;

end.
