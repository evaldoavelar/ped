unit Consulta.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.StdCtrls, Vcl.Buttons,
  JvExControls, JvNavigationPane, System.Actions, Vcl.ActnList, Util.VclFuncoes, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmConsultaBase = class(TfrmBase)
    dbGridResultado: TJvDBUltimGrid;
    actConsulta: TActionList;
    actPesquisa: TAction;
    actEscolhe: TAction;
    actVolta: TAction;
    dsBase: TDataSource;
    jvPnl1: TPanel;
    lblPesquisa: TLabel;
    lblValor: TLabel;
    Image1: TImage;
    BTN_Consultar: TBitBtn;
    BTN_Incluir: TBitBtn;
    BTN_Voltar: TBitBtn;
    edtValor: TEdit;
    cbbPesquisa: TComboBox;
    procedure actPesquisaExecute(Sender: TObject);
    procedure actEscolheExecute(Sender: TObject);
    procedure actVoltaExecute(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure dbGridResultadoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  protected
    procedure LiberaDataSource;
    procedure Pesquisar; virtual;
    procedure Selecionar; virtual;
    procedure IncializaComponentes;
  end;

var
  frmConsultaBase: TfrmConsultaBase;

implementation

{$R *.dfm}


uses Util.Funcoes;

procedure TfrmConsultaBase.Selecionar;
begin
  self.close();
end;

procedure TfrmConsultaBase.actEscolheExecute(Sender: TObject);
begin
  inherited;
  try
    Selecionar();
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        edtValor.SetFocus;
      except
      end;
    end;
  end;

end;

procedure TfrmConsultaBase.actPesquisaExecute(Sender: TObject);
begin
  inherited;

  try
    Pesquisar;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        edtValor.SetFocus;
      except
      end;
    end;
  end;
end;

procedure TfrmConsultaBase.actVoltaExecute(Sender: TObject);
begin
  inherited;
  self.close;
end;

procedure TfrmConsultaBase.dbGridResultadoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Selecionar();
  end;
end;

procedure TfrmConsultaBase.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    Pesquisar;
    if not dbGridResultado.DataSource.DataSet.IsEmpty then
    begin
      try
        dbGridResultado.SetFocus;
      except
      end;
    end;
  end;
end;

procedure TfrmConsultaBase.FormDestroy(Sender: TObject);
begin
  LiberaDataSource;
  inherited;
end;

procedure TfrmConsultaBase.FormShow(Sender: TObject);
begin
  inherited;
  IncializaComponentes;
end;

procedure TfrmConsultaBase.IncializaComponentes;
begin
  try
    TVclFuncoes.DisableVclStyles(self, 'TLabel');
    edtValor.SetFocus;
  except
  end;
end;

procedure TfrmConsultaBase.LiberaDataSource;
begin
  if Assigned(dsBase.DataSet) then
  begin
    dsBase.DataSet.FreeOnRelease;
    dsBase.DataSet.Free;
    dsBase.DataSet := nil;
  end;
end;

procedure TfrmConsultaBase.Pesquisar;
begin
  if Trim(edtValor.Text) = '' then
    raise Exception.Create('Informe um dado para pesquisa');

  LiberaDataSource;
end;

end.
