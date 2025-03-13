unit Caixa.Fechamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.Mask, JvExMask, Sistema.TParametros,
  JvToolEdit, JvBaseEdits, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Dominio.Entidades.TControleCaixa,
  Factory.Entidades, System.Generics.Collections,
  Vcl.Imaging.pngimage, JvExControls, JvNavigationPane, Util.VclFuncoes, IFactory.Dao;

type
  TfrmCaixaFechamento = class(TfrmBase)
    jvPnl1: TJvNavPanelHeader;
    pnl1: TPanel;
    pnl2: TPanel;
    btnAbrirCaixa: TBitBtn;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtSaldoAnteior: TJvCalcEdit;
    edtTotalDeCaixa: TJvCalcEdit;
    edtSangria: TJvCalcEdit;
    Image1: TImage;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAbrirCaixaClick(Sender: TObject);
  private
    { Private declarations }
    FParametros: TParametros;
    FFactory: IFactoryDao;
    FCaixaAberto: TControleCaixa;
  public
    { Public declarations }
  end;

var
  frmCaixaFechamento: TfrmCaixaFechamento;

implementation

{$R *.dfm}


uses Sistema.TLog, Factory.Dao, Utils.ArrayUtil, Relatorio.TRVendasDoDia, system.DateUtils;

procedure TfrmCaixaFechamento.btnAbrirCaixaClick(Sender: TObject);
begin
  inherited;
  TLog.d('>>> Entrando em  TfrmCaixaFechamento.btnAbrirCaixaClick ');

  try
    if FCaixaAberto = nil then
      raise Exception.Create('Caixa não foi aberto');

    if MessageDlg('Deseja Fechar o Caixa Agora?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      exit;

    var
    LcontroleCaixa := TControleCaixa.Create;
    LcontroleCaixa.DataFechamento := now;
    LcontroleCaixa.ValorFechamento := edtTotalDeCaixa.Value;
    FFactory.DAOControleCaixa.FecharCaixa(LcontroleCaixa);

    var
    LFactory := TFactory.new(nil, true);
    var
    impressao := TRVendasDoDia.Create(TFactoryEntidades.Parametros.ImpressoraTermica);
    var
    vendedor := TFactoryEntidades.new.VendedorLogado;

    var
    totais := LFactory.DaoPedido.totais(
      FCaixaAberto.DataAbertura,
      LcontroleCaixa.DataFechamento,
      TimeOf(FCaixaAberto.DataAbertura),
      TimeOf(LcontroleCaixa.DataFechamento));

    totais.Insert(0, TPair<string, string>.Create('Valor Abertura Caixa', FormatCurr('R$ ###,##0.00', FCaixaAberto.ValorAbertura)));
    totais.Insert(1, TPair<string, string>.Create('Valor Fechamento Caixa', FormatCurr('R$ ###,##0.00', LcontroleCaixa.ValorFechamento)));
    totais.Insert(2, TPair<string, string>.Create(' ', ''));

    impressao.Imprime(
      vendedor,
      FCaixaAberto.DataAbertura,
      LcontroleCaixa.DataFechamento,
      vendedor,
      LFactory.DadosEmitente,
      totais
      );

    FreeAndNil(impressao);
    FreeAndNil(LcontroleCaixa);
    LFactory.Close;

    Close;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TfrmCaixaFechamento.btnAbrirCaixaClick ');
end;

procedure TfrmCaixaFechamento.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCaixaFechamento.FormCreate ');
  inherited;
  FFactory := TFactory.new(nil, true);
  TLog.d('<<< Saindo de TfrmCaixaFechamento.FormCreate ');
end;

procedure TfrmCaixaFechamento.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCaixaFechamento.FormDestroy ');
  inherited;
  if Assigned(FCaixaAberto) then
    FreeAndNil(FCaixaAberto);
  TLog.d('<<< Saindo de TfrmCaixaFechamento.FormDestroy ');
end;

procedure TfrmCaixaFechamento.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCaixaFechamento.FormShow ');
  inherited;

  try
    FParametros := FFactory.DaoParametros.GetParametros;
    FCaixaAberto := FFactory.DAOControleCaixa.CaixaAberto(FParametros.PontoVenda.NUMCAIXA);

    if FCaixaAberto <> nil then
    begin
      edtSaldoAnteior.Value := FCaixaAberto.ValorAbertura;
      edtTotalDeCaixa.Value := FFactory.DaoPedido.TotalCaixa(FCaixaAberto.DataAbertura);
      edtSangria.Value := FFactory.DAOTSangriaSuprimento.TotalSangriaSuprimento(1, FCaixaAberto.DataAbertura);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TfrmCaixaFechamento.FormShow ');

end;

end.
