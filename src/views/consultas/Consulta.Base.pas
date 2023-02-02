unit Consulta.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.DB, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.StdCtrls, Vcl.Buttons,
  JvExControls, JvNavigationPane, System.Actions, Vcl.ActnList, Util.VclFuncoes, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  IFactory.Dao, Sistema.TParametros;

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
    procedure FormCreate(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  protected
    FParametros: TParametros;

    procedure LiberaDataSource;
    procedure Pesquisar; virtual;
    procedure Selecionar; virtual;
    procedure IncializaComponentes;
  end;

var
  frmConsultaBase: TfrmConsultaBase;

implementation

{$R *.dfm}


uses Util.Funcoes, Sistema.TLog, Factory.Dao, Factory.Entidades;

procedure TfrmConsultaBase.Selecionar;
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.Selecionar ');
  self.close();
  TLog.d('<<< Saindo de TfrmConsultaBase.Selecionar ');
end;

procedure TfrmConsultaBase.actEscolheExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.actEscolheExecute ');
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
  TLog.d('<<< Saindo de TfrmConsultaBase.actEscolheExecute ');
end;

procedure TfrmConsultaBase.actPesquisaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.actPesquisaExecute ');
  inherited;

  try
    Pesquisar;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        edtValor.SetFocus;
      except
      end;
    end;
  end;
  TLog.d('<<< Saindo de TfrmConsultaBase.actPesquisaExecute ');
end;

procedure TfrmConsultaBase.actVoltaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.actVoltaExecute ');
  inherited;
  self.close;
  TLog.d('<<< Saindo de TfrmConsultaBase.actVoltaExecute ');
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

procedure TfrmConsultaBase.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.FormCreate ');
  inherited;
  FFactory := TFactory.new(nil, True);

  FParametros := TFactoryEntidades.Parametros;
  TLog.d('<<< Saindo de TfrmConsultaBase.FormCreate ');
end;

procedure TfrmConsultaBase.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.FormDestroy ');
  LiberaDataSource;
  FFactory.close;
  inherited;
  TLog.d('<<< Saindo de TfrmConsultaBase.FormDestroy ');
end;

procedure TfrmConsultaBase.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.FormShow ');
  inherited;
  IncializaComponentes;
  TLog.d('<<< Saindo de TfrmConsultaBase.FormShow ');
end;

procedure TfrmConsultaBase.IncializaComponentes;
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.IncializaComponentes ');
  try
    TVclFuncoes.DisableVclStyles(self, 'TLabel');
    edtValor.SetFocus;
  except
  end;
  TLog.d('<<< Saindo de TfrmConsultaBase.IncializaComponentes ');
end;

procedure TfrmConsultaBase.LiberaDataSource;
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.LiberaDataSource ');
  if Assigned(dsBase.DataSet) then
  begin
    dsBase.DataSet.FreeOnRelease;
    dsBase.DataSet.Free;
    dsBase.DataSet := nil;
  end;
  TLog.d('<<< Saindo de TfrmConsultaBase.LiberaDataSource ');
end;

procedure TfrmConsultaBase.Pesquisar;
begin
  TLog.d('>>> Entrando em  TfrmConsultaBase.Pesquisar ');
  if Trim(edtValor.Text) = '' then
    raise Exception.Create('Informe um dado para pesquisa');

  LiberaDataSource;
  TLog.d('<<< Saindo de TfrmConsultaBase.Pesquisar ');
end;

end.
