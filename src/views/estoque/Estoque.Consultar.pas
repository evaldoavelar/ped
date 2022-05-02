unit Estoque.Consultar;

interface

uses
  Dominio.Entidades.TEstoqueProduto,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.Bind.Controls,
  Data.Bind.GenData, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components,
  System.ImageList, Vcl.ImgList, Data.Bind.ObjectScope, Vcl.Buttons,
  Vcl.Bind.Navigator, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.StdCtrls, Vcl.AutoComplete, Vcl.ComCtrls, System.Generics.Collections, Dominio.Entidades.TProduto;

type
  TViewEstoqueMovimentacoes = class(TfrmBase)
    Panel3: TPanel;
    Panel4: TPanel;
    lbl2: TLabel;
    edtPesquisaProduto: TAutoComplete;
    Panel5: TPanel;
    Label3: TLabel;
    edtDataFinal: TMaskEdit;
    Panel1: TPanel;
    Label1: TLabel;
    edtDataInicnio: TMaskEdit;
    Panel6: TPanel;
    Image1: TImage;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    pnl3: TPanel;
    Panel7: TPanel;
    lblProdutos: TLabel;
    Panel8: TPanel;
    BindNavigator1: TBindNavigator;
    Panel9: TPanel;
    lblTotalSaidas: TLabel;
    lblTotalEntradas: TLabel;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    adpBASE: TAdapterBindSource;
    imglIcons: TImageList;
    BindingsList1: TBindingsList;
    lvPesquisa: TListView;
    LinkFillControlToField1: TLinkFillControlToField;

    procedure edtPesquisaProdutoClick(Sender: TObject);

    procedure edtPesquisaProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvPesquisaCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvPesquisaGetImageIndex(Sender: TObject; Item: TListItem);
    procedure lvPesquisaGetSubItemImage(Sender: TObject; Item: TListItem;
      SubItem: Integer; var ImageIndex: Integer);
    procedure SpeedButton1Click(Sender: TObject);

  private
    { Private declarations }

    FCachePesquisaProduto: TStringList;
    procedure LiberaProdutosedtPesquisaProduto;
    procedure FiltrarPorPamatros;
    procedure CalculaTotais(aLista: Tlist<TEstoqueProduto>);

  public
    { Public declarations }

  end;

resourcestring
  StrPesquisa = 'PESQUISA...';

var
  ViewEstoqueMovimentacoes: TViewEstoqueMovimentacoes;

implementation

uses
  Dominio.Entidades.TFactory, Dao.IDaoEstoqueProduto, Dao.IDaoFiltroEstoque, Util.Thread;

{$R *.dfm}


procedure TViewEstoqueMovimentacoes.CalculaTotais(aLista: Tlist<TEstoqueProduto>);
var
  totalEntradas: double;
  totalSaidas: double;
begin
  totalEntradas := 0;
  totalSaidas := 0;
  for var Estoque in aLista do
  begin
    if Estoque.TIPO = 'E' then
      totalEntradas := totalEntradas + Estoque.QUANTIDADE
    else if Estoque.TIPO = 'S' then
      totalSaidas := totalSaidas + +Estoque.QUANTIDADE;
  end;

  lblTotalEntradas.Caption := Format('QUANTIDADE DE PRODUTOS QUE ENTROU: %f', [totalEntradas]);
  lblTotalSaidas.Caption := Format('QUANTIDADE DE PRODUTOS QUE SAIU: %f', [totalSaidas]);

end;

procedure TViewEstoqueMovimentacoes.edtPesquisaProdutoClick(Sender: TObject);
begin
  inherited;
  edtPesquisaProduto.SelectAll;
end;

procedure TViewEstoqueMovimentacoes.edtPesquisaProdutoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  Item: TProduto;
  itens: TObjectList<TProduto>;
  DescricaoProduto: string;
begin
  inherited;
  if (Length(edtPesquisaProduto.Text) > 1) and (edtPesquisaProduto.Text <> StrPesquisa) then
  begin

    if (FCachePesquisaProduto.IndexOf(edtPesquisaProduto.Text) = -1)
      and (edtPesquisaProduto.Items.IndexOf(edtPesquisaProduto.Text) = -1)
      and (Key <> VK_RETURN) then
    begin
      OutputDebugString(PWideChar(edtPesquisaProduto.Text));
      itens := TFactory.DaoProduto.GetProdutosPorDescricaoParcial(edtPesquisaProduto.Text);
      itens.OwnsObjects := FALSE;
      for Item in itens do
      begin

        if edtPesquisaProduto.Items.IndexOf(Item.Descricao) = -1 then
          edtPesquisaProduto.Items.AddObject(Item.Descricao, Item)
        else
          Item.Free;
      end;

      FreeAndNil(itens);

      FCachePesquisaProduto.Add(edtPesquisaProduto.Text);
    end;
  end;
