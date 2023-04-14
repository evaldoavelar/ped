unit Consulta.FormaPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Consulta.Base, Data.DB, Vcl.DBGrids,

  Dao.IDaoFormaPagto, Dominio.Entidades.TFormaPagto, System.Actions, Vcl.ActnList, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  Vcl.StdCtrls, Vcl.Grids;

type
  TfrmConsultaFormaPagto = class(TfrmConsultaBase)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FFormaPagto: TFormaPagto;
    daoForma: IDaoFormaPagto;
  protected
    procedure Pesquisar; override;
    procedure Selecionar; override;
    { Private declarations }
  public
    { Public declarations }
    property FormaPagto: TFormaPagto read FFormaPagto write FFormaPagto;
  end;

var
  frmConsultaFormaPagto: TfrmConsultaFormaPagto;

implementation

{$R *.dfm}


uses Sistema.TLog;

procedure TfrmConsultaFormaPagto.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaFormaPagto.FormCreate ');
  inherited;
  FormaPagto := nil;
  daoForma := fFactory.DaoFormaPagto;
  cbbPesquisa.ItemIndex := 1;
  TLog.d('<<< Saindo de TfrmConsultaFormaPagto.FormCreate ');
end;

procedure TfrmConsultaFormaPagto.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaFormaPagto.FormDestroy ');
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
  TLog.d('<<< Saindo de TfrmConsultaFormaPagto.FormDestroy ');
end;

procedure TfrmConsultaFormaPagto.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TfrmConsultaFormaPagto.Pesquisar ');
  inherited;
  case cbbPesquisa.ItemIndex of
    0:
      campo := 'ID';
    1:
      campo := 'DESCRICAO';

  else
    campo := 'DESCRICAO';
  end;

  dbGridResultado.DataSource.DataSet := daoForma.Listar(campo, edtValor.Text + '%');

  FormaPagto := nil;
  TLog.d('<<< Saindo de TfrmConsultaFormaPagto.Pesquisar ');
end;

procedure TfrmConsultaFormaPagto.Selecionar;
begin
  TLog.d('>>> Entrando em  TfrmConsultaFormaPagto.Selecionar ');
  inherited;
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FFormaPagto := daoForma.GeTFormaPagto(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);

  inherited;
  TLog.d('<<< Saindo de TfrmConsultaFormaPagto.Selecionar ');
end;

end.
