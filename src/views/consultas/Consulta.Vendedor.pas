unit Consulta.Vendedor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  Vcl.StdCtrls, JvExControls, JvNavigationPane,
  Dominio.Entidades.TFactory, Dao.IDaoVendedor, Dominio.Entidades.TVendedor, System.Actions,
  Vcl.ActnList, Vcl.Grids, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmConsultaVendedor = class(TfrmConsultaBase)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FVendededor: TVendedor;
    daoVendedor: IDaoVendedor;

    procedure Pesquisar; override;
    procedure Selecionar; override;
    { Private declarations }

  public
    { Public declarations }
    property Vendedor: TVendedor read FVendededor write FVendededor;
  end;

var
  frmConsultaVendedor: TfrmConsultaVendedor;

implementation

{$R *.dfm}


procedure TfrmConsultaVendedor.FormCreate(Sender: TObject);
begin
  inherited;
  Vendedor := nil;
  daoVendedor := TFactory.daoVendedor;
  cbbPesquisa.ItemIndex := 1;
end;

procedure TfrmConsultaVendedor.FormDestroy(Sender: TObject);
begin
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
end;

procedure TfrmConsultaVendedor.Pesquisar;
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

  dbGridResultado.DataSource.DataSet := daoVendedor.Listar(campo, edtValor.Text + '%');

  FVendededor := nil;
end;

procedure TfrmConsultaVendedor.Selecionar;
begin
  inherited;
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FVendededor := daoVendedor.GetVendedor(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;
end;

end.
