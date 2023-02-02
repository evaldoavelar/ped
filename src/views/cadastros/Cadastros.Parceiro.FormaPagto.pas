unit Cadastros.Parceiro.FormaPagto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Cadastros.Base, JvComponentBase, JvEnterTab,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.ExtCtrls, Dominio.Entidades.TParceiro.FormaPagto, System.Generics.Collections,
  Dao.IDaoParceiro.FormaPagto, Factory.Dao, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits,
  System.Bindings.Helper, Consulta.Parceiro.FormaPagto, Vcl.Imaging.jpeg,
  Vcl.AutoComplete, Dominio.Entidades.TEntity;

type
  TFrmCadastroFormaPagtoParceiro = class(TfrmCadastroBase)
    ts1: TTabSheet;
    lbl3: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtDescricao: TEdit;
    Label3: TLabel;
    edtComissaoValor: TEdit;
    procedure edtCodigoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FParceiroFormaPagto: TParceiroFormaPagto;
    DaoParceiroFormaPagto: IDaoParceiroFormaPagto;

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
  FrmCadastroFormaPagtoParceiro: TFrmCadastroFormaPagtoParceiro;

implementation

uses
  Sistema.TLog, Factory.Entidades;

{$R *.dfm}

{ TfrmCadastroBase1 }

procedure TFrmCadastroFormaPagtoParceiro.Excluir;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.Excluir ');
  inherited;
  try
    DaoParceiroFormaPagto.ExcluirParceiroFormaPagto(FParceiroFormaPagto.ID);
    FParceiroFormaPagto.Free;
    FParceiroFormaPagto := nil;

    Cancelar;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.Excluir ');
end;

procedure TFrmCadastroFormaPagtoParceiro.AtualizarEntity;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.AtualizarEntity ');
  inherited;
  DaoParceiroFormaPagto.AtualizaParceiroFormaPagtos(FParceiroFormaPagto);
  edtPesquisa.Text := FParceiroFormaPagto.DESCRICAO;
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.AtualizarEntity ');
end;

procedure TFrmCadastroFormaPagtoParceiro.Bind;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.Bind ');
  inherited;
  FParceiroFormaPagto.ClearBindings;
  FParceiroFormaPagto.Bind('ID', edtCodigo, 'Text');
  FParceiroFormaPagto.Bind('DESCRICAO', edtDescricao, 'Text');
  FParceiroFormaPagto.Bind('COMISSAOPERCENTUAL', edtComissaoValor, 'Text');
  // FParceiroFormaPagto.BindReadOnly('DESCRICAO', lblCliente, 'Caption');
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.Bind ');
end;

procedure TFrmCadastroFormaPagtoParceiro.Cancelar;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.Cancelar ');
  try
    if Assigned(FParceiroFormaPagto) and (FParceiroFormaPagto.ID > 0) then
    begin
      FParceiroFormaPagto := DaoParceiroFormaPagto.GeTParceiroFormaPagto(FParceiroFormaPagto.ID);
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
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.Cancelar ');
end;

procedure TFrmCadastroFormaPagtoParceiro.edtCodigoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TFrmCadastroFormaPagtoParceiro.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.FormDestroy ');
  DaoParceiroFormaPagto := nil;
  if Assigned(FParceiroFormaPagto) then
  begin
    FParceiroFormaPagto.Free;
    FParceiroFormaPagto := nil;
  end;
  inherited;
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.FormDestroy ');
end;

procedure TFrmCadastroFormaPagtoParceiro.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.FormShow ');
  inherited;
  DaoParceiroFormaPagto := fFactory.DaoParceiroFormaPagto;
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.FormShow ');
end;

procedure TFrmCadastroFormaPagtoParceiro.getEntity(aEntity: TObject);
var
  LItem: TParceiroFormaPagto;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.getEntity ');
  try

    // edição
    if (aEntity = nil) and (FParceiroFormaPagto <> nil) then
    begin
      FParceiroFormaPagto := DaoParceiroFormaPagto.GeTParceiroFormaPagto(FParceiroFormaPagto.ID);
    end
    else
    begin // pesquisa
      LItem := aEntity as TParceiroFormaPagto;

      if Assigned(FParceiroFormaPagto) then
        FreeAndNil(FParceiroFormaPagto);

      FParceiroFormaPagto := DaoParceiroFormaPagto.GeTParceiroFormaPagto(LItem.ID);
    end;

    if not Assigned(FParceiroFormaPagto) then
      raise Exception.Create('Forma de Pagamento não encontrado');
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
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.getEntity ');
end;

procedure TFrmCadastroFormaPagtoParceiro.IncluirEntity;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.IncluirEntity ');
  inherited;
  FParceiroFormaPagto.ID := DaoParceiroFormaPagto.GeraID;
  DaoParceiroFormaPagto.IncluiPagto(FParceiroFormaPagto);
  edtPesquisa.Text := FParceiroFormaPagto.DESCRICAO;
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.IncluirEntity ');
end;

function TFrmCadastroFormaPagtoParceiro.MontaDescricaoPesquisa(
  aItem: TEntity): string;
var
  LItem: TParceiroFormaPagto;
begin
  LItem := aItem as TParceiroFormaPagto;
  result := LItem.DESCRICAO;
end;

procedure TFrmCadastroFormaPagtoParceiro.Novo;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.Novo ');
  try
    inherited;

    if Assigned(FParceiroFormaPagto) then
    begin
      FParceiroFormaPagto.Free;
      FParceiroFormaPagto := nil;
    end;

    Self.FParceiroFormaPagto := TFactoryEntidades.new.ParceiroFormaPagto;
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
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.Novo ');
end;

function TFrmCadastroFormaPagtoParceiro.PesquisaPorDescricaoParcial(
  aValor: string): TObjectList<TEntity>;
var
  LLista: TObjectList<TParceiroFormaPagto>;
  item: TParceiroFormaPagto;
begin
  LLista := DaoParceiroFormaPagto.Listar(aValor);
  result := TObjectList<TEntity>.Create();

  for item in LLista do
    result.Add(item);

  LLista.OwnsObjects := False;
  LLista.Free;

end;

procedure TFrmCadastroFormaPagtoParceiro.Pesquisar;
begin
  TLog.d('>>> Entrando em  TFrmCadastroFormaPagtoParceiro.Pesquisar ');
  inherited;
  try
    FrmConsultaFormaPagtoParceiro := TFrmConsultaFormaPagtoParceiro.Create(Self);
    try
      FrmConsultaFormaPagtoParceiro.ShowModal;

      if Assigned(FrmConsultaFormaPagtoParceiro.ParceiroFormaPagto) then
      begin
        Self.FParceiroFormaPagto := FrmConsultaFormaPagtoParceiro.ParceiroFormaPagto;
        edtPesquisa.Text := Self.FParceiroFormaPagto.DESCRICAO;
        Bind();
        inherited;
      end
      else
      begin
        state := TState.stBrowser;
        tratabotoes;
      end;
    finally
      FrmConsultaFormaPagtoParceiro.Free;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmCadastroFormaPagtoParceiro.Pesquisar ');
end;

end.
