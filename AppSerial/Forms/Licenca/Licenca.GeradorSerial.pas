unit Licenca.GeradorSerial;

interface

uses
  System.SysUtils, System.DateUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, Data.Bind.GenData,
  FMX.Bind.GenData, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.ObjectScope, FMX.Objects, FMX.StdCtrls, FMX.ListView, FMX.ListView.Appearances,
  FMX.Layouts, FMX.MultiView, FMX.Memo, FMX.Bind.Navigator, System.Actions, FMX.ActnList, FMX.DateTimeCtrls, FMX.Edit, FMX.Controls.Presentation, FMX.ListView.Adapters.Base,
  Util.TSerial, FMX.StdActns, FMX.MediaLibrary.Actions, Util.Funcoes;

type
  TFrmGeradorSerial = class(TForm)
    MultiView1: TMultiView;
    Layout1: TLayout;
    MasterToolbar: TToolBar;
    MasterLabel: TLabel;
    DetailToolbar: TToolBar;
    DetailLabel: TLabel;
    MasterButton: TSpeedButton;
    lblName: TLabel;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    Layout2: TLayout;
    Layout3: TLayout;
    ActionList1: TActionList;
    LiveBindingsBindNavigateNext1: TFMXBindNavigateNext;
    LiveBindingsBindNavigatePrior1: TFMXBindNavigatePrior;
    edtCnpj: TEdit;
    Layout4: TLayout;
    Layout5: TLayout;
    Label1: TLabel;
    edtDataInicio: TDateEdit;
    Layout6: TLayout;
    Layout7: TLayout;
    Layout8: TLayout;
    Layout9: TLayout;
    Label3: TLabel;
    edtFim: TDateEdit;
    btn1: TButton;
    actGerar: TAction;
    Layout10: TLayout;
    LinkFillControlToField1: TLinkFillControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    ListView1: TListView;
    LinkListControlToField1: TLinkListControlToField;
    ShowShareSheetAction1: TShowShareSheetAction;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    ToolBar1: TToolBar;
    btnDown: TSpeedButton;
    lytBase: TLayout;
    lblSerial: TLabel;
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure actGerarExecute(Sender: TObject);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
  private
    { Private declarations }
    procedure GeraSerial();
  public
    { Public declarations }
  end;

var
  FrmGeradorSerial: TFrmGeradorSerial;

implementation

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}

procedure TFrmGeradorSerial.actGerarExecute(Sender: TObject);
begin
  try
    GeraSerial;
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TFrmGeradorSerial.GeraSerial;
var
  serial: TSerial;
  DataDeIncio, DataDeValidade: TDate;
  cnpj: string;
begin

  DataDeIncio := edtDataInicio.Date;
  DataDeValidade := edtFim.Date;

  cnpj := TUtil.ExtrairNumeros(Trim(edtCnpj.Text));

  if CompareDate(DataDeIncio, Now) = LessThanValue then
    raise Exception.Create('A data de inicío precisa ser igual ou maior que o dia de hoje');

  if CompareDate(DataDeValidade, DataDeIncio) = LessThanValue then
    raise Exception.Create('A datafinal precisa ser maior que a data incial');

  if Length(cnpj) < 6 then
    raise Exception.Create('Informe ao menos 6 numeros do CNPJ');

  serial := TSerial.Create;
  serial.NbrSegsEdt := 3; // numero de segmentos
  serial.SegSizeEdt := 6; // tamanho do segmento
  serial.DefField.Add('Inicio=6'); // campo e tamanho do campo
  serial.DefField.Add('Validade=6'); // campo e tamanho do campo
  serial.DefField.Add('cnpj=6'); // campo e tamanho do campo

  serial.DataField.Add('Inicio=' + FormatDateTime('ddmmyy', DataDeIncio)); // campo e valor do campo
  serial.DataField.Add('Validade=' + FormatDateTime('ddmmyy', DataDeValidade)); // campo e valor do campo
  serial.DataField.Add('cnpj=' + Copy(cnpj, Length(cnpj) - 6, 6)); // campo e valor do campo

  lblSerial.Text := serial.MakeLicense;

  serial.Free;

end;

procedure TFrmGeradorSerial.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  MultiView1.HideMaster;
end;

procedure TFrmGeradorSerial.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
  ShowShareSheetAction1.TextMessage := lblSerial.Text;
end;

end.
