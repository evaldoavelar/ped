unit Cadastros.Vendedor;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base,
  Vcl.StdCtrls, Vcl.ComCtrls, Dominio.Entidades.TEntity, System.Generics.Collections,
  Dao.IDaoVendedor, Dominio.Entidades.TVendedor, JvExMask, JvToolEdit, JvBaseEdits, JvComponentBase, JvEnterTab,
  System.Actions, Vcl.ActnList, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.AutoComplete, Vcl.Mask;

type
  TfrmCadastroVendedor = class(TfrmCadastroBase)
    ts1: TTabSheet;
    edtCodigo: TEdit;
    lbl3: TLabel;
    Label2: TLabel;
    edtDescricao: TEdit;
    Label3: TLabel;
    edtComissaoValor: TJvCalcEdit;
    edtComissaoPerc: TJvCalcEdit;
    Label4: TLabel;
    Label5: TLabel;
    edtSenha: TEdit;
    chkPodeCancelarPedido: TCheckBox;
    chkPodeReceberParcelas: TCheckBox;
    chkPodeAcessarCadastroVendedor: TCheckBox;
    chkPodeCancelarOrcamento: TCheckBox;
    chkPodeAcessarParametros: TCheckBox;
    procedure edtCodigoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkPodeCancelarPedidoClick(Sender: TObject);
  private
    FVendedor: TVendedor;
    FDaoVendedor: IDaoVendedor;

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
  end;

var
  frmCadastroVendedor: TfrmCadastroVendedor;

implementation

{$R *.dfm}


uses Consulta.Vendedor, Sistema.TLog, Factory.Entidades;

procedure TfrmCadastroVendedor.Excluir;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.Excluir ');
  inherited;
  try
    FDaoVendedor.ExcluirVendedor(FVendedor.CODIGO);
    FVendedor.Free;
    FVendedor := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroVendedor.Excluir ');
end;

procedure TfrmCadastroVendedor.AtualizarEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.AtualizarEntity ');
  inherited;
  FDaoVendedor.AtualizaVendedor(FVendedor);
  edtPesquisa.Text := FVendedor.NOME;
  TLog.d('<<< Saindo de TfrmCadastroVendedor.AtualizarEntity ');
end;

procedure TfrmCadastroVendedor.Bind;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.Bind ');
  inherited;
  FVendedor.ClearBindings;
  FVendedor.Bind('CODIGO', edtCodigo, 'Text');
  FVendedor.Bind('NOME', edtDescricao, 'Text');
  // FVendedor.Bind('NOME', lblCliente, 'Caption');
  FVendedor.Bind('COMISSAOV', edtComissaoValor, 'Text');
  FVendedor.Bind('COMISSAOP', edtComissaoPerc, 'Text');
  FVendedor.Bind('SENHA', edtSenha, 'Text');

  FVendedor.Bind('PODECANCELARPEDIDO', chkPodeCancelarPedido, 'Checked');
  FVendedor.Bind('PODERECEBERPARCELA', chkPodeReceberParcelas, 'Checked');
  FVendedor.Bind('PODEACESSARCADASTROVENDEDOR', chkPodeAcessarCadastroVendedor, 'Checked');
  FVendedor.Bind('PODECANCELARORCAMENTO', chkPodeCancelarOrcamento, 'Checked');
  FVendedor.Bind('PODEACESSARPARAMETROS', chkPodeAcessarParametros, 'Checked');
  TLog.d('<<< Saindo de TfrmCadastroVendedor.Bind ');
end;

procedure TfrmCadastroVendedor.Cancelar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.Cancelar ');
  try
    if Assigned(FVendedor) and (FVendedor.CODIGO <> '') then
    begin
      FVendedor := FDaoVendedor.GetVendedor(FVendedor.CODIGO);
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
  TLog.d('<<< Saindo de TfrmCadastroVendedor.Cancelar ');
end;

procedure TfrmCadastroVendedor.chkPodeCancelarPedidoClick(Sender: TObject);
begin
  inherited;

  TBindings.Notify(Sender, 'Checked');
end;

procedure TfrmCadastroVendedor.edtCodigoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroVendedor.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.FormDestroy ');
  if Assigned(FVendedor) then
  begin
    FVendedor.Free;
    FVendedor := nil;
  end;
  inherited;
  TLog.d('<<< Saindo de TfrmCadastroVendedor.FormDestroy ');
end;

procedure TfrmCadastroVendedor.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.FormShow ');
  inherited;

  FDaoVendedor := fFactory.DaoVendedor;
  TLog.d('<<< Saindo de TfrmCadastroVendedor.FormShow ');
end;

procedure TfrmCadastroVendedor.getEntity(aEntity: TObject);
var
  LItem: TVendedor;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.getEntity ');
  try

    // edição
    if (aEntity = nil) and (FVendedor <> nil) then
    begin
      FVendedor := FDaoVendedor.GetVendedor(FVendedor.CODIGO);
    end
    else
    begin // pesquisa
      LItem := aEntity as TVendedor;

      if Assigned(FVendedor) then
        FreeAndNil(FVendedor);

      FVendedor := FDaoVendedor.GetVendedor(LItem.CODIGO);
    end;

    if not Assigned(FVendedor) then
      raise Exception.Create('Vendedor não encontrado');
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
  TLog.d('<<< Saindo de TfrmCadastroVendedor.getEntity ');
end;

procedure TfrmCadastroVendedor.IncluirEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.IncluirEntity ');
  inherited;
  FDaoVendedor.IncluiVendedor(FVendedor);
  edtPesquisa.Text := FVendedor.NOME;
  TLog.d('<<< Saindo de TfrmCadastroVendedor.IncluirEntity ');
end;

function TfrmCadastroVendedor.MontaDescricaoPesquisa(aItem: TEntity): string;
var
  LItem: TVendedor;
begin
  LItem := aItem as TVendedor;
  result := LItem.NOME;
end;

procedure TfrmCadastroVendedor.Novo;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.Novo ');
  try
    inherited;

    if Assigned(FVendedor) then
    begin
      FVendedor.Free;
      FVendedor := nil;
    end;

    Self.FVendedor := TFactoryEntidades.new.Vendedor;
    Bind;
    try
      edtDescricao.SetFocus;
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
  TLog.d('<<< Saindo de TfrmCadastroVendedor.Novo ');
end;

function TfrmCadastroVendedor.PesquisaPorDescricaoParcial(
  aValor: string): TObjectList<TEntity>;
var
  LLista: TObjectList<TVendedor>;
  item: TVendedor;
begin
  LLista := FDaoVendedor.Listar(aValor);
  result := TObjectList<TEntity>.Create();

  for item in LLista do
    result.Add(item);

  LLista.OwnsObjects := false;
  LLista.Free;

end;

procedure TfrmCadastroVendedor.Pesquisar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroVendedor.Pesquisar ');
  inherited;
  try
    frmConsultaVendedor := TfrmConsultaVendedor.Create(Self);
    try
      frmConsultaVendedor.ShowModal;

      if Assigned(frmConsultaVendedor.Vendedor) then
      begin
        Self.FVendedor := frmConsultaVendedor.Vendedor;
        edtPesquisa.Text := Self.FVendedor.NOME;
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        tratabotoes;
      end;
    finally
      frmConsultaVendedor.Free;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroVendedor.Pesquisar ');
end;

end.
