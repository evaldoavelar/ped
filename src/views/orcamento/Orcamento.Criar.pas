unit Orcamento.Criar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Data.DB, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, JvExControls,
  JvNavigationPane, System.DateUtils, System.Types,
  Vcl.Mask, JvExMask, JvToolEdit, Dao.IDaoProdutos, Dominio.Entidades.TProduto, System.Generics.Collections, Dominio.Entidades.TFactory, System.Actions, Vcl.ActnList,
  Data.Bind.GenData,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Vcl.Bind.Grid, System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.Bind.ObjectScope,
  Dominio.Entidades.TItemOrcamento, Dominio.Entidades.TOrcamento, Util.Exceptions, Dao.IDaoVendedor, Dao.IDaoOrcamento, Helper.TBindGrid, Helper.TLiveBindingFormatCurr,
  Util.Backup, Util.Funcoes,
  Pedido.CancelarItem, Relatorio.TROrcamento, Helper.TItemOrcamento, JvExStdCtrls, JvCombobox, Dominio.Entidades.TCliente, Dao.IDAOCliente,
  Vcl.ComCtrls, Vcl.Imaging.jpeg;

type

  TFrmCadastroOrcamento = class(TfrmBase)
    ActionList1: TActionList;
    actVoltar: TAction;
    actCancelarOrcamento: TAction;
    AdapterBindSource1: TAdapterBindSource;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    strGridProdutos: TStringGrid;
    BindingsList1: TBindingsList;
    actCancelaItem: TAction;
    actNovo: TAction;
    actFinaliza: TAction;
    LinkGridToDataSourceAdapterBindSource1: TLinkGridToDataSource;
    actCPesquisaProduto: TAction;
    pgc1: TPageControl;
    tsItens: TTabSheet;
    tsObservacao: TTabSheet;
    Label8: TLabel;
    mmoObservacoes: TMemo;
    jvPnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblClientes: TLabel;
    lblValdiade: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    btnConsultaProduto: TSpeedButton;
    Label9: TLabel;
    edtDesconto: TEdit;
    edtNumOrcamento: TEdit;
    edtQuantidade: TEdit;
    edtValidade: TJvDateEdit;
    cbbProduto: TComboBox;
    edtPreco: TEdit;
    edtTotal: TEdit;
    cbbCliente: TComboBox;
    edtTelefone: TMaskEdit;
    cbbTipoDesconto: TComboBox;
    Image1: TImage;
    JvNavPanelHeader1: TPanel;
    Label1: TLabel;
    lblTotalbruto: TLabel;
    lblTotalLiquido: TLabel;
    Label3: TLabel;
    lblTotalDesconto: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    lblVolume: TLabel;
    lbl5: TLabel;
    btnVoltar: TBitBtn;
    pnl1: TPanel;
    btnNovo: TBitBtn;
    btnNovo1: TBitBtn;
    procedure cbbProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtDescontoKeyPress(Sender: TObject; var Key: Char);
    procedure edtClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtValidadeKeyPress(Sender: TObject; var Key: Char);
    procedure actVoltarExecute(Sender: TObject);
    procedure actCancelaItemExecute(Sender: TObject);
    procedure cbbProdutoSelect(Sender: TObject);
    procedure edtQuantidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtDescontoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbbProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actCancelarOrcamentoExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actFinalizaExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbbClienteKeyPress(Sender: TObject; var Key: Char);
    procedure cbbClienteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbbProdutoEnter(Sender: TObject);
    procedure cbbClienteSelect(Sender: TObject);
    procedure cbbClienteExit(Sender: TObject);
    procedure actCPesquisaProdutoExecute(Sender: TObject);
    procedure edtTelefoneKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    CachePesquisa: TStringList;
    NSeqItem: Integer;
    FblEmVEnda: Boolean;
    FTotal: Currency;
    FDesconto: Currency;

    Orcamento: TOrcamento;
    DaoProdutos: IDaoProdutos;
    DaoCliente: IDAOCliente;
    DaoVen: IDaoVendedor;
    DaoOrcamento: IDaoOrcamento;
    procedure IniciaCampos;
    procedure BindGrid;
    procedure IncluirItem;
    procedure AbreOrcamento;

    procedure OnVendeItem(item: TItemOrcamento);
    procedure OnExcluiItem(item: TItemOrcamento);
    procedure OnOrcamentoChange(ValorLiquido, ValorBruto, Desconto: Currency; Volume: Double);
    procedure BindTitulos;
    procedure RemoveItem;
    function getNumItem: Integer;
    procedure CalculaTotalEdit;
    procedure IniciaEdits;
    procedure CancelaOrcamento;
    procedure Imprime;
    procedure Novo;
    procedure HabilitarVenda(habilitar: Boolean);
    procedure PesquisaProduto;
  public
    { Public declarations }
    procedure GetOrcamento(id: Integer);
  end;

