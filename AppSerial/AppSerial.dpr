program AppSerial;

uses
  System.StartUpCopy,
  FMX.Forms,
  Frm.Principal in 'Frm.Principal.pas' {FrmPrincipal},
  Licenca.GeradorSerial in 'Forms\Licenca\Licenca.GeradorSerial.pas' {FrmGeradorSerial},
  AppSerial.Dominio.TClientePED in 'units\Dominio\Entidades\AppSerial.Dominio.TClientePED.pas',
  AppSerial.Dominio.TLicencaPED in 'units\Dominio\Entidades\AppSerial.Dominio.TLicencaPED.pas',
  AppSerial.Dao.IDAOClientePED in 'units\Dao\Abstract\AppSerial.Dao.IDAOClientePED.pas',
  AppSerial.DAO.TDAOClientePED in 'units\Dao\Concret\AppSerial.DAO.TDAOClientePED.pas',
  AppSerial.Dominio.TAppFactory in 'units\Dominio\Entidades\AppSerial.Dominio.TAppFactory.pas',
  FrmCadastro.Base in 'Forms\Cadastro\FrmCadastro.Base.pas' {FrmCadastroBase},
  FrmCadastro.Cliente in 'Forms\Cadastro\FrmCadastro.Cliente.pas' {FrmCadastroClientes},
  Licenca.Serial in 'Forms\Licenca\Licenca.Serial.pas' {FrmGeraSerial},
  AppSerial.Dao.IDAOLicenca in 'units\Dao\Abstract\AppSerial.Dao.IDAOLicenca.pas',
  AppSerial.DAO.TDAOLicencaPED in 'units\Dao\Concret\AppSerial.DAO.TDAOLicencaPED.pas',
  Util.Exceptions in '..\Repositorio\Util\Util.Exceptions.pas',
  Util.Funcoes in '..\Repositorio\Util\Util.Funcoes.pas',
  Util.TSerial in '..\Repositorio\Util\Util.TSerial.pas',
  Dominio.Entidades.TEntity in '..\Repositorio\Dominio\Dominio.Entidades.TEntity.pas',
  Dao.TDaoBase in '..\Repositorio\DAO\Dao.TDaoBase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
