program ServidorLicenca;
{$APPTYPE GUI}



uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FrmPrincipal in 'Forms\FrmPrincipal.pas' {Form1},
  ServerMethods.Licenca in 'units\Server\ServerMethods.Licenca.pas',
  WebModule.Principal in 'Forms\DM\WebModule.Principal.pas' {WebModulePrincipal: TWebModule},
  Dao.TDaoBase in '..\Repositorio\DAO\Dao.TDaoBase.pas',
  Dominio.Entidades.TEntity in '..\Repositorio\Dominio\Dominio.Entidades.TEntity.pas',
  Util.Exceptions in '..\Repositorio\Util\Util.Exceptions.pas',
  Util.Funcoes in '..\Repositorio\Util\Util.Funcoes.pas',
  Util.TSerial in '..\Repositorio\Util\Util.TSerial.pas',
  AppSerial.Dominio.TClientePED in '..\AppSerial\units\Dominio\Entidades\AppSerial.Dominio.TClientePED.pas',
  AppSerial.Dominio.TLicencaPED in '..\AppSerial\units\Dominio\Entidades\AppSerial.Dominio.TLicencaPED.pas',
  Servidor.Dominio.TAppFactory in 'units\units\Dominio\Entidades\Servidor.Dominio.TAppFactory.pas',
  AppSerial.Dao.IDAOClientePED in '..\AppSerial\units\Dao\Abstract\AppSerial.Dao.IDAOClientePED.pas',
  AppSerial.Dao.IDAOLicenca in '..\AppSerial\units\Dao\Abstract\AppSerial.Dao.IDAOLicenca.pas',
  AppSerial.DAO.TDAOClientePED in '..\AppSerial\units\Dao\Concret\AppSerial.DAO.TDAOClientePED.pas',
  AppSerial.DAO.TDAOLicencaPED in '..\AppSerial\units\Dao\Concret\AppSerial.DAO.TDAOLicencaPED.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
