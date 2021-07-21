unit DM.Conexao;

interface

uses
System.IOUtils,
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys,Firedac.DApt, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client;

type
  TDMConexao = class(TDataModule)
    conMobile: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure conMobileBeforeConnect(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDMConexao.conMobileBeforeConnect(Sender: TObject);
begin
 {$IF DEFINED(iOS) or DEFINED(ANDROID)}
  conMobile.Params.Values['Database'] :=   TPath.Combine(TPath.GetDocumentsPath, 'serial.db3');
 {$ENDIF}
end;

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  conMobile.Connected := True;
end;

end.
