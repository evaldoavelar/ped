unit Recebimento.ListaParcelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.DB,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
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
  Dominio.Entidades.TPedido, Dao.IDaoPedido, Recebimento.DetalhesPedido,
  Dominio.Entidades.TFactory, Relatorio.TRParcelas, Recebimento.Recebe;

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
  inherited;
  CategoryPanelGroup.CollapseAll;
end;

procedure TfrmParcelasVencendo.actImprimirExecute(Sender: TObject);
var
  impressao: TRParcela;
begin
  try
    if Parcelas.Count <= 0 then
      raise Exception.Create('Nenhum dado para imprimir');

    impressao := TRParcela.Create( TFactory.Parametros.Impressora);

    impressao.ImprimeLista(
      Self.Caption,
      TFactory.DadosEmitente,
      Parcelas);

    FreeAndNil(impressao);

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmParcelasVencendo.actOpenALLExecute(Sender: TObject);
begin
  inherited;
  CategoryPanelGroup.ExpandAll;
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
  lblNome.Caption := IntToStr(Parcela.NUMPARCELA) + 'ª Parcela do pedido ' +Format('%.*d',[6, parcela.IDPEDIDO]);
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

end;

procedure TfrmParcelasVencendo.Bind;
var
  Parcela: TParcelas;
  panel: TCategoryPanel;
begin
  for Parcela in Parcelas do
  begin
    panel := RetornaPanel(FormatDateTime('dd/mm/yyyy', Parcela.VENCIMENTO));
    AddParcelaPanel(panel, Parcela);
  end;
end;

procedure TfrmParcelasVencendo.btn2Click(Sender: TObject);
begin
  inherited;

end;

procedure TfrmParcelasVencendo.btnDetalhesClick(Sender: TObject);
var
  Pedido: TPedido;
  daoPedido: IDaoPedido;
begin
  try
    // ValidaGrid;

    frmDetalhesPedido := TfrmDetalhesPedido.Create(Self);
    try
      daoPedido := TFactory.daoPedido();
      Pedido := daoPedido.getPedido(TSpeedButton(Sender).Parcela.IDPEDIDO);

      frmDetalhesPedido.Pedido := Pedido;
      frmDetalhesPedido.ShowModal;

      if Assigned(Pedido) then
        FreeAndNil(Pedido);
    finally
      FreeAndNil(frmDetalhesPedido);
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;

end;

procedure TfrmParcelasVencendo.btnReceberClick(Sender: TObject);
begin
  try

    if not TFactory.VendedorLogado.PODERECEBERPARCELA then
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
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmParcelasVencendo.FormActivate(Sender: TObject);
begin
  inherited;
  Self.Top := FTop;
  Self.Left := FLeft;
end;

procedure TfrmParcelasVencendo.FormShow(Sender: TObject);
begin
  inherited;
  Bind();

end;

function TfrmParcelasVencendo.RetornaCaption(Data: string): string;
begin
  result := 'Vencimento: ' + Data;
end;

function TfrmParcelasVencendo.RetornaPanel(Data: string): TCategoryPanel;
var
  panel: Pointer;
begin

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
