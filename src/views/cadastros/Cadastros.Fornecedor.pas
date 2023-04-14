unit Cadastros.Fornecedor;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base, Vcl.StdCtrls,
  Vcl.ComCtrls, Dominio.Entidades.TEntity, System.Generics.Collections,
  Dao.IDaoFornecedor, Dominio.Entidades.TFornecedor, Vcl.Mask, JvComponentBase, JvEnterTab,
  System.Actions, Vcl.ActnList, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.AutoComplete;

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
    procedure getEntity(aEntity: TObject); override;
    function MontaDescricaoPesquisa(aItem: TEntity): string; override;
    function PesquisaPorDescricaoParcial(aValor: string): TObjectList<TEntity>; override;
    procedure AtualizarEntity(); override;
    procedure IncluirEntity(); override;
  public

    property Fornecedor: TFornecedor read FFornecedor write FFornecedor;
  end;

var
  frmCadastroFornecedor: TfrmCadastroFornecedor;

implementation

{$R *.dfm}


uses Consulta.Fornecedor, Sistema.TLog, Factory.Entidades;

procedure TfrmCadastroFornecedor.Excluir;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.Excluir ');
  inherited;
  try
    DaoFornecedor.ExcluirFornecedor(FFornecedor.CODIGO);
    FFornecedor.Free;
    FFornecedor := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.Excluir ');
end;

procedure TfrmCadastroFornecedor.AtualizarEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.AtualizarEntity ');
  inherited;
  DaoFornecedor.AtualizaFornecedors(FFornecedor);
  edtPesquisa.Text := FFornecedor.NOME;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.AtualizarEntity ');
end;

procedure TfrmCadastroFornecedor.Bind;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.Bind ');
  inherited;
  FFornecedor.ClearBindings;
  FFornecedor.Bind('CODIGO', edtCodigo, 'Text');
  FFornecedor.Bind('NOME', edtNome, 'Text');
  // FFornecedor.BindReadOnly('NOME', lblCliente, 'Caption');
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
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.Bind ');
end;

procedure TfrmCadastroFornecedor.Cancelar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.Cancelar ');
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
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.Cancelar ');
end;

procedure TfrmCadastroFornecedor.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.FormDestroy ');
  DaoFornecedor := nil;
  if Assigned(FFornecedor) then
  begin
    FFornecedor.Free;
    FFornecedor := nil;
  end;
  inherited;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.FormDestroy ');
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
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.FormShow ');
  inherited;

  DaoFornecedor := fFactory.DaoFornecedor;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.FormShow ');
end;

procedure TfrmCadastroFornecedor.getEntity(aEntity: TObject);
var
  LItem: TFornecedor;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.getEntity ');
  try

    // edição
    if (aEntity = nil) and (FFornecedor <> nil) then
    begin
      FFornecedor := DaoFornecedor.GeFornecedor(FFornecedor.CODIGO);
    end
    else
    begin // pesquisa
      LItem := aEntity as TFornecedor;

      if Assigned(FFornecedor) then
        FreeAndNil(FFornecedor);

      FFornecedor := DaoFornecedor.GeFornecedor(LItem.CODIGO);
    end;

    if not Assigned(FFornecedor) then
      raise Exception.Create('Fornecedor não encontrado');

    Bind();
    tratabotoes;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.getEntity ');
end;

procedure TfrmCadastroFornecedor.IncluirEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.IncluirEntity ');
  inherited;
  FFornecedor.CODIGO := DaoFornecedor.GeraID;
  DaoFornecedor.IncluiFornecedor(FFornecedor);
  edtPesquisa.Text := FFornecedor.NOME;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.IncluirEntity ');
end;

function TfrmCadastroFornecedor.MontaDescricaoPesquisa(aItem: TEntity): string;
var
  LItem: TFornecedor;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.MontaDescricaoPesquisa ');
  LItem := aItem as TFornecedor;
  result := LItem.NOME;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.MontaDescricaoPesquisa ');
end;

procedure TfrmCadastroFornecedor.Novo;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.Novo ');
  try
    inherited;

    if Assigned(FFornecedor) then
    begin
      FFornecedor.Free;
      FFornecedor := nil;
    end;

    Self.FFornecedor := TFactoryEntidades.new.Fornecedor;
    Bind;
    try
      edtNome.SetFocus;
    except
      on e: Exception do
    end;

  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.Novo ');
end;

function TfrmCadastroFornecedor.PesquisaPorDescricaoParcial(
  aValor: string): TObjectList<TEntity>;
var
  LLista: TObjectList<TFornecedor>;
  item: TFornecedor;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.PesquisaPorDescricaoParcial ');
  LLista := DaoFornecedor.Listar(aValor);
  result := TObjectList<TEntity>.Create();

  for item in LLista do
    result.Add(item);

  LLista.OwnsObjects := false;
  LLista.Free;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.PesquisaPorDescricaoParcial ');
end;

procedure TfrmCadastroFornecedor.Pesquisar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroFornecedor.Pesquisar ');
  inherited;
  try
    frmConsultaFornecedor := TfrmConsultaFornecedor.Create(Self);
    try
      frmConsultaFornecedor.ShowModal;

      if Assigned(frmConsultaFornecedor.Fornecedor) then
      begin
        Self.FFornecedor := frmConsultaFornecedor.Fornecedor;
        edtPesquisa.Text := Self.FFornecedor.NOME;
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
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroFornecedor.Pesquisar ');
end;

end.
