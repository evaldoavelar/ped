unit Filtro.Orcamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Filtro.Base, Data.DB, System.Actions, Vcl.ActnList, JvExControls, JvNavigationPane, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, Vcl.Mask, System.DateUtils,  System.Types,
  JvExMask, JvToolEdit, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Relatorio.TROrcamento, Orcamento.Criar,
  Dao.IDaoOrcamento, Dao.TDaoItemOrcamento,
  Dao.TDaoOrcamento, Dominio.Entidades.TItemOrcamento,
  Dominio.Entidades.TOrcamento, Helper.TItemOrcamento, Dominio.Entidades.TFactory;

type
  TfrmFiltroOrcamentos = class(TfrmFiltroBase)
    btnDetalhes: TBitBtn;
    btnImprimir: TBitBtn;
    actCancelaOrcamento: TAction;
    actNovo: TAction;
    actAlterar: TAction;
    actImprimir: TAction;
    btnNovo: TBitBtn;
    Bevel1: TBevel;
    Label3: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    actCopiarOrcamento: TAction;
    Panel3: TPanel;
    procedure dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtDataFinalKeyPress(Sender: TObject; var Key: Char);
    procedure edtDataInicialKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCancelaOrcamentoExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actAlterarExecute(Sender: TObject);
    procedure dbGridResultadoDblClick(Sender: TObject);
  private
    daoOrcamento: IDaoOrcamento;
    procedure Pesquisar; override;
    procedure ValidaGrid;
    procedure Reimprimir;
    procedure Cancelar;
    procedure Novo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFiltroOrcamentos: TfrmFiltroOrcamentos;

implementation

{$R *.dfm}


procedure TfrmFiltroOrcamentos.actCancelaOrcamentoExecute(Sender: TObject);
begin
  inherited;
  Cancelar;
end;

procedure TfrmFiltroOrcamentos.dbGridResultadoDblClick(Sender: TObject);
begin
  inherited;
  actAlterar.Execute;
end;

procedure TfrmFiltroOrcamentos.dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if compareDate(dbGridResultado.DataSource.DataSet.FieldByName('DATAVENCIMENTO').AsDateTime,Date()) = LessThanValue  then
  begin
    dbGridResultado.Canvas.Font.Color := clWindow;
    dbGridResultado.Canvas.Brush.Color := $000D1CB8;
  end
  else
  begin
    dbGridResultado.Canvas.Font.Color := clWindow;
    dbGridResultado.Canvas.Brush.Color := $0000C400
  end;

  dbGridResultado.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFiltroOrcamentos.edtDataFinalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    BTN_Consultar.SetFocus;
end;

procedure TfrmFiltroOrcamentos.edtDataInicialKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtDataFinal.SetFocus;
end;

procedure TfrmFiltroOrcamentos.Reimprimir;
var
  Orcamento: TOrcamento;
  Impressora: TROrcamento;
begin
  inherited;
  try
    ValidaGrid;
    Orcamento := daoOrcamento.getOrcamento(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
    Impressora := TROrcamento.create(TFactory.Parametros.Impressora);
    Impressora.ImprimeCupom(TFactory.DadosEmitente, Orcamento);

    FreeAndNil(Orcamento);
    FreeAndNil(Impressora);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;

end;

procedure TfrmFiltroOrcamentos.ValidaGrid;
begin
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.create('Nenhum registro selecionado');
  if dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString <> 'F' then
    raise Exception.create('Está ação só pode ser feita com os Orcamentos Finalizados');
end;

procedure TfrmFiltroOrcamentos.FormCreate(Sender: TObject);
begin
  inherited;
  Self.daoOrcamento := TFactory.daoOrcamento;
end;

procedure TfrmFiltroOrcamentos.FormShow(Sender: TObject);
begin
  inherited;
  edtDataInicial.Date := IncDay(Now, TFactory.Parametros.VALIDADEORCAMENTO * -1 );
  edtDataFinal.Date := now;
  Pesquisar;
end;

procedure TfrmFiltroOrcamentos.actAlterarExecute(Sender: TObject);
begin
  inherited;
  try
    FrmCadastroOrcamento := TFrmCadastroOrcamento.create(nil);
    try
      FrmCadastroOrcamento.GetOrcamento(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
      FrmCadastroOrcamento.ShowModal;
    finally
      FreeAndNil(FrmCadastroOrcamento);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroOrcamentos.actImprimirExecute(Sender: TObject);
begin
  inherited;
  Reimprimir;
end;

procedure TfrmFiltroOrcamentos.actNovoExecute(Sender: TObject);
begin
  inherited;
  Novo;
  Pesquisar;
end;

procedure TfrmFiltroOrcamentos.Cancelar;
var
  Orcamento: TOrcamento;
begin
  try
    ValidaGrid;

    if not TFactory.VendedorLogado.PODECANCELARORCAMENTO then
      raise Exception.create('Vendedor não tem permissão para cancelar Orçamento! Acesse o cadastro de Vendedor e marque a opção "Pode Cancelar Orcamento"');

    if MessageDlg('Deseja Cancelar O pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Orcamento := daoOrcamento.getOrcamento(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
      Orcamento.STATUS := 'C';
      daoOrcamento.AtualizaOrcamento(Orcamento);

      dbGridResultado.DataSource.DataSet.Edit;
      dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString := 'C';
      dbGridResultado.DataSource.DataSet.Post;
      if Assigned(Orcamento) then
        FreeAndNil(Orcamento);
    end;

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroOrcamentos.Novo;
begin
  try
    FrmCadastroOrcamento := TFrmCadastroOrcamento.create(nil);
    try
      FrmCadastroOrcamento.ShowModal;
    finally
      FreeAndNil(FrmCadastroOrcamento);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroOrcamentos.Pesquisar;
var
  campo: string;
begin
  // inherited;
  try
    if Assigned(dbGridResultado.DataSource.DataSet) then
      dbGridResultado.DataSource.DataSet.Free;

    LiberaDataSource();
    try

      Self.actPesquisa.Enabled := false;
      case cbbPesquisa.ItemIndex of
        0:
          begin
            campo := 'O.CLIENTE';
          end;
        1:
          campo := 'O.NUMERO';
      else
        campo := 'o.NUMERO';
      end;

      if (chkEntreDatas.checked) and (trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := daoOrcamento.Listar(campo, edtValor.Text, edtDataInicial.Date, edtDataFinal.Date)
      else if chkEntreDatas.checked and (trim(edtValor.Text) = '') then
        dbGridResultado.DataSource.DataSet := daoOrcamento.Listar(edtDataInicial.Date, edtDataFinal.Date)
      else if (not chkEntreDatas.checked) and (trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := daoOrcamento.Listar(campo, edtValor.Text)
      else
        dbGridResultado.DataSource.DataSet := daoOrcamento.Listar(Date, Date);

      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('VALORDESC')).Currency := true;
      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('VALORBRUTO')).Currency := true;
      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('VALORLIQUIDO')).Currency := true;

    finally
      Self.actPesquisa.Enabled := true;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

end.
