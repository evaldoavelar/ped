unit Cadastros.Base;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.TypInfo, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untFrmBase, Vcl.ExtCtrls, System.Actions,
  Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  JvComponentBase, JvEnterTab, Util.VclFuncoes, Vcl.Imaging.jpeg, Pedido.Venda.IPart,
  Vcl.AutoComplete, Dominio.Entidades.TEntity, System.Generics.Collections;

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
    btnPesquisar: TBitBtn;
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
    edtPesquisa: TAutoComplete;
    procedure FormCreate(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actPesquisarExecute(Sender: TObject);
    procedure actNovoExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPesquisaExit(Sender: TObject);
    procedure edtPesquisaEnter(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure edtPesquisaKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure edtPesquisaClick(Sender: TObject);
  private

    procedure ScreenActiveControlChange(Sender: TObject);
    procedure onEnter(Sender: TWinControl);
    procedure OnExit(Sender: TWinControl);
    procedure SelecionaEntidade;
    procedure SetarFocusNaPesquisa;

  protected
    lastFocused: TWinControl;
    originalColor: TColor;
    FCachePesquisa: TStringList;
    state: TState;

    procedure AtualizarEntity(); virtual; abstract;
    procedure IncluirEntity(); virtual; abstract;
    procedure Pesquisar; virtual;
    procedure Salvar;
    procedure Bind; virtual; abstract;
    procedure Novo; virtual;
    procedure getEntity(aEntity: TObject); virtual; abstract;
    procedure Cancelar; virtual;
    procedure Excluir; virtual; abstract;
    function MontaDescricaoPesquisa(aItem: TEntity): string; virtual; abstract;
    function PesquisaPorDescricaoParcial(aValor: string): TObjectList<TEntity>; virtual; abstract;
    procedure HabilitarControle(Controle: TControl; habilitar: Boolean);
    procedure TrataBotoes;
    procedure ExibePart(aPart: IPart; aParent: TWinControl; aParams: array of TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

const
  focusColor = $00ECF1EE;
  FontColor = $00584C42;

var
  frmCadastroBase: TfrmCadastroBase;

resourcestring
  StrPesquisa = '';

implementation

{$R *.dfm}


uses Sistema.TLog;

procedure TfrmCadastroBase.ExibePart(aPart: IPart; aParent: TWinControl; aParams: array of TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.ExibePart ');
  aPart
    .setParams(aParams)
    .SetParent(aParent)
    .SetUp;
  TLog.d('<<< Saindo de TfrmCadastroBase.ExibePart ');
end;

procedure TfrmCadastroBase.actCancelarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.actCancelarExecute ');
  if MessageDlg('Deseja cancelar a alteração?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    abort;

  inherited;
  Cancelar;

  try
    edtPesquisa.SetFocus;
    edtPesquisa.SelectAll;
  except
  end;

  TLog.d('<<< Saindo de TfrmCadastroBase.actCancelarExecute ');
end;

procedure TfrmCadastroBase.actEditarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.actEditarExecute ');
  inherited;
  state := TState.stEdit;
  getEntity(nil);
  TLog.d('<<< Saindo de TfrmCadastroBase.actEditarExecute ');
end;

procedure TfrmCadastroBase.actExcluirExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.actExcluirExecute ');
  inherited;
  if MessageDlg('Deseja excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    Exit;
  Excluir;
  TLog.d('<<< Saindo de TfrmCadastroBase.actExcluirExecute ');
end;

procedure TfrmCadastroBase.actNovoExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.actNovoExecute ');
  inherited;

  if state = StNovo then
  begin
    if MessageDlg('O registro ainda não foi salvo, deseja realmente criar um novo?', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;
  end;

  state := TState.StNovo;
  Novo;
  pgcPrincipal.ActivePageIndex := 0;
  TLog.d('<<< Saindo de TfrmCadastroBase.actNovoExecute ');
end;

procedure TfrmCadastroBase.actPesquisarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.actPesquisarExecute ');
  inherited;
  Pesquisar;
  TLog.d('<<< Saindo de TfrmCadastroBase.actPesquisarExecute ');
end;

procedure TfrmCadastroBase.actSairExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.actSairExecute ');
  inherited;

  close;
  TLog.d('<<< Saindo de TfrmCadastroBase.actSairExecute ');
end;

procedure TfrmCadastroBase.actSalvarExecute(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.actSalvarExecute ');
  inherited;
  Salvar;
  SetarFocusNaPesquisa;
  TLog.d('<<< Saindo de TfrmCadastroBase.actSalvarExecute ');
end;

procedure TfrmCadastroBase.SetarFocusNaPesquisa;
begin
  try
    edtPesquisa.SetFocus;
    edtPesquisa.Text := StrPesquisa;
    edtPesquisa.SelectAll;
  except
  end;
end;

procedure TfrmCadastroBase.Cancelar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.Cancelar ');
  state := TState.stBrowser;
  TrataBotoes;
  SetarFocusNaPesquisa;
  TLog.d('<<< Saindo de TfrmCadastroBase.Cancelar ');
end;

procedure TfrmCadastroBase.onEnter(Sender: TWinControl);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.onEnter ');
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
  TLog.d('<<< Saindo de TfrmCadastroBase.onEnter ');
end;

procedure TfrmCadastroBase.OnExit(Sender: TWinControl);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.OnExit ');
  if Sender <> nil then
  begin
    if IsPublishedProp(Sender, 'Color') then
    begin
      SetOrdProp(Sender, 'Color', originalColor);
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroBase.OnExit ');
end;

procedure TfrmCadastroBase.Pesquisar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.Pesquisar ');
  state := TState.stEdit;
  TrataBotoes;
  TLog.d('<<< Saindo de TfrmCadastroBase.Pesquisar ');
end;

procedure TfrmCadastroBase.edtPesquisaClick(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.edtPesquisaClick ');
  inherited;
  if not edtPesquisa.Showing then
    SelecionaEntidade;
  TLog.d('<<< Saindo de TfrmCadastroBase.edtPesquisaClick ');
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

procedure TfrmCadastroBase.SelecionaEntidade;
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.SelecionaEntidade ');
  try
    if (edtPesquisa.ItemIndex = -1) and (edtPesquisa.GetSelectObject = nil) then
      Exit;

    try
      OutputDebugString(PWideChar(edtPesquisa.Items.Strings[edtPesquisa.ItemIndex]));
      state := TState.stEdit;
      getEntity(edtPesquisa.GetSelectObject);
    except
      raise Exception.Create('nenhum item selecionado');
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.Message);
      MessageDlg(E.Message, mtError, [mbOK], 0);
      try
        edtPesquisa.Text := StrPesquisa;
        edtPesquisa.SetFocus;
      except
      end;
    end;
  end;
  TLog.d('<<< Saindo de TfrmCadastroBase.SelecionaEntidade ');
end;

procedure TfrmCadastroBase.edtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    TLog.d('>>> Entrando em  TfrmCadastroBase.edtPesquisaKeyPress ');
    SelecionaEntidade;
    Key := #0;
    TLog.d('<<< Saindo de TfrmCadastroBase.edtPesquisaKeyPress ');
  end
end;

procedure TfrmCadastroBase.edtPesquisaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Item: TEntity;
  itens: TObjectList<TEntity>;
  DescricaoProduto: string;
begin
  inherited;
  if (Length(edtPesquisa.Text) > 1) and (edtPesquisa.Text <> StrPesquisa) then
  begin
    if (FCachePesquisa.IndexOf(edtPesquisa.Text) = -1)
      and (edtPesquisa.Items.IndexOf(edtPesquisa.Text) = -1)
      and (Key <> VK_RETURN) then
    begin
      OutputDebugString(PWideChar(edtPesquisa.Text));
      itens := PesquisaPorDescricaoParcial(edtPesquisa.Text);
      itens.OwnsObjects := False;

      for Item in itens do
      begin
        DescricaoProduto := MontaDescricaoPesquisa(Item);
        if edtPesquisa.Items.IndexOf(DescricaoProduto) = -1 then
          edtPesquisa.Items.AddObject(DescricaoProduto, Item)
        else
          Item.Free;
      end;

      FreeAndNil(itens);

      FCachePesquisa.Add(edtPesquisa.Text);
    end;
    if not(Key in [VK_DOWN, VK_UP]) then
      edtPesquisa.ShowList;
  end;
end;

procedure TfrmCadastroBase.FormCreate(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.FormCreate ');
  inherited;
  state := TState.stBrowser;
  TVclFuncoes.DisableVclStyles(self, 'TLabel');
  TVclFuncoes.DisableVclStyles(self, 'TEdit');
  FCachePesquisa := TStringList.Create;
  Screen.OnActiveControlChange := ScreenActiveControlChange;
  TLog.d('<<< Saindo de TfrmCadastroBase.FormCreate ');
end;

procedure TfrmCadastroBase.FormDestroy(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.FormDestroy ');
  Screen.OnActiveControlChange := nil;
  FreeAndNil(FCachePesquisa);
  inherited;
  TLog.d('<<< Saindo de TfrmCadastroBase.FormDestroy ');
end;

procedure TfrmCadastroBase.FormShow(Sender: TObject);
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.FormShow ');
  inherited;
  pgcPrincipal.TabIndex := 0;
  TrataBotoes;
  HabilitarControle(pgcPrincipal, False);

  try
    edtPesquisa.Text := StrPesquisa;
    edtPesquisa.SetFocus;
  except
  end;
  TLog.d('<<< Saindo de TfrmCadastroBase.FormShow ');
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
  TLog.d('>>> Entrando em  TfrmCadastroBase.Novo ');
  TrataBotoes;
  TLog.d('<<< Saindo de TfrmCadastroBase.Novo ');
end;

procedure TfrmCadastroBase.Salvar;
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.Salvar ');
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
  TLog.d('<<< Saindo de TfrmCadastroBase.Salvar ');
end;

procedure TfrmCadastroBase.ScreenActiveControlChange(Sender: TObject);
var
  doEnter, doExit: Boolean;
  previousActiveControl: TWinControl;
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.ScreenActiveControlChange ');
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
  TLog.d('<<< Saindo de TfrmCadastroBase.ScreenActiveControlChange ');
end;

procedure TfrmCadastroBase.TrataBotoes;
begin
  TLog.d('>>> Entrando em  TfrmCadastroBase.TrataBotoes ');
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
  TLog.d('<<< Saindo de TfrmCadastroBase.TrataBotoes ');
end;

end.
