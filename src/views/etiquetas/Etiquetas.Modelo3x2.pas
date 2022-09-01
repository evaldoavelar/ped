unit Etiquetas.Modelo3x2;

interface

uses
  System.Bindings.Helper, Dominio.Entidades.TProduto, System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Utils.Rtti, Util.Funcoes,
  ACBrPosPrinter, System.TypInfo, Dao.IDaoProdutos, Impressao.Etiquetas,
  Dao.IDaoEmitente, Dominio.Entidades.TEmitente, Sistema.TParametros, Dao.IDaoParametros,
  Data.Bind.Components, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Actions,
  Vcl.ExtDlgs, Vcl.Imaging.pngimage, JvExMask, JvToolEdit, Vcl.AutoComplete,
  frxClass;

type

  TFrmEtiquetasModelo3x2 = class(TfrmBase)
    Panel1: TPanel;
    btn1: TBitBtn;
    BitBtn1: TBitBtn;
    GridPanel2: TGridPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel9: TPanel;
    lbl1: TLabel;
    edtPreco1: TEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    GridPanel1: TGridPanel;
    lblValdiade: TLabel;
    Label1: TLabel;
    edtHora1: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    edtPeso1: TEdit;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    imgLogo1: TImage;
    Panel10: TPanel;
    lblCidade1: TLabel;
    lblRua1: TLabel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Label6: TLabel;
    edtPreco2: TEdit;
    Panel14: TPanel;
    Panel15: TPanel;
    GridPanel3: TGridPanel;
    Label7: TLabel;
    Label8: TLabel;
    edtHora2: TDateTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    edtPeso2: TEdit;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    imgLogo2: TImage;
    Panel19: TPanel;
    lblCidade2: TLabel;
    lblRua2: TLabel;
    Panel20: TPanel;
    Panel21: TPanel;
    Panel22: TPanel;
    Label14: TLabel;
    edtPreco3: TEdit;
    Panel23: TPanel;
    Panel24: TPanel;
    GridPanel4: TGridPanel;
    Label15: TLabel;
    Label16: TLabel;
    edtHora3: TDateTimePicker;
    Label17: TLabel;
    Label18: TLabel;
    edtPeso3: TEdit;
    Panel25: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    imgLogo3: TImage;
    Panel28: TPanel;
    lblCidade3: TLabel;
    lblRua3: TLabel;
    Panel29: TPanel;
    Panel30: TPanel;
    Panel31: TPanel;
    Label22: TLabel;
    edtPreco4: TEdit;
    Panel32: TPanel;
    Panel33: TPanel;
    GridPanel5: TGridPanel;
    Label23: TLabel;
    Label24: TLabel;
    edtHora4: TDateTimePicker;
    Label25: TLabel;
    Label26: TLabel;
    edtPeso4: TEdit;
    Panel34: TPanel;
    Panel35: TPanel;
    Panel36: TPanel;
    imgLogo4: TImage;
    Panel37: TPanel;
    lblCidade4: TLabel;
    lblRua4: TLabel;
    Panel38: TPanel;
    Panel39: TPanel;
    Panel40: TPanel;
    Label30: TLabel;
    edtPreco5: TEdit;
    Panel41: TPanel;
    Panel42: TPanel;
    GridPanel6: TGridPanel;
    Label31: TLabel;
    Label32: TLabel;
    edtHora5: TDateTimePicker;
    Label33: TLabel;
    Label34: TLabel;
    edtPeso5: TEdit;
    Panel43: TPanel;
    Panel44: TPanel;
    Panel45: TPanel;
    imgLogo5: TImage;
    Panel46: TPanel;
    lblCidade5: TLabel;
    lblRua5: TLabel;
    Panel47: TPanel;
    Panel48: TPanel;
    Panel49: TPanel;
    Label38: TLabel;
    edtPreco6: TEdit;
    Panel50: TPanel;
    Panel51: TPanel;
    GridPanel7: TGridPanel;
    Label39: TLabel;
    Label40: TLabel;
    edtHora6: TDateTimePicker;
    Label41: TLabel;
    Label42: TLabel;
    edtPeso6: TEdit;
    Panel52: TPanel;
    Panel53: TPanel;
    Panel54: TPanel;
    imgLogo6: TImage;
    Panel55: TPanel;
    lblCidade6: TLabel;
    lblRua6: TLabel;
    Panel56: TPanel;
    Image1: TImage;
    lblCodigo1: TLabel;
    Panel57: TPanel;
    Image2: TImage;
    lblCodigo2: TLabel;
    Panel58: TPanel;
    Image3: TImage;
    lblCodigo3: TLabel;
    Panel59: TPanel;
    Image4: TImage;
    lblCodigo4: TLabel;
    Panel60: TPanel;
    Image5: TImage;
    lblCodigo5: TLabel;
    Panel61: TPanel;
    Image6: TImage;
    lblCodigo6: TLabel;
    btnConsultaProduto1: TSpeedButton;
    cbbProduto1: TComboBox;
    btnCopiar: TSpeedButton;
    edtValidade1: TDateTimePicker;
    edtData1: TDateTimePicker;
    lblDescricao1: TLabel;
    edtData3: TDateTimePicker;
    edtValidade3: TDateTimePicker;
    edtData2: TDateTimePicker;
    edtValidade2: TDateTimePicker;
    edtData4: TDateTimePicker;
    edtValidade4: TDateTimePicker;
    edtData5: TDateTimePicker;
    edtValidade5: TDateTimePicker;
    edtData6: TDateTimePicker;
    edtValidade6: TDateTimePicker;
    lblDescricao2: TLabel;
    lblDescricao3: TLabel;
    lblDescricao4: TLabel;
    lblDescricao5: TLabel;
    lblDescricao6: TLabel;
    cbbProduto2: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton6: TSpeedButton;
    cbbProduto3: TComboBox;
    SpeedButton2: TSpeedButton;
    SpeedButton7: TSpeedButton;
    cbbProduto4: TComboBox;
    SpeedButton3: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton9: TSpeedButton;
    cbbProduto6: TComboBox;
    SpeedButton5: TSpeedButton;
    cbbProduto5: TComboBox;
    Panel62: TPanel;
    Label4: TLabel;
    edtNumCopias: TEdit;
    frxReport1: TfrxReport;
    btnpdf: TBitBtn;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure cbbProduto1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure cbbProduto1Click(Sender: TObject);
    procedure btnConsultaProduto1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure cbbProduto1KeyPress(Sender: TObject; var Key: Char);
    procedure cbbProduto1Select(Sender: TObject);
    procedure cbbProduto1Enter(Sender: TObject);
    procedure btnCopiarClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnpdfClick(Sender: TObject);
  private
    { Private declarations }
    FDaoProdutos: IDaoProdutos;
    FEmitente: TEmitente;
    FParametros: TParametros;
    CachePesquisa: TStringList;
    procedure Bind; overload;
    procedure Bind(aTagOrigem: integer); overload;
    procedure PesquisaProduto(cbbProduto: TComponent; aCallback: TProc<TProduto, integer>);
    function MontaDescricaoPesquisaProduto(const Item: TProduto): string;
    procedure BindProduto(aProduto: TProduto; aTag: integer);
    function GetEtiqueta(aTag: integer): TImpressaoEtiquetas;
  public
    { Public declarations }
  end;

