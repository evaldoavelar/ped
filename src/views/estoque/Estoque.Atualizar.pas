unit Estoque.Atualizar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.StdCtrls, Vcl.Buttons,
  System.Actions, Vcl.ActnList, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.AutoComplete, Vcl.ComCtrls, Dominio.Entidades.TEstoqueProduto,
  Dominio.Entidades.TProduto, Estoque.Parts.Atualizar,
  System.Generics.Collections;

type
  TFrmEstoqueAtualizar = class(TfrmBase)
    PageControl1: TPageControl;
    tsEntrada: TTabSheet;
    jvPnl1: TPanel;
    GridPanel1: TGridPanel;
    pnl1: TPanel;
    Panel1: TPanel;
    Label5: TLabel;
    Panel12: TPanel;
    btnIncrementaQuantidade: TSpeedButton;
    btnSubtraiQuantidade: TSpeedButton;
    edtQuantidade: TEdit;
    Panel5: TPanel;
    lbl2: TLabel;
    edtPesquisaProduto: TAutoComplete;
    Panel2: TPanel;
    Label2: TLabel;
    edtNumeroNF: TEdit;
    Panel6: TPanel;
    Image6: TImage;
    btnIncluirProduto1: TSpeedButton;
    Panel7: TPanel;
    Panel8: TPanel;
    Image4: TImage;
    SpeedButton2: TSpeedButton;
    Panel9: TPanel;
    Image5: TImage;
    btnIncluir: TSpeedButton;
    pnl3: TPanel;
    scrlProdutos: TScrollBox;
    pnl2: TPanel;
    pnlNumero: TPanel;
    pnlCodigoPrd: TPanel;
    ViewPartVendaItens: TPanel;
    lblDescricao: TLabel;
    pnlPreco: TPanel;
    lblPreco: TLabel;
    lblTotal: TLabel;
    pnlCancelar: TPanel;
    img1: TImage;
    btnCancelar: TSpeedButton;
    tsConcluido: TTabSheet;
    Label4: TLabel;
    Panel13: TPanel;
    Panel4: TPanel;
    ActionList1: TActionList;
    actNovo: TAction;
    actSalvar: TAction;
    actExcluir: TAction;
    actProximo: TAction;
    actIncrementaQuantidade: TAction;
    actSubtraiQuantidade: TAction;
    actIncluir: TAction;
    btnIncluir1: TBitBtn;
    Panel3: TPanel;
    Panel10: TPanel;
    Label1: TLabel;
    actSair: TAction;
    btnSair: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actProximoExecute(Sender: TObject);
    procedure actSubtraiQuantidadeExecute(Sender: TObject);
    procedure actIncrementaQuantidadeExecute(Sender: TObject);
    procedure actIncluirExecute(Sender: TObject);
    procedure edtPesquisaProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisaProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtNumeroNFKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisaProdutoClick(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
  private
    FLancamentos: TList<TEstoqueProduto>;
    FCachePesquisaProduto: TStringList;
    { Private declarations }
    procedure SomaSubtraiQuantidade(aValue: Double);
    procedure DarEntradaEstoqueThread;
    procedure BindEstoque(aEstoque: TEstoqueProduto);
    procedure LiberaProdutosedtPesquisaProduto;
    procedure VendeItemPorDescricao(Produto: TProduto);
    function MontaDescricaoPesquisaProduto(const aItem: TProduto): string;
    function AddEntradaEstoque(aQuantidade: Double; aProduto: TProduto;
      aNumeroNF: string): TEstoqueProduto;
    procedure tsEntradaShow(Sender: TObject);
    procedure OcultaTabs(aPageControl: TPageControl);
    procedure Salvar;
  public
    { Public declarations }
  end;

resourcestring
  StrPesquisa = 'PESQUISA...';

var
  FrmEstoqueAtualizar: TFrmEstoqueAtualizar;

implementation

uses
  Utils.Rtti,
  Helpers.HelperString, Util.Thread, Util.Funcoes, Sistema.TLog, Factory.Entidades;

{$R *.dfm}


procedure TFrmEstoqueAtualizar.Salvar();
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.Salvar ');
  try
    fFactory.Conexao().StartTransaction;

    for var aEstoque in FLancamentos do
    begin
      fFactory.DaoEstoqueProduto.Inclui(aEstoque);
      fFactory.DaoProduto.EntradaSaidaEstoque(aEstoque.CODIGOPRD, aEstoque.QUANTIDADE, false)
    end;

    fFactory.Conexao().Commit;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      fFactory.Conexao().Rollback;
      raise;
    end;
  end;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.Salvar ');
end;

procedure TFrmEstoqueAtualizar.BindEstoque(aEstoque: TEstoqueProduto);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.BindEstoque ');
  TFrameEstoquePartsAtualizar
    .new(nil)
    .setParams([aEstoque])
    .SetParent(scrlProdutos)
    .setOnObjectChange(
    procedure(aobj: TObject)
    begin
      TLog.d('Produto cancelado');
      FLancamentos.Remove(aobj as TEstoqueProduto);
      aobj.Free;

    end).SetUp;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.BindEstoque ');
end;

procedure TFrmEstoqueAtualizar.actIncluirExecute(Sender: TObject);
var
  Produto: TProduto;
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.actIncluirExecute ');
  inherited;
  try
    if edtPesquisaProduto.ItemIndex <> -1 then
    begin
      Produto := nil;

      if edtPesquisaProduto.ItemIndex > -1 then
      begin
        if edtPesquisaProduto.GetSelectObject <> nil then
        begin
          try
            OutputDebugString(PWideChar(edtPesquisaProduto.Items.Strings[edtPesquisaProduto.ItemIndex]));
            Produto := edtPesquisaProduto.GetSelectObject as TProduto;
          except
            raise Exception.Create('Produto não selecionado');
          end;
        end;
      end;

      VendeItemPorDescricao(Produto);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        edtPesquisaProduto.Text := StrPesquisa;
        edtPesquisaProduto.SetFocus;
      except
      end;
    end;
  end;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.actIncluirExecute ');
end;

procedure TFrmEstoqueAtualizar.actIncrementaQuantidadeExecute(
  Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.actIncrementaQuantidadeExecute ');
  inherited;
  try
    SomaSubtraiQuantidade(1);
  except
    on E: Exception do
    begin
      TLog.d('SomaSubtraiQuantidade: ' + E.Message);
    end;
  end;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.actIncrementaQuantidadeExecute ');
end;

procedure TFrmEstoqueAtualizar.actNovoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.actNovoExecute ');
  inherited;
  try
    PageControl1.ActivePage := tsEntrada;
    LimpaScrollBox(scrlProdutos);

    TRY
      edtQuantidade.Text := '1';
      edtPesquisaProduto.SetFocus;
      edtPesquisaProduto.SelectAll;

    except
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.actNovoExecute ');
end;

procedure TFrmEstoqueAtualizar.actProximoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.actProximoExecute ');
  inherited;
  DarEntradaEstoqueThread;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.actProximoExecute ');
end;

procedure TFrmEstoqueAtualizar.DarEntradaEstoqueThread();
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.DarEntradaEstoqueThread ');
  TThreadUtil.Executar(
  // Exception
    procedure(E: Exception)
    begin
      Self.Enabled := true;
      // NotifyObservers('ERRO...', TAcaoView.acErro);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end,
  // Antes de Execultar
    procedure()
    begin
      Self.Enabled := false;
      // NotifyObservers('AGUARDE...', TAcaoView.acExecutando);
    end,
  // Execultar
    procedure()
    begin
      Salvar();

      TThread.Synchronize(TThread.CurrentThread,
        procedure()
        begin
          PageControl1.ActivePage := tsConcluido;
        end);
    end,
  // de pois deExecultar
    procedure()
    begin
      Self.Enabled := true;
      // NotifyObservers('CONCLUÍDO', TAcaoView.actConcluido);
    end
    );

  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.DarEntradaEstoqueThread ');
end;

procedure TFrmEstoqueAtualizar.actSairExecute(Sender: TObject);
begin
  inherited;
  CLOSE;
end;

procedure TFrmEstoqueAtualizar.actSubtraiQuantidadeExecute(Sender: TObject);
begin
  inherited;
  try
    SomaSubtraiQuantidade(-1);
  except
    on E: Exception do
    begin
      TLog.d('actSubtraiQuantidadeExecute: ' + E.Message);
    end;
  end;
end;

procedure TFrmEstoqueAtualizar.edtNumeroNFKeyPress(Sender: TObject;
var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    actIncluir.Execute;
  end
end;

procedure TFrmEstoqueAtualizar.edtPesquisaProdutoClick(Sender: TObject);
begin
  inherited;
  edtPesquisaProduto.SelectAll;
end;

procedure TFrmEstoqueAtualizar.edtPesquisaProdutoKeyPress(Sender: TObject;
var Key: Char);
var
  Produto: TProduto;
begin
  if Key = #13 then
  begin
    edtNumeroNF.SetFocus;
  end
  else if Key = '+' then
  begin
    actIncrementaQuantidade.Execute;
    Key := #0;
  end
  else if Key = '-' then
  begin
    actSubtraiQuantidade.Execute;
    Key := #0;
  end
end;

procedure TFrmEstoqueAtualizar.edtPesquisaProdutoKeyUp(Sender: TObject;
var Key: Word; Shift: TShiftState);
var
  Item: TProduto;
  itens: TObjectList<TProduto>;
  DescricaoProduto: string;
begin
  case Key of
    VK_Multiply:
      begin
        edtQuantidade.Text := Copy(edtPesquisaProduto.Text, 1, Length(edtPesquisaProduto.Text) - 1);
        try
          StrToFloat(edtQuantidade.Text);
        except
          MessageDlg('Quantidade inválida', mtError, [mbOK], 0);
          edtQuantidade.Text := '1';
          // DesbloqueiaControles;
          LiberaProdutosedtPesquisaProduto;
        end;
        // DesbloqueiaControles;
        LiberaProdutosedtPesquisaProduto;
      end;
    VK_ESCAPE:
      begin
        // edtPesquisaProduto.DroppedDown := false;
        edtPesquisaProduto.Text := StrPesquisa;
      end
  else
    begin
      if (Length(edtPesquisaProduto.Text) > 1) and (edtPesquisaProduto.Text <> StrPesquisa) then
      begin

        if (FCachePesquisaProduto.IndexOf(edtPesquisaProduto.Text) = -1)
          and (edtPesquisaProduto.Items.IndexOf(edtPesquisaProduto.Text) = -1)
          and (Key <> VK_RETURN) then
        begin
          OutputDebugString(PWideChar(edtPesquisaProduto.Text));
          itens := fFactory.DaoProduto.GetProdutosPorDescricaoParcial(edtPesquisaProduto.Text);
          itens.OwnsObjects := false;

          for Item in itens do
          begin
            DescricaoProduto := MontaDescricaoPesquisaProduto(Item);
            if edtPesquisaProduto.Items.IndexOf(DescricaoProduto) = -1 then
              edtPesquisaProduto.Items.AddObject(DescricaoProduto, Item)
            else
              Item.Free;
          end;

          FreeAndNil(itens);

          FCachePesquisaProduto.Add(edtPesquisaProduto.Text);
        end;
      end;
    end;
  end;

end;

procedure TFrmEstoqueAtualizar.edtQuantidadeKeyPress(Sender: TObject;
var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtPesquisaProduto.SetFocus;
end;

function TFrmEstoqueAtualizar.MontaDescricaoPesquisaProduto(const aItem: TProduto): string;
begin
  //TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.MontaDescricaoPesquisaProduto ');

  result := Format('%s %s %s', [
    aItem.DESCRICAO.RemoveAcentos
    , aItem.CODIGO
    , FormatCurr(' R$ 0.,00', aItem.PRECO_VENDA)
    ]);

 // TLog.d('<<< Saindo de TFrmEstoqueAtualizar.MontaDescricaoPesquisaProduto ');
end;

procedure TFrmEstoqueAtualizar.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.FormCreate ');
  inherited;
  FCachePesquisaProduto := TStringList.Create;
  FLancamentos := TList<TEstoqueProduto>.Create();

  OcultaTabs(PageControl1);
  PageControl1.ActivePage := tsEntrada;
  LimpaScrollBox(scrlProdutos);
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.FormCreate ');
end;

procedure TFrmEstoqueAtualizar.OcultaTabs(aPageControl: TPageControl);
var
  I: Integer;
begin
  TLog.d('>>> Entrando em  TViewBase.OcultaTabs ');
  for I := 0 to aPageControl.PageCount - 1 do
    aPageControl.Pages[I].TabVisible := false;
  TLog.d('<<< Saindo de TViewBase.OcultaTabs ');
end;

procedure TFrmEstoqueAtualizar.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.FormDestroy ');
  inherited;
  LiberaProdutosedtPesquisaProduto;
  FLancamentos.Free;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.FormDestroy ');
end;

procedure TFrmEstoqueAtualizar.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.FormShow ');
  inherited;
  try
    edtQuantidade.SetFocus;
  except
  end;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.FormShow ');
end;

procedure TFrmEstoqueAtualizar.VendeItemPorDescricao(Produto: TProduto);
var
  qtd: Double;
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.VendeItemPorDescricao ');
  try

    if not Assigned(Produto) then
      raise Exception.Create('PRODUTO NÃO SELECIONADO');

    if Produto.PRECO_VENDA <= 0 then
      raise Exception.Create('PRODUTO SEM PREÇO');

    try

      qtd := StrToFloat(edtQuantidade.Text);
    except
      on E: Exception do
        raise Exception.Create('VALOR INVÁLIDO PARA QUANTIDADE!!!!');
    end;

    if qtd < 0 then
      raise Exception.Create('QUANTIDADE PRECISA SER MAIOR QUE ZERO');

    // se for quantidade fracionada e produto não vende fracionado
    // if (Frac(Self.Quantidade) <> 0) and (not Produto.QUANTIDADEFRACIONADA) then
    // raise Exception.Create('ATENÇÃO: Produto Unitário com quantidade fracionada');

    try
      edtPesquisaProduto.Enabled := false;
      var
      entrada := AddEntradaEstoque(qtd, Produto, edtNumeroNF.Text);
      BindEstoque(entrada);

      LiberaProdutosedtPesquisaProduto();
    finally
      try
        // medtQuantidade.SetFocus;
        edtQuantidade.Text := '1';

        edtPesquisaProduto.Enabled := true;
        edtPesquisaProduto.ItemIndex := -1;
        edtPesquisaProduto.Text := StrPesquisa;
        LiberaProdutosedtPesquisaProduto;
        edtQuantidade.SetFocus;
        edtQuantidade.SelectAll;
      except
      end;
    end;

  except
    on E: EAbort do
    begin
      TLog.d('Abortado...');
      Exit;
    end;
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        edtPesquisaProduto.Text := StrPesquisa;
        edtPesquisaProduto.SetFocus;
      except
      end;
    end;
  end;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.VendeItemPorDescricao ');
end;

function TFrmEstoqueAtualizar.AddEntradaEstoque(aQuantidade: Double;
aProduto: TProduto; aNumeroNF: string): TEstoqueProduto;
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.AddEntradaEstoque ');
  TRttiUtil.Validation<Exception>((aQuantidade < 0), 'QUANTIDADE DO PRODUTO PRECISA SER MAIOR QUE ZERO!!! ');
  TRttiUtil.Validation<Exception>(aProduto = nil, 'INFORME O PRODUTO!!! ');

  result := TEstoqueProduto.Create;
  // result.IDPRD := aProduto.IDPRD;
  result.IDPEDIDO := 0;
  result.CODIGOPRD := aProduto.CODIGO;
  result.DESCRICAO := aProduto.DESCRICAO;
  result.NOTAFISCAL := aNumeroNF;
  result.QUANTIDADE := aQuantidade;
  result.DATA := Now;
  result.TIPO := 'E';
  result.Status := 'A';
  result.StatusBD := TEstoqueProduto.TStatusBD.stCriar;
  result.USUARIOCRIACAO := TFactoryEntidades.new.VendedorLogado.NOME;
  FLancamentos.Add(result);
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.AddEntradaEstoque ');
end;

procedure TFrmEstoqueAtualizar.LiberaProdutosedtPesquisaProduto;
var
  I: Integer;
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.LiberaProdutosedtPesquisaProduto ');
  edtPesquisaProduto.Clear;
  FCachePesquisaProduto.Clear;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.LiberaProdutosedtPesquisaProduto ');
end;

procedure TFrmEstoqueAtualizar.SomaSubtraiQuantidade(aValue: Double);
var
  qtd: Double;
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.SomaSubtraiQuantidade ');
  inherited;
  qtd := StrToFloatDef(edtQuantidade.Text, 1);

  qtd := qtd + aValue;

  qtd := TUtil.IFF<Double>(qtd <= 0, qtd, 1);
  qtd := TUtil.IFF<Double>(qtd >= 999, qtd, 999);

  edtQuantidade.Text := qtd.ToString;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.SomaSubtraiQuantidade ');
end;

procedure TFrmEstoqueAtualizar.tsEntradaShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TFrmEstoqueAtualizar.tsEntradaShow ');
  inherited;
  try
    edtPesquisaProduto.SetFocus;
    edtPesquisaProduto.SelectAll;
  except
    on E: Exception do
  end;
  TLog.d('<<< Saindo de TFrmEstoqueAtualizar.tsEntradaShow ');
end;

initialization

RegisterClass(TFrmEstoqueAtualizar);

end.
