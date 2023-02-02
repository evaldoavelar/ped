unit Consulta.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Consulta.Base, Data.DB,
  System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, Vcl.StdCtrls, Vcl.Buttons, JvExControls, JvNavigationPane,
  Dao.IDaoCliente, Dominio.Entidades.TCliente, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmConsultaCliente = class(TfrmConsultaBase)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actVoltaExecute(Sender: TObject);
    procedure dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    daoCliente: IDaoCliente;
    FCliente: TCliente;
  protected
    procedure Pesquisar; override;
    procedure Selecionar; override;
  public
    { Public declarations }
    property Cliente: TCliente read FCliente;
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

{$R *.dfm}


uses Factory.Dao, Sistema.TLog;

procedure TfrmConsultaCliente.actVoltaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaCliente.actVoltaExecute ');
  if Assigned(FCliente) then
    FreeAndNil(FCliente);
  inherited;
  TLog.d('<<< Saindo de TfrmConsultaCliente.actVoltaExecute ');
end;

procedure TfrmConsultaCliente.dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;

  if dbGridResultado.DataSource.DataSet.FieldByName('BLOQUEADO').AsInteger = 1 then
  begin
    dbGridResultado.Canvas.Font.Color := clWhite;
    dbGridResultado.Canvas.Brush.Color := $000D1CB8;
  end;

  dbGridResultado.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmConsultaCliente.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaCliente.FormCreate ');
  inherited;
  daoCliente := TFactory
    .new
    .daoCliente;

  cbbPesquisa.ItemIndex := 1;
  TLog.d('<<< Saindo de TfrmConsultaCliente.FormCreate ');
end;

procedure TfrmConsultaCliente.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaCliente.FormDestroy ');
  if Assigned(FCliente) then
    FreeAndNil(FCliente);

 // dbGridResultado.DataSource.DataSet.Free;
  inherited;
  TLog.d('<<< Saindo de TfrmConsultaCliente.FormDestroy ');
end;

procedure TfrmConsultaCliente.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TfrmConsultaCliente.Pesquisar ');
  inherited;
  case cbbPesquisa.ItemIndex of
    0:
      campo := 'CODIGO';
    1:
      campo := 'NOME';
    2:
      campo := 'CNPJ_CNPF';
  else
    campo := 'NOME';
  end;

  dbGridResultado.DataSource.DataSet := daoCliente.Listar(campo, edtValor.Text + '%');

  FCliente := nil;
  TLog.d('<<< Saindo de TfrmConsultaCliente.Pesquisar ');
end;

procedure TfrmConsultaCliente.Selecionar;
begin
  TLog.d('>>> Entrando em  TfrmConsultaCliente.Selecionar ');

  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  if Assigned(FCliente) then
    FreeAndNil(FCliente);

  FCliente := daoCliente.GeTCliente(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;
  TLog.d('<<< Saindo de TfrmConsultaCliente.Selecionar ');
end;

end.
