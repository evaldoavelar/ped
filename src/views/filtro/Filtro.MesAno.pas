unit Filtro.MesAno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg;

type
  TfrmFiltroMesAno = class(TForm)
    pnlPrincipal: TPanel;
    lblMesInicio: TLabel;
    cbbMesInicio: TComboBox;
    lblAnoInicio: TLabel;
    edtAnoInicio: TEdit;
    lblMesFim: TLabel;
    cbbMesFim: TComboBox;
    lblAnoFim: TLabel;
    edtAnoFim: TEdit;
    lblNumeroCaixa: TLabel;
    cbbNumeroDoCaixa: TComboBox;
    pnlBotoes: TPanel;
    btnImprimir: TBitBtn;
    btnCancelar: TBitBtn;
    actList: TActionList;
    actImprimir: TAction;
    actCancelar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actImprimirExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
  private
    function GetMesInicio: Integer;
    function GetAnoInicio: Integer;
    function GetMesFim: Integer;
    function GetAnoFim: Integer;
    function GetNumCaixa: string;
    procedure PreencheMeses;
    procedure PreencheCaixas;
    function ValidarCampos: Boolean;
  public
    property MesInicio: Integer read GetMesInicio;
    property AnoInicio: Integer read GetAnoInicio;
    property MesFim: Integer read GetMesFim;
    property AnoFim: Integer read GetAnoFim;
    property NumCaixa: string read GetNumCaixa;
  end;

var
  frmFiltroMesAno: TfrmFiltroMesAno;

implementation

{$R *.dfm}

uses Sistema.TLog, Factory.Dao, System.DateUtils;

procedure TfrmFiltroMesAno.FormCreate(Sender: TObject);
var
  LAnoAtual: Integer;
begin
  TLog.d('>>> Entrando em  TfrmFiltroMesAno.FormCreate ');
  try
    PreencheMeses;
    PreencheCaixas;

    LAnoAtual := YearOf(Now);
    cbbMesInicio.ItemIndex := MonthOf(Now) - 1;
    edtAnoInicio.Text := IntToStr(LAnoAtual);
    cbbMesFim.ItemIndex := MonthOf(Now) - 1;
    edtAnoFim.Text := IntToStr(LAnoAtual);
  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroMesAno.FormCreate ');
end;

procedure TfrmFiltroMesAno.PreencheMeses;
begin
  cbbMesInicio.Items.Clear;
  cbbMesFim.Items.Clear;
  cbbMesInicio.Items.AddStrings(['Janeiro', 'Fevereiro', 'Março', 'Abril',
    'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']);
  cbbMesFim.Items.AddStrings(['Janeiro', 'Fevereiro', 'Março', 'Abril',
    'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro']);
end;

procedure TfrmFiltroMesAno.PreencheCaixas;
var
  caixas: TStringList;
begin
  cbbNumeroDoCaixa.Clear;
  caixas := TFactory.new(nil, false).DaoPedido.ListaCaixas;
  try
    cbbNumeroDoCaixa.Items.Add('Todos os Caixas');
    cbbNumeroDoCaixa.Items.AddStrings(caixas);
    cbbNumeroDoCaixa.ItemIndex := 0;
  finally
    caixas.Free;
  end;
end;

function TfrmFiltroMesAno.GetMesInicio: Integer;
begin
  Result := cbbMesInicio.ItemIndex + 1;
end;

function TfrmFiltroMesAno.GetAnoInicio: Integer;
begin
  Result := StrToIntDef(edtAnoInicio.Text, YearOf(Now));
end;

function TfrmFiltroMesAno.GetMesFim: Integer;
begin
  Result := cbbMesFim.ItemIndex + 1;
end;

function TfrmFiltroMesAno.GetAnoFim: Integer;
begin
  Result := StrToIntDef(edtAnoFim.Text, YearOf(Now));
end;

function TfrmFiltroMesAno.GetNumCaixa: string;
begin
  if cbbNumeroDoCaixa.ItemIndex <= 0 then
    Result := ''
  else
    Result := cbbNumeroDoCaixa.Text;
end;

function TfrmFiltroMesAno.ValidarCampos: Boolean;
var
  LAnoI, LAnoF, LMesI, LMesF: Integer;
begin
  Result := False;

  LAnoI := GetAnoInicio;
  LAnoF := GetAnoFim;
  LMesI := GetMesInicio;
  LMesF := GetMesFim;

  if (cbbMesInicio.ItemIndex < 0) or (cbbMesFim.ItemIndex < 0) then
  begin
    MessageDlg('Selecione o mês inicial e o mês final.', mtWarning, [mbOK], 0);
    Exit;
  end;

  if LAnoI <= 0 then
  begin
    MessageDlg('Informe um ano inicial válido.', mtWarning, [mbOK], 0);
    edtAnoInicio.SetFocus;
    Exit;
  end;

  if LAnoF <= 0 then
  begin
    MessageDlg('Informe um ano final válido.', mtWarning, [mbOK], 0);
    edtAnoFim.SetFocus;
    Exit;
  end;

  if (LAnoF < LAnoI) or ((LAnoF = LAnoI) and (LMesF < LMesI)) then
  begin
    MessageDlg('O período final deve ser maior ou igual ao período inicial.', mtWarning, [mbOK], 0);
    Exit;
  end;

  Result := True;
end;

procedure TfrmFiltroMesAno.actImprimirExecute(Sender: TObject);
begin
  if ValidarCampos then
    ModalResult := mrOk;
end;

procedure TfrmFiltroMesAno.actCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