resourcestring
  StrPesquisa = '';

var
  FrmEtiquetasModelo3x2: TFrmEtiquetasModelo3x2;

implementation

uses Dominio.Entidades.TFactory, Vcl.Printers, System.StrUtils,
  Consulta.Produto, Relatorio.FREtiquetas.Modelo3x2, Utils.ArrayUtil;

{$R *.dfm}


procedure TFrmEtiquetasModelo3x2.Bind;
var
  I: integer;
  lbl: TLabel;
  imgLogo: TImage;
  edtData: TDateTimePicker;
  edtHora: TDateTimePicker;
begin
  FEmitente.ClearBindings;

  for I := 1 to 6 do
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

procedure TFrmEtiquetasModelo3x2.PesquisaProduto(cbbProduto: TComponent; aCallback: TProc<TProduto, integer>);
var
  Produto: TProduto;
  idx: integer;
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

procedure TFrmEtiquetasModelo3x2.btn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmEtiquetasModelo3x2.btnConsultaProduto1Click(Sender: TObject);
begin
  inherited;
  PesquisaProduto(TComponent(Sender), BindProduto);
end;

procedure TFrmEtiquetasModelo3x2.btnCopiarClick(Sender: TObject);
begin
  inherited;
  Bind(TComponent(Sender).Tag);
end;

procedure TFrmEtiquetasModelo3x2.btnpdfClick(Sender: TObject);
var
  Relatorio: TFREtiquetasModelo3x2;
  LEtiquetas: Tarray<TImpressaoEtiquetas>;
  I: integer;
