unit Splash.Form;

interface

uses
  system.Threading, System.SyncObjs,
  Winapi.Windows, Winapi.Messages, system.SysUtils, system.Variants, system.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.Samples.Gauges;

type
  TfrmSplash = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    pbSplash: TGauge;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AfterTest;
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}


procedure TfrmSplash.AfterTest;
begin
  Close;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
   pbSplash.MaxValue := 100;


  TTask.Run(
    procedure
    var
      processed: integer; // shared counter
      total: integer; // total number of items to be processed
    begin
      processed := 0;
      total := 1000;
      TParallel.For(1, 1000,
        procedure(i: integer)
        var
          new: integer;
        begin
          Sleep(10); // do the work
          new := TInterlocked.Increment(processed); // increment the shared counter
          if (new mod 10) = 0 then
          TThread.Queue(nil,
            procedure
            begin
              // update the progress bar in the main thread
              pbSplash.Progress := Round(new / total * 100);
            end
            ); // TThread.Queue
        end
        ); // TParallel.For

      // Update the UI
      TThread.Queue(nil, AfterTest);
    end
    ); // TTask.Run

end;

end.
