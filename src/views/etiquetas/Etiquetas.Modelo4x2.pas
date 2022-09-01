unit Etiquetas.Modelo4x2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls, Sistema.TParametros,
  Dominio.Entidades.TEmitente, Dao.IDaoProdutos, Dominio.Entidades.TProduto,
  Impressao.Etiquetas, System.Generics.Collections, frxClass;

type
  TFrmEtiquetasModelo4x2 = class(TfrmBase)
    Panel1: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    GridPanel1: TGridPanel;
    lblValdiade: TLabel;
    Label1: TLabel;
    edtHora1: TDateTimePicker;
    Label2: TLabel;
    edtData1: TDateTimePicker;
    Panel9: TPanel;
    Image1: TImage;
    lblCodigo1: TLabel;
    lblDescricao1: TLabel;
    Panel6: TPanel;
    btnConsultaProduto1: TSpeedButton;
    Panel7: TPanel;
    cbbProduto1: TComboBox;
    Panel8: TPanel;
    imgLogo1: TImage;
    Panel10: TPanel;
    lblCidade1: TLabel;
    lblRua1: TLabel;
    Panel11: TPanel;
    btn1: TBitBtn;
    BitBtn1: TBitBtn;
    Panel12: TPanel;
    Label4: TLabel;
    edtNumCopias: TEdit;
    btnpdf: TBitBtn;
    frxReport1: TfrxReport;
    SaveDialog1: TSaveDialog;
    Panel13: TPanel;
    Panel14: TPanel;
    edtContemDescricao1: TEdit;
    edtContem1: TEdit;
    edtObservacao1: TEdit;
    Panel2: TPanel;
    edtValidade1: TDateTimePicker;
    chkImprimirValidade: TCheckBox;
    procedure cbbProduto1Click(Sender: TObject);
    procedure btnpdfClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);

    procedure btnConsultaProduto1Click(Sender: TObject);
    procedure cbbProduto1Enter(Sender: TObject);
    procedure cbbProduto1KeyPress(Sender: TObject; var Key: Char);
    procedure cbbProduto1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure cbbProduto1Select(Sender: TObject);

    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FDaoProdutos: IDaoProdutos;
    FEmitente: TEmitente;
    FParametros: TParametros;
    CachePesquisa: TStringList;
    procedure Bind; overload;
    procedure Bind(aTagOrigem: Integer); overload;
    procedure PesquisaProduto(cbbProduto: TComponent; aCallback: TProc<TProduto, Integer>);
    function MontaDescricaoPesquisaProduto(const Item: TProduto): string;
    procedure BindProduto(aProduto: TProduto; aTag: Integer);
    function GetEtiqueta(aTag: Integer): TImpressaoEtiquetas;
  private
    const
    TOTALETIQUETAS: Integer = 1;
  public
    { Public declarations }
  end;

resourcestring
  StrPesquisa = '';

var
  FrmEtiquetasModelo4x2: TFrmEtiquetasModelo4x2;

implementation

uses Dominio.Entidades.TFactory, Vcl.Printers, System.StrUtils,
  Consulta.Produto, Relatorio.FREtiquetas.Modelo4x2, Utils.ArrayUtil,
  Util.Funcoes;

{$R *.dfm}


procedure TFrmEtiquetasModelo4x2.Bind;
var
  I: Integer;
  lbl: TLabel;
  imgLogo: TImage;
  edtData: TDateTimePicker;
  edtHora: TDateTimePicker;
begin
  FEmitente.ClearBindings;

  for I := 1 to TOTALETIQUETAS do
  begin
    lbl := self.FindComponent('lblRua' + I.ToString) as TLabel;
    lbl.Caption := Format('%s, %s', [FEmitente.ENDERECO, FEmitente.NUM]);

    lbl := self.FindComponent('lblCidade' + I.ToString) as TLabel;
    lbl.Caption := Format('%s, %s', [FEmitente.CIDADE, FEmitente.UF]);

    lbl := self.FindComponent('lblCodigo' + I.ToString) as TLabel;
    lbl.Caption := '';

    if Assigned(FParametros.LOGOMARCAETIQUETA) then
    begin
      imgLogo := self.FindComponent('imgLogo' + I.ToString) as TImage;
      imgLogo.Picture := FParametros.LOGOMARCAETIQUETA.Picture;
    end;

    edtData := self.FindComponent('edtData' + I.ToString) as TDateTimePicker;
    edtData.Date := Date;

    edtData := self.FindComponent('edtValidade' + I.ToString) as TDateTimePicker;
    edtData.Date := Date;

    edtHora := self.FindComponent('edtHora' + I.ToString) as TDateTimePicker;
    edtHora.Time := now;

  end;

