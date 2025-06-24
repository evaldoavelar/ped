unit Filtro.Datas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit,
  Vcl.Imaging.jpeg;

type
  TfrmFiltroDatas = class(TfrmBase)
    pnl1: TPanel;
    pnl2: TPanel;
    btnImprimir: TBitBtn;
    act1: TActionList;
    actImprimir: TAction;
    actCancelar: TAction;
    btnCancelar: TBitBtn;
    lbl1: TLabel;
    Label1: TLabel;
    edtDataIncio: TJvDateEdit;
    edtDataFim: TJvDateEdit;
    btnMes: TSpeedButton;
    btnSemana: TSpeedButton;
    actSemana: TAction;
    actMes: TAction;
    img1: TImage;
    Image1: TImage;
    img2: TImage;
    procedure actSemanaExecute(Sender: TObject);
    procedure actMesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }

  end;

var
  frmFiltroDatas: TfrmFiltroDatas;

implementation

{$R *.dfm}


uses Util.Funcoes, sistema.TLog;

procedure TfrmFiltroDatas.actMesExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroDatas.actMesExecute ');
  inherited;
  edtDataFim.Date := TUtil.LastDayOfMonth(Date);
  edtDataIncio.Date := TUtil.FirstDayOfMonth(Date);
  TLog.d('<<< Saindo de TfrmFiltroDatas.actMesExecute ');
end;

procedure TfrmFiltroDatas.actSemanaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroDatas.actSemanaExecute ');
  inherited;
  edtDataIncio.Date := TUtil.FirstDayOfWeek(Date);
  edtDataFim.Date := TUtil.LastDayOfWeek(Date);
  TLog.d('<<< Saindo de TfrmFiltroDatas.actSemanaExecute ');
end;

procedure TfrmFiltroDatas.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroDatas.FormShow ');
  inherited;
  edtDataIncio.Date := Now;
  var
  LDataFim := Now;
  TUtil.ReplaceTimer(LDataFim, 23, 59, 59, 0);
  edtDataFim.Date := LDataFim;

  TLog.d('<<< Saindo de TfrmFiltroDatas.FormShow ');
end;

end.
