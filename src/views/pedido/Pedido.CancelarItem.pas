unit Pedido.CancelarItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ActnList, Vcl.Buttons, System.Actions, Vcl.Imaging.jpeg, Util.VclFuncoes;

type
  TFrmCancelarItem = class(TForm)
    Label1: TLabel;
    Image2: TImage;
    ActionList1: TActionList;
    actOk: TAction;
    actCancelar: TAction;
    Panel1: TPanel;
    edtItem: TEdit;
    Panel2: TPanel;
    btnOk: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edtItemEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure edtItemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FNumItem: Integer;
  public
    { Public declarations }
    property NumItem: Integer read FNumItem;
  end;

var
  FrmCancelarItem: TFrmCancelarItem;

implementation

{$R *.dfm}




procedure TFrmCancelarItem.actCancelarExecute(Sender: TObject);
begin
  close;
end;

procedure TFrmCancelarItem.actOkExecute(Sender: TObject);
begin
  FNumItem := StrToIntDef(edtItem.Text, 0);
  self.close;
end;

procedure TFrmCancelarItem.edtItemEnter(Sender: TObject);
begin
  edtItem.SelectAll;
end;

procedure TFrmCancelarItem.edtItemKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnOk.SetFocus;
end;

procedure TFrmCancelarItem.FormCreate(Sender: TObject);
begin
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
  TVclFuncoes.DisableVclStyles(self, 'TEdit');
  FNumItem := 0;
end;

procedure TFrmCancelarItem.FormShow(Sender: TObject);
begin
  try
    edtItem.SetFocus;
  except
  end;
end;

end.
