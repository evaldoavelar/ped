unit untFrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages,Vcl.ComCtrls, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Data.Bind.ObjectScope,
   System.Generics.Collections;

type
  TfrmBase = class(TForm)
  protected
    procedure AutoSizeCol(Grid: TListView);
    procedure LimpaListBox<T: class>(aList: TListBox);
    procedure LimpaScrollBox(aScroll: TScrollBox);
    procedure LiberaTListDoAdapter<T: class>(aAdapter: TBindSourceAdapter);
    procedure ReCenter;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBase: TfrmBase;

implementation

uses
  Utils.Rtti;

{$R *.dfm}

{ TfrmBase }


procedure TfrmBase.AutoSizeCol(Grid: TListView);
var
  I, W, WMax: Integer;
  tamanhoGrid: Integer;
  novoTamanhoColuna: Integer;
  percentColumn: Double;
begin
 // FLog.d('>>> Entrando em  TViewBase.AutoSizeCol ');
  WMax := 0;

  tamanhoGrid := Grid.Width;

  for I := 0 to (Grid.Columns.Count - 1) do
  begin
    WMax := WMax + Grid.Columns[I].Width;
  end;

  for I := 0 to (Grid.Columns.Count - 1) do
  begin
    percentColumn := (Grid.Columns[I].Width * 100) / WMax;

    novoTamanhoColuna := Round((percentColumn * tamanhoGrid) / 100);

    Grid.Column[I].Width := novoTamanhoColuna;
  end;
 // FLog.d('<<< Saindo de TViewBase.AutoSizeCol ');
end;

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

procedure TfrmBase.LiberaTListDoAdapter<T>(aAdapter: TBindSourceAdapter);
var
  Lista: TList<T>;
begin
  if Assigned(aAdapter) = False or (aAdapter is TDataGeneratorAdapter) then
    Exit;

  Lista := TListBindSourceAdapter<T>(aAdapter).List;
  TRttiUtil.ListDisposeOf<T>(Lista);
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
  // FLog.d('>>> Entrando em  TViewBase.LimpaScrollBox ');
  for I := aScroll.ControlCount - 1 downto 0 do
  Begin
    aScroll.Controls[I].free;
  End;
  // FLog.d('<<< Saindo de TViewBase.LimpaScrollBox ');
end;

end.
