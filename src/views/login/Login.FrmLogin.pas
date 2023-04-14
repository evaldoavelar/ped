unit Login.FrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.ActnList,
  Dao.IDaoVendedor, Dominio.Entidades.TVendedor, System.Actions, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TfrmLogin = class(TfrmBase)
    act1: TActionList;
    actLogin: TAction;
    Panel1: TPanel;
    Label2: TLabel;
    Panel7: TPanel;
    Label3: TLabel;
    Panel3: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel2: TPanel;
    btnEntrar: TSpeedButton;
    Panel8: TPanel;
    Panel6: TPanel;
    btnSair: TSpeedButton;
    Panel9: TPanel;
    Image1: TImage;
    btnBancoDeDados: TSpeedButton;
    Panel21: TPanel;
    edtCodigo: TEdit;
    edtSenha: TEdit;
    actSair: TAction;
    procedure actLoginExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoExit(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure btnBancoDeDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FVendedor: TVendedor;
    daoVendedor: IDaoVendedor;
    FConfigurarDataBase: boolean;
    function getVendedor: TVendedor;
    procedure setVendedor(const Value: TVendedor);
    procedure ConfiguraBancoDeDados;
    { Private declarations }
  public
    { Public declarations }
    property ConfigurarDataBase: boolean read FConfigurarDataBase write FConfigurarDataBase;
    property Vendedor: TVendedor read getVendedor;
    procedure Login;
  end;

var
  FrmLogin: TfrmLogin;

implementation

{$R *.dfm}


uses Configuracoes.Database, Sistema.TLog;

procedure TfrmLogin.actLoginExecute(Sender: TObject);

begin
  inherited;
  Login;
end;

procedure TfrmLogin.actSairExecute(Sender: TObject);
begin
  inherited;
  Close;
  self.ModalResult := mrAbort;
end;

procedure TfrmLogin.btnBancoDeDadosClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmLogin.btnBancoDeDadosClick ');
  try
    ConfiguraBancoDeDados;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmLogin.btnBancoDeDadosClick ');
end;

procedure TfrmLogin.ConfiguraBancoDeDados;
var
  FrmConfiguracoesDatabase: TFrmConfiguracoesDatabase;
begin
  inherited;
  FrmConfiguracoesDatabase := TFrmConfiguracoesDatabase.Create(self);
  try
    FrmConfiguracoesDatabase.showmodal;
  finally
    FrmConfiguracoesDatabase.Free;
  end;
end;

procedure TfrmLogin.edtCodigoExit(Sender: TObject);
begin
  inherited;
  if daoVendedor = nil then
    daoVendedor := FFactory.daoVendedor;

  FVendedor := daoVendedor.getVendedor(edtCodigo.Text);
  // if Assigned(FVendedor) then
  // edtNome.Text := FVendedor.NOME;
end;

procedure TfrmLogin.edtCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    edtSenha.SetFocus;
  end;
end;

procedure TfrmLogin.edtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    actLogin.Execute;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmLogin.FormCreate ');
  ActiveControl := nil;
  inherited;

  TLog.d('<<< Saindo de TfrmLogin.FormCreate ');
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
  if not FConfigurarDataBase then
  begin
    daoVendedor := FFactory.daoVendedor;
    try
      edtCodigo.SetFocus;
    except
      on E: Exception do
    end;

  end;
end;

function TfrmLogin.getVendedor: TVendedor;
begin
  result := FVendedor;
end;

procedure TfrmLogin.Login;
begin
  TLog.d('>>> Entrando em  TfrmLogin.Login ');
  try

    if not Assigned(FVendedor) then
    begin
      edtCodigo.SetFocus;
      raise Exception.Create('Vendedor n�o encontrado');
    end;

    if FVendedor.SENHA <> edtSenha.Text then
    begin
      edtSenha.SetFocus;
      raise Exception.Create('Senha Inv�lida');
    end;

    Close;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmLogin.Login ');
end;

procedure TfrmLogin.setVendedor(const Value: TVendedor);
begin

end;

end.