end;

procedure TFrmEtiquetasModelo4x2.PesquisaProduto(cbbProduto: TComponent; aCallback: TProc<TProduto, Integer>);
var
  Produto: TProduto;
  idx: Integer;
begin
  FrmConsultaProdutos := TFrmConsultaProdutos.Create(self);
  try
    FrmConsultaProdutos.ShowModal;

    if Assigned(FrmConsultaProdutos.Produto) then
    begin
      Produto := FrmConsultaProdutos.Produto;
      aCallback(Produto, cbbProduto.Tag);
      Produto.Free;
    end;

  finally
    FrmConsultaProdutos.Free;
  end;
end;

procedure TFrmEtiquetasModelo4x2.btn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmEtiquetasModelo4x2.btnConsultaProduto1Click(Sender: TObject);
begin
  inherited;
  PesquisaProduto(TComponent(Sender), BindProduto);
end;

procedure TFrmEtiquetasModelo4x2.btnpdfClick(Sender: TObject);
var
  Relatorio: TFREtiquetasModelo4x2;
  LEtiquetas: Tarray<TImpressaoEtiquetas>;
  I: Integer;
begin
  try
    inherited;

    if not SaveDialog1.Execute then
      exit;

    for I := 1 to TOTALETIQUETAS do
      TArrayUtil<TImpressaoEtiquetas>.Append(LEtiquetas, GetEtiqueta(I));

    Relatorio := TFREtiquetasModelo4x2.Create(self);
    Relatorio.MostraPreview := FALSE;
    Relatorio.ArquivoPDF := SaveDialog1.FileName;
    Relatorio.PDF(LEtiquetas);
    Relatorio.Free;
  except
    on e: exception do
      MessageDlg(e.Message, mtError, [mbYes], 0);
  end;

end;

procedure TFrmEtiquetasModelo4x2.Bind(aTagOrigem: Integer);
var
  I: Integer;
  lblOrigem: TLabel;
  lblDestino: TLabel;
  cbbProdutoOrigem: TComboBox;
  cbbProdutoDestino: TComboBox;
  edtPrecoOrigem: TEdit;
  edtPrecoDestino: TEdit;
  edtDataDestino: TDateTimePicker;
  edtDataOrigem: TDateTimePicker;
  edtHoraOrigem: TDateTimePicker;
  edtHoraDestino: TDateTimePicker;
  edtPesoOrigem: TEdit;
  edtPesoDestino: TEdit;
begin
  for I := aTagOrigem + 1 to TOTALETIQUETAS do
  begin
    lblOrigem := self.FindComponent('lblCodigo' + aTagOrigem.ToString) as TLabel;
    lblDestino := self.FindComponent('lblCodigo' + I.ToString) as TLabel;
    lblDestino.Caption := lblOrigem.Caption;

    lblOrigem := self.FindComponent('lblDescricao' + aTagOrigem.ToString) as TLabel;
    lblDestino := self.FindComponent('lblDescricao' + I.ToString) as TLabel;
    lblDestino.Caption := lblOrigem.Caption;

    cbbProdutoOrigem := self.FindComponent('cbbProduto' + aTagOrigem.ToString) as TComboBox;
    cbbProdutoDestino := self.FindComponent('cbbProduto' + I.ToString) as TComboBox;
    cbbProdutoDestino.Text := cbbProdutoOrigem.Text;

    edtPrecoOrigem := self.FindComponent('edtPreco' + aTagOrigem.ToString) as TEdit;
    edtPrecoDestino := self.FindComponent('edtPreco' + I.ToString) as TEdit;
    edtPrecoDestino.Text := edtPrecoOrigem.Text;

    edtPesoOrigem := self.FindComponent('edtPeso' + aTagOrigem.ToString) as TEdit;
    edtPesoDestino := self.FindComponent('edtPeso' + I.ToString) as TEdit;
    edtPesoDestino.Text := edtPesoOrigem.Text;

    edtDataOrigem := self.FindComponent('edtValidade' + aTagOrigem.ToString) as TDateTimePicker;
    edtDataDestino := self.FindComponent('edtValidade' + I.ToString) as TDateTimePicker;
    edtDataDestino.Date := edtDataOrigem.Date;

    edtDataOrigem := self.FindComponent('edtData' + aTagOrigem.ToString) as TDateTimePicker;
    edtDataDestino := self.FindComponent('edtData' + I.ToString) as TDateTimePicker;
    edtDataDestino.Date := edtDataOrigem.Date;

    edtDataOrigem := self.FindComponent('edtData' + aTagOrigem.ToString) as TDateTimePicker;
    edtDataDestino := self.FindComponent('edtData' + I.ToString) as TDateTimePicker;
    edtDataDestino.Date := edtDataOrigem.Date;

    edtHoraOrigem := self.FindComponent('edtHora' + aTagOrigem.ToString) as TDateTimePicker;
    edtHoraDestino := self.FindComponent('edtHora' + I.ToString) as TDateTimePicker;
    edtHoraDestino.DateTime := edtHoraOrigem.DateTime;
  end;
