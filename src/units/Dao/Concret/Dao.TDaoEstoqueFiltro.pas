unit Dao.TDaoEstoqueFiltro;

interface

uses Dao.IDaoFiltroEstoque;

type
  TDaoEstoqueFiltro = class(TInterfacedObject, IDaoEstoqueFiltro)
  private
    FDataIncio: TDateTime;
    FDataFim: TDateTime;
    FCODIGO: string;
  public
    function setDataIncio(aData: TDateTime): IDaoEstoqueFiltro;
    function setDataFim(aData: TDateTime): IDaoEstoqueFiltro;
    function setProduto(aCODIGO: string): IDaoEstoqueFiltro;

    function getDataIncio: TDateTime;
    function getDataFim: TDateTime;
    function getProduto: string;

  public
    constructor Create();
    destructor Destroy; override;
    class function New: IDaoEstoqueFiltro;
  end;

implementation

uses
  Util.Funcoes;

{ TClasseBase }

constructor TDaoEstoqueFiltro.Create;
begin

end;

destructor TDaoEstoqueFiltro.Destroy;
begin

  inherited;
end;

function TDaoEstoqueFiltro.getDataFim: TDateTime;
begin
  Result := FDataFim
end;

function TDaoEstoqueFiltro.getDataIncio: TDateTime;
begin
  Result := FDataIncio
end;

function TDaoEstoqueFiltro.getProduto: string;
begin
  Result := FCODIGO
end;

class function TDaoEstoqueFiltro.New: IDaoEstoqueFiltro;
begin
  Result := Self.Create;

end;

function TDaoEstoqueFiltro.setDataFim(aData: TDateTime): IDaoEstoqueFiltro;
begin
  FDataFim := TUtil.ReplaceTimer(aData, 23, 59, 59, 59);
  Result := Self;
end;

function TDaoEstoqueFiltro.setDataIncio(aData: TDateTime): IDaoEstoqueFiltro;
begin
  FDataIncio := TUtil.ReplaceTimer(aData, 0, 0, 0, 1);
  Result := Self;
end;

function TDaoEstoqueFiltro.setProduto(aCODIGO: string): IDaoEstoqueFiltro;
begin
  FCODIGO := aCODIGO;
  Result := Self;
end;

end.
