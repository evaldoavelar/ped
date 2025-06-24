unit Recebimento.ListaParcelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.DB,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls,
  Dominio.Entidades.TParcelas,
  System.Generics.Collections, System.Actions, Vcl.ActnList, Vcl.Menus;

type

  TSpeedButton = class(Vcl.Buttons.TSpeedButton)
  private
    FPArcela: TParcelas;
    function getParcela: TParcelas;
    procedure setParcela(const Value: TParcelas);
  public
    property Parcela: TParcelas read getParcela write setParcela;
  end;

  TfrmParcelasVencendo = class(TfrmBase)
    pnl1: TPanel;
    btn1: TBitBtn;
    CategoryPanelGroup: TCategoryPanelGroup;
    CategoryPanel1: TCategoryPanel;
    pnl2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btn2: TSpeedButton;
    pm1: TPopupMenu;
    ActionList1: TActionList;
    actCloseALL: TAction;
    actOpenALL: TAction;
    actCloseALL1: TMenuItem;
    Expandir1: TMenuItem;
    btnImprimir: TBitBtn;
    actImprimir: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure actCloseALLExecute(Sender: TObject);
    procedure actOpenALLExecute(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);

  private
    FParcelas: TObjectList<TParcelas>;
    FLeft: Integer;
    FTop: Integer;
    { Private declarations }
    function RetornaCaption(Data: string): string;
    function RetornaPanel(Data: string): TCategoryPanel;
    procedure AddParcelaPanel(CatPanel: TCategoryPanel; Parcela: TParcelas);
    procedure btnDetalhesClick(Sender: TObject);
    procedure btnReceberClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);

  public
    { Public declarations }
    property Parcelas: TObjectList<TParcelas> read FParcelas write FParcelas;
    procedure Bind();
    procedure SetTop(ATop: Integer);
    procedure SetLef(ALef: Integer);
  end;

var
  frmParcelasVencendo: TfrmParcelasVencendo;

implementation

uses
  Dominio.Entidades.TPedido, Recebimento.DetalhesPedido,
  Relatorio.TRParcelas, Recebimento.Recebe, Sistema.TLog,
  Factory.Entidades;

{$R *.dfm}

{ TfrmParcelasVencendo }

procedure TfrmParcelasVencendo.SetLef(ALef: Integer);
begin
  FLeft := ALef;
end;

procedure TfrmParcelasVencendo.SetTop(ATop: Integer);
begin
  FTop := ATop;
end;

procedure TfrmParcelasVencendo.actCloseALLExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.actCloseALLExecute ');
  inherited;
  CategoryPanelGroup.CollapseAll;
  TLog.d('<<< Saindo de TfrmParcelasVencendo.actCloseALLExecute ');
end;

procedure TfrmParcelasVencendo.actImprimirExecute(Sender: TObject);
var
  impressao: TRParcela;
begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.actImprimirExecute ');
  try
    if Parcelas.Count <= 0 then
      raise Exception.Create('Nenhum dado para imprimir');

    impressao := TRParcela.Create(TFactoryEntidades.Parametros.ImpressoraTermica);

    impressao.ImprimeLista(
      Self.Caption,
      fFactory.DadosEmitente,
      Parcelas);

    FreeAndNil(impressao);

  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TfrmParcelasVencendo.actImprimirExecute ');
end;

procedure TfrmParcelasVencendo.actOpenALLExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.actOpenALLExecute ');
  inherited;
  CategoryPanelGroup.ExpandAll;
  TLog.d('<<< Saindo de TfrmParcelasVencendo.actOpenALLExecute ');
end;

procedure TfrmParcelasVencendo.AddParcelaPanel(CatPanel: TCategoryPanel; Parcela: TParcelas);
var
  pnl: TPanel;
  lblNome: TLabel;
  lblPreco: TLabel;
  lblParcela: TLabel;
  Cor: TColor;
  btn: TSpeedButton;
begin
  //TLog.d('>>> Entrando em  TfrmParcelasVencendo.AddParcelaPanel ');

  if Parcela.VENCIMENTO < Date() then
    Cor := $000D1CB8
  else
    Cor := $00EEAD00;

  CategoryPanelGroup.GradientBaseColor := Cor;
  CategoryPanelGroup.GradientColor := Cor;

  CatPanel.Color := Cor;
  CatPanel.ParentColor := False;

  pnl := TPanel.Create(CatPanel);
  pnl.Align := alTop;
  pnl.BevelOuter := bvNone;
  pnl.Parent := CatPanel;
  pnl.Height := 16;

  CatPanel.Height := CatPanel.Height + pnl.Height;

  lblParcela := TLabel.Create(pnl);
  lblParcela.Left := 2;
  lblParcela.Top := 1;
  lblParcela.Width := 340;
  lblParcela.Height := 13;
  lblParcela.AutoSize := False;
  lblParcela.Caption := Format('%s %s', [Parcela.CODCLIENTE, Parcela.NOME]);
  lblParcela.Parent := pnl;
  lblParcela.Font.Color := Cor;

  lblNome := TLabel.Create(pnl);
  lblNome.Left := 250;
  lblNome.Top := 1;
  lblNome.Width := 260;
  lblNome.Height := 13;
  lblNome.AutoSize := False;
  lblNome.Caption := IntToStr(Parcela.NUMPARCELA) + 'ª Parcela do pedido ' + Format('%.*d', [6, Parcela.IDPEDIDO]);
  lblNome.Parent := pnl;
  lblNome.Font.Color := Cor;

  lblPreco := TLabel.Create(pnl);
  lblPreco.Left := 395;
  lblPreco.Top := 1;
  lblPreco.Width := 80;
  lblPreco.Height := 13;
  lblPreco.Alignment := taRightJustify;
  lblPreco.AutoSize := False;
  lblPreco.Caption := FormatCurr('R$ 0.,00', Parcela.VALOR);
  lblPreco.Parent := pnl;
  lblPreco.Font.Color := Cor;

  btn := TSpeedButton.Create(Self);
  btn.Left := 483;
  btn.Top := 1;
  btn.Width := 15;
  btn.Height := 14;
  btn.Caption := 'P';
  btn.Font.Color := clBlack;
  btn.Font.Height := 9;
  btn.Parent := pnl;
  btn.Hint := 'Ver Pedido';
  btn.ShowHint := True;
  btn.Parcela := Parcela;
  btn.OnClick := btnDetalhesClick;

  btn := TSpeedButton.Create(Self);
  btn.Left := 500;
  btn.Top := 1;
  btn.Width := 15;
  btn.Height := 14;
  btn.Caption := 'R';
  btn.Font.Color := clBlack;
  btn.Font.Height := 9;
  btn.Parent := pnl;
  btn.Hint := 'Receber';
  btn.ShowHint := True;
  btn.Parcela := Parcela;
  btn.OnClick := btnReceberClick;
