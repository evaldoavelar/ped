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


uses Dominio.Entidades.TFactory;

{ TProdutos }

procedure TFrmConsultaProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  daoProduto := TFactory.daoProduto;
end;

procedure TFrmConsultaProdutos.FormShow(Sender: TObject);
begin
  inherited;
  cbbPesquisa.ItemIndex := 2;
end;

procedure TFrmConsultaProdutos.Pesquisar;
var
  campo: string;
begin
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

  dbGridResultado.DataSource.DataSet := daoProduto.Listar(campo, edtValor.Text );
  TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('PRECO_VENDA')).currency := true;

end;

procedure TFrmConsultaProdutos.Selecionar;
begin
if (dbGridResultado.DataSource.DataSet = nil) or  dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  if Assigned(FProduto) then
    FreeAndNil(FProduto);

  FProduto := daoProduto.GetProdutoPorCodigo(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;;

end;

end.
