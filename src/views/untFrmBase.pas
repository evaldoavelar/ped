unit untFrmBase;

interface

uses
  Winapi.Windows, Winapi.Messages, Vcl.ComCtrls, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.Bind.ObjectScope,
  System.Generics.Collections, Sistema.TParametros, IFactory.Dao;

type
  TfrmBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    FParametros: TParametros;
    FFactory: IFactoryDao;

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
  Utils.Rtti, Sistema.TLog, Factory.Dao;

{$R *.dfm}

{ TfrmBase }

procedure TfrmBase.AutoSizeCol(Grid: TListView);
var
  I, W, WMax: Integer;
  tamanhoGrid: Integer;
  novoTamanhoColuna: Integer;
  percentColumn: Double;
begin
  TLog.d('>>> Entrando em  TfrmBase.AutoSizeCol ');
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
  TLog.d('<<< Saindo de TfrmBase.AutoSizeCol ');
end;

procedure TfrmBase.ReCenter;
var
  LRect: TRect;
  X, Y: Integer;
begin
  TLog.d('>>> Entrando em  TfrmBase.ReCenter ');
  LRect := Screen.WorkAreaRect;
  X := LRect.Left + (LRect.Right - LRect.Left - Width) div 2;
  Y := LRect.Top + (LRect.Bottom - LRect.Top - Height) div 2;
  SetBounds(X, Y, Width, Height);
  TLog.d('<<< Saindo de TfrmBase.ReCenter ');
end;

procedure TfrmBase.LiberaTListDoAdapter<T>(aAdapter: TBindSourceAdapter);
var
  Lista: TList<T>;
begin
  TLog.d('>>> Entrando em  TfrmBase.LiberaTListDoAdapter<T> ');
  if Assigned(aAdapter) = False or (aAdapter is TDataGeneratorAdapter) then
    Exit;

  Lista := TListBindSourceAdapter<T>(aAdapter).List;
  TRttiUtil.ListDisposeOf<T>(Lista);
  TLog.d('<<< Saindo de TfrmBase.LiberaTListDoAdapter<T> ');
end;

procedure TfrmBase.LimpaListBox<T>(aList: TListBox);
begin
  TLog.d('>>> Entrando em  TfrmBase.LimpaListBox<T> ');
  for VAR I := aList.Items.Count - 1 downto 0 do
  Begin
    if Assigned(aList.Items.Objects[I]) then
      aList.Items.Objects[I].free;
  End;
  aList.Clear;
  TLog.d('<<< Saindo de TfrmBase.LimpaListBox<T> ');
end;

procedure TfrmBase.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmBase.FormCreate ');
  FFactory := TFactory.new(nil, True);
  TLog.d('<<< Saindo de TfrmBase.FormCreate ');
end;

procedure TfrmBase.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmBase.FormDestroy ');
  FFactory.Close;
  TLog.d('<<< Saindo de TfrmBase.FormDestroy ');
end;

procedure TfrmBase.LimpaScrollBox(aScroll: TScrollBox);
var
  I: Integer;
begin
  TLog.d('>>> Entrando em  TfrmBase.LimpaScrollBox ');

  for I := aScroll.ControlCount - 1 downto 0 do
  Begin
    aScroll.Controls[I].free;
  End;

  TLog.d('<<< Saindo de TfrmBase.LimpaScrollBox ');
end;

end.
