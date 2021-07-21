unit WebModule.Principal;

interface

uses
  System.SysUtils, System.Classes,
  Web.HTTPApp, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP, Datasnap.DSServer, Datasnap.DSHTTPWebBroker;
type
  TWebModulePrincipal = class(TWebModule)
    DSServer1: TDSServer;
    DSServerClass1: TDSServerClass;
    DSRESTWebDispatcher1: TDSRESTWebDispatcher;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModulePrincipal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

uses ServerMethods.Licenca;

procedure TWebModulePrincipal.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethods.Licenca.TServerLicenca;
end;


initialization
finalization


end.

