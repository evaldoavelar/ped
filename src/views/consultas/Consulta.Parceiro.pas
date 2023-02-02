unit Consulta.Parceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB, System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.StdCtrls,
  Vcl.Buttons, JvExControls,
  JvNavigationPane, Dominio.Entidades.TParceiro, Factory.Dao,
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

uses
  Sistema.TLog;

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
  TLog.d('>>> Entrando em  TfrmConsultaParceiro.FormCreate ');
  inherited;
  FParceiro := nil;
  daoParceiro := fFactory.daoParceiro;
  cbbPesquisa.ItemIndex := 1;
  TLog.d('<<< Saindo de TfrmConsultaParceiro.FormCreate ');
end;

procedure TfrmConsultaParceiro.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaParceiro.FormDestroy ');
  inherited;
  dbGridResultado.DataSource.DataSet.Free;
  TLog.d('<<< Saindo de TfrmConsultaParceiro.FormDestroy ');
end;

procedure TfrmConsultaParceiro.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TfrmConsultaParceiro.Pesquisar ');
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
  TLog.d('<<< Saindo de TfrmConsultaParceiro.Pesquisar ');
end;

procedure TfrmConsultaParceiro.Selecionar;
begin
  TLog.d('>>> Entrando em  TfrmConsultaParceiro.Selecionar ');
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  FParceiro := daoParceiro.getParceiro(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;
  TLog.d('<<< Saindo de TfrmConsultaParceiro.Selecionar ');
end;

function TfrmConsultaParceiro.getParceiro: TParceiro;
begin
  result := FParceiro;
end;

end.
