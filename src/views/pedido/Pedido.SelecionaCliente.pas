unit Pedido.SelecionaCliente;

interface

uses
  System.Bindings.Helper,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Dao.IDaoCliente, Dominio.Entidades.TCliente, Vcl.Imaging.jpeg, Dao.IDaoParcelas, Dominio.Entidades.TParcelas,
  Consulta.Cliente, Factory.Dao, Util.Exceptions, Cadastros.Cliente,
  System.Generics.Collections, Vcl.Imaging.pngimage, IFactory.Dao,
  Sistema.TParametros;

type
  TFrmInfoCliente = class(TfrmBase)
    Panel1: TPanel;
    Label10: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    btnOk: TBitBtn;
    btnPesquisaCliente: TBitBtn;
    edtCpf: TEdit;
    edtRua: TEdit;
    edtBairro: TEdit;
    edtCidade: TEdit;
    edtIE: TEdit;
    edtCEP: TEdit;
    edtTelefone: TEdit;
    edtCelular: TEdit;
    edtEmail: TEdit;
    img1: TImage;
    actInfoCliente: TActionList;
    actOk: TAction;
    actCancelar: TAction;
    edtNome: TEdit;
    actPesquisaCliente: TAction;
    img2: TImage;
    lbl3: TLabel;
    edtCodigo: TEdit;
    Label1: TLabel;
    edtNumero: TEdit;
    Label2: TLabel;
    mmoObservacao: TMemo;
    btnAdicionar: TBitBtn;
    actAdicionar: TAction;
    Image1: TImage;
    mmoAlerta: TMemo;
    lbl4: TLabel;
    Label11: TLabel;
    Panel19: TPanel;
    procedure actCancelarExecute(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure actPesquisaClienteExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtNomeChange(Sender: TObject);
    procedure actAdicionarExecute(Sender: TObject);
  private
    FCliente: TCliente;
    FFactory: IFactoryDao;
    FParametros: TParametros;
    daoCliente: IDaoCliente;
    parcelas: TObjectList<TParcelas>;
    procedure IncializaComponentes;
    procedure PesquisaCliente;
    procedure BindFields;
    procedure VerificaParcelasEmAtraso(CODIGO: string);
    function getCliente: TCliente;
    { Private declarations }
  public
    { Public declarations }
    property Cliente: TCliente read getCliente write FCliente;
  end;

var
  FrmInfoCliente: TFrmInfoCliente;

implementation

uses
  Sistema.TLog, Factory.Entidades;

{$R *.dfm}


procedure TFrmInfoCliente.IncializaComponentes;
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.IncializaComponentes ');
  try
    if (self.FCliente.CODIGO = '000000') or (self.FCliente.CODIGO = '') then
      btnPesquisaCliente.SetFocus
    else
      btnOk.SetFocus;
  except
    on E: Exception do
  end;
  TLog.d('<<< Saindo de TFrmInfoCliente.IncializaComponentes ');
end;

procedure TFrmInfoCliente.actAdicionarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.actAdicionarExecute ');
  inherited;
  frmCadastroCliente := TfrmCadastroCliente.Create(self);
  try
    frmCadastroCliente.ShowModal;
  finally
    frmCadastroCliente.Free;
  end;
  TLog.d('<<< Saindo de TFrmInfoCliente.actAdicionarExecute ');
end;

procedure TFrmInfoCliente.actCancelarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.actCancelarExecute ');
  inherited;
  self.Close;
  TLog.d('<<< Saindo de TFrmInfoCliente.actCancelarExecute ');
end;

procedure TFrmInfoCliente.VerificaParcelasEmAtraso(CODIGO: string);
var
  daoParcelas: IDaoParcelas;
  item: TParcelas;
  Total: Currency;
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.VerificaParcelasEmAtraso ');
  daoParcelas := FFactory.daoParcelas;
  Total := 0;
  parcelas := daoParcelas.GeTParcelasVencidasPorCliente(CODIGO, now);

  if parcelas.Count > 0 then
  begin

    mmoAlerta.Lines.Clear;
    mmoAlerta.Lines.Add(Format('O Cliente possui %d parcelas em Atraso:' + #13, [parcelas.Count]));
    mmoAlerta.Lines.Add('');

    for item in parcelas do
    begin
      Total := Total + item.VALOR;
      mmoAlerta.Lines.Add(Format('Pedido: %s Parcela Nº: %d Vencimento: %s Valor: %s', [
        Format('%.6d', [item.IDPEDIDO]),
        item.NUMPARCELA,
        dateTostr(item.VENCIMENTO),
        FormatCurr('R$ 0.,00', item.VALOR)
        ])
        );
    end;

    mmoAlerta.Lines.Add('');
    mmoAlerta.Lines.Add(Format('Total Devido: %s', [FormatCurr('R$ 0.,00', Total)]));

    if fParametros.BLOQUEARCLIENTECOMATRASO then
    begin
      mmoAlerta.Lines.Add('--------------------------------------------');
      mmoAlerta.Lines.Add('O SISTEMA ESTÁ PARAMETRIZADO PARA BLOQUEAR A VENDA PARA CLIENTES COM PARCELAS EM ATRASO!!!');
    end;

    self.Width := 869;
    self.ReCenter;
  end
  else
  begin
    self.Width := 453;
    self.ReCenter;
  end;
  TLog.d(mmoAlerta.Lines.Text);
  TLog.d('<<< Saindo de TFrmInfoCliente.VerificaParcelasEmAtraso ');
end;

procedure TFrmInfoCliente.PesquisaCliente;
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.PesquisaCliente ');
  try
    frmConsultaCliente := TFrmConsultaCliente.Create(self);
    try
      frmConsultaCliente.ShowModal;

      if Assigned(frmConsultaCliente.Cliente) then
      begin
        if frmConsultaCliente.Cliente.BLOQUEADO then
          raise Exception.Create('Cliente Bloqueado!');

        if Assigned(self.FCliente) then
        begin
          FreeAndNil(FCliente);
        end;

        self.FCliente := daoCliente.getCliente(frmConsultaCliente.Cliente.CODIGO);

        VerificaParcelasEmAtraso(frmConsultaCliente.Cliente.CODIGO);
      end;
    finally
      FreeAndNil(frmConsultaCliente);
    end;

    BindFields;
    btnOk.SetFocus;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmInfoCliente.PesquisaCliente ');
end;

procedure TFrmInfoCliente.BindFields;
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.BindFields ');
  FCliente.ClearBindings;
  FCliente.Bind('CODIGO', edtCodigo, 'Text');
  FCliente.Bind('NOME', edtNome, 'Text');
  FCliente.Bind('ENDERECO', edtRua, 'Text');
  FCliente.Bind('BAIRRO', edtBairro, 'Text');
  FCliente.Bind('CIDADE', edtCidade, 'Text');
  FCliente.Bind('CEP', edtCEP, 'Text');
  FCliente.Bind('CELULAR', edtCelular, 'Text');
  FCliente.Bind('TELEFONE', edtTelefone, 'Text');
  FCliente.Bind('EMAIL', edtEmail, 'Text');
  FCliente.Bind('CNPJ_CNPF', edtCpf, 'Text');
  FCliente.Bind('TELEFONE', edtTelefone, 'Text');
  FCliente.Bind('NUMERO', edtNumero, 'Text');
  FCliente.Bind('OBSERVACOES', mmoObservacao, 'Text');
  TLog.d('<<< Saindo de TFrmInfoCliente.BindFields ');
end;

procedure TFrmInfoCliente.actOkExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.actOkExecute ');
  inherited;
  try
    // if (not Assigned(FCliente)) or (FCliente.CODIGO = '000000') or (FCliente.CODIGO = '') then
    // raise TValidacaoException.Create('Cliente não pode ser Padrão');

    if FParametros.BLOQUEARCLIENTECOMATRASO then
      if Assigned(parcelas) and (parcelas.Count > 0) then
      begin
        raise TValidacaoException.Create('Cliente Bloqueado Pelo Sistema por estar com parcelas em atraso! ');
      end;

    if FParametros.ATUALIZACLIENTENAVENDA then
    begin
      daoCliente.AtualizaCliente(FCliente);
    end;

    self.Close;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmInfoCliente.actOkExecute ');
end;

procedure TFrmInfoCliente.actPesquisaClienteExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.actPesquisaClienteExecute ');
  inherited;
  PesquisaCliente();
  TLog.d('<<< Saindo de TFrmInfoCliente.actPesquisaClienteExecute ');
end;

procedure TFrmInfoCliente.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnOk.SetFocus;
end;

procedure TFrmInfoCliente.edtNomeChange(Sender: TObject);
begin
  inherited;
  TBindings.Notify(Sender, 'Text');
end;

procedure TFrmInfoCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.FormClose ');
  inherited;
  if Assigned(FCliente) then
    FCliente.ClearBindings;

    FreeAndNil(parcelas);
  TLog.d('<<< Saindo de TFrmInfoCliente.FormClose ');
end;

procedure TFrmInfoCliente.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.FormCreate ');
  inherited;
  FFactory := TFactory.new(nil,true);
  daoCliente := FFactory.daoCliente;
  FParametros := TFactoryEntidades.Parametros;
  TLog.d('<<< Saindo de TFrmInfoCliente.FormCreate ');
end;

procedure TFrmInfoCliente.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmInfoCliente.FormShow ');
  inherited;
  self.Width := 453;
  IncializaComponentes();
  BindFields;
  if Assigned(self.Cliente) then
    VerificaParcelasEmAtraso(self.Cliente.CODIGO);
  TLog.d('<<< Saindo de TFrmInfoCliente.FormShow ');
end;

function TFrmInfoCliente.getCliente: TCliente;
begin
  Result := FCliente;
end;

end.