end;

procedure TFrmEtiquetasModelo4x2.BindProduto(aProduto: TProduto; aTag: Integer);
var
  lbl: TLabel;
  cbbProduto: TComboBox;
  edtPreco: TEdit;
begin
  lbl := self.FindComponent('lblCodigo' + aTag.ToString) as TLabel;
  lbl.Caption := TUtil.IFF<string>(aProduto.BARRAS = '', aProduto.BARRAS, aProduto.CODIGO);

  lbl := self.FindComponent('lblDescricao' + aTag.ToString) as TLabel;
  lbl.Caption := aProduto.DESCRICAO;

  cbbProduto := self.FindComponent('cbbProduto' + aTag.ToString) as TComboBox;
  cbbProduto.Text := aProduto.DESCRICAO;

  // edtPreco := self.FindComponent('edtPreco' + aTag.ToString) as TEdit;
  // edtPreco.Text := FormatCurr('R$ 0.,00', aProduto.PRECO_VENDA);
end;

function TFrmEtiquetasModelo4x2.GetEtiqueta(aTag: Integer): TImpressaoEtiquetas;
var
  LEtiqueta: TImpressaoEtiquetas;
begin
  LEtiqueta := TImpressaoEtiquetas.Create;

  LEtiqueta.CODIGO := (self.FindComponent('lblCodigo' + aTag.ToString) as TLabel).Caption;
  LEtiqueta.DESCRICAO := (self.FindComponent('lblDescricao' + aTag.ToString) as TLabel).Caption;
  LEtiqueta.Contem := (self.FindComponent('edtContem' + aTag.ToString) as TEdit).Text;
  LEtiqueta.ContemDescricao := (self.FindComponent('edtContemDescricao' + aTag.ToString) as TEdit).Text;
  LEtiqueta.Validade := (self.FindComponent('edtValidade' + aTag.ToString) as TDateTimePicker).DateTime;
  LEtiqueta.ImprimirValidade := chkImprimirValidade.Checked;
  LEtiqueta.Data := (self.FindComponent('edtData' + aTag.ToString) as TDateTimePicker).Date;
  LEtiqueta.Hora := (self.FindComponent('edtHora' + aTag.ToString) as TDateTimePicker).DateTime;
  LEtiqueta.Observacao := (self.FindComponent('edtObservacao' + aTag.ToString) as TEdit).Text;

  result := LEtiqueta;
end;

procedure TFrmEtiquetasModelo4x2.BitBtn1Click(Sender: TObject);
var
  Relatorio: TFREtiquetasModelo4x2;
  LEtiquetas: Tarray<TImpressaoEtiquetas>;
  I: Integer;
  LCopias: Integer;
begin
  try
    inherited;

    for I := 1 to TOTALETIQUETAS do
      TArrayUtil<TImpressaoEtiquetas>.Append(LEtiquetas, GetEtiqueta(I));

    LCopias := StrToIntDef(edtNumCopias.Text, 1);

    Relatorio := TFREtiquetasModelo4x2.Create(self);
    Relatorio.MostraPreview := true;
    Relatorio.Imprimir(LEtiquetas, LCopias);
    Relatorio.Free;
  except
    on e: exception do
      MessageDlg(e.Message, mtError, [mbYes], 0);
  end;
