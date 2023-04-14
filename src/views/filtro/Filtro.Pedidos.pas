unit Filtro.Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.threading,
  JvExMask, JvToolEdit, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.Grids,
  Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBUltimGrid, Vcl.StdCtrls, Vcl.Buttons,
  JvExControls, JvNavigationPane, Filtro.Base, System.Generics.Collections,
  Dao.IDaoPedido, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg,
  Dominio.Entidades.TParcelas, Vcl.Mask;

type
  TfrmFiltroPedidos = class(TfrmFiltroBase)
    Bevel1: TBevel;
    Label3: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    actCancelar: TAction;
    Panel1: TPanel;
    Label6: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    pnl1: TPanel;
    Label1: TLabel;
    lblTotalLiquidoNaoFinalizado: TLabel;
    lblTotalCancelado: TLabel;
    lblTotalLiquidoConcluido: TLabel;
    cbbCampoSomar: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure dbGridResultadoDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure actReimprimirExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actDetalhesExecute(Sender: TObject);
    procedure dbGridResultadoDblClick(Sender: TObject);
    procedure edtDataInicialKeyPress(Sender: TObject; var Key: Char);
    procedure edtDataFinalKeyPress(Sender: TObject; var Key: Char);
    procedure cbbCampoSomarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    daoPedido: IDaoPedido;
    procedure Pesquisar; override;
    procedure Reimprimir;
    procedure Detalhes;
    procedure Cancelar;
    procedure ValidaGrid;
    procedure CalculaTotais;
  public
    { Public declarations }
  end;

var
  frmFiltroPedidos: TfrmFiltroPedidos;

implementation

{$R *.dfm}


uses Recebimento.DetalhesPedido, Dominio.Entidades.TPedido, Relatorio.TRPedido,
  Sistema.TLog, Factory.Entidades;

procedure TfrmFiltroPedidos.Pesquisar;
var
  campo: string;
begin
  // inherited;
  try
    if Assigned(dbGridResultado.DataSource.DataSet) then
      dbGridResultado.DataSource.DataSet.Free;

    LiberaDataSource();
    try

      self.actPesquisa.Enabled := false;
      case cbbPesquisa.ItemIndex of
        0:
          begin
            campo := 'C.NOME';
          end;
        1:
          campo := 'PE.CODCLIENTE';
        2:
          campo := 'PE.NUMERO';
      else
        campo := 'PE.NUMERO';
      end;

      if (chkEntreDatas.checked) and (trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := daoPedido.Listar(campo, edtValor.Text, edtDataInicial.Date, edtDataFinal.Date)
      else if chkEntreDatas.checked and (trim(edtValor.Text) = '') then
        dbGridResultado.DataSource.DataSet := daoPedido.Listar(edtDataInicial.Date, edtDataFinal.Date)
      else if (not chkEntreDatas.checked) and (trim(edtValor.Text) <> '') then
        dbGridResultado.DataSource.DataSet := daoPedido.Listar(campo, edtValor.Text)
      else
        dbGridResultado.DataSource.DataSet := daoPedido.Listar(Date, Date);

      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('VALORDESC')).Currency := true;
      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('VALORBRUTO')).Currency := true;
      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('VALORLIQUIDO')).Currency := true;
      TCurrencyField(dbGridResultado.DataSource.DataSet.FieldByName('VALORENTRADA')).Currency := true;
      CalculaTotais;
    finally
      self.actPesquisa.Enabled := true;
    end;
  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmFiltroPedidos.actCancelarExecute(Sender: TObject);
begin
  inherited;
  Cancelar;
end;

procedure TfrmFiltroPedidos.actDetalhesExecute(Sender: TObject);
begin
  inherited;
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.create('Nenhum registro selecionado');

  Detalhes;
end;

procedure TfrmFiltroPedidos.actReimprimirExecute(Sender: TObject);
begin
  Reimprimir;
end;

