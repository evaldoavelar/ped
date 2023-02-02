unit Grafico.Pedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Generics.Collections,
  System.Classes, Vcl.Graphics, System.DateUtils,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, VclTee.TeeGDIPlus, VclTee.TeEngine, VclTee.Series, Vcl.ExtCtrls, VclTee.TeeProcs, VclTee.Chart,
  Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit, Vcl.Imaging.pngimage,
  System.Threading, Vcl.ComCtrls;

type
  TfrmGraficoPedidos = class(TfrmBase)
    ChartVendasPeriodo: TChart;
    SeriesLinha: TLineSeries;
    pnl1: TPanel;
    lbl1: TLabel;
    edtDataIncio: TJvDateEdit;
    Label1: TLabel;
    btn1: TButton;
    pnl2: TPanel;
    chkPontos: TCheckBox;
    chkLegendas: TCheckBox;
    Chart1: TChart;
    SerieBarras: TBarSeries;
    pnl3: TPanel;
    spl1: TSplitter;
    img1: TImage;
    PageControl1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    edtDataFim: TJvDateEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure chkPontosClick(Sender: TObject);
    procedure chkLegendasClick(Sender: TObject);
  private
    procedure MontaGraficosPedido;
    { Private declarations }
  public
    { Public declarations }
    procedure Bind;
  end;

var
  frmGraficoPedidos: TfrmGraficoPedidos;

implementation

{$R *.dfm}


uses Dao.IDAOPedidoPeriodo, Helper.TPedidoPeriodo, Factory.Dao, Util.Funcoes;

procedure TfrmGraficoPedidos.Bind;
var
  task: ITask;
begin
  task := TTask.Create(
    procedure()
    begin
        MontaGraficosPedido;
    end);

  task.Start;

end;

procedure TfrmGraficoPedidos.MontaGraficosPedido;
var
  Dao: IDAOPedidoPeriodo;
  dtAux: TDate;
  vlAux: Currency;
  listaPeriodo: TListaPeriodoPedido;
  idx: Integer;
  // teste: TStringList;
  i: Integer;
  posX: Integer;
begin

  Dao := fFactory.DaoPedidoPeriodo();
  listaPeriodo := Dao.GetTotaisBrutoPedido(edtDataIncio.Date, edtDataFim.Date);

  SeriesLinha.Clear;
  SerieBarras.Clear;

  dtAux := edtDataIncio.Date;
  while dtAux <= edtDataFim.Date do
  begin
    idx := listaPeriodo.indexOfData(dtAux);
    if idx > -1 then
    begin
      vlAux := listaPeriodo.Periodos[idx].Valor;

      posX := SeriesLinha.AddY(vlAux, FormatCurr('R$ 0.,00', vlAux)); // FormatCurr('R$ 0.,00', vlAux)) ;
      SeriesLinha.XLabel[posX] := FormatDateTime('dd/mm/yy', dtAux);

      posX := SerieBarras.AddY(vlAux, FormatCurr('R$ 0.,00', vlAux));
      SerieBarras.XLabel[posX] := FormatDateTime('dd/mm/yy', dtAux);
    end
    else
    begin
      SeriesLinha.AddY(0);
    end;

    dtAux := IncDay(dtAux);
  end;

  FreeAndNil(listaPeriodo);

  // teste := TStringList.Create;
  // for i := 0 to SeriesLinha.XValues.Count - 1 do
  // teste.Add(FloatToStr(SeriesLinha.XValue[i]) + '=' + FloatToStr(SeriesLinha.YValues[i]));
  //
  // ShowMessage(teste.Text);
end;

procedure TfrmGraficoPedidos.btn1Click(Sender: TObject);
begin
  inherited;
  Bind;
end;

procedure TfrmGraficoPedidos.chkLegendasClick(Sender: TObject);
begin
  inherited;
  SeriesLinha.Marks.Visible := chkLegendas.Checked;
end;

procedure TfrmGraficoPedidos.chkPontosClick(Sender: TObject);
begin
  inherited;
  SeriesLinha.Pointer.Visible := chkPontos.Checked;
end;

procedure TfrmGraficoPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  edtDataIncio.Date := TUtil.FirstDayOfMonth(now);
  edtDataFim.Date := TUtil.LastDayOfMonth(now);
  chkPontos.Checked := false;
  chkLegendas.Checked := false;
end;

procedure TfrmGraficoPedidos.FormShow(Sender: TObject);
begin
  inherited;
  Bind;
end;

end.
