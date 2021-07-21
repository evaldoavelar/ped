unit Consulta.FormaPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Consulta.Base, Data.DB, Vcl.DBGrids,
  Vcl.StdCtrls,
  Dao.IDaoFormaPagto, Dominio.Entidades.TFormaPagto, System.Actions, Vcl.ActnList, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Grids, JvExDBGrids, JvDBGrid, JvDBUltimGrid;

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


uses Dominio.Entidades.TFactory;

procedure TfrmConsultaFormaPagto.FormCreate(Sender: TObject);
begin
  inherited;
  FormaPagto := nil;
  daoForma := TFactory.DaoFormaPagto;
  cbbPesquisa.ItemIndex := 1;
end;

procedure TfrmConsultaFormaPagto.FormDestroy(Sender: TObject);
begin
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
end;

procedure TfrmConsultaFormaPagto.Pesquisar;
var
  campo: string;
begin
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
end;

procedure TfrmConsultaFormaPagto.Selecionar;
begin
  inherited;
if (dbGridResultado.DataSource.DataSet = nil) or  dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FFormaPagto := daoForma.GeTFormaPagto(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);

  inherited;
end;

end.
