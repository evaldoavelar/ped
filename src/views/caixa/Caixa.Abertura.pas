unit Caixa.Abertura;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.Mask, JvExMask, Sistema.TParametros,
  JvToolEdit, JvBaseEdits, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Dominio.Entidades.TControleCaixa,
  Factory.Entidades,
  Vcl.Imaging.pngimage, JvExControls, JvNavigationPane, Util.VclFuncoes, IFactory.Dao;

type
  TfrmCaixaAbertura = class(TfrmBase)
    jvPnl1: TJvNavPanelHeader;
    lbl2: TLabel;
    Image1: TImage;
    pnl1: TPanel;
    btnAbrirCaixa: TBitBtn;
    BitBtn2: TBitBtn;
    pnl2: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    edtSaldoAnteior: TJvCalcEdit;
    edtValorAdicional: TJvCalcEdit;
    btnRepetir: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtValorAdicionalKeyPress(Sender: TObject; var Key: Char);
    procedure btnAbrirCaixaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnRepetirClick(Sender: TObject);
  private
    { Private declarations }
    FParametros: TParametros;
    FFactory: IFactoryDao;
    FCaixaAnterior: TControleCaixa;
  public
    { Public declarations }
  end;

var
  frmCaixaAbertura: TfrmCaixaAbertura;

implementation

{$R *.dfm}


uses Sistema.TLog, Factory.Dao, Utils.ArrayUtil, Relatorio.TRCaixa.Abertura, System.Generics.Collections;

procedure TfrmCaixaAbertura.btnAbrirCaixaClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCaixaAbertura.btnAbrirCaixaClick ');
  inherited;
  try
    if MessageDlg('Deseja Abrir o Caixa Agora?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      exit;

    var
    LcontroleCaixa := TControleCaixa.Create;
    LcontroleCaixa.DataAbertura := now;
    LcontroleCaixa.NUMCAIXA := FParametros.PontoVenda.NUMCAIXA;
    LcontroleCaixa.ValorAbertura := edtValorAdicional.Value;
    LcontroleCaixa.CODVEN := TFactoryEntidades.new.VendedorLogado.CODIGO;
    FFactory.DAOControleCaixa.AbrirCaixa(LcontroleCaixa);

    var
    LImpressao := TRCaixaAbertura.Create(TFactoryEntidades.Parametros.ImpressoraTermica);
    var
    LTotais := TList < TPair < string, string >>.Create;
    LTotais.Add(TPair<string, string>.Create('Valor Abertura', FormatCurr('R$ ###,##0.00', LcontroleCaixa.ValorAbertura)));
    LTotais.Add(TPair<string, string>.Create('Saldo Anterior', FormatCurr('R$ ###,##0.00', edtSaldoAnteior.Value)));

    LImpressao.Imprime(
      LcontroleCaixa.DataAbertura,
      TFactoryEntidades.new.VendedorLogado,
      TFactory.new(nil, true).DadosEmitente,
      LTotais);

    FreeAndNil(LcontroleCaixa);
    close;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCaixaAbertura.btnAbrirCaixaClick ');
end;

procedure TfrmCaixaAbertura.btnRepetirClick(Sender: TObject);
begin
  inherited;
  edtValorAdicional.Text := edtSaldoAnteior.Text;
end;

procedure TfrmCaixaAbertura.edtValorAdicionalKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnAbrirCaixa.Click;
end;

procedure TfrmCaixaAbertura.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCaixaAbertura.FormCreate ');
  inherited;
  FFactory := TFactory.new(nil, true);
  TLog.d('<<< Saindo de TfrmCaixaAbertura.FormCreate ');
end;

procedure TfrmCaixaAbertura.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCaixaAbertura.FormDestroy ');
  if Assigned(FCaixaAnterior) then
    FreeAndNil(FCaixaAnterior);
  inherited;
  TLog.d('<<< Saindo de TfrmCaixaAbertura.FormDestroy ');
end;

procedure TfrmCaixaAbertura.FormShow(Sender: TObject);
begin
  inherited;
  TLog.d('>>> Entrando em  TfrmCaixaAbertura.FormShow ');

  try
    edtSaldoAnteior.Value := 0;
    FParametros := FFactory.DaoParametros.GetParametros;
    FCaixaAnterior := FFactory.DAOControleCaixa.CaixaAnterior(FParametros.PontoVenda.NUMCAIXA);

    if FCaixaAnterior <> nil then
      edtSaldoAnteior.Value := FCaixaAnterior.ValorFechamento;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TfrmCaixaAbertura.FormShow ');
end;

end.
