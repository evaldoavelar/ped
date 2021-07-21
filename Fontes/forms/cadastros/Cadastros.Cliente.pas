unit Cadastros.Cliente;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Mask, JvExMask, JvToolEdit,
  Dao.IDaoCliente, Dominio.Entidades.TCliente, JvComponentBase, JvEnterTab,
  System.Actions, Vcl.ActnList, Vcl.WinXCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  JvBaseEdits, Vcl.DBCtrls, Data.DB, Vcl.Imaging.jpeg;

type

  TfrmCadastroCliente = class(TfrmCadastroBase)
    ts1: TTabSheet;
    lbl3: TLabel;
    Label3: TLabel;
    edtCpf: TEdit;
    Label4: TLabel;
    lbl1: TLabel;
    edtEmail: TEdit;
    edtIE: TEdit;
    Label8: TLabel;
    Label10: TLabel;
    lbl2: TLabel;
    edtCodigo: TEdit;
    ts2: TTabSheet;
    Label5: TLabel;
    edtRua: TEdit;
    Label6: TLabel;
    edtBairro: TEdit;
    Label7: TLabel;
    edtCidade: TEdit;
    Label9: TLabel;
    Label2: TLabel;
    edtFantasia: TEdit;
    Label11: TLabel;
    edtContato: TEdit;
    edtNumero: TEdit;
    Label12: TLabel;
    Label13: TLabel;
    edtUF: TEdit;
    Label14: TLabel;
    edtComplemento: TEdit;
    Label15: TLabel;
    edtNascimento: TJvDateEdit;
    ts3: TTabSheet;
    mmoObservacao: TMemo;
    chkBloqueado: TCheckBox;
    TabSheet1: TTabSheet;
    Label16: TLabel;
    edtCobRua: TEdit;
    Label17: TLabel;
    edtCobBairro: TEdit;
    Label18: TLabel;
    edtCobCidade: TEdit;
    Label19: TLabel;
    edtCobCompl: TEdit;
    edtCobUF: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    edtCobNumero: TEdit;
    Label22: TLabel;
    edtTelefone: TMaskEdit;
    edtCelular: TMaskEdit;
    edtCEP: TMaskEdit;
    edtCobCEP: TMaskEdit;
    edtNome: TEdit;
    procedure actNovoExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure chkBloqueadoClick(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
    procedure edtNascimentoExit(Sender: TObject);
    procedure edtCpfExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
    FCliente: TCliente;
    DaoCliente: IDaoCliente;

  protected
    procedure Excluir; override;
    procedure Pesquisar; override;
    procedure Cancelar; override;
    procedure Bind(); override;
    procedure Novo(); override;
    procedure getEntity; override;
    procedure AtualizarEntity(); override;
    procedure IncluirEntity(); override;
  public
    { Public declarations }
    property Cliente: TCliente read FCliente write FCliente;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}


uses Consulta.Cliente, Dominio.Entidades.TFactory;

procedure TfrmCadastroCliente.actNovoExecute(Sender: TObject);
begin
  inherited;
  Bind();
end;

procedure TfrmCadastroCliente.AtualizarEntity;
begin
  inherited;
  Self.FCliente.CADASTRO := now;
  DaoCliente.AtualizaCliente(FCliente);
end;

