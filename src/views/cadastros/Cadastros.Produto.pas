unit Cadastros.Produto;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons,
  Dao.IDaoProdutos, Dominio.Entidades.TProduto, JvToolEdit, JvExMask, JvBaseEdits, JvComponentBase, JvEnterTab,
  Vcl.Mask, System.Actions, Vcl.ActnList, Vcl.WinXCtrls, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  Vcl.AutoComplete, Dominio.Entidades.TEntity, System.Generics.Collections;

type
  TfrmCadastroProduto = class(TfrmCadastroBase)
    ts1: TTabSheet;
    ts2: TTabSheet;
    ts3: TTabSheet;
    lbl3: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtBarras: TEdit;
    Label3: TLabel;
    edtDescricao: TEdit;
    Label4: TLabel;
    lbl1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mmoObservacao: TMemo;
    edtUltimaAlteracao: TJvDateEdit;
    Label9: TLabel;
    Label10: TLabel;
    edtUltimVenda: TJvDateEdit;
    Label5: TLabel;
    lbl2: TLabel;
    edtCodFornecedor: TEdit;
    edtNomeFornecedor: TEdit;
    btnPesquisaCliente: TBitBtn;
    Label11: TLabel;
    edtDataCadastro: TJvDateEdit;
    cbbUND: TComboBox;
    edtCustoMedio: TJvCalcEdit;
    edtPrecoCusto: TJvCalcEdit;
    edtPrecovenda: TJvCalcEdit;
    edtPrecoAtacado: TJvCalcEdit;
    edtMargemLucro: TJvCalcEdit;
    Label12: TLabel;
    edtPreco1: TJvCalcEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Label13: TLabel;
    edtEstoqueMinimo: TEdit;
    Panel3: TPanel;
    Label14: TLabel;
    edtEstoque: TEdit;
    chkAvisarEstoque: TCheckBox;
    chkBloqueado: TCheckBox;
    chkFracionado: TCheckBox;
    chkInativo: TCheckBox;
    procedure FormDestroy(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
    procedure chkBloqueadoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtUltimaAlteracaoChange(Sender: TObject);
    procedure btnPesquisaClienteClick(Sender: TObject);
    procedure edtCustoMedioKeyPress(Sender: TObject; var Key: Char);
    procedure edtCustoMedioChange(Sender: TObject);
  private
    { Private declarations }
    FProduto: TProduto;
    FDaoProduto: IDaoProdutos;

  protected
    procedure Excluir; override;
    procedure Pesquisar; override;
    procedure Cancelar; override;
    procedure Bind(); override;
    procedure Novo(); override;
    procedure AtualizarEntity(); override;
    procedure IncluirEntity(); override;
    procedure getEntity(aEntity: TObject); override;
    function MontaDescricaoPesquisa(aItem: TEntity): string; override;
    function PesquisaPorDescricaoParcial(aValor: string): TObjectList<TEntity>; override;
  end;

var
  frmCadastroProduto: TfrmCadastroProduto;

implementation

{$R *.dfm}


uses Dominio.Entidades.TFactory, Consulta.Produto, Consulta.Fornecedor, Sistema.TLog;

procedure TfrmCadastroProduto.Excluir;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.Excluir ');
  inherited;
  try
    FDaoProduto.ExcluirProduto(FProduto.CODIGO);
    FProduto.Free;
    FProduto := nil;
    Cancelar;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroProduto.Excluir ');
end;

procedure TfrmCadastroProduto.AtualizarEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.AtualizarEntity ');
  inherited;
  FProduto.ALTERACAO_PRECO := Now;
  FDaoProduto.AtualizaProduto(FProduto);
  edtPesquisa.Text := FProduto.DESCRICAO;
  TLog.d('<<< Saindo de TfrmCadastroProduto.AtualizarEntity ');
end;

procedure TfrmCadastroProduto.Bind;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.Bind ');
  if not Assigned(FProduto) then
    Exit;

  inherited;
  FProduto.ClearBindings;
  FProduto.Bind('CODIGO', edtCodigo, 'Text');
  FProduto.Bind('BARRAS', edtBarras, 'Text');
  FProduto.Bind('DESCRICAO', edtDescricao, 'Text');
  // FProduto.BindReadOnly('DESCRICAO', lblCliente, 'Caption');
  FProduto.Bind('UND', cbbUND, 'Text');
  FProduto.Bind('CUSTO_MEDIO', edtCustoMedio, 'Text');
  FProduto.Bind('PRECO_CUSTO', edtPrecoCusto, 'Value');
  FProduto.Bind('PRECO_VENDA', edtPrecovenda, 'Value');
  FProduto.Bind('PRECO_VENDA', edtPreco1, 'Value');
  FProduto.Bind('PRECO_ATACADO', edtPrecoAtacado, 'Value');
  FProduto.Bind('MARGEM_LUCRO', edtMargemLucro, 'Value');
  FProduto.Bind('OBSERVACOES', mmoObservacao, 'Text');

  FProduto.Bind('ULTIMA_VENDA', edtUltimVenda, 'Date');
  FProduto.Bind('ALTERACAO_PRECO', edtUltimaAlteracao, 'Date');
  FProduto.Bind('DATA_CADASTRO', edtDataCadastro, 'Date');
  FProduto.Bind('BLOQUEADO', chkBloqueado, 'Checked');
  FProduto.Bind('INATIVO', chkInativo, 'Checked');
  FProduto.Bind('QUANTIDADEFRACIONADA', chkFracionado, 'Checked');

  FProduto.Bind('Fornecedor.CODIGO', edtCodFornecedor, 'Text');
  FProduto.Bind('Fornecedor.NOME', edtNomeFornecedor, 'Text');

  FProduto.Bind('ESTOQUE', edtEstoque, 'Text');
  FProduto.Bind('ESTOQUEMINIMO', edtEstoqueMinimo, 'Text');
  FProduto.Bind('AVISARESTOQUEBAIXO', chkAvisarEstoque, 'Checked');
  TLog.d('<<< Saindo de TfrmCadastroProduto.Bind ');
end;

procedure TfrmCadastroProduto.btnPesquisaClienteClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.btnPesquisaClienteClick ');
  inherited;
  try
    frmConsultaFornecedor := TfrmConsultaFornecedor.Create(Self);
    try
      frmConsultaFornecedor.ShowModal;

      if Assigned(frmConsultaFornecedor.Fornecedor) then
      begin
        Self.FProduto.Fornecedor.Free;
        Self.FProduto.Fornecedor := nil;
        Self.FProduto.Fornecedor := frmConsultaFornecedor.Fornecedor;
        Bind();
      end;
    finally
      frmConsultaFornecedor.Free;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroProduto.btnPesquisaClienteClick ');
end;

procedure TfrmCadastroProduto.Cancelar;
var
  CODIGO: string;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.Cancelar ');
  try
    if Assigned(FProduto) and (FProduto.CODIGO <> '') then
    begin
      CODIGO := FProduto.CODIGO;

      FreeAndNil(FProduto);
      FProduto := FDaoProduto.GetProdutoPorCodigo(CODIGO);
      Bind;
    end
    else
    begin
      Novo;
    end;

    inherited;
  except
    on e: EAbort do
    begin
      TLog.d(e.message);
      Exit;
    end;
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroProduto.Cancelar ');
end;

procedure TfrmCadastroProduto.chkBloqueadoClick(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Checked');
end;

procedure TfrmCadastroProduto.edtCustoMedioChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Value');
end;

procedure TfrmCadastroProduto.edtCustoMedioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in [#8, '0' .. '9', FormatSettings.DecimalSeparator]) then
  begin
    Key := #0;
  end;
end;

procedure TfrmCadastroProduto.edtCodigoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroProduto.edtUltimaAlteracaoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Date');
end;

procedure TfrmCadastroProduto.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.FormDestroy ');
  if Assigned(FProduto) then
  begin
    FreeAndNil(FProduto);
  end;
  inherited;
  TLog.d('<<< Saindo de TfrmCadastroProduto.FormDestroy ');
end;

procedure TfrmCadastroProduto.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.FormShow ');
  inherited;
  FDaoProduto := TFactory.DaoProduto;
  TLog.d('<<< Saindo de TfrmCadastroProduto.FormShow ');
end;

procedure TfrmCadastroProduto.getEntity(aEntity: TObject);
var
  LItem: TProduto;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.getEntity ');
  try

    // edição
    if (aEntity = nil) and (FProduto <> nil) then
    begin
      FProduto := FDaoProduto.GetProdutoPorCodigo(FProduto.CODIGO);
    end
    else
    begin // pesquisa
      LItem := aEntity as TProduto;

      if Assigned(FProduto) then
        FreeAndNil(FProduto);

      FProduto := FDaoProduto.GetProdutoPorCodigo(LItem.CODIGO);
    end;

    if not Assigned(FProduto) then
      raise Exception.Create('Produto não encontrado');

    Bind();
    tratabotoes;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroProduto.getEntity ');
end;

procedure TfrmCadastroProduto.IncluirEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.IncluirEntity ');
  inherited;
  FProduto.ALTERACAO_PRECO := Now;
  FProduto.DATA_CADASTRO := Now;
  FDaoProduto.IncluiProduto(FProduto);
  edtPesquisa.Text := FProduto.DESCRICAO;
  TLog.d('<<< Saindo de TfrmCadastroProduto.IncluirEntity ');
end;

function TfrmCadastroProduto.MontaDescricaoPesquisa(aItem: TEntity): string;
var
  LItem: TProduto;
begin
  LItem := aItem as TProduto;
  result := LItem.DESCRICAO + ' - ' + LItem.CODIGO + ' - ' + FormatCurr(' R$ 0.,00', LItem.PRECO_VENDA);
end;

procedure TfrmCadastroProduto.Novo;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.Novo ');
  try
    inherited;

    if Assigned(FProduto) then
    begin
      FreeAndNil(FProduto);
    end;

    Self.FProduto := TFactory.Produto;
    Bind;
    try
      edtDescricao.SetFocus;
    except
      on e: Exception do
    end;

  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroProduto.Novo ');
end;

function TfrmCadastroProduto.PesquisaPorDescricaoParcial(
  aValor: string): TObjectList<TEntity>;
var
  LLista: TObjectList<TProduto>;
  item: TProduto;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.PesquisaPorDescricaoParcial ');
  LLista := FDaoProduto.GetProdutosPorDescricaoParcial(aValor);
  result := TObjectList<TEntity>.Create();

  for item in LLista do
    result.Add(item);

  LLista.OwnsObjects := false;
  LLista.Free;
  TLog.d('<<< Saindo de TfrmCadastroProduto.PesquisaPorDescricaoParcial ');
end;

procedure TfrmCadastroProduto.Pesquisar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroProduto.Pesquisar ');
  inherited;
  try
    FrmConsultaProdutos := TFrmConsultaProdutos.Create(Self);
    try
      FrmConsultaProdutos.ShowModal;

      if Assigned(FrmConsultaProdutos.Produto) then
      begin
        if Assigned(FProduto) then
          FreeAndNil(FProduto);

        Self.FProduto := FrmConsultaProdutos.Produto;
        edtPesquisa.Text := (Self.FProduto.DESCRICAO);
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        tratabotoes;
      end;
    finally
      FrmConsultaProdutos.Free;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroProduto.Pesquisar ');
end;

end.
