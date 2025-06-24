unit Dao.IDAOControleCaixa;

interface

uses Dominio.Entidades.TControleCaixa;

type
  IDAOControleCaixa = interface
    ['{F8DB9D1E-E5F5-417B-974F-B92272852710}']
    function AbrirCaixa(aControle: TControleCaixa): integer;
    function FecharCaixa(aControle: TControleCaixa): integer;
    function CaixaAnterior(aNumCaixa: string): TControleCaixa;
    function CaixaAberto(aNumCaixa: string): TControleCaixa;
  end;

implementation

end.
