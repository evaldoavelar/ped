unit Filtro.VendasParceiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Threading, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Filtro.Base, Data.DB, System.Actions,
  Vcl.ActnList, JvExControls, JvNavigationPane, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,
  JvDBUltimGrid, Vcl.Mask,
  JvExMask, JvToolEdit, Vcl.StdCtrls, Vcl.Buttons, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Dao.TDaoParceiroVenda, Dominio.Entidades.TParceiroVenda,
  Dominio.Entidades.TFactory, parceiro.PagtoDetalhes;

type
  TfrmFiltroVendasParceiro = class(TfrmFiltroBase)
    Label1: TLabel;
    pnl1: TPanel;
    btnCancelar: TBitBtn;
    btnDetalhes: TBitBtn;
    actCancelar: TAction;
    cbbCampoSomar: TComboBox;
    lblTotalCancelado: TLabel;
    lblTotalLiquidoConcluido: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    Panel1: TPanel;
    Label3: TLabel;
    actDetalhes: TAction;
    procedure dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtDataInicialKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dbGridResultadoDblClick(Sender: TObject);
    procedure cbbCampoSomarChange(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actDetalhesExecute(Sender: TObject);
  private
    { Private declarations }
    procedure Detalhes;
    procedure CalculaTotais;
    procedure ValidaGrid;
    procedure Pesquisar; override;
  public
    { Public declarations }
  end;

var
  frmFiltroVendasParceiro: TfrmFiltroVendasParceiro;

implementation

{$R *.dfm}


procedure TfrmFiltroVendasParceiro.Pesquisar;
var
  campo: string;
begin
  // inherited;
  try
    if Assigned(dbGridResultado.DataSource.DataSet) then
      dbGridResultado.DataSource.DataSet.Free;

    LiberaDataSource();
    try

      self.actPesquisa.Enabled := false;
      case cbbPesquisa.ItemIndex of
        0:
          begin
            campo := 'NOME';
          end;
        1:
          campo := 'CODPARCEIRO';

      else
        campo := 'NOME';
      end;

      if (chkEntreDatas.checked) and (trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := TFactory.DaoParceiroVenda.Listar(campo, edtValor.Text, edtDataInicial.Date, edtDataFinal.Date)
      else if chkEntreDatas.checked and (trim(edtValor.Text) = '') then
        dbGridResultado.DataSource.DataSet := TFactory.DaoParceiroVenda.Listar(edtDataInicial.Date, edtDataFinal.Date)
      else if (not chkEntreDatas.checked) and (trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := TFactory.DaoParceiroVenda.Listar(campo, edtValor.Text + '%')
      else
        dbGridResultado.DataSource.DataSet := TFactory.DaoParceiroVenda.Listar(Date, Date);

      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('TOTALCOMISSAO')).Currency := true;
      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('TOTALPAGAMENTO')).Currency := true;
      CalculaTotais;
    finally
      self.actPesquisa.Enabled := true;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroVendasParceiro.actCancelarExecute(Sender: TObject);
var
  ParceiroVenda: TParceiroVenda;
begin
  try
    ValidaGrid;

    if not TFactory.VendedorLogado.PODECANCELARPEDIDO then
      raise Exception.create('Vendedor não tem permissão para cancelar pedido');

    if MessageDlg('Deseja Cancelar a venda do Parceiro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      ParceiroVenda := TFactory
        .DaoParceiroVenda
        .GeTParceiroVenda(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
      ParceiroVenda.STATUS := 'C';
      ParceiroVenda.VendedorCancelamento := TFactory.DaoVendedor.GetVendedor(TFactory.VendedorLogado.CODIGO);
      ParceiroVenda.DATACANCELAMENTO := now;

      TFactory
        .DaoParceiroVenda
        .AtualizaParceiroVendas(ParceiroVenda);

      dbGridResultado.DataSource.DataSet.Edit;
      dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString := 'C';
      dbGridResultado.DataSource.DataSet.Post;
      if Assigned(ParceiroVenda) then
        FreeAndNil(ParceiroVenda);
    end;

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroVendasParceiro.actDetalhesExecute(Sender: TObject);
begin
  inherited;
  Detalhes;
end;

procedure TfrmFiltroVendasParceiro.CalculaTotais;
var
  TotalLiquidoConcluido: Currency;
  TotalLiquidoCancelado: Currency;
  TotalLiquidoNaoFinalizado: Currency;

  campo: string;
begin
  TTask.Run(
    procedure
    begin
      { Some calculation that takes time }

      TThread.Synchronize(nil,
        procedure
        begin
          try
            case cbbCampoSomar.ItemIndex of
              0:
                campo := 'TOTALCOMISSAO';
              1:
                campo := 'TOTALPAGAMENTO';

            else
              campo := 'TOTALCOMISSAO'
            end;

            dbGridResultado.DataSource.DataSet.DisableControls;
            dbGridResultado.DataSource.DataSet.First;
            TotalLiquidoConcluido := 0;
            TotalLiquidoCancelado := 0;
            TotalLiquidoNaoFinalizado := 0;
            while not dbGridResultado.DataSource.DataSet.Eof do
            begin
              if (dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString = 'A') then
              begin
                TotalLiquidoNaoFinalizado := TotalLiquidoNaoFinalizado + dbGridResultado.DataSource.DataSet.FieldByName(campo).AsCurrency;
              end
              else if (dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString = 'C') then
              begin
                TotalLiquidoCancelado := TotalLiquidoCancelado + dbGridResultado.DataSource.DataSet.FieldByName(campo).AsCurrency;
              end
              else
              begin
                TotalLiquidoConcluido := TotalLiquidoConcluido + dbGridResultado.DataSource.DataSet.FieldByName(campo).AsCurrency;
              end;
              dbGridResultado.DataSource.DataSet.Next;
            end;
            lblTotalLiquidoConcluido.Caption := FormatCurr('R$ 0.,00', TotalLiquidoConcluido);
            lblTotalCancelado.Caption := FormatCurr('R$ 0.,00', TotalLiquidoCancelado);

          finally
            dbGridResultado.DataSource.DataSet.First;
            dbGridResultado.DataSource.DataSet.EnableControls;
          end;
        end

        );
    end);

end;

procedure TfrmFiltroVendasParceiro.cbbCampoSomarChange(Sender: TObject);
begin
  inherited;
  if Assigned(dbGridResultado.DataSource.DataSet) and (dbGridResultado.DataSource.DataSet.Active) then
    CalculaTotais;
end;

procedure TfrmFiltroVendasParceiro.dbGridResultadoDblClick(Sender: TObject);
begin
  inherited;
  Detalhes;
end;

procedure TfrmFiltroVendasParceiro.dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString = 'C' then
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

procedure TfrmFiltroVendasParceiro.Detalhes;
var
  ParceiroVenda: TParceiroVenda;
begin
  try
    if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
      raise Exception.create('Nenhum registro selecionado');

    ValidaGrid;

    FrmPagtoDetalhes := TFrmPagtoDetalhes.create(self);
    try
      ParceiroVenda := TFactory.DaoParceiroVenda.GeTParceiroVenda(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);

      FrmPagtoDetalhes.SetParceiroVenda(ParceiroVenda);
      FrmPagtoDetalhes.ShowModal;

      if Assigned(ParceiroVenda) then
        FreeAndNil(ParceiroVenda);
    finally
      FreeAndNil(FrmPagtoDetalhes);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroVendasParceiro.edtDataInicialKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    BTN_Consultar.SetFocus;
end;

procedure TfrmFiltroVendasParceiro.FormShow(Sender: TObject);
begin
  inherited;
  edtDataInicial.Date := now;
  edtDataFinal.Date := IncMonth(now, 1);
  Pesquisar;
end;

procedure TfrmFiltroVendasParceiro.ValidaGrid;
begin
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.create('Nenhum registro selecionado');

end;

end.
