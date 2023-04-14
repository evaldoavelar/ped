unit Recebimento.Recebe;

interface

uses
  System.Generics.Collections,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase,
  Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.WinXCtrls,
  Dominio.Entidades.TParcelas, Dao.IDaoParcelas, Dao.IDaoCliente, Dominio.Entidades.TCliente, Dao.IDaoPedido,
  Vcl.Imaging.jpeg, Util.VclFuncoes, IFactory.Dao;

type
  TfrmRecebimento = class(TfrmBase)
    Panel1: TPanel;
    edtPesquisa: TSearchBox;
    Label1: TLabel;
    strGridParcelas: TStringGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    lblCliente: TLabel;
    ActionList1: TActionList;
    actConfirmaRecebimento: TAction;
    actEstorna: TAction;
    actOk: TAction;
    Image1: TImage;
    BitBtn4: TBitBtn;
    actPesquisar: TAction;
    rgFiltro: TRadioGroup;
    lblTotal: TLabel;
    Label2: TLabel;
    Image2: TImage;
    BitBtn5: TBitBtn;
    actPedido: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPesquisaInvokeSearch(Sender: TObject);
    procedure actConfirmaRecebimentoExecute(Sender: TObject);
    procedure rgFiltroClick(Sender: TObject);
    procedure actPedidoExecute(Sender: TObject);
    procedure actEstornaExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
  private
    { Private declarations }
    FCliente: TCliente;
    FFactory: IFactoryDao;
    FParcelas: TObjectList<TParcelas>;
    DaoParcelas: IDaoParcelas;
    DaoCliente: IDaoCliente;
    DaoPedido: IDaoPedido;
    procedure AbrePedido;

    procedure Pesquisa;
    procedure Bind;
    function CriaButton(item: TParcelas): TButton;
    procedure ConfirmaRerecebimento;
    function GetStatusFitltro: string;
    procedure EstornaParcela;

  public
    { Public declarations }
    procedure getCliente;
  end;

var
  frmRecebimento: TfrmRecebimento;

implementation

{$R *.dfm}


uses Helper.TBindGrid, Consulta.Cliente, Factory.Dao, Sistema.TLog,
  Recebimento.ConfirmaBaixa, Recebimento.DetalhesPedido, Dominio.Entidades.TPedido,
  Factory.Entidades;

procedure TfrmRecebimento.AbrePedido;
var
  item: TParcelas;
  Pedido: TPedido;
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.AbrePedido ');
  try
    if Assigned(strGridParcelas.Objects[0, strGridParcelas.row]) then
    begin
      item := TParcelas(strGridParcelas.Objects[0, strGridParcelas.row]);

      frmDetalhesPedido := TfrmDetalhesPedido.Create(self);
      try
        Pedido := DaoPedido.getPedido(item.IDPEDIDO);
        frmDetalhesPedido.Pedido := Pedido;
        frmDetalhesPedido.ShowModal;
        FreeAndNil(Pedido);
      finally
        FreeAndNil(frmDetalhesPedido);
      end;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmRecebimento.AbrePedido ');
end;

procedure TfrmRecebimento.actConfirmaRecebimentoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.actConfirmaRecebimentoExecute ');
  inherited;
  ConfirmaRerecebimento;
  TLog.d('<<< Saindo de TfrmRecebimento.actConfirmaRecebimentoExecute ');
end;

procedure TfrmRecebimento.actEstornaExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.actEstornaExecute ');
  inherited;
  EstornaParcela;
  TLog.d('<<< Saindo de TfrmRecebimento.actEstornaExecute ');
end;

procedure TfrmRecebimento.actOkExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.actOkExecute ');
  inherited;
  self.Close;
  TLog.d('<<< Saindo de TfrmRecebimento.actOkExecute ');
end;

procedure TfrmRecebimento.actPedidoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.actPedidoExecute ');
  inherited;
  AbrePedido;
  TLog.d('<<< Saindo de TfrmRecebimento.actPedidoExecute ');
end;

procedure TfrmRecebimento.actPesquisarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.actPesquisarExecute ');
  inherited;
  Pesquisa;
  TLog.d('<<< Saindo de TfrmRecebimento.actPesquisarExecute ');
end;

procedure TfrmRecebimento.Bind;
var
  total: Currency;
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.Bind ');
  TBindGrid.BindParcelas(strGridParcelas, FParcelas);
  edtPesquisa.Text := self.FCliente.CODIGO;
  lblCliente.Caption := self.FCliente.Nome;

  total := DaoParcelas.GeTParcelasTotal(self.FCliente.CODIGO, GetStatusFitltro());
  lblTotal.Caption := FormatCurr('R$ ###,##0.00', total);
  TLog.d('<<< Saindo de TfrmRecebimento.Bind ');
end;

procedure TfrmRecebimento.ConfirmaRerecebimento;
var
  item: TParcelas;
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.ConfirmaRerecebimento ');
  try
    if Assigned(strGridParcelas.Objects[0, strGridParcelas.row]) then
    begin
      item := TParcelas(strGridParcelas.Objects[0, strGridParcelas.row]);

      if item.RECEBIDO = 'S' then
        raise Exception.Create('Recebimento já Confirmado');

      frmConfirmaBaixa := TfrmConfirmaBaixa.Create(self);
      try
        item.DATABAIXA := now;
        item.VendedorRecebimento := FFactory.DaoVendedor.GetVendedor(TFactoryEntidades.new.VendedorLogado.CODIGO);
        frmConfirmaBaixa.Parcela := item;

        if frmConfirmaBaixa.ShowModal = mrYes then
        begin
          item.RECEBIDO := 'S';

          DaoParcelas.BaixaParcelas(item);

          strGridParcelas.Cells[4, strGridParcelas.row] := 'Sim';
          strGridParcelas.Cells[5, strGridParcelas.row] := dateToStr(item.DATABAIXA);

          MessageDlg('Recebimento confirmado', mtInformation, [mbOK], 0);
        end;
      finally
        frmConfirmaBaixa.Free;
      end;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmRecebimento.ConfirmaRerecebimento ');
