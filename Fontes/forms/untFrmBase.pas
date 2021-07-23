unit untFrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmBase = class(TForm)
  protected
    procedure LimpaListBox<T>(aList: TListBox);
    procedure LimpaScrollBox(aScroll: TScrollBox);

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

procedure TfrmBase.LimpaListBox<T>(aList: TListBox);
begin
  for VAR I := aList.Items.Count - 1 downto 0 do
  Begin
    if Assigned(aList.Items.Objects[I]) then
      aList.Items.Objects[I].free;
  End;
  aList.Clear;
end;

procedure TfrmBase.LimpaScrollBox(aScroll: TScrollBox);
var
  I: Integer;
begin
  //FLog.d('>>> Entrando em  TViewBase.LimpaScrollBox ');
  for I := aScroll.ControlCount - 1 downto 0 do
  Begin
    aScroll.Controls[I].free;
  End;
 // FLog.d('<<< Saindo de TViewBase.LimpaScrollBox ');
end;

end.