begin
  try
    inherited;

    if not SaveDialog1.Execute then
      exit;

    for I := 1 to 6 do
      TArrayUtil<TImpressaoEtiquetas>.Append(LEtiquetas, GetEtiqueta(I));

    Relatorio := TFREtiquetasModelo3x2.Create(self);
    Relatorio.MostraPreview := FALSE;
    Relatorio.ArquivoPDF := SaveDialog1.FileName;
    Relatorio.PDF(LEtiquetas);
    Relatorio.Free;
  except
    on e: exception do
      MessageDlg(e.Message, mtError, [mbYes], 0);
  end;

end;

procedure TFrmEtiquetasModelo3x2.Bind(aTagOrigem: integer);
var
  I: integer;
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
  for I := aTagOrigem + 1 to 6 do
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

procedure TFrmEtiquetasModelo3x2.BindProduto(aProduto: TProduto; aTag: integer);
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

  edtPreco := self.FindComponent('edtPreco' + aTag.ToString) as TEdit;
  edtPreco.Text := FormatCurr('R$ 0.,00', aProduto.PRECO_VENDA);
end;

function TFrmEtiquetasModelo3x2.GetEtiqueta(aTag: integer): TImpressaoEtiquetas;
var
  LEtiqueta: TImpressaoEtiquetas;
begin
  LEtiqueta := TImpressaoEtiquetas.Create;

  LEtiqueta.CODIGO := (self.FindComponent('lblCodigo' + aTag.ToString) as TLabel).Caption;
  LEtiqueta.DESCRICAO := (self.FindComponent('lblDescricao' + aTag.ToString) as TLabel).Caption;
  LEtiqueta.Preco := (self.FindComponent('edtPreco' + aTag.ToString) as TEdit).Text;
  LEtiqueta.Peso := (self.FindComponent('edtPeso' + aTag.ToString) as TEdit).Text;
  LEtiqueta.Validade := (self.FindComponent('edtValidade' + aTag.ToString) as TDateTimePicker).DateTime;
  LEtiqueta.Data := (self.FindComponent('edtData' + aTag.ToString) as TDateTimePicker).Date;
  LEtiqueta.Hora := (self.FindComponent('edtHora' + aTag.ToString) as TDateTimePicker).DateTime;

  result := LEtiqueta;
end;

procedure TFrmEtiquetasModelo3x2.BitBtn1Click(Sender: TObject);
var
  Relatorio: TFREtiquetasModelo3x2;
  LEtiquetas: Tarray<TImpressaoEtiquetas>;
  I: integer;
  LCopias: Integer;
begin
  try
    inherited;

    for I := 1 to 6 do
      TArrayUtil<TImpressaoEtiquetas>.Append(LEtiquetas, GetEtiqueta(I));

    LCopias :=  StrToIntDef(edtNumCopias.Text, 1);

    Relatorio := TFREtiquetasModelo3x2.Create(self);
    Relatorio.MostraPreview := false;
    Relatorio.Imprimir(LEtiquetas, LCopias);
    Relatorio.Free;
  except
    on e: exception do
      MessageDlg(e.Message, mtError, [mbYes], 0);
  end;
end;

procedure TFrmEtiquetasModelo3x2.cbbProduto1Click(Sender: TObject);
begin
  inherited;
  TComboBox(Sender).SelectAll;
end;

procedure TFrmEtiquetasModelo3x2.cbbProduto1Enter(Sender: TObject);
var
  cbbProduto: TComboBox;
begin
  inherited;
  cbbProduto := TComboBox(Sender);
end;

procedure TFrmEtiquetasModelo3x2.cbbProduto1KeyPress(Sender: TObject; var Key: Char);
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

procedure TFrmEtiquetasModelo3x2.cbbProduto1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TFrmEtiquetasModelo3x2.cbbProduto1Select(Sender: TObject);

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

function TFrmEtiquetasModelo3x2.MontaDescricaoPesquisaProduto(const Item: TProduto): string;
begin
  result := Item.DESCRICAO + ' - ' + Item.CODIGO + ' - ' + FormatCurr(' R$ 0.,00', Item.PRECO_VENDA);
end;

procedure TFrmEtiquetasModelo3x2.FormCreate(Sender: TObject);
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

procedure TFrmEtiquetasModelo3x2.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FParametros);
  FreeAndNil(FEmitente);
  FreeAndNil(CachePesquisa);
end;

end.
