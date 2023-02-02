unit Filtro.Orcamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Filtro.Base, Data.DB, System.Actions, Vcl.ActnList, JvExControls, JvNavigationPane, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, Vcl.Mask, System.DateUtils, System.Types,
  JvExMask, JvToolEdit, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Relatorio.TROrcamento, Orcamento.Criar,
  Dao.IDaoOrcamento, Dao.TDaoItemOrcamento,
  Dao.TDaoOrcamento, Dominio.Entidades.TItemOrcamento,
  Dominio.Entidades.TOrcamento, Helper.TItemOrcamento, Factory.Dao;

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

uses
  Sistema.TLog, Factory.Entidades;

{$R *.dfm}


procedure TfrmFiltroOrcamentos.actCancelaOrcamentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.actCancelaOrcamentoExecute ');
  inherited;
  Cancelar;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.actCancelaOrcamentoExecute ');
end;

procedure TfrmFiltroOrcamentos.dbGridResultadoDblClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.dbGridResultadoDblClick ');
  inherited;
  actAlterar.Execute;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.dbGridResultadoDblClick ');
end;

procedure TfrmFiltroOrcamentos.dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if compareDate(dbGridResultado.DataSource.DataSet.FieldByName('DATAVENCIMENTO').AsDateTime, Date()) = LessThanValue then
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
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.Reimprimir ');
  inherited;
  try
    ValidaGrid;
    Orcamento := daoOrcamento.getOrcamento(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
    Impressora := TROrcamento.create(FParametros.ImpressoraTermica);
    Impressora.ImprimeCupom(FFactory.DadosEmitente, Orcamento);

    FreeAndNil(Orcamento);
    FreeAndNil(Impressora);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.Reimprimir ');
end;

procedure TfrmFiltroOrcamentos.ValidaGrid;
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.ValidaGrid ');
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.create('Nenhum registro selecionado');
  if dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString <> 'F' then
    raise Exception.create('Está ação só pode ser feita com os Orcamentos Finalizados');
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.ValidaGrid ');
end;

procedure TfrmFiltroOrcamentos.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.FormCreate ');
  inherited;

  Self.daoOrcamento := FFactory.daoOrcamento;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.FormCreate ');
end;

procedure TfrmFiltroOrcamentos.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.FormShow ');
  inherited;
  edtDataInicial.Date := IncDay(Now, FParametros.VALIDADEORCAMENTO * -1);
  edtDataFinal.Date := Now;
  Pesquisar;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.FormShow ');
end;

procedure TfrmFiltroOrcamentos.actAlterarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.actAlterarExecute ');
  inherited;
  try
    FrmCadastroOrcamento := TFrmCadastroOrcamento.create(nil);
    try
      FrmCadastroOrcamento.getOrcamento(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
      FrmCadastroOrcamento.ShowModal;
    finally
      FreeAndNil(FrmCadastroOrcamento);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.actAlterarExecute ');
end;

procedure TfrmFiltroOrcamentos.actImprimirExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.actImprimirExecute ');
  inherited;
  Reimprimir;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.actImprimirExecute ');
end;

procedure TfrmFiltroOrcamentos.actNovoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.actNovoExecute ');
  inherited;
  Novo;
  Pesquisar;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.actNovoExecute ');
end;

procedure TfrmFiltroOrcamentos.Cancelar;
var
  Orcamento: TOrcamento;
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.Cancelar ');
  try
    ValidaGrid;

    if not TFactoryEntidades.new.VendedorLogado.PODECANCELARORCAMENTO then
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
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.Cancelar ');
end;

procedure TfrmFiltroOrcamentos.Novo;
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.Novo ');
  try
    FrmCadastroOrcamento := TFrmCadastroOrcamento.create(nil);
    try
      FrmCadastroOrcamento.ShowModal;
    finally
      FreeAndNil(FrmCadastroOrcamento);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.Novo ');
end;

procedure TfrmFiltroOrcamentos.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TfrmFiltroOrcamentos.Pesquisar ');
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
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroOrcamentos.Pesquisar ');
end;

end.
