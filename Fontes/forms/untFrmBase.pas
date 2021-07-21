unit untFrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TfrmBase = class(TForm)
  protected
    procedure ReCenter;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

{$R *.dfm}

{ TfrmBase }

procedure TfrmBase.ReCenter;
var
  LRect: TRect;
  X, Y: Integer;
begin
  LRect := Screen.WorkAreaRect;
  X := LRect.Left + (LRect.Right - LRect.Left - Width) div 2;
  Y := LRect.Top + (LRect.Bottom - LRect.Top - Height) div 2;
  SetBounds(X, Y, Width, Height);
end;

end.
