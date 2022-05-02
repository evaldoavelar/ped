unit Cadastros.Fornecedor;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base, Vcl.StdCtrls,
  Vcl.ComCtrls,
  Dao.IDaoFornecedor, Dominio.Entidades.TFornecedor, Vcl.Mask, JvComponentBase, JvEnterTab,
  System.Actions, Vcl.ActnList, Vcl.WinXCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TfrmCadastroFornecedor = class(TfrmCadastroBase)
    ts1: TTabSheet;
    lbl3: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtNome: TEdit;
    Label3: TLabel;
    edtFantasia: TEdit;
    Label4: TLabel;
    edtCpf: TEdit;
    Label5: TLabel;
    edtIE: TEdit;
    Label6: TLabel;
    edtContato: TEdit;
    lbl1: TLabel;
    edtEmail: TEdit;
    Label7: TLabel;
    edtTelefone: TMaskEdit;
    lbl2: TLabel;
    edtCelular: TMaskEdit;
    ts2: TTabSheet;
    Label8: TLabel;
    edtRua: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    edtCidade: TEdit;
    Label14: TLabel;
    Label13: TLabel;
    Label11: TLabel;
    edtCEP: TMaskEdit;
    Label12: TLabel;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtUF: TEdit;
    edtBairro: TEdit;
    ts3: TTabSheet;
    mmoObservacao: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNomeChange(Sender: TObject);
  private
    { Private declarations }
    DaoFornecedor: IDaoFornecedor;
    FFornecedor: TFornecedor;
    procedure edtCodigoChange(Sender: TObject);

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

    property Fornecedor: TFornecedor read FFornecedor write FFornecedor;
  end;

var
  frmCadastroFornecedor: TfrmCadastroFornecedor;

implementation

{$R *.dfm}


uses Dominio.Entidades.TFactory, Consulta.Fornecedor;

procedure TfrmCadastroFornecedor.Excluir;
begin
  inherited;
  try
    DaoFornecedor.ExcluirFornecedor(FFornecedor.CODIGO);
    FFornecedor.Free;
    FFornecedor := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroFornecedor.AtualizarEntity;
begin
  inherited;
  DaoFornecedor.AtualizaFornecedors(FFornecedor);
  edtPesquisa.Text := FFornecedor.CODIGO;
end;

procedure TfrmCadastroFornecedor.Bind;
begin
  inherited;
  FFornecedor.ClearBindings;
  FFornecedor.Bind('CODIGO', edtCodigo, 'Text');
  FFornecedor.Bind('NOME', edtNome, 'Text');
  FFornecedor.BindReadOnly('NOME', lblCliente, 'Caption');
  FFornecedor.Bind('FANTASIA', edtFantasia, 'Text');
  FFornecedor.Bind('CNPJ_CNPF', edtCpf, 'Text');
  FFornecedor.Bind('IE_RG', edtIE, 'Text');
  FFornecedor.Bind('CONTATO', edtContato, 'Text');
  FFornecedor.Bind('NUMERO', edtNumero, 'Text');
  FFornecedor.Bind('COMPLEMENTO', edtComplemento, 'Text');
  FFornecedor.Bind('UF', edtUF, 'Text');
  FFornecedor.Bind('ENDERECO', edtRua, 'Text');
  FFornecedor.Bind('BAIRRO', edtBairro, 'Text');
  FFornecedor.Bind('CIDADE', edtCidade, 'Text');
  FFornecedor.Bind('CEP', edtCEP, 'Text');
  FFornecedor.Bind('CELULAR', edtCelular, 'Text');
  FFornecedor.Bind('TELEFONE', edtTelefone, 'Text');
  FFornecedor.Bind('EMAIL', edtEmail, 'Text');
  FFornecedor.Bind('OBSERVACOES', mmoObservacao, 'Text');
end;

procedure TfrmCadastroFornecedor.Cancelar;
begin
  try
    if Assigned(FFornecedor) and (FFornecedor.CODIGO <> '') then
    begin
      FFornecedor := DaoFornecedor.GeFornecedor(FFornecedor.CODIGO);
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

procedure TfrmCadastroFornecedor.FormDestroy(Sender: TObject);
begin
  DaoFornecedor := nil;
  if Assigned(FFornecedor) then
  begin
    FFornecedor.Free;
    FFornecedor := nil;
  end;
  inherited;

end;

procedure TfrmCadastroFornecedor.edtCodigoChange(Sender: TObject);
begin
  inherited;
end;

procedure TfrmCadastroFornecedor.edtNomeChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroFornecedor.FormShow(Sender: TObject);
begin
  inherited;

  DaoFornecedor := TFactory.DaoFornecedor;
end;

procedure TfrmCadastroFornecedor.getEntity;
begin
  try
    FFornecedor := DaoFornecedor.GeFornecedor(edtPesquisa.Text);
    if not Assigned(FFornecedor) then
      raise Exception.Create('Fornecedor não encontrado');
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

procedure TfrmCadastroFornecedor.IncluirEntity;
begin
  inherited;
  FFornecedor.CODIGO := DaoFornecedor.GeraID;
  DaoFornecedor.IncluiFornecedor(FFornecedor);
  edtPesquisa.Text := FFornecedor.CODIGO;
end;

procedure TfrmCadastroFornecedor.Novo;
begin
  try
    inherited;

    if Assigned(FFornecedor) then
    begin
      FFornecedor.Free;
      FFornecedor := nil;
    end;

    Self.FFornecedor := TFactory.Fornecedor;
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

procedure TfrmCadastroFornecedor.Pesquisar;
begin
  inherited;
  try
    frmConsultaFornecedor := TfrmConsultaFornecedor.Create(Self);
    try
      frmConsultaFornecedor.ShowModal;

      if Assigned(frmConsultaFornecedor.Fornecedor) then
      begin
        Self.FFornecedor := frmConsultaFornecedor.Fornecedor;
        edtPesquisa.Text := Self.FFornecedor.CODIGO;
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        tratabotoes;
      end;
    finally
      frmConsultaFornecedor.Free;
    end;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

end.
