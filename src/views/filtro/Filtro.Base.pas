unit Filtro.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.DB, System.Actions,
  Vcl.ActnList, JvExControls, JvNavigationPane, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.Mask, JvExMask, JvToolEdit,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Util.VclFuncoes, Sistema.TParametros;

type
  TfrmFiltroBase = class(TfrmBase)
    pnlEsquerda: TPanel;
    img2: TImage;
    img1: TImage;
    lblPesquisa: TLabel;
    lblInforme: TLabel;
    cbbPesquisa: TComboBox;
    edtValor: TEdit;
    BTN_Consultar: TBitBtn;
    chkEntreDatas: TCheckBox;
    edtDataInicial: TJvDateEdit;
    edtDataFinal: TJvDateEdit;
    dbGridResultado: TJvDBUltimGrid;
    jvPnl1: TJvNavPanelHeader;
    BTN_Voltar: TBitBtn;
    actConsulta: TActionList;
    actPesquisa: TAction;
    actVolta: TAction;
    splEsquerda: TSplitter;
    dsBase: TDataSource;
    procedure actPesquisaExecute(Sender: TObject);
    procedure actVoltaExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkEntreDatasClick(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private

  protected

    FParametros: TParametros;
    { Private declarations }
    procedure Pesquisar; virtual; abstract;
    procedure LiberaDataSource;
    procedure IncializaComponentes;
  public
    { Public declarations }
  end;

var
  frmFiltroBase: TfrmFiltroBase;

implementation

uses
  Factory.Dao, Sistema.TLog, Factory.Entidades;

{$R *.dfm}


procedure TfrmFiltroBase.actVoltaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.actVoltaExecute ');
  inherited;
  self.close;
  TLog.d('<<< Saindo de TfrmFiltroBase.actVoltaExecute ');
end;

procedure TfrmFiltroBase.chkEntreDatasClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.chkEntreDatasClick ');
  inherited;
  edtDataInicial.Enabled := chkEntreDatas.Checked;
  edtDataFinal.Enabled := chkEntreDatas.Checked;
  TLog.d('<<< Saindo de TfrmFiltroBase.chkEntreDatasClick ');
end;

procedure TfrmFiltroBase.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    actPesquisa.Execute;
end;

procedure TfrmFiltroBase.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.FormCreate ');
  inherited;
  FFactory := TFactory.new(nil, True);
  FParametros := FFactory.DaoParametros.GetParametros;
  TLog.d('<<< Saindo de TfrmFiltroBase.FormCreate ');
end;

procedure TfrmFiltroBase.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.FormDestroy ');
  inherited;
  LiberaDataSource;
  if Assigned(FParametros) then
    FreeAndNil(FParametros);
  FFactory.close;
  TLog.d('<<< Saindo de TfrmFiltroBase.FormDestroy ');
end;

procedure TfrmFiltroBase.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.FormShow ');
  inherited;
  IncializaComponentes;

  chkEntreDatas.Checked := True;
  edtDataInicial.Date := now;
  edtDataFinal.Date := now;
  cbbPesquisa.ItemIndex := 0;
  TLog.d('<<< Saindo de TfrmFiltroBase.FormShow ');
end;

procedure TfrmFiltroBase.LiberaDataSource;
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.LiberaDataSource ');
  if Assigned(dsBase.DataSet) then
  begin
    dsBase.DataSet.FreeOnRelease;
    dsBase.DataSet.Free;
    dsBase.DataSet := nil;
  end;
  TLog.d('<<< Saindo de TfrmFiltroBase.LiberaDataSource ');
end;

procedure TfrmFiltroBase.IncializaComponentes;
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.IncializaComponentes ');
  try
    TVclFuncoes.DisableVclStyles(pnlEsquerda, 'TPanel');
    TVclFuncoes.DisableVclStyles(self, 'TLabel');
    edtValor.SetFocus;
  except
  end;
  TLog.d('<<< Saindo de TfrmFiltroBase.IncializaComponentes ');
end;

procedure TfrmFiltroBase.actPesquisaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroBase.actPesquisaExecute ');
  inherited;
  try
    Pesquisar;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroBase.actPesquisaExecute ');
end;

end.
