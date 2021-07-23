unit Cadastros.FormaPagto;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Dominio.Entidades.CondicaoPagto,
  Vcl.StdCtrls, Vcl.ComCtrls, Dominio.Entidades.TFormaPagto.Tipo,
  Dao.IDaoFormaPagto, Dominio.Entidades.TFormaPagto, JvExMask, JvToolEdit, JvBaseEdits, JvComponentBase, JvEnterTab,
  Vcl.Mask, System.Actions, Vcl.ActnList, Vcl.WinXCtrls, Vcl.Buttons, Helper.Currency,
  Vcl.ExtCtrls, Cadastros.Base, Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TfrmCadastroFormaPagto = class(TfrmCadastroBase)
    ts1: TTabSheet;
    lbl3: TLabel;
    edtCodigo: TEdit;
    Label2: TLabel;
    edtDescricao: TEdit;
    Panel1: TPanel;
    Label5: TLabel;
    cbbTipo: TComboBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Label8: TLabel;
    Image2: TImage;
    pnl1: TPanel;
    GridPanel1: TGridPanel;
    Panel2: TPanel;
    pgcEndereco: TPageControl;
    Panel9: TPanel;
    GridPanel3: TGridPanel;
    Panel10: TPanel;
    Label13: TLabel;
    edtCondicaoDescricao: TEdit;
    Panel11: TPanel;
    Label6: TLabel;
    edtCondicaoQuantasVezes: TEdit;
    Panel12: TPanel;
    Label7: TLabel;
    edtCondicaoAcrescimo: TEdit;
    Panel13: TPanel;
    Panel14: TPanel;
    img1: TImage;
    btnIncluirCondicao: TSpeedButton;
    scrlbxMeiosPagamentos: TScrollBox;
    chkATIVO: TCheckBox;
    procedure edtCodigoChange(Sender: TObject);
    procedure edtQuantasVezesChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbbTipoChange(Sender: TObject);
    procedure btnIncluirCondicaoClick(Sender: TObject);
    procedure chkATIVOClick(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure edtCondicaoAcrescimoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCondicaoAcrescimoExit(Sender: TObject);
    procedure edtCondicaoAcrescimoEnter(Sender: TObject);
  private
    { Private declarations }
    FFormaPagto: TFormaPagto;
    DaoFormaPagto: IDaoFormaPagto;
    procedure InicializaLabelsCondicao;
    procedure BindCondicaoPagamento(aCondicao: TCONDICAODEPAGTO);
    procedure LimpaScrollBox(aScroll: TScrollBox);

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


uses Dominio.Entidades.TFactory, Consulta.FormaPagto, Utils.Rtti, Pedido.Venda.Part.CondicaoPagamento;

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

procedure TfrmCadastroFormaPagto.actNovoExecute(Sender: TObject);
begin
  inherited;
  InicializaLabelsCondicao;
end;

procedure TfrmCadastroFormaPagto.AtualizarEntity;
begin
  inherited;
  DaoFormaPagto.AtualizaFormaPagtos(FFormaPagto);
  edtPesquisa.Text := FFormaPagto.ID.ToString;
end;

procedure TfrmCadastroFormaPagto.Bind;
var
  condicao: TCONDICAODEPAGTO;
begin
  inherited;
  FFormaPagto.ClearBindings;
  FFormaPagto.Bind('ID', edtCodigo, 'Text');
  FFormaPagto.Bind('DESCRICAO', edtDescricao, 'Text');
  FFormaPagto.Bind('ATIVO', chkATIVO, 'Checked');
  FFormaPagto.BindReadOnly('DESCRICAO', lblCliente, 'Caption');
  cbbTipo.ItemIndex := cbbTipo.Items.IndexOf(FFormaPagto.TipoPagamento.ToString);

  LimpaScrollBox(scrlbxMeiosPagamentos);
  for condicao in FFormaPagto.CONDICAODEPAGTO do
    BindCondicaoPagamento(condicao);

  InicializaLabelsCondicao;
end;

procedure TfrmCadastroFormaPagto.btnIncluirCondicaoClick(Sender: TObject);
var
  condicao: TCONDICAODEPAGTO;
begin

  try
    inherited;
    condicao := Self.FFormaPagto.AddCondicao();
    try
      condicao.ACRESCIMO := StrToFloat(edtCondicaoAcrescimo.Text);
    except
      on e: Exception do
        raise Exception.Create('Valor do acrescimo não é válido!');
    end;

    condicao.DESCRICAO := edtCondicaoDescricao.Text;
    try
      condicao.QUANTASVEZES := StrToInt(edtCondicaoQuantasVezes.Text);
    except
      on e: Exception do
        raise Exception.Create('Valor de QUANTAS VEZES não é válido!');
    end;

    BindCondicaoPagamento(condicao);
    InicializaLabelsCondicao;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmCadastroFormaPagto.LimpaScrollBox(aScroll: TScrollBox);
var
  i: Integer;
begin
  for i := aScroll.ControlCount - 1 downto 0 do
  Begin
    aScroll.Controls[i].Free;
  End;
end;

procedure TfrmCadastroFormaPagto.BindCondicaoPagamento(aCondicao: TCONDICAODEPAGTO);
begin
  try
    ExibePart(TViewPartVendaFormaPagto.New(nil), scrlbxMeiosPagamentos, [aCondicao]);
  except
    on e: Exception do
  end;

end;

procedure TfrmCadastroFormaPagto.InicializaLabelsCondicao;
begin
  edtCondicaoAcrescimo.Text := '0,00';
  edtCondicaoDescricao.Text := '';
  edtCondicaoQuantasVezes.Text := '1';
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

procedure TfrmCadastroFormaPagto.cbbTipoChange(Sender: TObject);
begin
  inherited;
  FFormaPagto.TipoPagamento := TRttiUtil.StringToEnum<TTipoPagto>(cbbTipo.Items[cbbTipo.ItemIndex]);
end;

procedure TfrmCadastroFormaPagto.chkATIVOClick(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Checked');
end;

procedure TfrmCadastroFormaPagto.edtCodigoChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TfrmCadastroFormaPagto.edtCondicaoAcrescimoEnter(Sender: TObject);
begin
  inherited;
  JvEnterAsTab1.EnterAsTab := False;
end;

procedure TfrmCadastroFormaPagto.edtCondicaoAcrescimoExit(Sender: TObject);
begin
  inherited;
  JvEnterAsTab1.EnterAsTab := true;
  try
    TEdit(Sender).Text := StrToCurr((TEdit(Sender).Text)).ToStrDuasCasasSemPonto();
  except
    on e: Exception do
  end;
end;

procedure TfrmCadastroFormaPagto.edtCondicaoAcrescimoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    btnIncluirCondicao.Click;
    try
      edtCondicaoDescricao.SetFocus;
    except
    end;
  end;
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
  cbbTipo.Clear;
  TRttiUtil.EnumToValues<TTipoPagto>(cbbTipo.Items);
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
  edtPesquisa.Text := FFormaPagto.ID.ToString;
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
