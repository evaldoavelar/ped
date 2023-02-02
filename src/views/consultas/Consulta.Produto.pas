unit Consulta.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, Vcl.StdCtrls,
  Dao.IDaoProdutos, Dominio.Entidades.TProduto, System.Actions, Vcl.ActnList, Vcl.Grids,
  Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmConsultaProdutos = class(TfrmConsultaBase)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    daoProduto: IDaoProdutos;
    FProduto: TProduto;
  protected
    procedure Pesquisar; override;
    procedure Selecionar; override;
  public
    { Public declarations }
    property Produto: TProduto read FProduto;
  end;

var
  FrmConsultaProdutos: TFrmConsultaProdutos;

implementation

{$R *.dfm}


uses Factory.Dao, Sistema.TLog;

{ TProdutos }

procedure TFrmConsultaProdutos.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmConsultaProdutos.FormCreate ');
  inherited;
  daoProduto := fFactory.daoProduto;
  TLog.d('<<< Saindo de TFrmConsultaProdutos.FormCreate ');
end;

procedure TFrmConsultaProdutos.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmConsultaProdutos.FormShow ');
  inherited;
  cbbPesquisa.ItemIndex := 2;
  TLog.d('<<< Saindo de TFrmConsultaProdutos.FormShow ');
end;

procedure TFrmConsultaProdutos.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TFrmConsultaProdutos.Pesquisar ');
  inherited;

  case cbbPesquisa.ItemIndex of
    0:
      campo := 'CODIGO';
    1:
      campo := 'BARRAS';
    2:
      campo := 'DESCRICAO';
  else
    campo := 'CODIGO';
  end;

  dbGridResultado.DataSource.DataSet := daoProduto.Listar(campo, edtValor.Text);
  TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('PRECO_VENDA')).currency := true;
  TLog.d('<<< Saindo de TFrmConsultaProdutos.Pesquisar ');
end;

procedure TFrmConsultaProdutos.Selecionar;
begin
  TLog.d('>>> Entrando em  TFrmConsultaProdutos.Selecionar ');
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  if Assigned(FProduto) then
    FreeAndNil(FProduto);

  FProduto := daoProduto.GetProdutoPorCodigo(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;;
  TLog.d('<<< Saindo de TFrmConsultaProdutos.Selecionar ');
end;

end.