procedure TfrmFiltroPedidos.Reimprimir;
var
  Pedido: TPedido;
  Impressora: TRPedido;
  ParcelasAtrasadas: TObjectList<TParcelas>;
begin
  TLog.d('>>> Entrando em  TfrmFiltroPedidos.Reimprimir ');
  inherited;
  try
    ValidaGrid;
    Pedido := daoPedido.getPedido(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
    Impressora := TRPedido.create(FParametros.ImpressoraTermica);
    ParcelasAtrasadas := fFactory.daoParcelas.GeTParcelasVencidasPorCliente(Pedido.Cliente.CODIGO, now);

    Impressora.ImprimeCupom(fFactory.DadosEmitente,
      Pedido,
      fFactory.daoParcelas.GeTParcelasVencidasPorCliente(Pedido.Cliente.CODIGO, now));

    FreeAndNil(Pedido);
    FreeAndNil(Impressora);
    FreeAndNil(ParcelasAtrasadas);
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroPedidos.Reimprimir ');
end;

procedure TfrmFiltroPedidos.ValidaGrid;
begin
  TLog.d('>>> Entrando em  TfrmFiltroPedidos.ValidaGrid ');
  if (dbGridResultado.DataSource.DataSet = nil) or dbGridResultado.DataSource.DataSet.IsEmpty then
    raise Exception.create('Nenhum registro selecionado');
  if dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString <> 'F' then
    raise Exception.create('Está ação só pode ser feita com os pedidos Finalizados');
  TLog.d('<<< Saindo de TfrmFiltroPedidos.ValidaGrid ');
end;

procedure TfrmFiltroPedidos.CalculaTotais;
var
  TotalLiquidoConcluido: Currency;
  TotalLiquidoCancelado: Currency;
  TotalLiquidoNaoFinalizado: Currency;

  campo: string;
begin
  TLog.d('>>> Entrando em  TfrmFiltroPedidos.CalculaTotais ');
  TTask.Run(
    procedure
    begin
      { Some calculation that takes time }

      TThread.Synchronize(nil,
        procedure
        begin
          try
            case cbbCampoSomar.ItemIndex of
              0:
                campo := 'VALORLIQUIDO';
              1:
                campo := 'VALORBRUTO';
              2:
                campo := 'VALORENTRADA';
              3:
                campo := 'VALORDESC';
            else
              campo := 'VALORLIQUIDO'
            end;

            dbGridResultado.DataSource.DataSet.DisableControls;
            dbGridResultado.DataSource.DataSet.First;
            TotalLiquidoConcluido := 0;
            TotalLiquidoCancelado := 0;
            TotalLiquidoNaoFinalizado := 0;
            while not dbGridResultado.DataSource.DataSet.Eof do
            begin
              if (dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString = 'A') then
              begin
                TotalLiquidoNaoFinalizado := TotalLiquidoNaoFinalizado + dbGridResultado.DataSource.DataSet.FieldByName(campo).AsCurrency;
              end
              else if (dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString = 'C') then
              begin
                TotalLiquidoCancelado := TotalLiquidoCancelado + dbGridResultado.DataSource.DataSet.FieldByName(campo).AsCurrency;
              end
              else
              begin
                TotalLiquidoConcluido := TotalLiquidoConcluido + dbGridResultado.DataSource.DataSet.FieldByName(campo).AsCurrency;
              end;
              dbGridResultado.DataSource.DataSet.Next;
            end;
            lblTotalLiquidoConcluido.Caption := FormatCurr('R$ 0.,00', TotalLiquidoConcluido);
            lblTotalCancelado.Caption := FormatCurr('R$ 0.,00', TotalLiquidoCancelado);
            lblTotalLiquidoNaoFinalizado.Caption := FormatCurr('R$ 0.,00', TotalLiquidoNaoFinalizado);
          finally
            dbGridResultado.DataSource.DataSet.First;
            dbGridResultado.DataSource.DataSet.EnableControls;
          end;
        end

        );
    end);
  TLog.d('<<< Saindo de TfrmFiltroPedidos.CalculaTotais ');
end;

procedure TfrmFiltroPedidos.Cancelar;
var
  Pedido: TPedido;
begin
  TLog.d('>>> Entrando em  TfrmFiltroPedidos.Cancelar ');
  try
    ValidaGrid;

    if not TFactoryEntidades.new.VendedorLogado.PODECANCELARPEDIDO then
      raise Exception.create('Vendedor não tem permissão para cancelar pedido');

    if MessageDlg('Deseja Cancelar O pedido?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      Pedido := daoPedido.getPedido(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);
      Pedido.STATUS := 'C';
      Pedido.VendedorCancelamento := fFactory.DaoVendedor.GetVendedor(TFactoryEntidades.new.VendedorLogado.CODIGO);
      Pedido.DATACANCELAMENTO := now;

      daoPedido.AtualizaPedido(Pedido);

      dbGridResultado.DataSource.DataSet.Edit;
      dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString := 'C';
      dbGridResultado.DataSource.DataSet.Post;
      if Assigned(Pedido) then
        FreeAndNil(Pedido);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroPedidos.Cancelar ');
end;

procedure TfrmFiltroPedidos.cbbCampoSomarChange(Sender: TObject);
begin
  inherited;
  if Assigned(dbGridResultado.DataSource.DataSet) and (dbGridResultado.DataSource.DataSet.Active) then
    CalculaTotais;
end;

procedure TfrmFiltroPedidos.dbGridResultadoDblClick(Sender: TObject);
begin
  inherited;
  Detalhes;
end;

procedure TfrmFiltroPedidos.dbGridResultadoDrawColumnCell(Sender: TObject;
const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString = 'A' then
  begin
    dbGridResultado.Canvas.Font.Color := clWindow;
    dbGridResultado.Canvas.Brush.Color := $000075D7;
  end
  else if dbGridResultado.DataSource.DataSet.FieldByName('STATUS').AsString = 'C' then
  begin
    dbGridResultado.Canvas.Font.Color := clWindow;
    dbGridResultado.Canvas.Brush.Color := $000D1CB8;
  end
  else
  begin
    dbGridResultado.Canvas.Font.Color := clWindow;
    dbGridResultado.Canvas.Brush.Color := $0000C400
  end;

  dbGridResultado.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmFiltroPedidos.Detalhes;
var
  Pedido: TPedido;
begin
  TLog.d('>>> Entrando em  TfrmFiltroPedidos.Detalhes ');
  try
    // ValidaGrid;

    frmDetalhesPedido := TfrmDetalhesPedido.create(self);
    try
      Pedido := daoPedido.getPedido(dbGridResultado.DataSource.DataSet.FieldByName('ID').AsInteger);

      frmDetalhesPedido.Pedido := Pedido;
      frmDetalhesPedido.ShowModal;

      if Assigned(Pedido) then
        FreeAndNil(Pedido);
    finally
      FreeAndNil(frmDetalhesPedido);
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroPedidos.Detalhes ');
end;

procedure TfrmFiltroPedidos.edtDataFinalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    BTN_Consultar.SetFocus;
end;

procedure TfrmFiltroPedidos.edtDataInicialKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    edtDataFinal.SetFocus;
end;

procedure TfrmFiltroPedidos.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroPedidos.FormCreate ');
  inherited;
  daoPedido := fFactory.daoPedido;
  TLog.d('<<< Saindo de TfrmFiltroPedidos.FormCreate ');
end;

procedure TfrmFiltroPedidos.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroPedidos.FormShow ');
  inherited;
  edtDataInicial.Date := now;
  edtDataFinal.Date := IncMonth(now, 1);
  Pesquisar;
  TLog.d('<<< Saindo de TfrmFiltroPedidos.FormShow ');
end;

end.