end;

procedure TViewEstoqueMovimentacoes.FormCreate(Sender: TObject);
begin
  inherited;
  FCachePesquisaProduto := TStringList.Create;
end;

procedure TViewEstoqueMovimentacoes.FormDestroy(Sender: TObject);
begin
  inherited;
  LiberaTListDoAdapter<TEstoqueProduto>(adpBASE.Adapter);
  LiberaProdutosedtPesquisaProduto;
end;

procedure TViewEstoqueMovimentacoes.FormResize(Sender: TObject);
begin
  inherited;
 //utoSizeCol(lvPesquisa);
end;

procedure TViewEstoqueMovimentacoes.FormShow(Sender: TObject);
begin
  inherited;
  edtDataInicnio.Text := FormatDateTime('dd/mm/yyyy', now);
  edtDataFinal.Text := FormatDateTime('dd/mm/yyyy', now);

  lblTotalEntradas.Caption := '';
  lblTotalSaidas.Caption := '';
  try
    edtPesquisaProduto.SetFocus;
  except
  end;
  FiltrarPorPamatros;
end;

procedure TViewEstoqueMovimentacoes.LiberaProdutosedtPesquisaProduto;
var
  i: Integer;
begin
  edtPesquisaProduto.Clear;
  FCachePesquisaProduto.Clear;
end;

procedure TViewEstoqueMovimentacoes.lvPesquisaCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  inherited;

  // se for o campo status  e tem recibo
  if (Item.SubItems[5] = 'S') then
  begin
    Sender.Canvas.Font.Color := clRed;
  end
  else if Item.SubItems[5] = 'E' then
  begin
    Sender.Canvas.Font.Color := $0054A80F; // $00E8731A;
  end

end;

procedure TViewEstoqueMovimentacoes.lvPesquisaGetImageIndex(Sender: TObject; Item: TListItem);
begin
  inherited;
  Item.ImageIndex := -1;
end;

procedure TViewEstoqueMovimentacoes.lvPesquisaGetSubItemImage(Sender: TObject;
  Item: TListItem; SubItem: Integer; var ImageIndex: Integer);
begin
  inherited;
  // se for o campo status
  if SubItem = 5 then
  begin
    if Item.SubItems[SubItem] = 'E' then
      Item.SubItemImages[SubItem] := 0
    else if (Item.SubItems[SubItem] = 'S') then
      Item.SubItemImages[SubItem] := 1;
  end;
end;

procedure TViewEstoqueMovimentacoes.SpeedButton1Click(Sender: TObject);
var
  Filtro: IDaoEstoqueFiltro;
begin
  inherited;
  FiltrarPorPamatros;
end;

procedure TViewEstoqueMovimentacoes.FiltrarPorPamatros;
var
  Filtro: IDaoEstoqueFiltro;
begin
  TThreadUtil.Executar(
    // Exception
    procedure(e: Exception)
    begin
      MessageDlg(e.Message, mtError, [mbOK], 0);
    end,
  // Antes de Execultar
    procedure()
    begin
      adpBASE.Active := FALSE;
      // liberar a lista de produtos da pesquisa anterior
      LiberaTListDoAdapter<TEstoqueProduto>(adpBASE.Adapter);

      Filtro := TFactory.DaoFiltroEstoque;

      Filtro
        .setDataIncio(StrToDateTimeDef(edtDataInicnio.Text, 0))
        .setDataFim(StrToDateTimeDef(edtDataFinal.Text, 0));

      if edtPesquisaProduto.GetSelectObject <> nil then
      begin

        var
        Produto := edtPesquisaProduto.GetSelectObject as TProduto;
        Filtro.setProduto(Produto.CODIGO);
      end;
    end,
  // Execultar
    procedure()
    var
      adpater: TBaseListBindSourceAdapter;
    begin

      // criar um novo adapter a partir da lista de produtos retornada
      var
      estoques := TFactory
        .DaoEstoqueProduto
        .ListaObject(Filtro);

      CalculaTotais(estoques);

      adpater := TListBindSourceAdapter<TEstoqueProduto>.Create(Self, estoques, FALSE);

      TThread.Synchronize(TThread.CurrentThread,
        procedure()
        begin
          adpBASE.Adapter := adpater;
        end);
    end,
  // de pois deExecultar
    procedure()
    begin
      adpBASE.Active := true;

      // exibir a quantidade de produtos retornados
      lblProdutos.Caption := adpBASE.Adapter.ItemCount.ToString + ' REGISTROS';

    end
    );

end;

initialization

RegisterClass(TViewEstoqueMovimentacoes);

end.
