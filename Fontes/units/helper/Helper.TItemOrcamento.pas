unit Helper.TItemOrcamento;

interface

uses
System.SysUtils,
 Dominio.Entidades.TItemOrcamento;

type
  TItemOrcamentoHelper = class helper for TItemOrcamento
  private
    function getValorBrutoCur: string;
    function getValorLiquidoCur: string;
    function getValorUnitarioCur: string;
    function getValorDescontoCur: string;
  public
    property VALORBRUTOCUR: string read getValorBrutoCur;
    property VALORUNITATOCUR: string read getValorUnitarioCur;
    property VALORLIQUIDOTOCUR: string read getValorLiquidoCur;
    property VALORDESCONTOTOCUR: string read getValorDescontoCur;
  end;

implementation

function TItemOrcamentoHelper.getValorDescontoCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_DESCONTO);
end;

function TItemOrcamentoHelper.getValorBrutoCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_BRUTO);
end;

function TItemOrcamentoHelper.getValorLiquidoCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_LIQUIDO);
end;

function TItemOrcamentoHelper.getValorUnitarioCur: string;
begin
  result := FormatCurr('R$ 0.,00', Self.VALOR_UNITA);
end;

end.
