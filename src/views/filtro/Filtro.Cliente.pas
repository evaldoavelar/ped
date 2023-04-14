unit Filtro.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections,
  Dominio.Entidades.TCliente, Factory.Dao, untFrmBase, Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.jpeg, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  Consulta.Cliente, IFactory.Dao;

type
  TfrmFiltroCliente = class(TfrmBase)
    pnl2: TPanel;
    btnOk: TBitBtn;
    btnCancelar: TBitBtn;
    pnl1: TPanel;
    img2: TImage;
    lbl1: TLabel;
    cbbCliente: TComboBox;
    btnConsultaProduto: TSpeedButton;
    act1: TActionList;
    actPesquisaCliente: TAction;
    actOk: TAction;
    procedure cbbClienteKeyPress(Sender: TObject; var Key: Char);
    procedure cbbClienteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actOkExecute(Sender: TObject);
    procedure actPesquisaClienteExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FCliente: TCliente;
    FFactory: IFactoryDao;
    procedure SetCliente(const Value: TCliente);
    procedure PesquisaCliente;
    procedure BindFields(ACliente: TCliente);
    { Private declarations }
  public
    { Public declarations }
    property Cliente: TCliente read FCliente write SetCliente;
  end;

var
  frmFiltroCliente: TfrmFiltroCliente;

implementation

uses
  Sistema.TLog;

{$R *.dfm}


procedure TfrmFiltroCliente.actOkExecute(Sender: TObject);
var
  ACliente: TCliente;
begin
  TLog.d('>>> Entrando em  TfrmFiltroCliente.actOkExecute ');
  inherited;
  try
    if cbbCliente.ItemIndex >= 0 then
    begin
      ACliente := cbbCliente.Items.Objects[cbbCliente.ItemIndex] as TCliente;

      Self.FCliente := FFactory
        .DaoCliente
        .GeTCliente(ACliente.CODIGO);

      Close;
    end
    else
    begin
      MessageDlg('Selecione um cliente', mtError, [mbOK], 0);
    end;
  except
    on E: EAbort do
      Exit;
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
      try
        // cbbProduto.Text := '';
        cbbCliente.SetFocus;
      except
      end;
    end;
  end;
  TLog.d('>>> Entrando em  TfrmFiltroCliente.actOkExecute ');
end;

procedure TfrmFiltroCliente.actPesquisaClienteExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroCliente.actPesquisaClienteExecute ');
  inherited;
  PesquisaCliente;
  TLog.d('<<< Saindo de TfrmFiltroCliente.actPesquisaClienteExecute ');
end;

procedure TfrmFiltroCliente.PesquisaCliente;
var
  ACliente: TCliente;
begin
  TLog.d('>>> Entrando em  TfrmFiltroCliente.PesquisaCliente ');
  try
    frmConsultaCliente := TFrmConsultaCliente.Create(Self);
    try
      frmConsultaCliente.ShowModal;

      if Assigned(frmConsultaCliente.Cliente) then
      begin
        ACliente := FFactory
          .DaoCliente
          .GeTCliente(frmConsultaCliente.Cliente.CODIGO);
      end;
    finally
      FreeAndNil(frmConsultaCliente);
    end;

    if Assigned(ACliente) then
    begin
      BindFields(ACliente);
      btnOk.SetFocus;
    end;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      MessageDlg(E.message, mtError, [mbOK], 0);
    end;
  end;
  TLog.d('<<< Saindo de TfrmFiltroCliente.PesquisaCliente ');
end;

procedure TfrmFiltroCliente.BindFields(ACliente: TCliente);
var
  idx: Integer;
begin

  idx := cbbCliente.Items.IndexOf(ACliente.Nome);

  if idx >= 0 then
  begin
    cbbCliente.ItemIndex := idx;
  end
  else
  begin
    idx := cbbCliente.Items.AddObject(ACliente.Nome, ACliente);
    cbbCliente.ItemIndex := idx;
  end;
end;

procedure TfrmFiltroCliente.cbbClienteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    btnOk.SetFocus;
  end
  else
    if Key = #27 then
  begin
    cbbCliente.DroppedDown := False;
  end;
end;

procedure TfrmFiltroCliente.cbbClienteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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

      itens := FFactory
        .DaoCliente
        .GeTClientesByName(cbbCliente.Text);

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

procedure TfrmFiltroCliente.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmFiltroCliente.FormCreate ');
  inherited;
  FFactory := TFactory.new(nil, True);
  TLog.d('<<< Saindo de TfrmFiltroCliente.FormCreate ');
end;

procedure TfrmFiltroCliente.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  TLog.d('>>> Entrando em  TfrmFiltroCliente.FormDestroy ');
  for i := 0 to cbbCliente.Items.Count - 1 do
    cbbCliente.Items.Objects[i].Free;
  FFactory.Close;
  inherited;
  TLog.d('<<< Saindo de TfrmFiltroCliente.FormDestroy ');
end;

procedure TfrmFiltroCliente.SetCliente(const Value: TCliente);
begin
  FCliente := Value;
end;

end.
