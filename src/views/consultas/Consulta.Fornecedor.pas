unit Consulta.Fornecedor;

interface

uses

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  JvExControls, JvNavigationPane,
  Dao.IDaoFornecedor, Dominio.Entidades.TFornecedor, System.Actions, Vcl.ActnList,
  Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids;

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


uses Sistema.TLog;

procedure TfrmConsultaFornecedor.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaFornecedor.FormCreate ');
  inherited;
  Fornecedor := nil;
  DaoFornecedor := fFactory.DaoFornecedor;
  cbbPesquisa.ItemIndex := 1;
  TLog.d('<<< Saindo de TfrmConsultaFornecedor.FormCreate ');
end;

procedure TfrmConsultaFornecedor.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaFornecedor.FormDestroy ');
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
  TLog.d('<<< Saindo de TfrmConsultaFornecedor.FormDestroy ');
end;

procedure TfrmConsultaFornecedor.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TfrmConsultaFornecedor.Pesquisar ');
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
  TLog.d('<<< Saindo de TfrmConsultaFornecedor.Pesquisar ');
end;

procedure TfrmConsultaFornecedor.Selecionar;
begin
  TLog.d('>>> Entrando em  TfrmConsultaFornecedor.Selecionar ');
  inherited;
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FFornecedor := DaoFornecedor.GeFornecedor(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;
  TLog.d('<<< Saindo de TfrmConsultaFornecedor.Selecionar ');
end;

end.
