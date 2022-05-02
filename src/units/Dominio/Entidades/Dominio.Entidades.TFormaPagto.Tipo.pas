unit Dominio.Entidades.TFormaPagto.Tipo;

interface

type

  TTipoPagto = (Nenhum = 0, Dinheiro = 1, Debito = 2, Credito = 3, Outros = 4, Parcelado = 5, Pix = 6);

  TTipoPagtoHelper = record helper for TTipoPagto
  public
    function ToString: string;
    function Descricao: string;

  end;

implementation

uses
  Utils.Rtti;

{ TTipoPagtoHelper }

function TTipoPagtoHelper.Descricao: string;
begin
  case Self of
    Nenhum:
      Result := 'NENHUM';
    Dinheiro:
      Result := 'DINHEIRO';
    Debito:
      Result := 'DÉBITO';
    Credito:
      Result := 'CRÉDITO';
    Pix:
      Result := 'PIX';
    Outros:
      Result := 'OUTROS';
  end;
end;

function TTipoPagtoHelper.ToString: string;
begin
  Result := TRttiUtil.EnumToString<TTipoPagto>(Self);

end;

end.