//  TLog.d('<<< Saindo de TfrmParcelasVencendo.AddParcelaPanel ');
end;

procedure TfrmParcelasVencendo.Bind;
var
  Parcela: TParcelas;
  panel: TCategoryPanel;
begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.Bind ');
  for Parcela in Parcelas do
  begin
    panel := RetornaPanel(FormatDateTime('dd/mm/yyyy', Parcela.VENCIMENTO));
    AddParcelaPanel(panel, Parcela);
  end;
  TLog.d('<<< Saindo de TfrmParcelasVencendo.Bind ');
end;

procedure TfrmParcelasVencendo.btn2Click(Sender: TObject);
begin
  inherited;

end;

procedure TfrmParcelasVencendo.btnDetalhesClick(Sender: TObject);
var
  Pedido: TPedido;

begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.btnDetalhesClick ');
  try
    // ValidaGrid;

    frmDetalhesPedido := TfrmDetalhesPedido.Create(Self);
    try

      Pedido := fFactory.daoPedido.getPedido(TSpeedButton(Sender).Parcela.IDPEDIDO);

      frmDetalhesPedido.Pedido := Pedido;
      frmDetalhesPedido.ShowModal;

      if Assigned(Pedido) then
        FreeAndNil(Pedido);
    finally
      FreeAndNil(frmDetalhesPedido);
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmParcelasVencendo.btnDetalhesClick ');
end;

procedure TfrmParcelasVencendo.btnReceberClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.btnReceberClick ');
  try

    if not TFactoryEntidades.new.VendedorLogado.PODERECEBERPARCELA then
      raise Exception.Create('Vendedor não tem permissão para acessar recebimento de parcelas');

    frmRecebimento := TfrmRecebimento.Create(Self);
    try
      frmRecebimento.edtPesquisa.Text := TSpeedButton(Sender).Parcela.CODCLIENTE;
      frmRecebimento.edtPesquisaInvokeSearch(nil);
      frmRecebimento.ShowModal;
    finally
      FreeAndNil(frmRecebimento);
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.Message);
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end;
  end;

  TLog.d('<<< Saindo de TfrmParcelasVencendo.btnReceberClick ');
end;

procedure TfrmParcelasVencendo.FormActivate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.FormActivate ');
  inherited;
  Self.Top := FTop;
  Self.Left := FLeft;
  TLog.d('<<< Saindo de TfrmParcelasVencendo.FormActivate ');
end;

procedure TfrmParcelasVencendo.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmParcelasVencendo.FormShow ');
  inherited;
  Bind();
  TLog.d('<<< Saindo de TfrmParcelasVencendo.FormShow ');
end;

function TfrmParcelasVencendo.RetornaCaption(Data: string): string;
begin
 // TLog.d('>>> Entrando em  TfrmParcelasVencendo.RetornaCaption ');
  result := 'Vencimento: ' + Data;
//  TLog.d('<<< Saindo de TfrmParcelasVencendo.RetornaCaption ');
end;

function TfrmParcelasVencendo.RetornaPanel(Data: string): TCategoryPanel;
var
  panel: Pointer;
begin
//  TLog.d('>>> Entrando em  TfrmParcelasVencendo.RetornaPanel ');

  result := nil;

  for panel in CategoryPanelGroup.Panels do
  begin
    if TCategoryPanel(panel).Caption = RetornaCaption(Data) then
    begin
      result := TCategoryPanel(panel);
      Break;
    end;

  end;

  if not Assigned(result) then
  begin
    result := TCategoryPanel.Create(CategoryPanelGroup);
    result.Caption := RetornaCaption(Data);
    result.PanelGroup := CategoryPanelGroup;
    result.ParentBackground := True;
    result.Height := 25;
  end;

 // TLog.d('<<< Saindo de TfrmParcelasVencendo.RetornaPanel ');
end;

{ TSpeedButtonHelp }

function TSpeedButton.getParcela: TParcelas;
begin
  result := FPArcela;
end;

procedure TSpeedButton.setParcela(const Value: TParcelas);
begin
  FPArcela := Value;
end;

end.
