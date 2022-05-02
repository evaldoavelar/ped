unit Consulta.Fornecedor;

interface

uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  Vcl.StdCtrls, JvExControls, JvNavigationPane,
  Dao.IDaoFornecedor, Dominio.Entidades.TFornecedor, System.Actions, Vcl.ActnList,
  Vcl.Grids, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmConsultaFornecedor = class(TfrmConsultaBase)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FFornecedor: TFornecedor;
    DaoFornecedor: IDaoFornecedor;
    procedure Pesquisar; override;
    procedure Selecionar; override;
    { Private declarations }
  public
    { Public declarations }
    property Fornecedor: TFornecedor read FFornecedor write FFornecedor;
  end;

var
  frmConsultaFornecedor: TfrmConsultaFornecedor;

implementation

{$R *.dfm}


uses Dominio.Entidades.TFactory;

procedure TfrmConsultaFornecedor.FormCreate(Sender: TObject);
begin
  inherited;
  Fornecedor := nil;
  DaoFornecedor := TFactory.DaoFornecedor;
  cbbPesquisa.ItemIndex := 1;
end;

procedure TfrmConsultaFornecedor.FormDestroy(Sender: TObject);
begin
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
end;

procedure TfrmConsultaFornecedor.Pesquisar;
var
  campo: string;
begin
  inherited;
  case cbbPesquisa.ItemIndex of
    0:
      campo := 'CODIGO';
    1:
      campo := 'NOME';

  else
    campo := 'NOME';
  end;

  dbGridResultado.DataSource.DataSet := DaoFornecedor.Listar(campo, edtValor.Text + '%');

  Fornecedor := nil;
end;

procedure TfrmConsultaFornecedor.Selecionar;
begin
  inherited;
if (dbGridResultado.DataSource.DataSet = nil) or  dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FFornecedor := DaoFornecedor.GeFornecedor(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;
end;

end.
