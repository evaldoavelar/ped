unit Cadastros.FormaPagto;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ComCtrls,
  Dao.IDaoFormaPagto, Dominio.Entidades.TFormaPagto, JvExMask, JvToolEdit, JvBaseEdits, JvComponentBase, JvEnterTab,
  Vcl.Mask, System.Actions, Vcl.ActnList, Vcl.WinXCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Cadastros.Base, Vcl.Imaging.jpeg;

type
  TfrmCadastroFormaPagto = class(TfrmCadastroBase)
    ts1: TTabSheet;
    lbl3: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtDescricao: TEdit;
    Label3: TLabel;
    edtQuantasVezes: TJvCalcEdit;
    Label4: TLabel;
    edtJuros: TJvCalcEdit;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtQuantasVezesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FFormaPagto: TFormaPagto;
    DaoFormaPagto: IDaoFormaPagto;

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
  frmCadastroFormaPagto: TfrmCadastroFormaPagto;

implementation

{$R *.dfm}


uses Dominio.Entidades.TFactory, Consulta.FormaPagto;

{ TfrmCadastroFormaPagto }

procedure TfrmCadastroFormaPagto.Excluir;
begin
  inherited;
  try
    DaoFormaPagto.ExcluirFormaPagto(FFormaPagto.ID);
    FFormaPagto.Free;
    FFormaPagto := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

procedure TfrmCadastroFormaPagto.AtualizarEntity;
begin
  inherited;
  DaoFormaPagto.AtualizaFormaPagtos(FFormaPagto);
end;

procedure TfrmCadastroFormaPagto.Bind;
begin
  inherited;
  FFormaPagto.ClearBindings;
  FFormaPagto.Bind('ID', edtCodigo, 'Text');
  FFormaPagto.Bind('DESCRICAO', edtDescricao, 'Text');
  FFormaPagto.Bind('QUANTASVEZES', edtQuantasVezes, 'Text');
  FFormaPagto.Bind('JUROS', edtJuros, 'Text');
  FFormaPagto.BindReadOnly('DESCRICAO', lblCliente, 'Caption');

end;

procedure TfrmCadastroFormaPagto.Cancelar;
begin
  try
    if Assigned(FFormaPagto) and (FFormaPagto.ID > 0) then
    begin
      FFormaPagto := DaoFormaPagto.GeTFormaPagto(FFormaPagto.ID);
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

procedure TfrmCadastroFormaPagto.edtCodigoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroFormaPagto.edtQuantasVezesChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroFormaPagto.FormDestroy(Sender: TObject);
begin
  DaoFormaPagto := nil;
  if Assigned(FFormaPagto) then
  begin
    FFormaPagto.Free;
    FFormaPagto := nil;
  end;
  inherited;
end;

procedure TfrmCadastroFormaPagto.FormShow(Sender: TObject);
begin
  inherited;
  DaoFormaPagto := TFactory.DaoFormaPagto;
end;

procedure TfrmCadastroFormaPagto.getEntity;
begin
  try
    FFormaPagto := DaoFormaPagto.GeTFormaPagto(StrToIntDef(edtPesquisa.Text, 0));
    if not Assigned(FFormaPagto) then
      raise Exception.Create('Forma de Pagamento não encontrado');
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

procedure TfrmCadastroFormaPagto.IncluirEntity;
begin
  inherited;
  FFormaPagto.ID := DaoFormaPagto.GeraID;
  DaoFormaPagto.IncluiPagto(FFormaPagto);
end;

procedure TfrmCadastroFormaPagto.Novo;
begin
  try
    inherited;

    if Assigned(FFormaPagto) then
    begin
      FFormaPagto.Free;
      FFormaPagto := nil;
    end;

    Self.FFormaPagto := TFactory.FormaPagto;
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

procedure TfrmCadastroFormaPagto.Pesquisar;
begin
  inherited;
  try
    frmConsultaFormaPagto := TfrmConsultaFormaPagto.Create(Self);
    try
      frmConsultaFormaPagto.ShowModal;

      if Assigned(frmConsultaFormaPagto.FormaPagto) then
      begin
        Self.FFormaPagto := frmConsultaFormaPagto.FormaPagto;
        edtPesquisa.Text := IntToStr(Self.FFormaPagto.ID);
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        tratabotoes;
      end;
    finally
      frmConsultaFormaPagto.Free;
    end;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

end.
