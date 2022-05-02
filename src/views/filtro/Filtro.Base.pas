unit Filtro.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.DB, System.Actions,
  Vcl.ActnList, JvExControls, JvNavigationPane, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.Mask, JvExMask, JvToolEdit,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Util.VclFuncoes;

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
  private

  protected
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
  Util.Funcoes;

{$R *.dfm}


procedure TfrmFiltroBase.actVoltaExecute(Sender: TObject);
begin
  inherited;
  self.close;
end;

procedure TfrmFiltroBase.chkEntreDatasClick(Sender: TObject);
begin
  inherited;
  edtDataInicial.Enabled := chkEntreDatas.Checked;
  edtDataFinal.Enabled := chkEntreDatas.Checked;
end;

procedure TfrmFiltroBase.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if key = #13 then
    actPesquisa.Execute;
end;

procedure TfrmFiltroBase.FormDestroy(Sender: TObject);
begin
  inherited;
  LiberaDataSource;
end;

procedure TfrmFiltroBase.FormShow(Sender: TObject);
begin
  inherited;
  IncializaComponentes;

  chkEntreDatas.Checked := true;
  edtDataInicial.Date := now;
  edtDataFinal.Date := now;
  cbbPesquisa.ItemIndex := 0;

end;

procedure TfrmFiltroBase.LiberaDataSource;
begin
  if Assigned(dsBase.DataSet) then
  begin
    dsBase.DataSet.FreeOnRelease;
    dsBase.DataSet.Free;
    dsBase.DataSet := nil;
  end;
end;

procedure TfrmFiltroBase.IncializaComponentes;
begin
  try
    TVclFuncoes.DisableVclStyles(pnlEsquerda, 'TPanel');
    TVclFuncoes.DisableVclStyles(self, 'TLabel');
    edtValor.SetFocus;
  except
  end;
end;

procedure TfrmFiltroBase.actPesquisaExecute(Sender: TObject);
begin
  inherited;
  try
    Pesquisar;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

end.
