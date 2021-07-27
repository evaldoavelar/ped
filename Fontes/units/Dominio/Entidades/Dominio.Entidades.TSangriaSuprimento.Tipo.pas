unit Dominio.Entidades.TSangriaSuprimento.Tipo;

interface

type

  TSangriaSuprimentoTipo = (Sangria = 1, Suprimento = 2);

  TSangriaSuprimentoTipoHelper = record helper for TSangriaSuprimentoTipo
  public
    function ToString: string;
    function Descricao: string;

  end;

implementation

uses
  Utils.Rtti;

{ TSangriaSuprimentoTipoHelper }

function TSangriaSuprimentoTipoHelper.Descricao: string;
begin
  case self of
    Sangria:
      result := 'Sangria';
    Suprimento:
      result := 'Suprimento';
  end;
end;

function TSangriaSuprimentoTipoHelper.ToString: string;
begin
  result := TRttiUtil.EnumToString<TSangriaSuprimentoTipo>(self);
end;

end.
