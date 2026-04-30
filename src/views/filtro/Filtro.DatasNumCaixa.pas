unit Filtro.DatasNumCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Filtro.Datas, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TfrmFiltroDatasNumCaixa = class(TfrmFiltroDatas)
    Label2: TLabel;
    cbbNumeroDoCaixa: TComboBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroDatasNumCaixa: TfrmFiltroDatasNumCaixa;

implementation

{$R *.dfm}


uses Sistema.TLog, Factory.Dao;

procedure TfrmFiltroDatasNumCaixa.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroDatasNumCaixa.FormCreate ');
  try
    inherited;

    cbbNumeroDoCaixa.Clear;

    var
    caixas := TFactory.new(nil, false)
      .DaoPedido
      .ListaCaixas;

    cbbNumeroDoCaixa.Items.Add('Todos os Caixas');
    cbbNumeroDoCaixa.Items.AddStrings(caixas);
    cbbNumeroDoCaixa.ItemIndex := 0;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroDatasNumCaixa.FormCreate ');
end;

end.
