unit Splash.Form;

interface

uses
  system.Threading, system.SyncObjs,
  Winapi.Windows, Winapi.Messages, system.SysUtils, system.Variants, system.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.pngimage, Vcl.Samples.Gauges, Filtro.Cliente, IFactory.Dao;

type
  TfrmSplash = class(TForm)
    pnl1: TPanel;
    img1: TImage;
    pbSplash: TGauge;
    Image2: TImage;
    procedure FormShow(Sender: TObject);
  private
    FConfigurarDataBase: boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure AfterTest;
    property ConfigurarDataBase: boolean read FConfigurarDataBase write FConfigurarDataBase;
  end;

var
  frmSplash: TfrmSplash;

implementation

uses
  Factory.Dao, Util.Thread, Sistema.TLog;

{$R *.dfm}


procedure TfrmSplash.AfterTest;
begin
  Close;
end;

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  TThreadUtil.Executar(
    // Exception
    procedure(e: Exception)
    begin
      TLog.d(e.Message);
    end,
  // Antes de Execultar
    procedure()
    begin
      pbSplash.MaxValue := 100;
      pbSplash.Progress := 0;
      FConfigurarDataBase := false;
    end,
  // Execultar
    procedure()
    var
      total: integer;
      I: integer; // total number of items to be processed
      LFactory: IFactoryDao;
    begin

      total := 1000;

      for I := 0 to total do
      begin

        if (I mod 10) = 0 then
          TThread.Synchronize(nil,
            procedure
            begin
              // update the progress bar in the main thread
              pbSplash.Progress := Round(I / total * 100);
            end
            ); // TThread.Queue

        if I = 500 then
        begin

          try
            LFactory := TFactory.new(nil, true);
            try
              LFactory
                .Conexao(nil, false)
                .Open;
            except
              on e: Exception do
              begin
                FConfigurarDataBase := true;
              end;
            end;
          finally
            LFactory.Close;
          end;

        end;
      end;
    end,
  // de pois deExecultar
    procedure()
    begin
      Close;
    end
    );

  // pbSplash.MaxValue := 100;
  //
  // TTask.Run(
  // procedure
  // var
  // processed: integer; // shared counter
  // total: integer; // total number of items to be processed
  // begin
  // processed := 0;
  // total := 1000;
  // TParallel.For(1, 1000,
  // procedure(i: integer)
  // var
  // new: integer;
  // begin
  // Sleep(10); // do the work
  // new := TInterlocked.Increment(processed); // increment the shared counter
  // if (new mod 10) = 0 then
  // TThread.Queue(nil,
  // procedure
  // begin
  // // update the progress bar in the main thread
  // pbSplash.Progress := Round(new / total * 100);
  // end
  // ); // TThread.Queue
  //
  // if i = 500 then
  // begin
  //
  // try
  // TFactory
  // .new(nil, false)
  // .Conexao(nil, false)
  // .Open;
  // except
  // on e: Exception do
  // begin
  // FConfigurarDataBase := true;
  // end;
  // end;
  // end;
  // end
  // ); // TParallel.For
  //
  // // Update the UI
  // TThread.Queue(nil, AfterTest);
  // end
  // ); // TTask.Run

end;

end.
