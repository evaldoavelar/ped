unit Filtro.Parcelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.Threading, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Mask, JvExMask, JvToolEdit, System.Actions, Vcl.ActnList, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.StdCtrls, Vcl.Buttons, JvExControls, JvNavigationPane,
  Dao.IDaoParcelas, Vcl.Imaging.pngimage, Filtro.Base, Consulta.Base,
  Vcl.Imaging.jpeg;

type
  TfrmFiltroParcelas = class(TfrmFiltroBase)
    actDetalhes: TAction;
    actImprimir: TAction;
    actReceber: TAction;
    Label7: TLabel;
    lblTotalAVencer: TLabel;
    lblTotalVencidas: TLabel;
    lblTotalReceber: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel3: TPanel;
    Panel2: TPanel;
    Label4: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    btnDetalhes: TBitBtn;
    btnImprimir: TBitBtn;
    btnReceber: TBitBtn;
    pnl1: TPanel;
    chkVencidas: TCheckBox;
    Label5: TLabel;
    procedure actDetalhesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actEscolheExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actReceberExecute(Sender: TObject);
    procedure dbGridResultadoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure chkEntreDatasClick(Sender: TObject);
    procedure chkVencidasClick(Sender: TObject);
  private
    { Private declarations }

    DaoParcelas: IDaoParcelas;

    procedure Imprimir;
    procedure Detalhes;
    procedure Receber;
    procedure CalculaTotais;

  public
    { Public declarations }
    procedure Pesquisar; override;

  end;

var
  frmFiltroParcelas: TfrmFiltroParcelas;

implementation

uses Relatorio.TRParcelas, Factory.Dao, Dominio.Entidades.TPedido, Recebimento.DetalhesPedido, Dao.IDaoPedido, Recebimento.ConfirmaBaixa,
  Recebimento.Recebe, Sistema.TLog, Factory.Entidades;

procedure TfrmFiltroParcelas.actDetalhesExecute(Sender: TObject);
begin
  inherited;
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.create('Nenhum registro selecionado');

  Detalhes;
end;

procedure TfrmFiltroParcelas.actEscolheExecute(Sender: TObject);
begin
  // inherited;

end;

procedure TfrmFiltroParcelas.actImprimirExecute(Sender: TObject);
begin
  inherited;

  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.create('Nenhum registro selecionado');

  Imprimir;
end;

procedure TfrmFiltroParcelas.actReceberExecute(Sender: TObject);
begin
  inherited;
  Receber;
end;

procedure TfrmFiltroParcelas.dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if (dbGridResultado.DataSource.DataSet.FieldByName('vencimento').AsDateTime >= Date)
    and (dbGridResultado.DataSource.DataSet.FieldByName('recebido').AsString <> 'S')
  then
  begin
    dbGridResultado.Canvas.Font.Color := clWindow;
    dbGridResultado.Canvas.Brush.Color := $00EEAD00;
  end
  else if (dbGridResultado.DataSource.DataSet.FieldByName('vencimento').AsDateTime < Date)
    and (dbGridResultado.DataSource.DataSet.FieldByName('recebido').AsString <> 'S') then
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

procedure TfrmFiltroParcelas.dbGridResultadoKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;

end;

procedure TfrmFiltroParcelas.Detalhes;
var
  Pedido: TPedido;
begin
  TLog.d('>>> Entrando em  TfrmFiltroParcelas.Detalhes ');
  try
    // ValidaGrid;

    frmDetalhesPedido := TfrmDetalhesPedido.create(self);
    try
      Pedido := fFactory.daoPedido.getPedido(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);

      frmDetalhesPedido.Pedido := Pedido;
      frmDetalhesPedido.ShowModal;

      if Assigned(Pedido) then
        FreeAndNil(Pedido);
    finally
      FreeAndNil(frmDetalhesPedido);
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroParcelas.Detalhes ');
end;

procedure TfrmFiltroParcelas.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroParcelas.FormCreate ');
  inherited;
  DaoParcelas := fFactory.DaoParcelas();

  TLog.d('<<< Saindo de TfrmFiltroParcelas.FormCreate ');
end;

procedure TfrmFiltroParcelas.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroParcelas.FormShow ');
  inherited;
  edtDataInicial.Date := now;
  edtDataFinal.Date := IncMonth(now, 1);
  chkVencidas.Checked := True;
  Pesquisar;
  TLog.d('<<< Saindo de TfrmFiltroParcelas.FormShow ');
end;

procedure TfrmFiltroParcelas.Imprimir;
var
  impressao: TRParcela;
begin
  TLog.d('>>> Entrando em  TfrmFiltroParcelas.Imprimir ');
  try

    impressao := TRParcela.create(TFactoryEntidades.Parametros.ImpressoraTermica);

    if dbGridResultado.DataSource.DataSet.IsEmpty then
      raise Exception.create('Nada para imprimir');

  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TfrmFiltroParcelas.Imprimir ');
