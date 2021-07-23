unit Cadastros.Vendedor;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base,
  Vcl.StdCtrls, Vcl.ComCtrls,
  Dao.IDaoVendedor, Dominio.Entidades.TVendedor, JvExMask, JvToolEdit, JvBaseEdits, JvComponentBase, JvEnterTab,
  Vcl.Mask, System.Actions, Vcl.ActnList, Vcl.WinXCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg;

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
    DaoVendedor: IDaoVendedor;

  protected
    procedure Excluir; override;
    procedure Pesquisar; override;
    procedure Cancelar; override;
    procedure Bind(); override;
    procedure Novo(); override;
    procedure getEntity; override;
    procedure AtualizarEntity(); override;
    procedure IncluirEntity(); override;
  end;

var
  frmCadastroVendedor: TfrmCadastroVendedor;

implementation

{$R *.dfm}


uses Dominio.Entidades.TFactory, Consulta.Vendedor;

procedure TfrmCadastroVendedor.Excluir;
begin
  inherited;
  try
    DaoVendedor.ExcluirVendedor(FVendedor.CODIGO);
    FVendedor.Free;
    FVendedor := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroVendedor.AtualizarEntity;
begin
  inherited;
  DaoVendedor.AtualizaVendedor(FVendedor);
  edtPesquisa.Text := FVendedor.CODIGO;
end;

procedure TfrmCadastroVendedor.Bind;
begin
  inherited;
  FVendedor.ClearBindings;
  FVendedor.Bind('CODIGO', edtCodigo, 'Text');
  FVendedor.Bind('NOME', edtDescricao, 'Text');
  FVendedor.Bind('NOME', lblCliente, 'Caption');
  FVendedor.Bind('COMISSAOV', edtComissaoValor, 'Text');
  FVendedor.Bind('COMISSAOP', edtComissaoPerc, 'Text');
  FVendedor.Bind('SENHA', edtSenha, 'Text');

  FVendedor.Bind('PODECANCELARPEDIDO', chkPodeCancelarPedido, 'Checked');
  FVendedor.Bind('PODERECEBERPARCELA', chkPodeReceberParcelas, 'Checked');
  FVendedor.Bind('PODEACESSARCADASTROVENDEDOR', chkPodeAcessarCadastroVendedor, 'Checked');
  FVendedor.Bind('PODECANCELARORCAMENTO', chkPodeCancelarOrcamento, 'Checked');
  FVendedor.Bind('PODEACESSARPARAMETROS', chkPodeAcessarParametros, 'Checked');

end;

procedure TfrmCadastroVendedor.Cancelar;
begin
  try
    if Assigned(FVendedor) and (FVendedor.CODIGO <> '') then
    begin
      FVendedor := DaoVendedor.GetVendedor(FVendedor.CODIGO);
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
  if Assigned(FVendedor) then
  begin
    FVendedor.Free;
    FVendedor := nil;
  end;
  inherited;
end;

procedure TfrmCadastroVendedor.FormShow(Sender: TObject);
begin
  inherited;

  DaoVendedor := TFactory.DaoVendedor;
end;

procedure TfrmCadastroVendedor.getEntity;
begin
  try
    FVendedor := DaoVendedor.GetVendedor(edtPesquisa.Text);
    if not Assigned(FVendedor) then
      raise Exception.Create('Vendedor não encontrado');
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

procedure TfrmCadastroVendedor.IncluirEntity;
begin
  inherited;
  DaoVendedor.IncluiVendedor(FVendedor);
  edtPesquisa.Text := FVendedor.CODIGO;
end;

procedure TfrmCadastroVendedor.Novo;
begin
  try
    inherited;

    if Assigned(FVendedor) then
    begin
      FVendedor.Free;
      FVendedor := nil;
    end;

    Self.FVendedor := TFactory.Vendedor;
    Bind;
    try
      edtDescricao.SetFocus;
    except
      on e: Exception do
    end;

  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;

end;

procedure TfrmCadastroVendedor.Pesquisar;
begin
  inherited;
  try
    frmConsultaVendedor := TfrmConsultaVendedor.Create(Self);
    try
      frmConsultaVendedor.ShowModal;

      if Assigned(frmConsultaVendedor.Vendedor) then
      begin
        Self.FVendedor := frmConsultaVendedor.Vendedor;
        edtPesquisa.Text := Self.FVendedor.CODIGO;
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
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

end.