procedure TfrmCadastroCliente.Bind;
begin
  inherited;
  FCliente.ClearBindings;
  FCliente.Bind('CODIGO', edtCodigo, 'Text');
  FCliente.BindReadOnly('NOME', lblCliente, 'Caption');
  FCliente.Bind('NOME', edtNome, 'Text');
  FCliente.Bind('FANTASIA', edtFantasia, 'Text');
  FCliente.Bind('CNPJ_CNPF', edtCpf, 'Text');
  FCliente.Bind('IE_RG', edtIE, 'Text');
  FCliente.Bind('NASCIMENTO', edtNascimento, 'Date');
  FCliente.Bind('CONTATO', edtContato, 'Text');
  FCliente.Bind('NUMERO', edtNumero, 'Text');
  FCliente.Bind('COMPLEMENTO', edtComplemento, 'Text');
  FCliente.Bind('UF', edtUF, 'Text');
  FCliente.Bind('ENDERECO', edtRua, 'Text');
  FCliente.Bind('BAIRRO', edtBairro, 'Text');
  FCliente.Bind('CIDADE', edtCidade, 'Text');
  FCliente.Bind('CEP', edtCEP, 'Text');
  FCliente.Bind('CELULAR', edtCelular, 'Text');
  FCliente.Bind('TELEFONE', edtTelefone, 'Text');
  FCliente.Bind('EMAIL', edtEmail, 'Text');
  FCliente.Bind('OBSERVACOES', mmoObservacao, 'Text');
  FCliente.Bind('BLOQUEADO', chkBloqueado, 'Checked');

  FCliente.Bind('COB_NUMERO', edtCobNumero, 'Text');
  FCliente.Bind('COB_COMPLEMENTO', edtCobCompl, 'Text');
  FCliente.Bind('COB_UF', edtCobUF, 'Text');
  FCliente.Bind('COB_ENDERECO', edtCobRua, 'Text');
  FCliente.Bind('COB_BAIRRO', edtCobBairro, 'Text');
  FCliente.Bind('COB_CIDADE', edtCobCidade, 'Text');
  FCliente.Bind('COB_CEP', edtCobCEP, 'Text');
end;

procedure TfrmCadastroCliente.Cancelar;
var
  codigo: string;
begin
  try
    if Assigned(FCliente) and (FCliente.codigo <> '') then
    begin
      codigo := FCliente.codigo;
      FreeAndNil(FCliente);
      FCliente := DaoCliente.GeTCliente(codigo);
      Bind;
    end
    else
    begin
      Novo;
    end;

    inherited;
  except
    on e: EAbort do
      Exit;
    on e: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroCliente.chkBloqueadoClick(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Checked');
end;

procedure TfrmCadastroCliente.edtCodigoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroCliente.edtCpfExit(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroCliente.edtNascimentoExit(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Date');
end;

procedure TfrmCadastroCliente.edtNomeChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroCliente.Excluir;
begin
  inherited;
  try
    DaoCliente.ExcluirCliente(FCliente.codigo);
    FreeAndNil(FCliente);
    Cancelar;
  except
    on e: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroCliente.getEntity;
begin
  try
    FCliente := DaoCliente.GeTCliente(edtPesquisa.Text);
    if not Assigned(FCliente) then
      raise Exception.Create('Cliente não encontrado');
    Bind();
    tratabotoes;
  except
    on e: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroCliente.IncluirEntity;
begin
  inherited;
  Self.FCliente.CADASTRO := now;
  FCliente.codigo := DaoCliente.GeraID;
  DaoCliente.IncluiCliente(FCliente);
end;

procedure TfrmCadastroCliente.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FCliente) then
  begin
    FreeAndNil(FCliente);
  end;
end;

procedure TfrmCadastroCliente.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  ShowMessage('ok');
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  inherited;
  DaoCliente := TFactory.DaoCliente;
end;

procedure TfrmCadastroCliente.Novo;
begin
  try
    inherited;

    if Assigned(FCliente) then
    begin
      FreeAndNil(FCliente);
    end;

    Self.FCliente := TFactory.Cliente;
    Self.FCliente.UF := 'MG';
    Self.FCliente.CIDADE := 'Jaboticatubas';
    Self.FCliente.CEP := '35830-000';
    Bind;

    try
      edtNome.SetFocus;
    except
      on e: Exception do
    end;

  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmCadastroCliente.Pesquisar;
begin

  try
    frmConsultaCliente := TFrmConsultaCliente.Create(Self);
    try
      frmConsultaCliente.ShowModal;

      if Assigned(frmConsultaCliente.Cliente) then
      begin
        FreeAndNil(FCliente);
        Self.FCliente := DaoCliente.GeTCliente(frmConsultaCliente.Cliente.codigo);
        edtPesquisa.Text := Self.FCliente.codigo;
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        tratabotoes;
      end;
    finally
      FreeAndNil(frmConsultaCliente);
    end;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

end.
