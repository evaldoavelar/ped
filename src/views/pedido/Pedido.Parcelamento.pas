unit Pedido.Parcelamento;

interface

uses
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits, Vcl.ExtCtrls, Vcl.Buttons,
  JvExStdCtrls, JvEdit, JvValidateEdit, JvMaskEdit, JvCheckedMaskEdit, JvDatePickerEdit, Vcl.ActnList,
  Dao.IDaoFormaPagto,
  Dominio.Entidades.TPedido, Dominio.Entidades.TParcelas, Dominio.Entidades.TFormaPagto, Dominio.Entidades.TFactory,
  System.Actions, Vcl.Imaging.jpeg, Util.VclFuncoes, Vcl.Imaging.pngimage,
  Dominio.Entidades.Pedido.Pagamentos.Pagamento;

type
  TFrmParcelamento = class(TfrmBase)
    pnlCentro: TPanel;
    labForma: TLabel;
    pnl2: TPanel;
    Label3: TLabel;
    pnl3: TPanel;
    btnOK: TBitBtn;
    lstFormaPagto: TListBox;
    img2: TImage;
    actParcelamento: TActionList;
    actOk: TAction;
    actCancelar: TAction;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    lstParcelas: TListBox;
    Label4: TLabel;
    img3: TImage;
    Label6: TLabel;
    lbl1: TLabel;
    pnlImage4: TPanel;
    lblSubTotal: TLabel;
    Image3: TPanel;
    lblValorPedido: TLabel;
    pnlEntrada: TPanel;
    edtValorEntrada: TJvCalcEdit;
    pnlData: TPanel;
    medtData: TJvDateEdit;
    Panel21: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstFormaPagtoKeyPress(Sender: TObject; var Key: Char);
    procedure actOkExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lstFormaPagtoEnter(Sender: TObject);
    procedure lstFormaPagtoExit(Sender: TObject);
    procedure lstParcelasKeyPress(Sender: TObject; var Key: Char);
    procedure medtDataKeyPress(Sender: TObject; var Key: Char);
    procedure lstParcelasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure medtDataKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lstFormaPagtoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnOKKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtValorEntradaExit(Sender: TObject);
    procedure edtValorEntradaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtValorEntradaEnter(Sender: TObject);
    procedure medtDataEnter(Sender: TObject);
    procedure medtDataExit(Sender: TObject);
  private
    FPedido: TPedido;
    FOLDOnChange: TOnChange;
    pagtos: TObjectList<TFormaPagto>;

    daoTFormaPagto: IDaoFormaPagto;
    FPagto: TPEDIDOPAGAMENTO;
    procedure IncializaComponentes;
    procedure PopulaLista;
    procedure ParcelaPedido;
    procedure OnPedidoChange(ValorLiquido, ValorBruto: currency; Volume: Double);
    procedure SetPagto(const Value: TPEDIDOPAGAMENTO);
    { Private declarations }
  public
    { Public declarations }
    property Pedido: TPedido read FPedido write FPedido;
    property Pagto: TPEDIDOPAGAMENTO read FPagto write SetPagto;
  end;

var
  FrmParcelamento: TFrmParcelamento;

implementation

uses
  Util.Funcoes, Util.Exceptions, Dominio.Entidades.TFormaPagto.Tipo;

{$R *.dfm}


procedure TFrmParcelamento.actCancelarExecute(Sender: TObject);
begin
  inherited;
  self.Pagto.parcelas.Clear;
  self.Close;
end;

