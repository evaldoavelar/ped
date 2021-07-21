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


uses Dominio.Entidades.TFactory;

procedure TfrmConsultaCliente.actVoltaExecute(Sender: TObject);
begin
  if Assigned(FCliente) then
    FreeAndNil(FCliente);
  inherited;
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
  inherited;
  daoCliente := TFactory.daoCliente;
  cbbPesquisa.ItemIndex := 1;
end;

procedure TfrmConsultaCliente.FormDestroy(Sender: TObject);
begin
  if Assigned(FCliente) then
    FreeAndNil(FCliente);

  dbGridResultado.DataSource.DataSet.Free;
  inherited;
end;

procedure TfrmConsultaCliente.Pesquisar;
var
  campo: string;
begin
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
end;

procedure TfrmConsultaCliente.Selecionar;
begin

 if (dbGridResultado.DataSource.DataSet = nil) or  dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.Create('Nenhum dado para selecionar');

  if Assigned(FCliente) then
    FreeAndNil(FCliente);

  FCliente := daoCliente.GeTCliente(dbGridResultado.DataSource.DataSet.FieldByName('CODIGO').AsString);

  inherited;
end;

end.
