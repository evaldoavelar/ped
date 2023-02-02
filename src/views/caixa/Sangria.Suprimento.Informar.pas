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
  System.Bindings.Helper, Factory.Dao, Factory.Entidades, Sistema.TLog;

{$R *.dfm}


procedure TFrmSangria.btnCancelarClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmSangria.btnCancelarClick ');
  inherited;
  close;
  TLog.d('<<< Saindo de TFrmSangria.btnCancelarClick ');
end;

procedure TFrmSangria.btnOkClick(Sender: TObject);
var
  impressao: TRSangriaSuprimento;
begin
  TLog.d('>>> Entrando em  TFrmSangria.btnOkClick ');
  try
    inherited;
    FSangriaSuprimento.DATA := now;
    FSangriaSuprimento.HORA := now;

    fFactory
      .DAOTSangriaSuprimento
      .Inclui(FSangriaSuprimento);

    try
      impressao := TRSangriaSuprimento.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

      impressao.Imprime(
        FSangriaSuprimento,
        TFactoryEntidades.new.VendedorLogado,
        fFactory.DadosEmitente
        );

      FreeAndNil(impressao);
    except
      on e: Exception do
      begin
        TLog.d(e.Message);
        MessageDlg(e.Message, mtError, [mbOK], 0);
      end;
    end;

    close;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmSangria.btnOkClick ');
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
  TLog.d('>>> Entrando em  TFrmSangria.FormCreate ');
  inherited;
  fFactory := TFactory.new(nil, True);
  FSangriaSuprimento := TSangriaSuprimento.Create;
  FSangriaSuprimento.FORMA := 'Dinheiro';

  FSangriaSuprimento.Bind('FORMA', edtForma, 'Text');
  FSangriaSuprimento.Bind('VALOR', edtValor, 'Value');
  FSangriaSuprimento.Bind('HISTORICO', mmoHISTORICO, 'Text');
  FSangriaSuprimento.CODVEN := TFactoryEntidades.new.VendedorLogado.CODIGO;
  TLog.d('<<< Saindo de TFrmSangria.FormCreate ');
end;

procedure TFrmSangria.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmSangria.FormDestroy ');
  inherited;
  FreeAndNil(FSangriaSuprimento);
  fFactory.close;
  TLog.d('<<< Saindo de TFrmSangria.FormDestroy ');
end;

procedure TFrmSangria.setTipo(aTipo: TSangriaSuprimentoTipo);
begin
  TLog.d('>>> Entrando em  TFrmSangria.setTipo ');
  FSangriaSuprimento.TipoSangriaSuprimento := aTipo;
  lblSangriaSuprimento.Caption := aTipo.Descricao;
  self.Caption := aTipo.Descricao;
  TLog.d('<<< Saindo de TFrmSangria.setTipo ');
end;

end.
