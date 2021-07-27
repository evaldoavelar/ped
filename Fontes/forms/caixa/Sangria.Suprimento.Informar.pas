unit Sangria.Suprimento.Informar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Dominio.Entidades.TSangriaSuprimento, Dominio.Entidades.TSangriaSuprimento.Tipo,
  Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits, Relatorio.TRSangriaSuprimento,
  JvComponentBase, JvEnterTab;

type
  TFrmSangria = class(TfrmBase)
    mmoHISTORICO: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    edtForma: TEdit;
    Label3: TLabel;
    lblSangriaSuprimento: TLabel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    edtValor: TJvCalcEdit;
    JvEnterAsTab1: TJvEnterAsTab;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtFormaChange(Sender: TObject);
  private
    { Private declarations }
    FSangriaSuprimento: TSangriaSuprimento;
  public
    { Public declarations }
    procedure setTipo(aTipo: TSangriaSuprimentoTipo);
  end;

var
  FrmSangria: TFrmSangria;

implementation

uses
  System.Bindings.Helper, Dominio.Entidades.TFactory;

{$R *.dfm}


procedure TFrmSangria.btnCancelarClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmSangria.btnOkClick(Sender: TObject);
var
  impressao: TRSangriaSuprimento;
begin
  try
    inherited;
    FSangriaSuprimento.DATA := now;
    FSangriaSuprimento.HORA := now;

    TFactory
      .DAOTSangriaSuprimento
      .Inclui(FSangriaSuprimento);

    try
      impressao := TRSangriaSuprimento.Create(TFactory.Parametros.Impressora);

      impressao.Imprime(
        FSangriaSuprimento,
        TFactory.VendedorLogado,
        TFactory.DadosEmitente
        );

      FreeAndNil(impressao);
    except
      on E: Exception do
        MessageDlg(E.Message, mtError, [mbOK], 0);
    end;

    close;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;

end;

procedure TFrmSangria.edtFormaChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TFrmSangria.edtValorChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Value');
end;

procedure TFrmSangria.FormCreate(Sender: TObject);
begin
  inherited;
  FSangriaSuprimento:= TSangriaSuprimento.create;
  FSangriaSuprimento.FORMA := 'Dinheiro';

  FSangriaSuprimento.Bind('FORMA', edtForma, 'Text');
  FSangriaSuprimento.Bind('VALOR', edtValor, 'Value');
  FSangriaSuprimento.Bind('HISTORICO', mmoHISTORICO, 'Text');
   FSangriaSuprimento.CODVEN := TFactory.VendedorLogado.CODIGO;
end;

procedure TFrmSangria.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FSangriaSuprimento);
end;

procedure TFrmSangria.setTipo(aTipo: TSangriaSuprimentoTipo);
begin
  FSangriaSuprimento.TipoSangriaSuprimento := aTipo;
  lblSangriaSuprimento.Caption := aTipo.Descricao;
  self.Caption := aTipo.Descricao;
end;

end.