var
  FrmCadastroOrcamento: TFrmCadastroOrcamento;

implementation

uses
  Consulta.Produto;

procedure TFrmCadastroOrcamento.BindTitulos;
var
  i: Integer;
const
  Titulos: array [0 .. 8] of string = ('Seq', 'Cod Produto', 'Descrição', 'UND', 'Valor Unitário', 'Quantidade', 'Valor Desconto', 'Valor Bruto', 'Valor Líquido');
  ColWidth: array [0 .. 8] of Integer = (40, 70, 300, 40, 80, 80, 80, 80, 80);
begin
  // TBindGrid.InicializaGrid(strGridProdutos, Titulos, ColWidth);
  for i := Low(Titulos) to High(Titulos) do
  begin
    // titulo
    strGridProdutos.Cells[i, 0] := Titulos[i];
    strGridProdutos.ColWidths[i] := ColWidth[i];
  end;
end;

{$R *.dfm}


procedure TFrmCadastroOrcamento.BindGrid();
begin

  AdapterBindSource1.Active := False;

  if Assigned(Orcamento) then
  begin
    if Assigned(AdapterBindSource1.Adapter) then
      AdapterBindSource1.Adapter.Free;

    AdapterBindSource1.Adapter := TListBindSourceAdapter<TItemOrcamento>.create(Self, Orcamento.itens, False);
    AdapterBindSource1.Active := True;
    BindTitulos();
  end;
end;

procedure TFrmCadastroOrcamento.GetOrcamento(id: Integer);
begin
  Orcamento := DaoOrcamento.GetOrcamento(id);

  if Orcamento = nil then
    raise Exception.create('Orçamento não encontrado');

  Orcamento.OnVendeItem := OnVendeItem;
  Orcamento.OnExcluiItem := OnExcluiItem;
  Orcamento.OnChange := OnOrcamentoChange;
  NSeqItem := Orcamento.UltimoSequencial + 1;

  cbbCliente.Text := Orcamento.Cliente;
  edtNumOrcamento.Text := Orcamento.NUMERO;
  edtValidade.Date := Orcamento.DATAVENCIMENTO;
  edtTelefone.Text := Orcamento.TELEFONE;
  mmoObservacoes.Lines.Text := Orcamento.OBSERVACAO;

  OnOrcamentoChange(Orcamento.ValorLiquido, Orcamento.ValorBruto, Orcamento.VALORDESC, Orcamento.Volume);

  // FblEmVEnda := Orcamento.STATUS = 'A';
  // HabilitarVenda(FblEmVEnda);
  FblEmVEnda := True;
  BindGrid;
end;

procedure TFrmCadastroOrcamento.actCancelaItemExecute(Sender: TObject);
begin
  inherited;
  RemoveItem;
end;

procedure TFrmCadastroOrcamento.actCancelarOrcamentoExecute(Sender: TObject);
begin
  CancelaOrcamento;
end;

procedure TFrmCadastroOrcamento.actCPesquisaProdutoExecute(Sender: TObject);
begin
  inherited;
  try
    PesquisaProduto;
  except
    MessageDlg('Quantidade inválida', mtError, [mbOK], 0);
  end;
end;

procedure TFrmCadastroOrcamento.PesquisaProduto;
var
  Produto: TProduto;
  idx: Integer;
begin
  FrmConsultaProdutos := TFrmConsultaProdutos.create(Self);
  try
    FrmConsultaProdutos.ShowModal;

    if Assigned(FrmConsultaProdutos.Produto) then
    begin
      Produto := FrmConsultaProdutos.Produto;

      idx := cbbProduto.Items.IndexOf(Produto.DESCRICAO);

      if idx = -1 then
      begin
        cbbProduto.AddItem(Produto.DESCRICAO, Produto);
        idx := cbbProduto.Items.IndexOf(Produto.DESCRICAO);
        cbbProduto.ItemIndex := idx;
      end
      else
      begin
        FreeAndNil(Produto);
        cbbProduto.ItemIndex := idx;
      end;

      cbbProdutoSelect(cbbProduto);
      edtQuantidade.SetFocus;
    end;

  finally
    FrmConsultaProdutos.Free;
  end;