end;

procedure TfrmFiltroParcelas.Pesquisar;
var
  campo: string;
begin
  TLog.d('>>> Entrando em  TfrmFiltroParcelas.Pesquisar ');
  // inherited;
  try

    LiberaDataSource();
    try

      self.actPesquisa.Enabled := false;
      case cbbPesquisa.ItemIndex of
        0:
          campo := 'c.NOME';
        1:
          campo := 'pe.CODCLIENTE';
        2:
          campo := 'pe.NUMERO';
      else
        campo := 'pe.NUMERO';
      end;

      if chkVencidas.Checked and (Trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := DaoParcelas.GetParcelaVencidasDS(campo, edtValor.Text, now)
      else if chkVencidas.Checked then
        dbGridResultado.DataSource.DataSet := DaoParcelas.GetParcelaVencidasDS(now)
      else if chkEntreDatas.Checked and (Trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := DaoParcelas.GeTParcelas(campo, edtValor.Text, edtDataInicial.Date, edtDataFinal.Date)
      else if (not chkEntreDatas.Checked) and (Trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := DaoParcelas.GeTParcelas(campo, edtValor.Text)
      else
        dbGridResultado.DataSource.DataSet := DaoParcelas.GeTParcelas(edtDataInicial.Date, edtDataFinal.Date);

      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('Valor')).Currency := True;
      CalculaTotais;

    finally
      self.actPesquisa.Enabled := True;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TfrmFiltroParcelas.Pesquisar ');
end;

procedure TfrmFiltroParcelas.CalculaTotais;
var
  totalVencidas: Currency;
  totalVencer: Currency;
  totalRecebido: Currency;

begin
  TLog.d('>>> Entrando em  TfrmFiltroParcelas.CalculaTotais ');
  TTask.Run(
    procedure
    begin
      { Some calculation that takes time }

      TThread.Synchronize(nil,
        procedure
        begin
          try
            dbGridResultado.DataSource.DataSet.DisableControls;
            dbGridResultado.DataSource.DataSet.First;
            totalVencidas := 0;
            totalVencer := 0;
            totalRecebido := 0;

            while not dbGridResultado.DataSource.DataSet.Eof do
            begin
              if (dbGridResultado.DataSource.DataSet.FieldByName('vencimento').AsDateTime < Date)
                and (dbGridResultado.DataSource.DataSet.FieldByName('recebido').AsString <> 'S') then
              begin
                totalVencidas := totalVencidas + dbGridResultado.DataSource.DataSet.FieldByName('Valor').AsCurrency;
              end
              else if (dbGridResultado.DataSource.DataSet.FieldByName('vencimento').AsDateTime >= Date)
                and (dbGridResultado.DataSource.DataSet.FieldByName('recebido').AsString <> 'S') then
              begin
                totalVencer := totalVencer + dbGridResultado.DataSource.DataSet.FieldByName('Valor').AsCurrency;
              end
              else
              begin
                totalRecebido := totalRecebido + dbGridResultado.DataSource.DataSet.FieldByName('Valor').AsCurrency;
              end;
              dbGridResultado.DataSource.DataSet.Next;
            end;
            lblTotalVencidas.Caption := FormatCurr('R$ 0.,00', totalVencidas);
            lblTotalAVencer.Caption := FormatCurr('R$ 0.,00', totalVencer);
            lblTotalReceber.Caption := FormatCurr('R$ 0.,00', totalRecebido);
          finally
            dbGridResultado.DataSource.DataSet.First;
            dbGridResultado.DataSource.DataSet.EnableControls;
          end;
        end

        );
    end);

  TLog.d('<<< Saindo de TfrmFiltroParcelas.CalculaTotais ');
end;

procedure TfrmFiltroParcelas.chkEntreDatasClick(Sender: TObject);
begin
  inherited;
  chkVencidas.Checked := not chkEntreDatas.Checked;
end;

procedure TfrmFiltroParcelas.chkVencidasClick(Sender: TObject);
begin
  inherited;
  chkEntreDatas.Checked := not chkVencidas.Checked;

end;

{$R *.dfm}


procedure TfrmFiltroParcelas.Receber;
begin
  TLog.d('>>> Entrando em  TfrmFiltroParcelas.Receber ');
  try

    if not TFactoryEntidades.new.VendedorLogado.PODERECEBERPARCELA then
      raise Exception.create('Vendedor não tem permissão para acessar recebimento de parcelas');

    frmRecebimento := TfrmRecebimento.create(self);
    try
      frmRecebimento.edtPesquisa.Text := dbGridResultado.DataSource.DataSet.FieldByName('codigo').AsString;
      frmRecebimento.edtPesquisaInvokeSearch(nil);
      frmRecebimento.ShowModal;
    finally
      FreeAndNil(frmRecebimento);
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroParcelas.Receber ');
end;

end.
