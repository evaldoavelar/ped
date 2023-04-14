unit Recebimento.ConfirmaBaixa;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls,
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
    BitBtn1: TBitBtn;
    btnCancelar: TBitBtn;
    lbl1: TLabel;
    edtDatBaixa: TJvDateEdit;
    edtValor: TJvCalcEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtDatBaixaChange(Sender: TObject);
  private
    FParcela: TParcelas;
    procedure Bind;
    { Private declarations }
  public
    { Public declarations }
    property Parcela: TParcelas read FParcela write FParcela;
  end;

var
  frmConfirmaBaixa: TfrmConfirmaBaixa;

implementation

{$R *.dfm}




procedure TfrmConfirmaBaixa.Bind;
begin
  if not Assigned(FParcela) then
    raise Exception.Create('Parcela não associada');

  FParcela.BindReadOnly('NUMPARCELA', lblParcela, 'Caption');
  FParcela.BindReadOnly('VENCIMENTO', lblVencimento, 'Caption');
  FParcela.BindReadOnly('VALOR', edtValor, 'Value');
  FParcela.Bind('DATABAIXA', edtDatBaixa, 'Date');
end;

procedure TfrmConfirmaBaixa.edtDatBaixaChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Date');
end;

procedure TfrmConfirmaBaixa.FormCreate(Sender: TObject);
begin
  inherited;
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
end;

procedure TfrmConfirmaBaixa.FormShow(Sender: TObject);
begin
  inherited;
  Bind;
end;

end.
