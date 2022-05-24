unit Etiquetas.Modelo1;

interface

uses
  System.Bindings.Helper, Dominio.Entidades.TProduto, System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.Mask, Vcl.StdCtrls,
  Vcl.ActnList, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Utils.Rtti, Util.Funcoes,
  ACBrPosPrinter, System.TypInfo, Dao.IDaoProdutos,
  Dao.IDaoEmitente, Dominio.Entidades.TEmitente, Sistema.TParametros, Dao.IDaoParametros,
  Data.Bind.Components, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Actions,
  Vcl.ExtDlgs, Vcl.Imaging.pngimage, JvExMask, JvToolEdit, Vcl.AutoComplete;

type

  TFrmEtiquetasModelo1 = class(TfrmBase)
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
    edtData1: TJvDateEdit;
    Label1: TLabel;
    edtHora1: TDateTimePicker;
    Label2: TLabel;
    edtValidade1: TJvDateEdit;
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
    edtData2: TJvDateEdit;
    Label8: TLabel;
    edtHora2: TDateTimePicker;
    Label9: TLabel;
    edtValidade2: TJvDateEdit;
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
    edtData3: TJvDateEdit;
    Label16: TLabel;
    edtHora3: TDateTimePicker;
    Label17: TLabel;
    edtValidade3: TJvDateEdit;
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
    edtData4: TJvDateEdit;
    Label24: TLabel;
    edtHora4: TDateTimePicker;
    Label25: TLabel;
    edtValidade4: TJvDateEdit;
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
    edtData5: TJvDateEdit;
    Label32: TLabel;
    edtHora5: TDateTimePicker;
    Label33: TLabel;
    edtValidade5: TJvDateEdit;
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
    edtData6: TJvDateEdit;
    Label40: TLabel;
    edtHora6: TDateTimePicker;
    Label41: TLabel;
    edtValidade6: TJvDateEdit;
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
    SpeedButton1: TSpeedButton;
    AutoComplete1: TAutoComplete;
    AutoComplete2: TAutoComplete;
    SpeedButton2: TSpeedButton;
    AutoComplete3: TAutoComplete;
    SpeedButton3: TSpeedButton;
    AutoComplete4: TAutoComplete;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    cbbProduto6: TComboBox;
    cbbProduto1: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cbbProduto1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure cbbProduto1Click(Sender: TObject);
    procedure btnConsultaProduto1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure cbbProduto1KeyPress(Sender: TObject; var Key: Char);
    procedure cbbProduto1Select(Sender: TObject);
    procedure cbbProduto1Enter(Sender: TObject);
  private
    { Private declarations }
    FDaoProdutos: IDaoProdutos;
    FEmitente: TEmitente;
    FParametros: TParametros;
    CachePesquisa: TStringList;
    procedure Bind;
    procedure PesquisaProduto(cbbProduto: TComponent; aCallback: TProc<TProduto, Integer>);
    function MontaDescricaoPesquisaProduto(const Item: TProduto): string;
    procedure BindProduto(aProduto: TProduto; aTag: Integer);
  public
    { Public declarations }
  end;

resourcestring
  StrPesquisa = '';

var
  FrmEtiquetasModelo1: TFrmEtiquetasModelo1;

implementation

uses Dominio.Entidades.TFactory, Vcl.Printers, System.StrUtils,
  Consulta.Produto;

{$R *.dfm}

procedure TFrmEtiquetasModelo1.Bind;
var
  I: Integer;
  lbl: TLabel;
  imgLogo: TImage;
  edtData: TJvDateEdit;
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

    imgLogo := self.FindComponent('imgLogo' + I.ToString) as TImage;
    imgLogo.Picture := FParametros.LOGOMARCAETIQUETA.Picture;

    edtData := self.FindComponent('edtData' + I.ToString) as TJvDateEdit;
    edtData.Date := Now;

    edtHora := self.FindComponent('edtHora' + I.ToString) as TDateTimePicker;
    edtHora.DateTime := Now;

  end;

end;

procedure TFrmEtiquetasModelo1.PesquisaProduto(cbbProduto: TComponent; aCallback: TProc<TProduto, Integer>);
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

procedure TFrmEtiquetasModelo1.btn1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmEtiquetasModelo1.btnConsultaProduto1Click(Sender: TObject);
begin
  inherited;
  PesquisaProduto(cbbProduto1, BindProduto);
end;

procedure TFrmEtiquetasModelo1.BindProduto(aProduto: TProduto; aTag: Integer);
var
  lbl: TLabel;
begin
  lbl := self.FindComponent('lblCodigo' + aTag.ToString) as TLabel;
  lbl.Caption := TUtil.IFF<string>(aProduto.BARRAS = '', aProduto.BARRAS, aProduto.CODIGO);

end;

procedure TFrmEtiquetasModelo1.cbbProduto1Click(Sender: TObject);
begin
  inherited;
  TComboBox(Sender).SelectAll;
end;

procedure TFrmEtiquetasModelo1.cbbProduto1Enter(Sender: TObject);
var
  cbbProduto: TComboBox;
begin
  inherited;
  cbbProduto := TComboBox(Sender);
end;

procedure TFrmEtiquetasModelo1.cbbProduto1KeyPress(Sender: TObject; var Key: Char);
var
  cbbProduto: TComboBox;
begin
  inherited;
  if Key = #27 then
  begin
    cbbProduto := TComboBox(Sender);
    cbbProduto.Text := 'Pesquisar...';
    cbbProduto.DroppedDown := False;
  end;
end;

procedure TFrmEtiquetasModelo1.cbbProduto1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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
        cbbProduto.DroppedDown := False;
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
      cbbProduto.DroppedDown := True;
      if Length(cbbProduto.Text) > 1 then
      begin
        // if not cbbProduto.AutoDropDown then
        // cbbProduto.AutoDropDown := True;
        cbbProduto.DroppedDown := True;
        // cbbProduto.AutoComplete := Length(cbbProduto.Text) >= 2;

        if { (CachePesquisa.IndexOf(cbbProduto.Text) = -1) and } (cbbProduto.Items.IndexOf(cbbProduto.Text) = -1) and (Key <> VK_RETURN) then
        begin
          OutputDebugString(PWideChar(cbbProduto.Text));
          itens := FDaoProdutos.GetProdutosPorDescricaoParcial(cbbProduto.Text);
          itens.OwnsObjects := False;

          for Item in itens do
          begin
            if cbbProduto.Items.IndexOf(Item.DESCRICAO) = -1 then
              cbbProduto.Items.AddObject(Item.DESCRICAO, Item);
          end;

          FreeAndNil(itens);

          // CachePesquisa.Add(cbbProduto.Text);
        end;
      end;
    end;
  end;
end;

procedure TFrmEtiquetasModelo1.cbbProduto1Select(Sender: TObject);

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

function TFrmEtiquetasModelo1.MontaDescricaoPesquisaProduto(const Item: TProduto): string;
begin
  result := Item.DESCRICAO + ' - ' + Item.CODIGO + ' - ' + FormatCurr(' R$ 0.,00', Item.PRECO_VENDA);
end;

procedure TFrmEtiquetasModelo1.FormCreate(Sender: TObject);
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

procedure TFrmEtiquetasModelo1.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FParametros);
  FreeAndNil(FEmitente);
  FreeAndNil(CachePesquisa);
end;

end.