procedure TFrmParcelamento.actOkExecute(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TFrmParcelamento.btnOKKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
    medtData.SetFocus;
end;

procedure TFrmParcelamento.edtValorEntradaEnter(Sender: TObject);
begin
  inherited;
  pnlEntrada.Color := $00ECE3D2;
  edtValorEntrada.Font.Color := $00A25800;
end;

procedure TFrmParcelamento.edtValorEntradaExit(Sender: TObject);
begin
  inherited;
  try
    self.Pedido.ValorEntrada := edtValorEntrada.Value;
    pnlEntrada.Color := $00A25800;
    edtValorEntrada.Font.Color := clWhite;
  except
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      Exit;
    end;
  end;
end;

procedure TFrmParcelamento.edtValorEntradaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if Key = #13 then
  begin
    try
      lstFormaPagto.SetFocus;
    except
    end;
  end;
end;

procedure TFrmParcelamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Pedido.OnChange := FOLDOnChange
end;

procedure TFrmParcelamento.FormCreate(Sender: TObject);
begin
  inherited;
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
  TVclFuncoes.DisableVclStyles(self, 'TListBox');
  daoTFormaPagto := TFactory.DaoFormaPagto;
end;

procedure TFrmParcelamento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(pagtos);
  inherited;
end;

procedure TFrmParcelamento.FormShow(Sender: TObject);
begin
  inherited;
  IncializaComponentes;

end;

procedure TFrmParcelamento.IncializaComponentes;
begin
  try
    try
      self.lblSubTotal.Caption := FormatCurr('R$ ###,##0.00', Pedido.ValorLiquido);
    except
      on E: Exception do
        raise Exception.Create('Falha lblSubTotal IncializaComponentes');
    end;

    try
      self.lblValorPedido.Caption := FormatCurr('R$ ###,##0.00', Pedido.ValorBruto);
    except
      on E: Exception do
        raise Exception.Create('Falha lblValorPedido IncializaComponentes');
    end;

    FOLDOnChange := Pedido.OnChange;
    Pedido.OnChange := OnPedidoChange;

    lstFormaPagto.Clear;
    PopulaLista;
    lstFormaPagto.ItemIndex := 0;
    lstParcelas.Clear;

    Pedido.ValorEntrada := 0;
    edtValorEntrada.Value := Pedido.ValorEntrada;
    edtValorEntrada.SetFocus;

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmParcelamento.lstFormaPagtoEnter(Sender: TObject);
begin
  inherited;
  { TListBox(Sender).Font.Size := TListBox(Sender).Font.Size + 2;
    TListBox(Sender).Repaint;
    Aplication.ProcessMessages; }

  TListBox(Sender).Color := $00ECE3D2;
end;

procedure TFrmParcelamento.lstFormaPagtoExit(Sender: TObject);
begin
  inherited; {
    TListBox(Sender).Font.Size := TListBox(Sender).Font.Size - 2;
    TListBox(Sender).Repaint;
    Application.ProcessMessages; }
  TListBox(Sender).Color := clWindow;
end;

procedure TFrmParcelamento.lstFormaPagtoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    try
      medtData.SetFocus;
      if medtData.Text = '  /  /    ' then
        medtData.Text := DateToStr(IncMonth(now, 1));
    except
    end;
  end;
end;

procedure TFrmParcelamento.lstFormaPagtoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  if Key = VK_ESCAPE then
    actCancelar.Execute;
end;

procedure TFrmParcelamento.lstParcelasKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnOK.SetFocus
end;

procedure TFrmParcelamento.lstParcelasKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
    medtData.SetFocus;
end;

procedure TFrmParcelamento.medtDataEnter(Sender: TObject);
begin
  inherited;
  pnlData.Color := $00ECE3D2;
end;

procedure TFrmParcelamento.medtDataExit(Sender: TObject);
begin
  inherited;
  pnlData.Color := $00FCFCFC;
end;

procedure TFrmParcelamento.medtDataKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    ParcelaPedido
end;

procedure TFrmParcelamento.medtDataKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
    lstFormaPagto.SetFocus;
end;

procedure TFrmParcelamento.OnPedidoChange(ValorLiquido, ValorBruto: currency;
  Volume: Double);
begin
  try
    self.lblSubTotal.Caption := FormatCurr('R$ ###,##0.00', ValorLiquido);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;

  try
    self.lblValorPedido.Caption := FormatCurr('R$ ###,##0.00', Pedido.ValorBruto);
  except
    on E: Exception do
      raise Exception.Create('Falha lblValorPedido IncializaComponentes');
  end;
end;

procedure TFrmParcelamento.ParcelaPedido;
var
  parcela: TParcelas;
  NumParcelas: Integer;
  VencimentoPrimeiraParcela: TDate;
begin
  try
    NumParcelas := TFormaPagto(lstFormaPagto.Items.Objects[lstFormaPagto.ItemIndex]).CONDICAODEPAGTO[0].quantasVezes;
    try
      VencimentoPrimeiraParcela := StrToDate(medtData.Text);
    except
      raise TValidacaoException.Create('Data Inválida');
    end;

    // if (DayOfWeek(VencimentoPrimeiraParcela) = 7) or (DayOfWeek(VencimentoPrimeiraParcela) = 1) then
    // raise TValidacaoException.Create('A data de vencimento da primeira parcela não pode Cair em um final de semana');

    if VencimentoPrimeiraParcela <= Date then
      raise TValidacaoException.Create('A data de vencimento precisa ser maior que o dia de hoje');

    Pagto.ParcelarPedido(FPedido.Cliente.CODIGO, NumParcelas, VencimentoPrimeiraParcela);

    lstParcelas.Clear;
    for parcela in Pagto.parcelas do
    begin
      lstParcelas.Items.Add(
        TUtil.PadR(IntToStr(parcela.NUMPARCELA) + 'ª', 25, ' ')
        + TUtil.PadR(FormatCurr('R$ ###,##0.00', parcela.VALOR), 20, ' ')
        + DateToStr(parcela.VENCIMENTO)
        )
    end;

    try
      lstParcelas.ItemIndex := 0;
      lstParcelas.SetFocus;
    except
    end;
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TFrmParcelamento.PopulaLista;
var
  Pagto: TFormaPagto;
  I: Integer;
begin
  try
    pagtos := daoTFormaPagto.ListaObject();

    for Pagto in pagtos do
    begin
      if Pagto.TipoPagamento = TTipoPagto.Crediario then
        lstFormaPagto.Items.AddObject(Pagto.DESCRICAO, Pagto);
    end;

    medtData.Text := '  /  /    ';

  except
    on E: Exception do
      raise Exception.Create('Falha ao popular lista: ' + E.Message);
  end;

end;



procedure TFrmParcelamento.SetPagto(const Value: TPEDIDOPAGAMENTO);
begin
  FPagto := Value;
end;

end.
