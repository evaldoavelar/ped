unit Dao.IDaoOrcamento;

interface



uses
  System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Data.DB,
  Sistema.TLog,
  Dominio.Entidades.TItemOrcamento, Dominio.Entidades.TOrcamento;

type

  IDaoOrcamento = interface
   ['{29DDE77A-0EDF-4991-8E52-407203707205}']
    procedure AbreOrcamento(Orcamento: TOrcamento);
    procedure VendeItem(Item: TItemOrcamento);
    procedure ExcluiItem(Item: TItemOrcamento);
    procedure AtualizaOrcamento(Orcamento: TOrcamento);
    procedure AtualizaStatus(Orcamento: TOrcamento);
    procedure FinalizaOrcamento(Orcamento: TOrcamento);
    function getOrcamento(id: Integer): TOrcamento;
    function GeraID: Integer;
    function Listar(campo, valor: string; dataInicio, dataFim: TDate): TDataSet; overload;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(dataInicio, dataFim: TDate): TDataSet; overload;

    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;

  end;
implementation

end.
