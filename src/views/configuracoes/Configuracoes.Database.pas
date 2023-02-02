unit Configuracoes.Database;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.Buttons, Vcl.StdCtrls, Sistema.TBancoDeDados,
  Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TFrmConfiguracoesDatabase = class(TfrmBase)
    pnl1: TPanel;
    btnOk: TBitBtn;
    Panel2: TPanel;
    Panel3: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtBancoDeDados: TEdit;
    edtSenha: TEdit;
    edtUsuario: TEdit;
    edtServidor: TEdit;
    Panel4: TPanel;
    btnTestar: TSpeedButton;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure edtServidorChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTestarClick(Sender: TObject);
  private
    { Private declarations }
    FBancoDeDados: TParametrosBancoDeDados;
    procedure Bind;
  public
    { Public declarations }
  end;

var
  FrmConfiguracoesDatabase: TFrmConfiguracoesDatabase;

implementation

uses
  System.Bindings.Helper, Factory.Dao, Sistema.TLog;

{$R *.dfm}


procedure TFrmConfiguracoesDatabase.Bind;
begin
  TLog.d('>>> Entrando em  TFrmConfiguracoesDatabase.Bind ');
  FBancoDeDados.ClearBindings;
  FBancoDeDados.Bind('Servidor', edtServidor, 'Text');
  FBancoDeDados.Bind('Database', edtBancoDeDados, 'Text');
  FBancoDeDados.Bind('Usuario', edtUsuario, 'Text');
  FBancoDeDados.Bind('SenhaProxy', edtSenha, 'Text');
  TLog.d('<<< Saindo de TFrmConfiguracoesDatabase.Bind ');
end;

procedure TFrmConfiguracoesDatabase.edtServidorChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TFrmConfiguracoesDatabase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(FBancoDeDados) then
    FreeAndNil(FBancoDeDados)
end;

procedure TFrmConfiguracoesDatabase.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmConfiguracoesDatabase.FormCreate ');
  inherited;
  FBancoDeDados := fFactory
    .DaoParametrosBancoDeDados
    .Carregar;
  Bind;
  TLog.d('<<< Saindo de TFrmConfiguracoesDatabase.FormCreate ');
end;

procedure TFrmConfiguracoesDatabase.btnOkClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmConfiguracoesDatabase.btnOkClick ');
  inherited;
  fFactory
    .DaoParametrosBancoDeDados
    .Salvar(FBancoDeDados);
  close;
  TLog.d('<<< Saindo de TFrmConfiguracoesDatabase.btnOkClick ');
end;

procedure TFrmConfiguracoesDatabase.btnTestarClick(Sender: TObject);
begin
  inherited;
  TLog.d('>>> Entrando em  TFrmConfiguracoesDatabase.btnTestarClick ');
  try
    TFactory.new.Conexao(FBancoDeDados);
    MessageDlg('Conectado!', mtInformation, [mbOK], 0);
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmConfiguracoesDatabase.btnTestarClick ');
end;

end.
