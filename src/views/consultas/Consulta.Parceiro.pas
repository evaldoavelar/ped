unit Consulta.Parceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.StdCtrls,
  Vcl.Buttons, JvExControls,
  JvNavigationPane, Dominio.Entidades.TParceiro, Dominio.Entidades.TFactory,
  Dao.IDaoParceiro, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmConsultaParceiro = class(TfrmConsultaBase)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    FParceiro: TParceiro;
    function getParceiro: TParceiro;
  private

    daoParceiro: IDaoParceiro;

    procedure Pesquisar; override;
    procedure Selecionar; override;
    { Private declarations }
  public
    { Public declarations }
    property Parceiro: TParceiro read getParceiro;
  end;

var
  frmConsultaParceiro: TfrmConsultaParceiro;

implementation

{$R *.dfm}

{ TfrmConsultaParceiro }

procedure TfrmConsultaParceiro.dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if dbGridResultado.DataSource.DataSet.FieldByName('INATIVO').AsInteger = 1 then
  begin
    dbGridResultado.Canvas.Font.Color := clWhite;
    dbGridResultado.Canvas.Brush.Color := $000D1CB8;
  end;

  dbGridResultado.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmConsultaParceiro.FormCreate(Sender: TObject);
begin
  inherited;
  FParceiro := nil;
  daoParceiro := TFactory.daoParceiro;
  cbbPesquisa.ItemIndex := 1;
end;

procedure TfrmConsultaParceiro.FormDestroy(Sender: TObject);
begin
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
end;

procedure TfrmConsultaParceiro.Pesquisar;
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

  dbGridResultado.DataSource.DataSet := daoParceiro.Listar(campo, edtValor.Text + '%');

  FParceiro := nil;
end;

procedure TfrmConsultaParceiro.Selecionar;
begin

  if (dbGridResultado.DataSource.DataSet = nil) or  dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FParceiro := daoParceiro.getParceiro(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;
end;

function TfrmConsultaParceiro.getParceiro: TParceiro;
begin
  result := FParceiro;
end;

end.