end;

procedure TFrmEtiquetasModelo4x2.cbbProduto1Click(Sender: TObject);
begin
  inherited;
  TComboBox(Sender).SelectAll;
end;

procedure TFrmEtiquetasModelo4x2.cbbProduto1Enter(Sender: TObject);
var
  cbbProduto: TComboBox;
begin
  inherited;
  cbbProduto := TComboBox(Sender);
end;

procedure TFrmEtiquetasModelo4x2.cbbProduto1KeyPress(Sender: TObject; var Key: Char);
var
  cbbProduto: TComboBox;
begin
  inherited;
  if Key = #27 then
  begin
    cbbProduto := TComboBox(Sender);
    cbbProduto.Text := 'Pesquisar...';
    cbbProduto.DroppedDown := FALSE;
  end;
end;

procedure TFrmEtiquetasModelo4x2.cbbProduto1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  itens: TObjectList<TProduto>;
  DescricaoProduto: string;
  Item: TProduto;
  cbbProduto: TComboBox;
begin

  cbbProduto := TComboBox(Sender);

  inherited;
  case Key of
    // VK_UP, VK_DOWN
    VK_RETURN:
      begin
        cbbProduto.DroppedDown := FALSE;
      end;
    VK_INSERT:
      begin
        PesquisaProduto(cbbProduto, BindProduto);
      end;
    VK_ESCAPE:
      begin
        cbbProduto.Text := StrPesquisa;
      end
  else
    begin
      cbbProduto.DroppedDown := true;
      if Length(cbbProduto.Text) > 1 then
      begin
        // if not cbbProduto.AutoDropDown then
        // cbbProduto.AutoDropDown := True;
        cbbProduto.DroppedDown := true;
        // cbbProduto.AutoComplete := Length(cbbProduto.Text) >= 2;

        if { (CachePesquisa.IndexOf(cbbProduto.Text) = -1) and } (cbbProduto.Items.IndexOf(cbbProduto.Text) = -1) and (Key <> VK_RETURN) then
        begin
          OutputDebugString(PWideChar(cbbProduto.Text));
          itens := FDaoProdutos.GetProdutosPorDescricaoParcial(cbbProduto.Text);
          itens.OwnsObjects := FALSE;

          for Item in itens do
          begin
            if cbbProduto.Items.IndexOf(Item.DESCRICAO) = -1 then
              cbbProduto.Items.AddObject(Item.DESCRICAO, Item);
          end;

          FreeAndNil(itens);

          // CachePesquisa.Add(cbbProduto.Text);
        end;

        cbbProduto.DropDownCount := 8;
      end;
    end;
  end;
end;

procedure TFrmEtiquetasModelo4x2.cbbProduto1Select(Sender: TObject);

var
  Produto: TProduto;
  cbbProduto: TComboBox;
begin
  inherited;

  cbbProduto := TComboBox(Sender);

  if cbbProduto.ItemIndex > -1 then
  begin
    if cbbProduto.Items.Objects[cbbProduto.ItemIndex] <> nil then
    begin
      try

        // cbbProduto.DroppedDown := False;
        Produto := cbbProduto.Items.Objects[cbbProduto.ItemIndex] as TProduto;
        // edtPreco.Text := FormatCurr('0.,00', Produto.PRECO_VENDA);
        BindProduto(Produto, cbbProduto.Tag)
      except
      end;
    end;
  end;
end;

function TFrmEtiquetasModelo4x2.MontaDescricaoPesquisaProduto(const Item: TProduto): string;
begin
  result := Item.DESCRICAO + ' - ' + Item.CODIGO + ' - ' + FormatCurr(' R$ 0.,00', Item.PRECO_VENDA);
end;

procedure TFrmEtiquetasModelo4x2.FormCreate(Sender: TObject);
begin
  inherited;
  CachePesquisa := TStringList.Create;
  FDaoProdutos := TFactory.DaoProduto;
  try
    FEmitente := TFactory.DaoEmitente.GetEmitente();

    if not Assigned(FEmitente) then
    begin
      FEmitente := TFactory.Emitente;
    end;

    FParametros := TFactory.DaoParametros.GetParametros;
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

procedure TFrmEtiquetasModelo4x2.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FParametros);
  FreeAndNil(FEmitente);
  FreeAndNil(CachePesquisa);
end;

end.
