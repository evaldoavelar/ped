unit Configuracoes.Parametros;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  ACBrPosPrinter, System.TypInfo,
  Dao.IDaoEmitente, Dominio.Entidades.TEmitente, Sistema.TParametros, Dao.IDaoParametros,
  Data.Bind.Components, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Actions;

type
  TFrmConfiguracoes = class(TfrmBase)
    pnl1: TPanel;
    btnOk: TBitBtn;
    pgc1: TPageControl;
    ts1: TTabSheet;
    act1: TActionList;
    actOk: TAction;
    ts2: TTabSheet;
    chkVenderClienteBloqueado: TCheckBox;
    edtRazaoSocial: TEdit;
    Label2: TLabel;
    edtFantasia: TEdit;
    Label3: TLabel;
    edtCpf: TEdit;
    Label4: TLabel;
    Label10: TLabel;
    edtIE: TEdit;
    edtResponsavel: TEdit;
    edtIM: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtRua: TEdit;
    Label7: TLabel;
    edtBairro: TEdit;
    Label8: TLabel;
    edtCidade: TEdit;
    Label11: TLabel;
    edtComplemento: TEdit;
    Label13: TLabel;
    edtUF: TEdit;
    Label9: TLabel;
    edtCEP: TMaskEdit;
    Label12: TLabel;
    edtNumero: TEdit;
    Label14: TLabel;
    edtTelefone: TMaskEdit;
    lbl2: TLabel;
    edtFax: TMaskEdit;
    edtEmail: TEdit;
    Label15: TLabel;
    chkAtualizaClienteNaVenda: TCheckBox;
    grp1: TGroupBox;
    Label16: TLabel;
    cbxModelo: TComboBox;
    BindingsList1: TBindingsList;
    chkImprimir2Vias: TCheckBox;
    chkImprimirItens2Via: TCheckBox;
    chkBakcup: TCheckBox;
    chkBloquearClienteComAtraso: TCheckBox;
    lbl1: TLabel;
    edtValidadeOrcamento: TEdit;
    rgPesquisaPor: TRadioGroup;
    procedure edtRazaoSocialChange(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cbxModeloChange(Sender: TObject);
    procedure chkVenderClienteBloqueadoClick(Sender: TObject);
    procedure rgPesquisaPorClick(Sender: TObject);
  private
    { Private declarations }
    DaoEmitente: IDaoEmitente;
    DaoParametros: IDaoParametros;
    FEmitente: TEmitente;
    FParametros: TParametros;
    procedure Bind;
    procedure Get();
    procedure salvar();
  public
    { Public declarations }
  end;

var
  FrmConfiguracoes: TFrmConfiguracoes;

implementation

{$R *.dfm}


uses Dominio.Entidades.TFactory, Vcl.Printers;

procedure TFrmConfiguracoes.actOkExecute(Sender: TObject);
begin
  inherited;
  salvar();

end;

procedure TFrmConfiguracoes.Bind;
var
  ModeloImpressora: TACBrPosPrinterModelo;
  I: Integer;
begin
  cbxModelo.Items.Clear;

  for ModeloImpressora := Low(TACBrPosPrinterModelo) to High(TACBrPosPrinterModelo) do
  begin
    for I := 0 to Printer.Printers.Count - 1 do
      cbxModelo.Items.Add(Printer.Printers[I]);
  end;

  FEmitente.ClearBindings;
  FEmitente.Bind('RAZAO_SOCIAL', edtRazaoSocial, 'Text');
  FEmitente.Bind('FANTASIA', edtFantasia, 'Text');
  FEmitente.Bind('CNPJ', edtCpf, 'Text');
  FEmitente.Bind('IE', edtIE, 'Text');
  FEmitente.Bind('RESPONSAVEL', edtResponsavel, 'Text');
  FEmitente.Bind('NUM', edtNumero, 'Text');
  FEmitente.Bind('COMPLEMENTO', edtComplemento, 'Text');
  FEmitente.Bind('UF', edtUF, 'Text');
  FEmitente.Bind('ENDERECO', edtRua, 'Text');
  FEmitente.Bind('BAIRRO', edtBairro, 'Text');
  FEmitente.Bind('CIDADE', edtCidade, 'Text');
  FEmitente.Bind('CEP', edtCEP, 'Text');
  FEmitente.Bind('FAX', edtFax, 'Text');
  FEmitente.Bind('TELEFONE', edtTelefone, 'Text');
  FEmitente.Bind('EMAIL', edtEmail, 'Text');

  FParametros.ClearBindings;
  FParametros.Bind('VENDECLIENTEBLOQUEADO', chkVenderClienteBloqueado, 'Checked');
  FParametros.Bind('ATUALIZACLIENTENAVENDA', chkAtualizaClienteNaVenda, 'Checked');
  FParametros.Bind('BLOQUEARCLIENTECOMATRASO', chkBloquearClienteComAtraso, 'Checked');
  FParametros.Bind('BACKUPDIARIO', chkBakcup, 'Checked');
  FParametros.Bind('Impressora.MODELOIMPRESSORA', cbxModelo, 'Text');
  FParametros.Bind('Impressora.IMPRIMIR2VIAS', chkImprimir2Vias, 'Checked');
  FParametros.Bind('Impressora.IMPRIMIRITENS2VIA', chkImprimirItens2Via, 'Checked');
  FParametros.Bind('VALIDADEORCAMENTO', edtValidadeOrcamento, 'Text');
  FParametros.Bind('PESQUISAPRODUTOPOR', rgPesquisaPor, 'ItemIndex');

end;

procedure TFrmConfiguracoes.cbxModeloChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TFrmConfiguracoes.chkVenderClienteBloqueadoClick(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Checked');
end;

procedure TFrmConfiguracoes.edtRazaoSocialChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TFrmConfiguracoes.rgPesquisaPorClick(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'ItemIndex');
end;

procedure TFrmConfiguracoes.FormCreate(Sender: TObject);
begin
  inherited;
  DaoEmitente := TFactory.DaoEmitente;
  DaoParametros := TFactory.DaoParametros;
end;

procedure TFrmConfiguracoes.FormDestroy(Sender: TObject);
begin
  inherited;

  if Assigned(FEmitente) then
    FreeAndNil(FEmitente);

  if Assigned(FParametros) then
    FreeAndNil(FParametros);

end;

procedure TFrmConfiguracoes.FormShow(Sender: TObject);
begin
  inherited;
  Get;
  pgc1.TabIndex := 0;
end;

procedure TFrmConfiguracoes.Get;
begin
  try
    FEmitente := DaoEmitente.GetEmitente();

    if not Assigned(FEmitente) then
    begin
      FEmitente := TFactory.Emitente;
    end;

    FParametros := DaoParametros.GetParametros;
    if not Assigned(FParametros) then
    begin
      FParametros := TFactory.Parametros;
    end;

    Bind;
  except
    on e: exception do
      MessageDlg('Falha no get: ' + e.Message, mtError, [mbYes], 0);
  end;
end;



procedure TFrmConfiguracoes.salvar;
begin
  try
    if not Assigned(DaoEmitente.GetEmitente()) then
    begin
      DaoEmitente.IncluiEmitente(FEmitente);
    end
    else
    begin
      DaoEmitente.AtualizaEmitente(FEmitente);
    end;

    if not Assigned(DaoParametros.GetParametros()) then
    begin
      DaoParametros.IncluiParametros(FParametros);
    end
    else
    begin
      DaoParametros.AtualizaParametros(FParametros);
    end;

    close;
  except
    on e: exception do
      MessageDlg('Falha no salvar: ' + e.Message, mtError, [mbYes], 0);
  end;
end;

end.
