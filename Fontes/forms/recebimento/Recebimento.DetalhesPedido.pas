unit Recebimento.DetalhesPedido;

interface

uses
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  Dominio.Entidades.TEntity, Dominio.Entidades.TPedido,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TFactory, Dao.IDaoPedido,
  Vcl.Mask, JvExMask, JvToolEdit,
  JvBaseEdits, JvExStdCtrls, JvTextListBox,
  System.Actions, Vcl.ActnList, Vcl.Grids, Vcl.ExtDlgs, Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage, Util.VclFuncoes;

type
  TfrmDetalhesPedido = class(TfrmBase)
    pgPedido: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    lblNumero: TLabel;
    Label2: TLabel;
    lblData: TLabel;
    lblHora: TLabel;
    Label5: TLabel;
    Image1: TImage;
    Label3: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Panel2: TPanel;
    Label11: TLabel;
    lblVendendor: TLabel;
    Label13: TLabel;
    lblObservacao: TLabel;
    lblCodVendedor: TLabel;
    edtValorBruto: TJvCalcEdit;
    edtValorDesconto: TJvCalcEdit;
    edtValorLiquido: TJvCalcEdit;
    Label6: TLabel;
    lblCliCodigo: TLabel;
    lblCliNome: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    lblCliFantasia: TLabel;
    Label16: TLabel;
    lblCliContato: TLabel;
    Label18: TLabel;
    lblCliCPF: TLabel;
    Label20: TLabel;
    lblCliRG: TLabel;
    Label22: TLabel;
    lblCliEndereco: TLabel;
    Label24: TLabel;
    lblCliNUmero: TLabel;
    Panel3: TPanel;
    Label26: TLabel;
    lblCliComplemento: TLabel;
    Label28: TLabel;
    lblCliBairro: TLabel;
    Label30: TLabel;
    lblCliCidade: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    lblCliUF: TLabel;
    lblCliCEP: TLabel;
    Label36: TLabel;
    Panel4: TPanel;
    lblCliTelefone: TLabel;
    Label38: TLabel;
    lblCliCelular: TLabel;
    Image2: TImage;
    Label7: TLabel;
    lblCliEmail: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    ActionList1: TActionList;
    actOk: TAction;
    actBaixar: TAction;
    strGridProdutos: TStringGrid;
    strGridParcelas: TStringGrid;
    ts1: TTabSheet;
    Panel8: TPanel;
    btnAnexarComprovante: TBitBtn;
    actAnexarComprovante: TAction;
    dlgOpenPic: TOpenPictureDialog;
    scr1: TScrollBox;
    imgComprovante: TImage;
    btnAnexarComprovante1: TBitBtn;
    actSalvarComprovante: TAction;
    dlgSavePic: TSavePictureDialog;
    actCancelar: TAction;
    lbl1: TLabel;
    lblObservacaoCliente: TLabel;
    Label4: TLabel;
    edtValorEntrada: TJvCalcEdit;
    pnlAviso: TPanel;
    lblCanceladoPorVendedor: TLabel;
    lblCanceladoPor: TLabel;
    Label9: TLabel;
    lblNomeParceiro: TLabel;
    lblCodigoParceiro: TLabel;
    procedure FormShow(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actAnexarComprovanteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actSalvarComprovanteExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
  private
    FPedido: TPedido;
    DaoPedido: IDaoPedido;
    { Private declarations }
    procedure Bind();
    procedure AnexarComprovante;
    procedure cancelar;
  public
    { Public declarations }
    property Pedido: TPedido read FPedido write FPedido;

  end;

var
  frmDetalhesPedido: TfrmDetalhesPedido;

implementation

{$R *.dfm}


uses Util.Funcoes, Helper.TBindGrid;

procedure TfrmDetalhesPedido.actAnexarComprovanteExecute(Sender: TObject);
begin
  inherited;
  AnexarComprovante;
end;

procedure TfrmDetalhesPedido.actCancelarExecute(Sender: TObject);
begin
  inherited;
  cancelar;
end;

procedure TfrmDetalhesPedido.actOkExecute(Sender: TObject);
begin
  inherited;
  self.Close;
end;

procedure TfrmDetalhesPedido.actSalvarComprovanteExecute(Sender: TObject);
begin
  inherited;
  dlgSavePic.FileName := 'Comprovante.jpg';
  if dlgSavePic.Execute then
  begin
    imgComprovante.Picture.SaveToFile(dlgSavePic.FileName);
  end;
end;

procedure TfrmDetalhesPedido.AnexarComprovante;
begin
  try
    if dlgOpenPic.Execute then
    begin
      FPedido.COMPROVANTE := TImage.Create(self);
      FPedido.COMPROVANTE.Picture.LoadFromFile(dlgOpenPic.FileName);
      DaoPedido.AdicionaComprovante(Pedido);
      imgComprovante.Picture := FPedido.COMPROVANTE.Picture;
      actSalvarComprovante.Enabled := True;

      MessageDlg('Imagem  Anexada', mtInformation, [mbOK], 0);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmDetalhesPedido.Bind;
begin
  FPedido.BindReadOnly('NUMERO', lblNumero, 'Caption');
  FPedido.BindReadOnly('HORAPEDIDO', lblHora, 'Caption');
  FPedido.BindReadOnly('DATAPEDIDO', lblData, 'Caption');
  FPedido.BindReadOnly('OBSERVACAO', lblObservacao, 'Caption');
  FPedido.BindReadOnly('VALORBRUTO', edtValorBruto, 'Value');
  FPedido.BindReadOnly('VALORDESC', edtValorDesconto, 'Value');
  FPedido.BindReadOnly('VALORLIQUIDO', edtValorLiquido, 'Value');
  FPedido.BindReadOnly('VALORENTRADA', edtValorEntrada, 'Value');

  FPedido.Vendedor.BindReadOnly('NOME', lblVendendor, 'Caption');
  FPedido.Vendedor.BindReadOnly('CODIGO', lblCodVendedor, 'Caption');

  FPedido.Cliente.BindReadOnly('CODIGO', lblCliCodigo, 'Caption');
  FPedido.Cliente.BindReadOnly('NOME', lblCliNome, 'Caption');
  FPedido.Cliente.BindReadOnly('FANTASIA', lblCliFantasia, 'Caption');
  FPedido.Cliente.BindReadOnly('CNPJ_CNPF', lblCliCPF, 'Caption');
  FPedido.Cliente.BindReadOnly('IE_RG', lblCliRG, 'Caption');
  FPedido.Cliente.BindReadOnly('NUMERO', lblCliNUmero, 'Caption');
  FPedido.Cliente.BindReadOnly('COMPLEMENTO', lblCliComplemento, 'Caption');
  FPedido.Cliente.BindReadOnly('UF', lblCliUF, 'Caption');
  FPedido.Cliente.BindReadOnly('CONTATO', lblCliContato, 'Caption');
  FPedido.Cliente.BindReadOnly('ENDERECO', lblCliEndereco, 'Caption');
  FPedido.Cliente.BindReadOnly('BAIRRO', lblCliBairro, 'Caption');
  FPedido.Cliente.BindReadOnly('CIDADE', lblCliCidade, 'Caption');
  FPedido.Cliente.BindReadOnly('CEP', lblCliCEP, 'Caption');
  FPedido.Cliente.BindReadOnly('CELULAR', lblCliCelular, 'Caption');
  FPedido.Cliente.BindReadOnly('TELEFONE', lblCliTelefone, 'Caption');
  FPedido.Cliente.BindReadOnly('EMAIL', lblCliEmail, 'Caption');
  FPedido.Cliente.BindReadOnly('CNPJ_CNPF', lblCliCPF, 'Caption');
  FPedido.Cliente.BindReadOnly('TELEFONE', lblCliTelefone, 'Caption');
  FPedido.Cliente.BindReadOnly('OBSERVACOES', lblObservacaoCliente, 'Caption');
  FPedido.Cliente.BindReadOnly('OBSERVACOES', lblObservacaoCliente, 'Caption');

  if Assigned(FPedido.VendedorCancelamento) then
  begin
    lblCanceladoPor.Visible := True;
    lblCanceladoPorVendedor.Visible := True;
    FPedido.VendedorCancelamento.BindReadOnly('NOME', lblCanceladoPor, 'Caption');
  end;

  if Assigned(FPedido.ParceiroVenda) then
  begin
    lblCodigoParceiro.Visible := True;
    lblNomeParceiro.Visible := True;

    FPedido.ParceiroVenda.BindReadOnly('CODIGO', lblCodigoParceiro, 'Caption');
    FPedido.ParceiroVenda.BindReadOnly('NOME', lblNomeParceiro, 'Caption');
  end;

  TBindGrid.BindProdutos(strGridProdutos, FPedido.itens);
  TBindGrid.BindParcelas(strGridParcelas, FPedido.parcelas);

  if FPedido.STATUS = 'C' then
  begin
    pnlAviso.Visible := True;
    pnlAviso.Caption := 'CANCELADO';
    pnlAviso.Color := $000D1CB8;
  end
  else if FPedido.STATUS = 'A' then
  begin
    pnlAviso.Visible := True;
    pnlAviso.Caption := 'NÃO FINALIZADO';
    pnlAviso.Color := $000075D7;
  end;
  // imgNaoFinalizado.Visible := ;

  try
    if FPedido.COMPROVANTE <> nil then
    begin
      imgComprovante.Picture := FPedido.COMPROVANTE.Picture;
      actSalvarComprovante.Enabled := True;
    end
    else
    begin
      actSalvarComprovante.Enabled := false;
    end;
  except
    on E: Exception do
      MessageDlg('Falha ao mapear comprovante: ' + E.Message, mtError, [mbOK], 0);
  end;

end;

procedure TfrmDetalhesPedido.cancelar;
begin
  if MessageDlg('Confirma o cancelamento do Pedido?', mtError, [mbYes, mbNo], 0) = mrYes then
  begin
    if MessageDlg('Tem certeza? ', mtError, [mbYes, mbNo], 0) = mrYes then
    begin

    end;
  end;

end;

procedure TfrmDetalhesPedido.FormCreate(Sender: TObject);
begin
  inherited;
  DaoPedido := TFactory.DaoPedido;
end;

procedure TfrmDetalhesPedido.FormShow(Sender: TObject);
begin
  inherited;
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
  TVclFuncoes.DisableVclStyles(pgPedido, 'TPanel');
  TVclFuncoes.DisableVclStyles(self, 'TJvCalcEdit');
  TVclFuncoes.DisableVclStyles(self, 'TStringGrid');
  TVclFuncoes.DisableVclStyles(self, 'TJvTextListBox');
  Bind();
  pgPedido.TabIndex := 0;
end;

end.
