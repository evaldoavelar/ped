unit Dao.IDaoImportacao;

interface

uses
  Dominio.Entidades.TImportacao;

type

  IDaoImportacao = interface
    ['{D79402F0-ACA0-47D5-B5AF-0119D677AD3D}']
    procedure AtualizaDataImportacao(aImportacao: TImportacao);
    function GetUltimaImportacao(aTabela: string): TDateTime;
    function Select(aTabela: string): TImportacao;
  end;

implementation

end.
