unit Cadastros.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.TypInfo, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.WinXCtrls, Vcl.Buttons, Vcl.ComCtrls,
  JvComponentBase, JvEnterTab, Util.VclFuncoes, Vcl.Imaging.jpeg, Pedido.Venda.IPart;

type
  TState = (stEdit, StNovo, stExcluir, stBrowser);

  TfrmCadastroBase = class(TfrmBase)
    pnlContainer: TPanel;
    pnlBotoes: TPanel;
    pgcPrincipal: TPageControl;
    pnlTop: TPanel;
    btnNovo: TBitBtn;
    btnSalvar: TBitBtn;
    btnCacenlar: TBitBtn;
    edtPesquisa: TSearchBox;
    btnPesquisar: TBitBtn;
    Label1: TLabel;
    lblCliente: TLabel;
    btnSair: TBitBtn;
    act1: TActionList;
    actPesquisar: TAction;
    actNovo: TAction;
    actSalvar: TAction;
    actCancelar: TAction;
    actSair: TAction;
    JvEnterAsTab1: TJvEnterAsTab;
    actExcluir: TAction;
    btnExcluir: TBitBtn;
    lblAtalhos: TLabel;
    Image1: TImage;
    BitBtn1: TBitBtn;
    actEditar: TAction;
    procedure FormCreate(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure edtPesquisaInvokeSearch(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPesquisaExit(Sender: TObject);
    procedure edtPesquisaEnter(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
  private

    procedure ScreenActiveControlChange(Sender: TObject);
    procedure onEnter(Sender: TWinControl);
    procedure OnExit(Sender: TWinControl);


  protected
    lastFocused: TWinControl;
    originalColor: TColor;

    state: TState;

    procedure AtualizarEntity(); virtual; abstract;
    procedure IncluirEntity(); virtual; abstract;
    procedure Pesquisar; virtual;
    procedure Salvar;
    procedure Bind; virtual; abstract;
    procedure Novo; virtual;
    procedure getEntity; virtual; abstract;
    procedure Cancelar; virtual;
    procedure Excluir; virtual; abstract;
    procedure HabilitarControle(Controle: TControl; habilitar: Boolean);
    procedure TrataBotoes;
     procedure ExibePart(aPart: IPart; aParent: TWinControl;      aParams: array of TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

const
  focusColor = $00ECF1EE;
  FontColor = $00584C42;

var
  frmCadastroBase: TfrmCadastroBase;

implementation

{$R *.dfm}


uses Util.Funcoes;

procedure TfrmCadastroBase.ExibePart(aPart: IPart; aParent: TWinControl; aParams: array of TObject);
begin
  aPart
    .setParams(aParams)
    .SetParent(aParent)
    .SetUp;
end;

procedure TfrmCadastroBase.actCancelarExecute(Sender: TObject);
begin
  if MessageDlg('Deseja cancelar a alterção?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    abort;

  inherited;
  Cancelar;

end;

procedure TfrmCadastroBase.actEditarExecute(Sender: TObject);
begin
  inherited;
 state := TState.stEdit;
  getEntity;
end;

procedure TfrmCadastroBase.actExcluirExecute(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;
  Excluir;
end;

procedure TfrmCadastroBase.actNovoExecute(Sender: TObject);
begin
  inherited;

  if state = StNovo then
  begin
    if MessageDlg('O registro ainda não foi salvo, deseja realmente criar um novo?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
  end;

  state := TState.StNovo;
  Novo;
  pgcPrincipal.ActivePageIndex := 0;
end;

procedure TfrmCadastroBase.actPesquisarExecute(Sender: TObject);
begin
  inherited;
  Pesquisar;
end;

procedure TfrmCadastroBase.actSairExecute(Sender: TObject);
begin
  inherited;

  close;
end;

procedure TfrmCadastroBase.actSalvarExecute(Sender: TObject);
begin
  inherited;
  Salvar;
end;

procedure TfrmCadastroBase.Cancelar;
begin
  state := TState.stBrowser;
  TrataBotoes;
end;

procedure TfrmCadastroBase.onEnter(Sender: TWinControl);
begin

  if Sender <> nil then
  begin
    if IsPublishedProp(Sender, 'Color') then
    begin
      originalColor := GetOrdProp(Sender, 'Color');
      SetOrdProp(Sender, 'Color', focusColor);
    end;

    if IsPublishedProp(Sender, 'Font.Color') then
    begin
      originalColor := GetOrdProp(Sender, 'Font.Color');
      SetOrdProp(Sender, 'Font.Color', FontColor);
    end;
  end;

end;

procedure TfrmCadastroBase.OnExit(Sender: TWinControl);
begin
  if Sender <> nil then
  begin
    if IsPublishedProp(Sender, 'Color') then
    begin
      SetOrdProp(Sender, 'Color', originalColor);
    end;
  end;
end;

procedure TfrmCadastroBase.Pesquisar;
begin
  state := TState.stEdit;
  TrataBotoes;
end;

procedure TfrmCadastroBase.edtPesquisaEnter(Sender: TObject);
begin
  inherited;
  JvEnterAsTab1.EnterAsTab := False;
end;

procedure TfrmCadastroBase.edtPesquisaExit(Sender: TObject);
begin
  inherited;
  JvEnterAsTab1.EnterAsTab := True;
end;

procedure TfrmCadastroBase.edtPesquisaInvokeSearch(Sender: TObject);
begin
  inherited;
  state := TState.stEdit;
  getEntity;
end;

procedure TfrmCadastroBase.FormCreate(Sender: TObject);
begin
  inherited;
  state := TState.stBrowser;
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
  TVclFuncoes.DisableVclStyles(self, 'TEdit');

  Screen.OnActiveControlChange := ScreenActiveControlChange;
end;

procedure TfrmCadastroBase.FormDestroy(Sender: TObject);
begin
  inherited;
  Screen.OnActiveControlChange := nil;
end;

procedure TfrmCadastroBase.FormShow(Sender: TObject);
begin
  inherited;
  pgcPrincipal.TabIndex := 0;
  TrataBotoes;
  HabilitarControle(pgcPrincipal, False);
  lblCliente.Caption := '';
  try
    edtPesquisa.SetFocus;
  except
    on E: Exception do
  end;
end;

procedure TfrmCadastroBase.HabilitarControle(Controle: TControl; habilitar: Boolean);
var
  i: Integer;
  Prop: PPropInfo;
  elem: TControl;

  PropInfo: PPropInfo;
begin

  if Controle is TWinControl then
  begin
    // pecorrer os elementos do controle
    for i := 0 to TWinControl(Controle).ControlCount - 1 do
    begin
      elem := TWinControl(Controle).Controls[i];

      // elemento é um controle com controles
      if elem is TWinControl then
      begin
        // Pecorrer os elementos do controle recursivamente
        HabilitarControle(elem, habilitar);

        // Habilitar/Desabilitar também o controle
        if IsPublishedProp(elem, 'Enabled') then
        begin
          PropInfo := GetPropInfo(elem.ClassInfo, 'Tag');
          if Assigned(PropInfo) then
          begin
            tag := GetPropValue(elem, 'Tag');
            if tag = 0 then
              SetPropValue(elem, 'Enabled', habilitar);
          end;
        end;
      end
      else
      begin
        // verificar se o componente possui a propriedade Enabled
        if IsPublishedProp(elem, 'Enabled') then
        begin
          PropInfo := GetPropInfo(elem.ClassInfo, 'Tag');
          if Assigned(PropInfo) then
          begin
            tag := GetPropValue(elem, 'Tag');
            if tag = 0 then
              SetPropValue(elem, 'Enabled', habilitar);
          end;

        end;
      end;
    end;
  end;

end;

procedure TfrmCadastroBase.Novo;
begin
  TrataBotoes;
end;

procedure TfrmCadastroBase.Salvar;
begin

  try
   ActiveControl := nil;

    case state of
      stEdit:
        begin
          AtualizarEntity();
        end;
      StNovo:
        begin
          IncluirEntity();
        end;
      stBrowser:
        raise Exception.Create('Não está em edição');
    end;

    state := TState.stBrowser;
    TrataBotoes;
   // MessageDlg('Salvo Com Sucesso!', mtInformation, [mbOK], 0);

  except
    on E: Exception do
      MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TfrmCadastroBase.ScreenActiveControlChange(Sender: TObject);
var
  doEnter, doExit: Boolean;
  previousActiveControl: TWinControl;
begin
  if Screen.ActiveControl = nil then
  begin
    lastFocused := nil;
    Exit;
  end;

  doEnter := True;
  doExit := True;

  // CheckBox
  if Screen.ActiveControl is TButtonControl then
    doEnter := False;

  previousActiveControl := lastFocused;

  if previousActiveControl <> nil then
  begin
    // CheckBox
    if previousActiveControl is TButtonControl then
      doExit := False;
  end;

  lastFocused := Screen.ActiveControl;

  if doExit then
    OnExit(previousActiveControl);
  if doEnter then
    onEnter(lastFocused);
end;

procedure TfrmCadastroBase.TrataBotoes;
begin
  case state of
    stEdit:
      begin
        actNovo.Enabled := False;
        actSalvar.Enabled := True;
        actCancelar.Enabled := True;
        actExcluir.Enabled := True;
        actPesquisar.Enabled := False;
        edtPesquisa.Enabled := False;
        actEditar.Enabled := False;
        HabilitarControle(pgcPrincipal, True);
      end;
    StNovo:
      begin
        actNovo.Enabled := False;
        actEditar.Enabled := False;
        actSalvar.Enabled := True;
        actExcluir.Enabled := False;
        actCancelar.Enabled := True;
        actPesquisar.Enabled := False;
        edtPesquisa.Enabled := False;
        HabilitarControle(pgcPrincipal, True);
      end;
    stExcluir:
      begin

      end;
    stBrowser:
      begin
        actNovo.Enabled := True;
        actEditar.Enabled := True;
        actSalvar.Enabled := False;
        actCancelar.Enabled := False;
        actExcluir.Enabled := False;
        actPesquisar.Enabled := True;
        edtPesquisa.Enabled := True;
        HabilitarControle(pgcPrincipal, False);
      end;
  end;

  self.Refresh;
  self.Repaint;
  Application.ProcessMessages;
end;

end.
