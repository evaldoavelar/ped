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
    edtPagamentos: TJvCalcEdit;
    edtSuprimento: TJvCalcEdit;
    Image1: TImage;
    lbl2: TLabel;
    edtSangria: TJvCalcEdit;
    Label4: TLabel;
    edtTrocos: TJvCalcEdit;
    Label5: TLabel;
    edtTotalDeCaixa: TJvCalcEdit;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAbrirCaixaClick(Sender: TObject);
  private
    { Private declarations }
    FParametros: TParametros;
    FFactory: IFactoryDao;
    FCaixaAberto: TControleCaixa;
    FEmProcessamento: boolean;
    procedure CalculaTotalCaixa;
  public
    { Public declarations }
  end;

var
  frmCaixaFechamento: TfrmCaixaFechamento;

implementation

{$R *.dfm}


uses Sistema.TLog, Factory.Dao, Utils.ArrayUtil, Relatorio.TRVendasDoDia,
  System.Threading, System.DateUtils;

procedure TfrmCaixaFechamento.btnAbrirCaixaClick(Sender: TObject);
begin
  inherited;
  TLog.d('>>> Entrando em  TfrmCaixaFechamento.btnAbrirCaixaClick ');

  try
    if FCaixaAberto = nil then
      raise Exception.Create('Caixa não foi aberto');

    if MessageDlg('Deseja Fechar o Caixa Agora?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      exit;

    FCaixaAberto.DataFechamento := now;
    FCaixaAberto.ValorFechamento := edtTotalDeCaixa.Value;
    FFactory.DAOControleCaixa.FecharCaixa(FCaixaAberto);

    var
    LFactory := TFactory.new(nil, true);
    var
    impressao := TRVendasDoDia.Create(TFactoryEntidades.Parametros.ImpressoraTermica);
    var
    vendedor := TFactoryEntidades.new.VendedorLogado;

    var
    totais := LFactory.DaoPedido.totais(
      FCaixaAberto.DataAbertura,
      FCaixaAberto.DataFechamento,
      TimeOf(FCaixaAberto.DataAbertura),
      TimeOf(FCaixaAberto.DataFechamento));

    totais.Insert(0, TPair<string, string>.Create('Valor Abertura Caixa', FormatCurr('R$ ###,##0.00', FCaixaAberto.ValorAbertura)));
    totais.Insert(1, TPair<string, string>.Create('Valor Fechamento Caixa', FormatCurr('R$ ###,##0.00', FCaixaAberto.ValorFechamento)));
    totais.Insert(2, TPair<string, string>.Create(' ', ''));

    impressao.Imprime(
      vendedor,
      FCaixaAberto.DataAbertura,
      FCaixaAberto.DataFechamento,
      vendedor,
      LFactory.DadosEmitente,
      totais
      );

    FreeAndNil(impressao);
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

procedure TfrmCaixaFechamento.CalculaTotalCaixa();
begin
  edtTotalDeCaixa.Value := edtSaldoAnteior.Value + edtPagamentos.Value + edtSuprimento.Value - edtTrocos.Value - edtSangria.Value;
end;

procedure TfrmCaixaFechamento.FormShow(Sender: TObject);
var
  tasks: array of ITask;
begin
  TLog.d('>>> Entrando em  TfrmCaixaFechamento.FormShow ');
  inherited;

  try
    FParametros := FFactory.DaoParametros.GetParametros;
    FCaixaAberto := FFactory.DAOControleCaixa.CaixaAberto(FParametros.PontoVenda.NUMCAIXA);
    FEmProcessamento := true;

    if FCaixaAberto <> nil then
    begin
      Setlength(tasks, 4);

      tasks[0] := TTask.Create(
        procedure()
        begin
          try

            var
            LTotal := TFactory.new().DaoPedido.TotalCaixa(FCaixaAberto.DataAbertura, now);

            TThread.Queue(nil,
              procedure
              begin
                edtPagamentos.Value := LTotal;
                CalculaTotalCaixa();
              end);
          except
            on E: Exception do
              TLog.d(E.message);
          end;
        end);
      tasks[0].Start;

      tasks[1] := TTask.Create(
        procedure()
        begin
          try
            var
            LTotal := TFactory.new().DaoPedido.TotalTroco(FCaixaAberto.DataAbertura, now);

            TThread.Queue(nil,
              procedure
              begin
                edtTrocos.Value := LTotal;
                CalculaTotalCaixa();
              end);
          except
            on E: Exception do
              TLog.d(E.message);
          end;
        end);
      tasks[1].Start;

      tasks[2] := TTask.Create(
        procedure()
        begin
          try
            var
            LTotal := TFactory.new().DAOTSangriaSuprimento.TotalSangriaSuprimento(1, FCaixaAberto.DataAbertura);

            TThread.Queue(nil,
              procedure
              begin
                edtSangria.Value := LTotal;
                CalculaTotalCaixa();
              end);
          except
            on E: Exception do
              TLog.d(E.message);
          end;
        end);
      tasks[2].Start;

      tasks[3] := TTask.Create(
        procedure()
        begin
          try
            var
            LTotal := TFactory.new().DAOTSangriaSuprimento.TotalSangriaSuprimento(2, FCaixaAberto.DataAbertura);

            TThread.Queue(nil,
              procedure
              begin
                edtSuprimento.Value := LTotal;
                CalculaTotalCaixa();
              end);
          except
            on E: Exception do
              TLog.d(E.message);
          end;
        end);
      tasks[3].Start;

      edtSaldoAnteior.Value := FCaixaAberto.ValorAbertura;
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
