unit Consulta.Parceiro.FormaPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.StdCtrls,
  Vcl.Buttons, JvExControls,
  JvNavigationPane, Dao.IDaoParceiro.FormaPagto, Dominio.Entidades.TParceiro.FormaPagto, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmConsultaFormaPagtoParceiro = class(TfrmConsultaBase)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  private
    FParceiroFormaPagto: TParceiroFormaPagto;
    daoForma: IDaoParceiroFormaPagto;
  protected
    procedure Pesquisar; override;
    procedure Selecionar; override;
    { Private declarations }
  public
    { Public declarations }
    property ParceiroFormaPagto: TParceiroFormaPagto read FParceiroFormaPagto write FParceiroFormaPagto;
  end;

var
  FrmConsultaFormaPagtoParceiro: TFrmConsultaFormaPagtoParceiro;

implementation

{$R *.dfm}


uses Dominio.Entidades.TFactory;

procedure TFrmConsultaFormaPagtoParceiro.FormCreate(Sender: TObject);
begin
  inherited;
  ParceiroFormaPagto := nil;
  daoForma := TFactory.DaoParceiroFormaPagto;
  cbbPesquisa.ItemIndex := 1;
end;

procedure TFrmConsultaFormaPagtoParceiro.FormDestroy(Sender: TObject);
begin
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
end;

procedure TFrmConsultaFormaPagtoParceiro.Pesquisar;
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

  ParceiroFormaPagto := nil;
end;

procedure TFrmConsultaFormaPagtoParceiro.Selecionar;
begin
  inherited;
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FParceiroFormaPagto := daoForma.GeTParceiroFormaPagto(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);

  inherited;
end;

end.