end;

function TfrmRecebimento.CriaButton(item: TParcelas): TButton;
var
  button: TButton;
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.CriaButton ');
  button := TButton.Create(self); // creates an instance of TButton
  // sets the coordinates of the button, where the button should appear on the form
  button.Top := strGridParcelas.Height + 10;
  button.Left := 10;
  button.Visible := true;
  // sets the parent of the button
  button.Parent := self;

  button.Caption := 'cell[0,0]';
  // associate the new button with the first cell of the grid
  TLog.d('<<< Saindo de TfrmRecebimento.CriaButton ');
end;

procedure TfrmRecebimento.edtPesquisaInvokeSearch(Sender: TObject);
begin
  inherited;
  getCliente;
end;

procedure TfrmRecebimento.EstornaParcela;
var
  item: TParcelas;
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.EstornaParcela ');
  try
    if Assigned(strGridParcelas.Objects[0, strGridParcelas.row]) then
    begin
      item := TParcelas(strGridParcelas.Objects[0, strGridParcelas.row]);

      if item.RECEBIDO = 'N' then
        raise Exception.Create('Recebimento não baixado');

      frmConfirmaBaixa := TfrmConfirmaBaixa.Create(self);
      try
        frmConfirmaBaixa.Parcela := item;

        frmConfirmaBaixa.lblConfirma.Caption := 'Confirma o estorno da parcela?';
        if frmConfirmaBaixa.ShowModal = mrYes then
        begin
          item.RECEBIDO := 'S';
          item.DATABAIXA := now;
          DaoParcelas.ExtornaParcelas(item);

          strGridParcelas.Cells[4, strGridParcelas.row] := 'Não';
          strGridParcelas.Cells[5, strGridParcelas.row] := ' - ';

          MessageDlg('Recebimento Extornado', mtInformation, [mbOK], 0);
        end;
      finally
        frmConfirmaBaixa.Free;
      end;
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
  TLog.d('<<< Saindo de TfrmRecebimento.EstornaParcela ');
end;

procedure TfrmRecebimento.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.FormCreate ');
  inherited;
  FFactory := Tfactory.new(nil, true);
  DaoParcelas := FFactory.DaoParcelas;
  DaoCliente := FFactory.DaoCliente;
  DaoPedido := FFactory.DaoPedido;
  TLog.d('<<< Saindo de TfrmRecebimento.FormCreate ');
end;

procedure TfrmRecebimento.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.FormDestroy ');
  if Assigned(FCliente) then
    FreeAndNil(FCliente);
  if Assigned(FParcelas) then
    FreeAndNil(FParcelas);

  FFactory.Close;
  inherited;
  TLog.d('<<< Saindo de TfrmRecebimento.FormDestroy ');
end;

procedure TfrmRecebimento.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.FormShow ');
  inherited;
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
  TVclFuncoes.DisableVclStyles(self, 'TStringGrid');
  TVclFuncoes.DisableVclStyles(self, 'TPanel');
  if edtPesquisa.Text = '' then
    TBindGrid.BindParcelas(strGridParcelas, nil);
  TLog.d('<<< Saindo de TfrmRecebimento.FormShow ');
end;

procedure TfrmRecebimento.getCliente;
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.getCliente ');
  try
    if Assigned(FCliente) then
      FreeAndNil(FCliente);

    FCliente := DaoCliente.getCliente(edtPesquisa.Text);
    if not Assigned(FCliente) then
      raise Exception.Create('Cliente não encontrado');

    if Assigned(FParcelas) then
      FreeAndNil(FParcelas);
    FParcelas := DaoParcelas.GeTParcelasPorCliente(self.FCliente.CODIGO, GetStatusFitltro());
    Bind();
    TLog.d('<<< Saindo de TfrmRecebimento.getCliente ');
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
      edtPesquisa.SetFocus;
    end;
  end;
end;

function TfrmRecebimento.GetStatusFitltro: string;
begin
  case rgFiltro.ItemIndex of
    0:
      Result := 'N';
    1:
      Result := 'S'
  else
    Result := '';
  end;
end;

procedure TfrmRecebimento.Pesquisa;
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.Pesquisa ');
  try
    frmConsultaCliente := TFrmConsultaCliente.Create(self);
    try
      frmConsultaCliente.ShowModal;

      if Assigned(frmConsultaCliente.Cliente) then
      begin
        if Assigned(self.FCliente) then
          FreeAndNil(self.FCliente);

        if Assigned(self.FParcelas) then
          FreeAndNil(self.FParcelas);

        self.FCliente := DaoCliente.getCliente(frmConsultaCliente.Cliente.CODIGO);
        self.FParcelas := DaoParcelas.GeTParcelasPorCliente(self.FCliente.CODIGO, GetStatusFitltro());
        Bind();
      end;
    finally
      FreeAndNil(frmConsultaCliente);
    end;
  except
    on e: Exception do
    begin
      TLog.d(e.message);
      MessageDlg(e.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmRecebimento.Pesquisa ');
end;

procedure TfrmRecebimento.rgFiltroClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmRecebimento.rgFiltroClick ');
  inherited;
  if Trim(edtPesquisa.Text) <> '' then
    getCliente;

  actEstorna.Enabled := rgFiltro.ItemIndex = 1;
  actConfirmaRecebimento.Enabled := (rgFiltro.ItemIndex = 0);
  TLog.d('<<< Saindo de TfrmRecebimento.rgFiltroClick ');
end;

end.
