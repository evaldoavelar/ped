unit Recebimento.ConfirmaBaixa;

interface

uses
  System.Bindings.Helper, System.Generics.Collections, Dominio.Entidades.Pedido.Parcela.Pagamentos,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, IFactory.Dao, Dao.IDaoParcelas, Dominio.Entidades.TPedido, Dao.IDAOParcelaPagamento,
  Dominio.Entidades.TParcelas, JvExMask, JvToolEdit, JvBaseEdits, Util.VclFuncoes,
  Vcl.Mask;

type
  TfrmConfirmaBaixa = class(TfrmBase)
    Panel1: TPanel;
    Label11: TLabel;
    lblParcela: TLabel;
    Label1: TLabel;
    lblVencimento: TLabel;
    Label3: TLabel;
    lblConfirma: TLabel;
    lbl1: TLabel;
    edtDatBaixa: TJvDateEdit;
    edtValor: TJvCalcEdit;
    GridPanel1: TGridPanel;
    BitBtn1: TBitBtn;
    btnCancelar: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDatBaixaChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    FFactory: IFactoryDao;
    FDAOParcelaPagamento: IDAOParcelaPagamento;
    DaoParcelas: IDaoParcelas;
    FParcelas: TList<TParcelas>;
    FParcelaPagamento: TParcelaPagamentos;
    procedure Bind;
    function TotalParcelas: currency;
    { Private declarations }
  public
    { Public declarations }
    property ParcelaPagamento: TParcelaPagamentos read FParcelaPagamento write FParcelaPagamento;

  end;

var
  frmConfirmaBaixa: TfrmConfirmaBaixa;

implementation

{$R *.dfm}


uses Sistema.TLog, Factory.Dao, Pedido.Pagamento, Utils.ArrayUtil;

procedure TfrmConfirmaBaixa.Bind;
var
  LParcelas: TArray<string>;
  Lvencimentos: TArray<string>;
begin
  TLog.d('>>> Entrando em  TfrmConfirmaBaixa.Bind ');
  for var Parcela in ParcelaPagamento.Parcelas do
  begin
    if Parcela.RECEBIDO = 'S' then
      continue;

    TArrayUtil<string>.Append(LParcelas, Parcela.NUMPARCELA.ToString());
    TArrayUtil<string>.Append(Lvencimentos, DateToStr(Parcela.VENCIMENTO));
  end;

  lblParcela.Caption := TArrayUtil<string>.ConcatStr(LParcelas, ',');
  lblVencimento.Caption := TArrayUtil<string>.ConcatStr(Lvencimentos, ',');
  edtValor.Value := TotalParcelas();
  edtDatBaixa.Date := now;
  TLog.d('<<< Saindo de TfrmConfirmaBaixa.Bind ');
end;

procedure TfrmConfirmaBaixa.BitBtn1Click(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConfirmaBaixa.BitBtn1Click ');
  try

    inherited;
    FrmPagamento := TFrmPagamento.Create(Self);
    try
      FrmPagamento.Recebimento := true;
      FrmPagamento.Pagamentos := FParcelaPagamento.Pagamentos;
      FrmPagamento.OnGetValorLiquido := function(): currency
        begin
          result := TotalParcelas()
        end;
      FrmPagamento.OnValorBruto := function(): currency
        begin
          result := TotalParcelas()
        end;
      FrmPagamento.Cliente := nil;
      FrmPagamento.OnGetValorDesc := function(): currency
        begin
          result := 0;
        end;
      FrmPagamento.OnSetDesconto := procedure(aTipo: TTipoDesconto; aValor: currency)
        begin

        end;

      FrmPagamento.IDPedido := ParcelaPagamento.Parcelas.First.IDPedido;
      FrmPagamento.ShowModal;

      if FParcelaPagamento.Pagamentos.FormasDePagamento.Count = 0 then
        exit;

      FDAOParcelaPagamento.Incluir(ParcelaPagamento);
      ModalResult := mrYes;
      close;
    finally
      FrmPagamento.Free;
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmConfirmaBaixa.BitBtn1Click ');
end;

procedure TfrmConfirmaBaixa.edtDatBaixaChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Date');
end;

procedure TfrmConfirmaBaixa.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConfirmaBaixa.FormCreate ');
  inherited;
  TVclFuncoes.DisableVclStyles(Self, 'TLabel');
  FFactory := Tfactory.new(nil, true);
  DaoParcelas := FFactory.DaoParcelas;
  FDAOParcelaPagamento := FFactory.DAOParcelaPagamento;
  FParcelaPagamento := TParcelaPagamentos.Create;
  TLog.d('<<< Saindo de TfrmConfirmaBaixa.FormCreate ');
end;

procedure TfrmConfirmaBaixa.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmConfirmaBaixa.FormShow ');
  inherited;
  Bind;
  TLog.d('<<< Saindo de TfrmConfirmaBaixa.FormShow ');
end;

function TfrmConfirmaBaixa.TotalParcelas: currency;
begin
  result := 0;
  for var Parcela in ParcelaPagamento.Parcelas do
  begin
    if Parcela.RECEBIDO = 'S' then
      continue;

    result := result + Parcela.VALOR;
  end;
end;

end.
