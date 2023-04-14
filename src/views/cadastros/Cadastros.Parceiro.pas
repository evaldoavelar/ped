unit Cadastros.Parceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Dominio.Entidades.TEntity, System.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base, JvComponentBase, JvEnterTab, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Dao.IDaoParceiro, Dominio.Entidades.TParceiro, Consulta.Parceiro,
  System.Bindings.Helper, Vcl.Imaging.jpeg, Vcl.AutoComplete;

type
  TfrmCadastroParceiro = class(TfrmCadastroBase)
    tsParceiro: TTabSheet;
    edtDescricao: TEdit;
    Label2: TLabel;
    edtCodigo: TEdit;
    lbl3: TLabel;
    chkINATIVO: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtDescricaoChange(Sender: TObject);
    procedure chkINATIVOClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  protected
    FParceiro: TParceiro;
    DaoParceiro: IDaoParceiro;
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
  frmCadastroParceiro: TfrmCadastroParceiro;

implementation

uses
  Sistema.TLog, Factory.Entidades;

{$R *.dfm}


procedure TfrmCadastroParceiro.Excluir;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.Excluir ');
  inherited;
  try
    DaoParceiro.ExcluirParceiro(FParceiro.CODIGO);
    FParceiro.Free;
    FParceiro := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroParceiro.Excluir ');
end;

procedure TfrmCadastroParceiro.AtualizarEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.AtualizarEntity ');
  inherited;
  DaoParceiro.AtualizaParceiro(FParceiro);
  TLog.d('<<< Saindo de TfrmCadastroParceiro.AtualizarEntity ');
end;

procedure TfrmCadastroParceiro.Bind;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.Bind ');
  inherited;
  FParceiro.ClearBindings;
  FParceiro.Bind('CODIGO', edtCodigo, 'Text');
  FParceiro.Bind('NOME', edtDescricao, 'Text');
  // FParceiro.Bind('NOME', lblCliente, 'Caption');
  FParceiro.Bind('INATIVO', chkINATIVO, 'Checked');
  TLog.d('<<< Saindo de TfrmCadastroParceiro.Bind ');
end;

procedure TfrmCadastroParceiro.Cancelar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.Cancelar ');
  try
    if Assigned(FParceiro) and (FParceiro.CODIGO <> '') then
    begin
      FParceiro := DaoParceiro.GetParceiro(FParceiro.CODIGO);
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
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroParceiro.Cancelar ');
end;

procedure TfrmCadastroParceiro.chkINATIVOClick(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Checked');
end;

procedure TfrmCadastroParceiro.edtDescricaoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroParceiro.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.FormDestroy ');
  if Assigned(FParceiro) then
  begin
    FParceiro.Free;
    FParceiro := nil;
  end;
  inherited;
  TLog.d('<<< Saindo de TfrmCadastroParceiro.FormDestroy ');
end;

procedure TfrmCadastroParceiro.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.FormShow ');
  inherited;

  DaoParceiro := fFactory.DaoParceiro;
  TLog.d('<<< Saindo de TfrmCadastroParceiro.FormShow ');
end;

procedure TfrmCadastroParceiro.getEntity(aEntity: TObject);
var
  LItem: TParceiro;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.getEntity ');
  try

    // edição
    if (aEntity = nil) and (FParceiro <> nil) then
    begin
      FParceiro := DaoParceiro.GetParceiro(FParceiro.CODIGO);
    end
    else
    begin // pesquisa
      LItem := aEntity as TParceiro;

      if Assigned(FParceiro) then
        FreeAndNil(FParceiro);

      FParceiro := DaoParceiro.GetParceiro(LItem.CODIGO);
    end;

    if not Assigned(FParceiro) then
      raise Exception.Create('Parceiro não encontrado');

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
  TLog.d('<<< Saindo de TfrmCadastroParceiro.getEntity ');
end;

procedure TfrmCadastroParceiro.IncluirEntity;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.IncluirEntity ');
  DaoParceiro.IncluiParceiro(FParceiro);
  inherited;
  TLog.d('<<< Saindo de TfrmCadastroParceiro.IncluirEntity ');
end;

function TfrmCadastroParceiro.MontaDescricaoPesquisa(aItem: TEntity): string;
var
  LItem: TParceiro;
begin
  LItem := aItem as TParceiro;
  result := LItem.NOME;
end;

procedure TfrmCadastroParceiro.Novo;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.Novo ');
  try

    if Assigned(FParceiro) then
    begin
      FParceiro.Free;
      FParceiro := nil;
    end;

    Self.FParceiro := TFactoryEntidades.new.Parceiro;
    Bind;
    inherited;

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
  TLog.d('<<< Saindo de TfrmCadastroParceiro.Novo ');
end;

function TfrmCadastroParceiro.PesquisaPorDescricaoParcial(
  aValor: string): TObjectList<TEntity>;
var
  LLista: TObjectList<TParceiro>;
  item: TParceiro;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.PesquisaPorDescricaoParcial ');
  LLista := DaoParceiro.Listar(aValor);
  result := TObjectList<TEntity>.Create();

  for item in LLista do
    result.Add(item);

  LLista.OwnsObjects := false;
  LLista.Free;
  TLog.d('<<< Saindo de TfrmCadastroParceiro.PesquisaPorDescricaoParcial ');
end;

procedure TfrmCadastroParceiro.Pesquisar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroParceiro.Pesquisar ');
  inherited;
  try
    frmConsultaParceiro := TfrmConsultaParceiro.Create(Self);
    try
      frmConsultaParceiro.ShowModal;

      if Assigned(frmConsultaParceiro.Parceiro) then
      begin
        Self.FParceiro := frmConsultaParceiro.Parceiro;
        edtPesquisa.Text := Self.FParceiro.NOME;
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        tratabotoes;
      end;
    finally
      frmConsultaParceiro.Free;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroParceiro.Pesquisar ');
end;

end.
