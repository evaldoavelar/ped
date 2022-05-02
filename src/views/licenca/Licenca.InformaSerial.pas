unit Licenca.InformaSerial;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.jpeg, Vcl.ExtCtrls;

type
  TFrmInformaSerial = class(TfrmBase)
    Image1: TImage;
    lblPedidos: TLabel;
    edtSerial1: TEdit;
    Label1: TLabel;
    edtSerial2: TEdit;
    Label2: TLabel;
    edtSerial3: TEdit;
    btn1: TBitBtn;
    BitBtn1: TBitBtn;
    procedure edtSerial1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInformaSerial: TFrmInformaSerial;

implementation

{$R *.dfm}

procedure TFrmInformaSerial.edtSerial1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Length(TEdit(Sender).Text) = 6 then
    Perform(CM_DIALOGKEY, VK_TAB, 0);
end;

end.
