unit Consulta.Parceiro.FormaPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB, System.Actions, Vcl.ActnList, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid,
  Vcl.Buttons, JvExControls,
  JvNavigationPane, Dao.IDaoParceiro.FormaPagto, Dominio.Entidades.TParceiro.FormaPagto, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids;

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


uses Sistema.TLog;

procedure TFrmConsultaFormaPagtoParceiro.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmConsultaFormaPagtoParceiro.FormCreate ');
  inherited;
  ParceiroFormaPagto := nil;
  daoForma := FFactory.DaoParceiroFormaPagto;
  cbbPesquisa.ItemIndex := 1;
  TLog.d('<<< Saindo de TFrmConsultaFormaPagtoParceiro.FormCreate ');
end;

procedure TFrmConsultaFormaPagtoParceiro.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmConsultaFormaPagtoParceiro.FormDestroy ');
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
  TLog.d('<<< Saindo de TFrmConsultaFormaPagtoParceiro.FormDestroy ');
end;

procedure TFrmConsultaFormaPagtoParceiro.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TFrmConsultaFormaPagtoParceiro.Pesquisar ');
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
  TLog.d('<<< Saindo de TFrmConsultaFormaPagtoParceiro.Pesquisar ');
end;

procedure TFrmConsultaFormaPagtoParceiro.Selecionar;
begin
  TLog.d('>>> Entrando em  TFrmConsultaFormaPagtoParceiro.Selecionar ');
  inherited;
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FParceiroFormaPagto := daoForma.GeTParceiroFormaPagto(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);

  inherited;
  TLog.d('<<< Saindo de TFrmConsultaFormaPagtoParceiro.Selecionar ');
end;

end.