end;

procedure TFrmCadastroOrcamento.actFinalizaExecute(Sender: TObject);
begin
  inherited;
  try

    if not Assigned(Orcamento) then
      raise Exception.create('O Orçamento não foi aberto');

    if Orcamento.itens.Count = 0 then
      raise Exception.create('O Orçamento não possúi nenhum item!');

    Orcamento.STATUS := 'F';
    Orcamento.TELEFONE := edtTelefone.Text;
    Orcamento.OBSERVACAO := mmoObservacoes.Lines.Text;

    DaoOrcamento.FinalizaOrcamento(Orcamento);

    Imprime;
    FblEmVEnda := False;
    Novo();

    MessageDlg('Orçamento Finalizado!', mtInformation, [mbOK], 0);
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmCadastroOrcamento.actNovoExecute(Sender: TObject);
begin
  inherited;
  Novo;
end;

procedure TFrmCadastroOrcamento.Imprime;
var
  Impressora: TROrcamento;
begin
  try // todo: buscar dos parametros
    Impressora := TROrcamento.create(TFactory.Parametros.ImpressoraTermica);

    try
      Impressora.ImprimeCupom(TFactory.DadosEmitente, Orcamento);
    finally
      FreeAndNil(Impressora);
    end;

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmCadastroOrcamento.Novo;
begin
  if FblEmVEnda then
    if MessageDlg('Deseja Cancelar o Orçamento Atual e criar um novo Orçamento?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      Exit;
    end;

  if Assigned(Orcamento) then
    FreeAndNil(Orcamento);

  HabilitarVenda(True);
  IniciaCampos;
end;

procedure TFrmCadastroOrcamento.CancelaOrcamento;
begin
  try
    if not FblEmVEnda then
      raise Exception.create('O Orçamento não foi aberto');

    if not Assigned(Orcamento) then
      raise Exception.create('Orcamento não associado');

    if MessageDlg('Deseja Cancelar este Orçamento?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Orcamento.STATUS := 'C';
      DaoOrcamento.AtualizaStatus(Orcamento);
    end;
    Novo;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TFrmCadastroOrcamento.RemoveItem;
var
  NumItem: Integer;
begin
  try
    if not FblEmVEnda then
      raise Exception.create('O Orçamento não foi aberto');

    if not Assigned(Orcamento) then
      raise Exception.create('Orcamento não associado');

    if Orcamento.ItemCount = 0 then
      raise Exception.create('O Orçamento ainda não possui itens');

    NumItem := getNumItem();

    Orcamento.ExcluiItem(NumItem);

    BindGrid;

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;

end;

function TFrmCadastroOrcamento.getNumItem: Integer;
begin
  FrmCancelarItem := TFrmCancelarItem.create(Self);
  try
    FrmCancelarItem.Top := Self.Top + 120;
    FrmCancelarItem.Left := Self.Left + 200;
    FrmCancelarItem.ShowModal;

    result := FrmCancelarItem.NumItem;
  finally
    FrmCancelarItem.Free;
  end;
end;

procedure TFrmCadastroOrcamento.HabilitarVenda(habilitar: Boolean);
begin
  edtQuantidade.Enabled := habilitar;
  edtDesconto.Enabled := habilitar;
  cbbProduto.Enabled := habilitar;
  cbbCliente.Enabled := habilitar;
  actFinaliza.Enabled := habilitar;
end;

procedure TFrmCadastroOrcamento.CalculaTotalEdit;
var
  Preco: Currency;
  quantidade: Double;
begin
  try
    Preco := StrToCurrDef(edtPreco.Text, 0);
    quantidade := StrToFloatDef(edtQuantidade.Text, 1);
    FDesconto := StrToCurrDef(edtDesconto.Text, 1);

    if cbbTipoDesconto.ItemIndex = 1 then
      FDesconto := (Preco * FDesconto) / 100;

    FTotal := (Preco * quantidade) - FDesconto;

    edtTotal.Text := FormatCurr('R$ 0.,00', FTotal);
  except
  end;
end;

procedure TFrmCadastroOrcamento.IniciaEdits;
begin
  edtQuantidade.Text := '1';
  edtDesconto.Text := '0';
  edtPreco.Text := '';
  edtTotal.Text := '';
  cbbProduto.ItemIndex := -1;
  cbbProduto.Text := 'Pesquisar...'
end;

procedure TFrmCadastroOrcamento.actVoltarExecute(Sender: TObject);
begin
  inherited;

  Close;

end;

procedure TFrmCadastroOrcamento.IncluirItem;
var
  Produto: TProduto;
  itemOrcamento: TItemOrcamento;
begin
  try
    if cbbProduto.ItemIndex = -1 then
    begin
      cbbProduto.SetFocus;
      raise TValidacaoException.create('Produto não selecionado');
    end;

    if CompareDate(edtValidade.Date, Date()) = LessThanValue then
      raise Exception.create('A Data de Validade é menor que o dia de hoje');

    Produto := cbbProduto.Items.Objects[cbbProduto.ItemIndex] as TProduto;

    itemOrcamento := TItemOrcamento.create;

    try
      itemOrcamento.SEQ := NSeqItem;
      itemOrcamento.CODPRODUTO := Produto.CODIGO;
      itemOrcamento.DESCRICAO := Produto.DESCRICAO;
      itemOrcamento.UND := Produto.UND;
      itemOrcamento.QTD := TUtil.UStrToCurrFloat(edtQuantidade.Text);
      itemOrcamento.VALOR_UNITA := Produto.PRECO_VENDA;
      itemOrcamento.VALOR_DESCONTO := FDesconto;

      // se for quantidade fracionada e produto não vende fracionado
      if (Frac(itemOrcamento.QTD) <> 0) and (not Produto.QUANTIDADEFRACIONADA) then
        raise Exception.create('ATENÇÃO: Produto Unitário com quantidade fracionada');

      if (itemOrcamento.QTD <= 0) then
        raise Exception.create('ATENÇÃO: Quantidade inválida para o Produto');

    except
      on E: Exception do
      begin
        FreeAndNil(itemOrcamento);
        raise Exception.create('Falha ao montar Item: ' + E.Message);
      end;
    end;

    if not Assigned(Orcamento) then
    begin
      AbreOrcamento();
    end;

    if not Assigned(Orcamento) then
      raise Exception.create('Orcamento não foi aberto');

    Orcamento.VendeItem(itemOrcamento);

    inc(NSeqItem);

    BindGrid();
    IniciaEdits();
    try
      cbbProduto.SetFocus;
    except
      on E: Exception do
    end;

  except
    on E: EAbort do
      Exit;
    on E: Exception do
    begin
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        // cbbProduto.Text := '';
        cbbProduto.SetFocus;
      except
      end;
    end;
  end;
end;

procedure TFrmCadastroOrcamento.AbreOrcamento;
begin
  Orcamento := TFactory.Orcamento;

  try

    Orcamento.OnVendeItem := OnVendeItem;
    Orcamento.OnExcluiItem := OnExcluiItem;
    Orcamento.OnChange := OnOrcamentoChange;

    Orcamento.DATAORCAMENTO := Date();
    Orcamento.HORAORCAMENTO := Time();
    Orcamento.DATAVENCIMENTO := edtValidade.Date;
    Orcamento.TELEFONE := edtTelefone.Text;
    Orcamento.STATUS := 'A';
    Orcamento.Vendedor := DaoVen.GetVendedor(TFactory.VendedorLogado.CODIGO);
    Orcamento.Cliente := cbbCliente.Text;

    TFactory.Conexao.StartTransaction;
    Orcamento.id := DaoOrcamento.GeraID;
    Orcamento.NUMERO := Format('%.6d', [Orcamento.id]);
    DaoOrcamento.AbreOrcamento(Orcamento);
    TFactory.Conexao.Commit;

    edtNumOrcamento.Text := Orcamento.NUMERO;
    FblEmVEnda := True;

  except
    on E: TValidacaoException do
    begin
      TFactory.Conexao.Rollback;
      FreeAndNil(Orcamento);
      raise Exception.create(E.Message);
    end;
    on E: TDaoException do
    begin
      TFactory.Conexao.Rollback;
      FreeAndNil(Orcamento);
      raise Exception.create('Dao: ' + E.Message);
    end;
    on E: Exception do
    begin
      TFactory.Conexao.Rollback;
      FreeAndNil(Orcamento);
      raise Exception.create('Falha ao abrir pedido: ' + E.Message);
    end;
  end;
end;

procedure TFrmCadastroOrcamento.IniciaCampos;
begin
  FTotal := 0;
  FDesconto := 0;
  pgc1.TabIndex := 0;
  FblEmVEnda := False;
  edtNumOrcamento.Text := '';
  cbbCliente.ItemIndex := -1;
  mmoObservacoes.Clear;
  cbbCliente.Text := '';
  edtValidade.Date := incDay(Now, (TFactory.Parametros.VALIDADEORCAMENTO));
  IniciaEdits();
  NSeqItem := 1;
  FblEmVEnda := False;
  BindTitulos();
  BindGrid();
  OnOrcamentoChange(0, 0, 0, 0);
end;

procedure TFrmCadastroOrcamento.OnExcluiItem(item: TItemOrcamento);
begin
  DaoOrcamento.ExcluiItem(item);
end;

procedure TFrmCadastroOrcamento.OnOrcamentoChange(ValorLiquido, ValorBruto, Desconto: Currency; Volume: Double);
begin
  try
    lblTotalbruto.Caption := FormatCurr('R$ 0.,00', ValorBruto);
  except
    on E: Exception do
      raise Exception.create('Falha ao obter Valor Bruto no evento');
  end;
  try
    lblTotalLiquido.Caption := FormatCurr('R$ 0.,00', ValorLiquido);
  except
    on E: Exception do
      raise Exception.create('Falha ao obter Valor Liquido no evento');
  end;
  try
    lblTotalDesconto.Caption := FormatCurr('R$ 0.,00', Desconto);
  except
    on E: Exception do
      raise Exception.create('Falha ao obter Desconto no evento');
  end;
  try
    lblVolume.Caption := FloatToStr(Volume);
  except
    on E: Exception do
      raise Exception.create('Falha ao obter volume no evento');
  end;
end;

procedure TFrmCadastroOrcamento.OnVendeItem(item: TItemOrcamento);
begin
  DaoOrcamento.VendeItem(item);
  Orcamento.Cliente := cbbCliente.Text;
  Orcamento.DATAVENCIMENTO := edtValidade.Date;
  Orcamento.TELEFONE := edtTelefone.Text;
  Orcamento.OBSERVACAO := mmoObservacoes.Lines.Text;
  DaoOrcamento.AtualizaOrcamento(Orcamento);
end;

procedure TFrmCadastroOrcamento.cbbClienteExit(Sender: TObject);
begin
  inherited;
  if cbbCliente.ItemIndex = -1 then
    edtTelefone.Text := '';
end;

procedure TFrmCadastroOrcamento.cbbClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if (cbbCliente.ItemIndex = -1) or (edtTelefone.Text = '(  )     -    ') then
      edtTelefone.SetFocus
    else
      cbbProduto.SetFocus;
  end
  else if Key = #27 then
  begin
    cbbCliente.DroppedDown := False;
  end;
end;

procedure TFrmCadastroOrcamento.cbbClienteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  item: TCliente;
  itens: TObjectList<TCliente>;
begin
  inherited;
  if Length(cbbCliente.Text) > 1 then
  begin
    // if not cbbCliente.AutoDropDown then
    cbbCliente.AutoDropDown := True;
    cbbCliente.DroppedDown := cbbCliente.Items.Count > 0;

    if (cbbCliente.Items.IndexOf(cbbCliente.Text) = -1)
      and (Key <> VK_RETURN) then
    begin
      OutputDebugString(PWideChar(cbbCliente.Text));
      itens := DaoCliente.GeTClientesByName(cbbCliente.Text);
      itens.OwnsObjects := False;

      for item in itens do
      begin
        if cbbCliente.Items.IndexOf(item.Nome) = -1 then
          cbbCliente.Items.AddObject(item.Nome, item);
      end;

      FreeAndNil(itens);
    end;
  end;
end;

procedure TFrmCadastroOrcamento.cbbClienteSelect(Sender: TObject);
var
  Cliente: TCliente;
begin
  inherited;
  if cbbCliente.ItemIndex > 0 then
  begin
    if cbbCliente.Items.Objects[cbbCliente.ItemIndex] <> nil then
    begin
      try
        Cliente := cbbCliente.Items.Objects[cbbCliente.ItemIndex] as TCliente;
        if Cliente.CELULAR <> '' then
          edtTelefone.Text := Cliente.CELULAR
        else
          edtTelefone.Text := Cliente.TELEFONE;
      except
      end;
    end;
  end
  else
  begin
    edtTelefone.Text := '';
  end;
end;

procedure TFrmCadastroOrcamento.cbbProdutoEnter(Sender: TObject);
begin
  inherited;
  // cbbCliente.DroppedDown := cbbCliente.Items.Count > 0;
end;

procedure TFrmCadastroOrcamento.cbbProdutoKeyPress(Sender: TObject; var Key: Char);
var
  item: TProduto;

begin
  inherited;

  if Key = #13 then
  begin
    if cbbProduto.ItemIndex <> -1 then
      edtQuantidade.SetFocus
    else
      Key := #0;
  end
  else if Key = #27 then
  begin
    cbbProduto.Text := 'Pesquisar...';
    cbbProduto.DroppedDown := False;
  end;

end;

procedure TFrmCadastroOrcamento.cbbProdutoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  item: TProduto;
  itens: TObjectList<TProduto>;
begin
  inherited;
  if Length(cbbProduto.Text) > 1 then
  begin
    // if not cbbProduto.AutoDropDown then
    // cbbProduto.AutoDropDown := True;
    cbbProduto.DroppedDown := True;
    cbbProduto.AutoComplete := Length(cbbProduto.Text) >= 2;

    if (CachePesquisa.IndexOf(cbbProduto.Text) = -1)
      and (cbbProduto.Items.IndexOf(cbbProduto.Text) = -1)
      and (Key <> VK_RETURN) then
    begin
      OutputDebugString(PWideChar(cbbProduto.Text));
      itens := DaoProdutos.GetProdutosPorDescricaoParcial(cbbProduto.Text);
      itens.OwnsObjects := False;

      for item in itens do
      begin
        if cbbProduto.Items.IndexOf(item.DESCRICAO) = -1 then
          cbbProduto.Items.AddObject(item.DESCRICAO, item);
      end;

      FreeAndNil(itens);

      CachePesquisa.Add(cbbProduto.Text);
    end;
  end;
end;

procedure TFrmCadastroOrcamento.cbbProdutoSelect(Sender: TObject);
var
  Produto: TProduto;
begin
  inherited;
  if cbbProduto.ItemIndex > -1 then
  begin
    if cbbProduto.Items.Objects[cbbProduto.ItemIndex] <> nil then
    begin
      try
        Produto := cbbProduto.Items.Objects[cbbProduto.ItemIndex] as TProduto;
        edtPreco.Text := FormatCurr('0.,00', Produto.PRECO_VENDA);
        CalculaTotalEdit();
      except
      end;
    end;
  end;
end;

procedure TFrmCadastroOrcamento.edtClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtValidade.SetFocus;
end;

procedure TFrmCadastroOrcamento.edtDescontoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    IncluirItem;
  end
  else if not(Key in [#8, '0' .. '9', FormatSettings.DecimalSeparator]) then
  begin
    Key := #0
  end

end;

procedure TFrmCadastroOrcamento.edtDescontoKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  CalculaTotalEdit;
end;

procedure TFrmCadastroOrcamento.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtDesconto.SetFocus
  else if not(Key in [#8, '0' .. '9', FormatSettings.DecimalSeparator]) then
  begin
    Key := #0
  end

end;

procedure TFrmCadastroOrcamento.edtQuantidadeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  CalculaTotalEdit;
end;

procedure TFrmCadastroOrcamento.edtTelefoneKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtValidade.SetFocus;
end;

procedure TFrmCadastroOrcamento.edtValidadeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    cbbProduto.SetFocus;
end;

procedure TFrmCadastroOrcamento.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if FblEmVEnda then
    if MessageDlg('O Orçamento não foi finalizado! Deseja sair mesmo assim?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin
      CanClose := False;
    end;
end;

procedure TFrmCadastroOrcamento.FormCreate(Sender: TObject);
begin
  inherited;
  cbbTipoDesconto.ItemIndex := 1;
  CachePesquisa := TStringList.create;
  DaoProdutos := TFactory.DaoProduto;
  DaoOrcamento := TFactory.DaoOrcamento;
  DaoVen := TFactory.DaoVendedor;
  DaoCliente := TFactory.DaoCliente;
  IniciaCampos;
end;

procedure TFrmCadastroOrcamento.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  AdapterBindSource1.Active := False;

  FreeAndNil(CachePesquisa);

  for i := 0 to cbbProduto.Items.Count - 1 do
    cbbProduto.Items.Objects[i].Free;

  for i := 0 to cbbCliente.Items.Count - 1 do
    cbbCliente.Items.Objects[i].Free;

  if Assigned(Orcamento) then
    FreeAndNil(Orcamento);

  inherited;
end;

end.
