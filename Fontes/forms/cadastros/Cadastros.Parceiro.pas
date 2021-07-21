unit Cadastros.Parceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base, JvComponentBase, JvEnterTab, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Dominio.Entidades.TFactory, Dao.IDaoParceiro, Dominio.Entidades.TParceiro, Consulta.Parceiro,
  System.Bindings.Helper, Vcl.Imaging.jpeg;

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
    procedure getEntity; override;
    procedure AtualizarEntity(); override;
    procedure IncluirEntity(); override;
  end;

var
  frmCadastroParceiro: TfrmCadastroParceiro;

implementation

{$R *.dfm}


procedure TfrmCadastroParceiro.Excluir;
begin

  inherited;
  try
    DaoParceiro.ExcluirParceiro(FParceiro.CODIGO);
    FParceiro.Free;
    FParceiro := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroParceiro.AtualizarEntity;
begin
  inherited;
  DaoParceiro.AtualizaParceiro(FParceiro);
end;

procedure TfrmCadastroParceiro.Bind;
begin
  inherited;
  FParceiro.ClearBindings;
  FParceiro.Bind('CODIGO', edtCodigo, 'Text');
  FParceiro.Bind('NOME', edtDescricao, 'Text');
  FParceiro.Bind('NOME', lblCliente, 'Caption');
  FParceiro.Bind('INATIVO', chkINATIVO, 'Checked');
end;

procedure TfrmCadastroParceiro.Cancelar;
begin
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
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;

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
  if Assigned(FParceiro) then
  begin
    FParceiro.Free;
    FParceiro := nil;
  end;
  inherited;
end;

procedure TfrmCadastroParceiro.FormShow(Sender: TObject);
begin
  inherited;

  DaoParceiro := TFactory.DaoParceiro;
end;

procedure TfrmCadastroParceiro.getEntity;
begin
  try
    FParceiro := DaoParceiro.GetParceiro(edtPesquisa.Text);
    if not Assigned(FParceiro) then
      raise Exception.Create('Parceiro não encontrado');
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

procedure TfrmCadastroParceiro.IncluirEntity;
begin

  DaoParceiro.IncluiParceiro(FParceiro);
  inherited;
end;

procedure TfrmCadastroParceiro.Novo;
begin
  try


    if Assigned(FParceiro) then
    begin
      FParceiro.Free;
      FParceiro := nil;
    end;

    Self.FParceiro := TFactory.Parceiro;
    Bind;
    inherited;

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

procedure TfrmCadastroParceiro.Pesquisar;
begin
  inherited;
  try
    frmConsultaParceiro := TfrmConsultaParceiro.Create(Self);
    try
      frmConsultaParceiro.ShowModal;

      if Assigned(frmConsultaParceiro.Parceiro) then
      begin
        Self.FParceiro := frmConsultaParceiro.Parceiro;
        edtPesquisa.Text := Self.FParceiro.CODIGO;
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        TrataBotoes;
      end;
    finally
      frmConsultaParceiro.Free;
    end;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

end.
