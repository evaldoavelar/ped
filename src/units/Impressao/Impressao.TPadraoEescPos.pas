{ ******************************************************************************* }
{ }
{ UImpressora.pas }
{ }
{ Copyright (C) 2010 Consult Soluções em TI }
{ }
{ Autor: Evaldo  18/8/2010 }
{ }
{ Descrição: Unit Com funções para impressora não fiscal }
{ }
{ }
{ ******************************************************************************* }

unit Impressao.TPadraoEescPos;

interface

uses System.Classes, Winapi.Windows, Winapi.WinSpool,
  FMX.Printer, SysUtils, FMX.Dialogs,
  Impressao.TParametrosImpressora;

type

  TDocInfo = record
    DocName, OutputFile, Datatype: PChar;
  end;

  TPosPaginaCodigo = (pcNone, pc437, pc850, pc852, pc860, pcUTF8, pc1252);

  TConfigLogo = class(TPersistent)
  private
    FFatorX: Byte;
    FFatorY: Byte;
    FIgnorarLogo: Boolean;
    FKeyCode1: Byte;
    FKeyCode2: Byte;
  public
    constructor Create;

  published
    property IgnorarLogo: Boolean read FIgnorarLogo write FIgnorarLogo default False;
    property KeyCode1: Byte read FKeyCode1 write FKeyCode1 default 32;
    property KeyCode2: Byte read FKeyCode2 write FKeyCode2 default 32;
    property FatorX: Byte read FFatorX write FFatorX default 1;
    property FatorY: Byte read FFatorY write FFatorY default 1;
  end;

  TEscPosComandos = class
  private
    FBeep: AnsiString;
    FAlinhadoCentro: AnsiString;
    FAlinhadoDireita: AnsiString;
    FAlinhadoEsquerda: AnsiString;
    FCorteParcial: AnsiString;
    FDesligaInvertido: AnsiString;
    FEspacoEntreLinhasPadrao: AnsiString;
    FLigaInvertido: AnsiString;
    FFonteNormal: AnsiString;
    FLigaCondensado: AnsiString;
    FCorteTotal: AnsiString;
    FEspacoEntreLinhas: AnsiString;
    FLigaExpandido: AnsiString;
    FDesligaCondensado: AnsiString;
    FDesligaExpandido: AnsiString;
    FDesligaItalico: AnsiString;
    FDesligaNegrito: AnsiString;
    FDesligaSublinhado: AnsiString;
    FFonteA: AnsiString;
    FFonteB: AnsiString;
    FLigaItalico: AnsiString;
    FLigaNegrito: AnsiString;
    FLigaSublinhado: AnsiString;
    FZera: AnsiString;
  public
    property Zera: AnsiString read FZera write FZera;
    property EspacoEntreLinhas: AnsiString read FEspacoEntreLinhas
      write FEspacoEntreLinhas;
    property EspacoEntreLinhasPadrao: AnsiString
      read FEspacoEntreLinhasPadrao write FEspacoEntreLinhasPadrao;

    property LigaNegrito: AnsiString read FLigaNegrito write FLigaNegrito;
    property DesligaNegrito: AnsiString read FDesligaNegrito write FDesligaNegrito;
    property LigaExpandido: AnsiString read FLigaExpandido write FLigaExpandido;
    property DesligaExpandido: AnsiString read FDesligaExpandido write FDesligaExpandido;
    property LigaSublinhado: AnsiString read FLigaSublinhado write FLigaSublinhado;
    property DesligaSublinhado: AnsiString read FDesligaSublinhado
      write FDesligaSublinhado;
    property LigaItalico: AnsiString read FLigaItalico write FLigaItalico;
    property DesligaItalico: AnsiString read FDesligaItalico write FDesligaItalico;
    property LigaCondensado: AnsiString read FLigaCondensado write FLigaCondensado;
    property DesligaCondensado: AnsiString read FDesligaCondensado
      write FDesligaCondensado;
    property LigaInvertido: AnsiString read FLigaInvertido write FLigaInvertido;
    property DesligaInvertido: AnsiString read FDesligaInvertido write FDesligaInvertido;

    property FonteNormal: AnsiString read FFonteNormal write FFonteNormal;
    property FonteA: AnsiString read FFonteA write FFonteA;
    property FonteB: AnsiString read FFonteB write FFonteB;

    property AlinhadoEsquerda: AnsiString read FAlinhadoEsquerda write FAlinhadoEsquerda;
    property AlinhadoDireita: AnsiString read FAlinhadoDireita write FAlinhadoDireita;
    property AlinhadoCentro: AnsiString read FAlinhadoCentro write FAlinhadoCentro;

    property Beep: AnsiString read FBeep write FBeep;
    property CorteTotal: AnsiString read FCorteTotal write FCorteTotal;
    property CorteParcial: AnsiString read FCorteParcial write FCorteParcial;
  end;

  // ==============================================================================
  // Classe: TImpressora
  // Autor: Evaldo
  // Data: 17/8/2010
  // Descrição: Classe para realizar impressoes pela impressora não fiscal
  // ==============================================================================

  TImpressora = class(TObject)

  private

    FCmd: TEscPosComandos;
    FVias: Integer;
    FDevice: string;
    ColunasCupom: Integer;
    function FormatarLinha(Item, Valor: string): string;
    function ComandoEspacoEntreLinhas(Espacos: Byte): AnsiString;
    function ComandoPaginaCodigo(APagCodigo: TPosPaginaCodigo): AnsiString;
    function AnsiChr(b: Byte): AnsiChar;
    function ComandoLogo: AnsiString; // formata a linha para ser impressa no cupom

  protected
    _iRetorno: Integer; // retorno da impressora
    FESCPOS: TStringList; // Itens que seram impressos
    _Visual: TStringList; // Itens que seram impressos

  public
    Parametros: TParametrosImpressora;
    property Cmd: TEscPosComandos read FCmd;
    property Vias: Integer read FVias write FVias;

    constructor Create(Device: string; ParametrosImpressora: TParametrosImpressora; ModoDebug: Boolean = False);
    destructor Destroy;
    procedure SobePapel; // Sobe o papel para ser picotado
    procedure ADDItem(Item: string); // adiciona item para o couteudo do cupom
    procedure ADDItemRaw(Item: string); // adiciona item para o couteudo do cupom
    procedure ADDItemCondensado(Item: string); // adiciona item formatado a direita
    procedure ADDLinhaEmBranco; // adiciona uma linha em Branco para o conteúdo
    procedure ADDItemValor(Item, Valor: string); // adiciona item com um valor, formatando-o para o couteudo do cupom
    procedure ADDItemValorCustom(Item, Valor: string; TamItem: Integer); // adiciona item com um valor, formatando-o para o couteudo do cupom
    function Imprime: Boolean; // imprime o conteúdo do cupom
    procedure ADDItemDireita(Item: string); // adiciona item formatado a direita
    procedure ADDItemDireitaCondensado(Item: string); // adiciona item formatado a direita
    procedure ADDItemCentro(Item: string); // adiciona item formatado ao centro
    procedure ADDItemCentroNegrito(Item: string); // adiciona item formatado ao centro
    procedure ADDItemCentroCondensado(Item: string); // adiciona item formatado ao centro
    procedure ADDISeparadorTitulo(Titulo: string); // adiciona separador titulo
    procedure ADDISeparadorSimples;
    procedure ADDISeparadorDuplo;
    procedure Inicializa;
    procedure ADDColunas(Cabecalhos: array of string);
    function VerificaStatusImpressora: string; // Verificar qual é o status da impressora
    procedure ClearItens; // apaga os itens
    function Itens: string;
    procedure CortaPapel;

    property Papel: TStringList read _Visual write _Visual;
  end;

  TImpressaoCupons = class(TImpressora)
  protected

  public
    procedure CabecalhoCupom(Filial, Titulo: string); // cabeçalho do cupom
    procedure Rodape; // rodapé
    function ImprimeRecebimento: Boolean; // imprime o cupom de recebimento
  end;

const
  StrImpressoraOk: string = 'Impressora ok';
  // Epson
  NUL = #00;
  SOH = #01;
  STX = #02;
  ETX = #03;
  EOT = #04;
  ENQ = #05;
  ACK = #06;
  BELL = #07;
  BS = #08;
  TAB = #09;
  LF = #10;
  FF = #12;
  CR = #13;
  SO = #14;
  SI = #15;
  DLE = #16;
  WAK = #17;
  DC2 = #18;
  DC4 = #20;
  NAK = #21;
  SYN = #22;
  ESC = #27;
  FS = #28;
  GS = #29;
  CTRL_Z = #26;
  CRLF = CR + LF;

  escNewLine = chr(10); // New line (LF line feed)
  escUnerlineOn = chr(27) + chr(45) + chr(1); // Unerline On
  escUnerlineOnx2 = chr(27) + chr(45) + chr(2); // Unerline On x 2
  escUnerlineOff = chr(27) + chr(45) + chr(0); // Unerline Off
  escBoldOn = chr(27) + chr(69) + chr(1); // Bold On
  escBoldOff = chr(27) + chr(69) + chr(0); // Bold Off
  escNegativeOn = chr(29) + chr(66) + chr(1); // White On Black On'
  escNegativeOff = chr(29) + chr(66) + chr(0); // White On Black Off
  esc8CpiOn = chr(29) + chr(33) + chr(16); // Font Size x2 On
  esc8CpiOff = chr(29) + chr(33) + chr(0); // Font Size x2 Off
  esc16Cpi = chr(27) + chr(77) + chr(48); // Font A  -  Normal Font
  esc20Cpi = chr(27) + chr(77) + chr(49); // Font B - Small Font
  escReset = chr(27) + chr(64); // chr(27) + chr(77) + chr(48); // Reset Printer
  escFeedAndCut = chr(29) + chr(86) + chr(65); // Partial Cut and feed

  escAlignLeft = chr(27) + chr(97) + chr(48); // Align Text to the Left
  escAlignCenter = chr(27) + chr(97) + chr(49); // Align Text to the Center
  escAlignRight = chr(27) + chr(97) + chr(50); // Align Text to the Right

implementation

uses Util.Funcoes;

resourcestring
  StrImpressoraINI = 'impressora.ini';
  StrVazio = ' ';

function TImpressora.AnsiChr(b: Byte): AnsiChar;
begin
  Result := AnsiChar(chr(b));
end;

function TImpressora.ComandoEspacoEntreLinhas(Espacos: Byte): AnsiString;
begin
  if Espacos = 0 then
    Result := Cmd.EspacoEntreLinhasPadrao
  else
    Result := Cmd.EspacoEntreLinhas + AnsiChr(Espacos);
end;

function TImpressora.ComandoLogo: AnsiString;
begin
  // with fpPosPrinter.ConfigLogo do
  // begin
  // Result := GS + '(L' + #6 + #0 + #48 + #69 +
  // AnsiChr(KeyCode1) + AnsiChr(KeyCode2) +
  // AnsiChr(FatorX)   + AnsiChr(FatorY);
  // end;
end;

function TImpressora.ComandoPaginaCodigo(APagCodigo: TPosPaginaCodigo
  ): AnsiString;
var
  CmdPag: Integer;
begin
  case APagCodigo of
    pc437:
      CmdPag := 0;
    pc850:
      CmdPag := 2;
    pc852:
      CmdPag := 18;
    pc860:
      CmdPag := 3;
    pc1252:
      CmdPag := 16;
  else
    begin
      Result := '';
      Exit;
    end;
  end;

  Result := ESC + 't' + AnsiChr(CmdPag);
end;

{ TImpressao }

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.ADDItem
  Author:    Evaldo 18/8/2010
  Arguments: Item
  Result:    Nenhum
  Objetivo:  adiciona item para o conteudo do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDColunas(Cabecalhos: array of string);
var
  Tam: Integer;
  Linha: String;
  s: string;
begin
  Tam := Length(Cabecalhos);
  Tam := 64 div Tam;

  Linha := '';
  for s in Cabecalhos do
  begin
    Linha := Linha + (TUtil.PadL(s, Tam, ' '));
  end;

  Self.FESCPOS.Add(Self.FCmd.LigaCondensado + Linha);
  Self._Visual.Add(Linha);

end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressora.ADDISeparadorDuplo
  Author:    Evaldo 4/11/2010
  Arguments: None
  Result:    None
  Objetivo:  Adiciona um separador duplo nas linhas do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDISeparadorDuplo;
begin
  Self.ADDLinhaEmBranco;
  Self.FESCPOS.Add(TUtil.Padc('=', Self.Parametros.ColunasCupom, '='));
  Self._Visual.Add(TUtil.Padc('=', Self.Parametros.ColunasCupom, '='));
  Self.ADDLinhaEmBranco;

end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressora.ADDISeparadorSimples
  Author:    Evaldo 4/11/2010
  Arguments: None
  Result:    None
  Objetivo:  Adiciona um separador simples nas linhas do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDISeparadorSimples;
begin
  Self.FESCPOS.Add(Self.Cmd.FonteNormal + TUtil.Padc('-', Self.Parametros.ColunasCupom, '-'));
  Self._Visual.Add(TUtil.Padc('-', Self.Parametros.ColunasCupom, '-'));
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressora.ADDISeparadorTitulo
  Author:    Evaldo 4/11/2010
  Arguments: Titulo: string
  Result:    None
  Objetivo:  Adiciona um separador de titulo nas linhas do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDISeparadorTitulo(Titulo: string);
var
  Linha: String;
begin
  Linha := ' ' + Titulo + ' ';
  Self.ADDLinhaEmBranco;
  Self.FESCPOS.Add(TUtil.Padc(Linha, Self.Parametros.ColunasCupom, '-'));
  Self._Visual.Add(TUtil.Padc(Linha, Self.Parametros.ColunasCupom, '-'));
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressora.ADDItem
  Author:    Evaldo 4/11/2010
  Arguments: Item: string
  Result:    None
  Objetivo:  Adiciona uma linha no cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDItem(Item: string);
begin
  Self.FESCPOS.Add(Self.Cmd.FAlinhadoEsquerda + Self.Cmd.LigaCondensado + Item + Self.Cmd.DesligaCondensado);
  Self._Visual.Add(Item);
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.ADDItemDireita
  Author:    Evaldo 19/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  adiciona item formatado a direita
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDItemDireita(Item: string);
begin
  //
  Self.FESCPOS.Add(Self.Cmd.AlinhadoDireita + Item);
  Self._Visual.Add(TUtil.PadL(Item, Self.Parametros.ColunasCupom, ' '));
end;

procedure TImpressora.ADDItemDireitaCondensado(Item: string);
begin
  Self.FESCPOS.Add(Self.Cmd.LigaCondensado + Self.Cmd.AlinhadoDireita + Item + Self.Cmd.DesligaCondensado);
  Self._Visual.Add(TUtil.PadL(Item, Self.Parametros.ColunasCupom, ' '));
end;

procedure TImpressora.ADDItemRaw(Item: string);
begin
  Self.FESCPOS.Add(Item);
  Self._Visual.Add(Item);
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressora.ADDItemCentro
  Author:    Evaldo 4/11/2010
  Arguments: Item: string
  Result:    None
  Objetivo:  adiciona item formatado ao centro
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDItemCentro(Item: string);
begin
  // Self._Papel.Add(Linha.Padc(Self.Parametros.ColunasCupom, ' '));
  Self.FESCPOS.Add(Self.Cmd.AlinhadoCentro + Item + Self.Cmd.AlinhadoEsquerda);
  Self._Visual.Add(TUtil.Padc(Item, Self.Parametros.ColunasCupom, ' '));
end;

procedure TImpressora.ADDItemCentroCondensado(Item: string);
begin
  Self.FESCPOS.Add(Self.Cmd.LigaCondensado + Item + Self.Cmd.DesligaCondensado);
  Self._Visual.Add(TUtil.PadL(Item, Self.Parametros.ColunasCupom, ' '));
end;

procedure TImpressora.ADDItemCentroNegrito(Item: string);
begin
  Self.FESCPOS.Add(Self.Cmd.LigaNegrito + Self.Cmd.AlinhadoCentro + Item + Self.Cmd.DesligaNegrito);
end;

procedure TImpressora.ADDItemCondensado(Item: string);
begin
  Self.FESCPOS.Add(Self.Cmd.LigaCondensado + Item + Self.Cmd.DesligaCondensado);
  Self._Visual.Add(Item);
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.ADDItemValor
  Author:    Evaldo 18/8/2010
  Arguments: Item e o seu valor
  Result:    Nenhum
  Objetivo:  adiciona item com um valor, formatando-o para o couteudo do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDItemValor(Item, Valor: string);
begin
  Self.FESCPOS.Add(Self.Cmd.AlinhadoEsquerda + Self.FCmd.LigaCondensado + FormatarLinha(Item, Valor) + Self.Cmd.DesligaCondensado);
  Self._Visual.Add(FormatarLinha(Item, Valor));
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressora.ADDItemValorCustom
  Author:    Evaldo 4/11/2010
  Arguments: Item, Valor: string; TamItem: Integer
  Result:    None
  Objetivo:  Permite adicionar um item e um valor customizando o tamanho em que o
  item vai aparecer no cupom atraves da variavel
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDItemValorCustom(Item, Valor: string; TamItem: Integer);
var
  larguracupom: Integer;
  itemlargura: Integer;
  valorlargura: Integer;
  aux: Integer;
begin

  larguracupom := 62;
  itemlargura := (larguracupom div 3);
  valorlargura := larguracupom - itemlargura;

  Self.FESCPOS.Add(Self.Cmd.AlinhadoEsquerda +
    Self.FCmd.LigaCondensado +
    TUtil.PadR(Item, itemlargura, ' ') +
    TUtil.PadL(Valor, valorlargura, ' ') +
    Self.Cmd.DesligaCondensado);

  aux := Self.Parametros.ColunasCupom - TamItem;

  Self._Visual.Add(TUtil.PadR(Item, TamItem, ' ') + TUtil.PadL(Valor, aux, ' '));

end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.ADDLinhaEmBranco
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  adiciona uma linha em Branco para o conteúdo
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ADDLinhaEmBranco;
begin
  Self.FESCPOS.Add(Self.Cmd.LigaCondensado + ' ' + Self.Cmd.DesligaCondensado);
  Self._Visual.Add(StrVazio);

end;

procedure TImpressora.CortaPapel;
begin
  Self.FESCPOS.Add(Cmd.CorteParcial);
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.CabecalhoCupom
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  cabeçalho do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressaoCupons.CabecalhoCupom(Filial, Titulo: string);
begin
  // Self.FESCPOS.Add(escReset);
  // Self.Papel.Add( Linha.PadC(Self.Parametros.ColunasCupom, '-'));
  Self.FESCPOS.Add( Self.Cmd.LigaNegrito + Self.Cmd.AlinhadoCentro +Self.Cmd.FonteA esc8CpiOn + Titulo + escBoldOff + esc8CpiOff);

  // Linha.Text := (titulo);
  // Self.Papel.Add(Linha.PadC(Self.Parametros.ColunasCupom, ' '));

  Self.FESCPOS.Add(esc20Cpi + StrVazio + escAlignLeft);
  Self.FESCPOS.Add('CEASAMINAS: ' + Filial);
  Self.FESCPOS.Add('CNPJ: 17.504.325/0001-04');
  Self.FESCPOS.Add(StrVazio);
  Self.FESCPOS.Add(Self.Cmd.FEspacoEntreLinhas);
  Self.FESCPOS.Add(Self.Cmd.CorteTotal);

end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressaoCupons.CabecalhoRecebimento
  Author:    Evaldo 4/11/2010
  Arguments: None
  Result:    None
  Objetivo:  Adicionar um cabeçalho de recebimento para o cupom
  -------------------------------------------------------------------------------<md> }
//
// procedure TImpressaoCupons.CabecalhoRecebimento;
// var
// Linha: TCSTString;
// begin
//
// Linha.Text := StrVazio;
// Self.Papel.Add(Linha.PadC(Self.Parametros.ColunasCupom, '-'));
//
// Linha.Text := ('Recibo Mensalista');
// Self.Papel.Add(Linha.PadC(Self.Parametros.ColunasCupom, ' '));
//
// Self.Papel.Add(StrVazio);
// Self.Papel.Add('CEASAMINAS: ' + Self.Parametros.Filial);
// Self.Papel.Add('CNPJ: 17.504.325/0001-04');
// Self.Papel.Add(StrVazio);
//
//
// end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.ClearItens
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  Apaga os itens do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.ClearItens;
begin
  Self.FESCPOS.Clear;
  Self._Visual.Clear;
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.Imprime
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  imprime os itens do cupom
  -------------------------------------------------------------------------------<md> }

function TImpressora.Imprime: Boolean;

Var
  Handle: THandle;
  N: DWord;
  DocInfo1: TDocInfo1;
  P: Byte;
  I: Integer;
  prndata: AnsiString;
begin

  // {$REGION 'ESC/POS COMMANDS'}
  // prndata := char(27) + char(64);
  // prndata := prndata + chr($1B) + 'a' + chr(1);
  // prndata := prndata + chr($1B) + '!' + chr($8);
  // prndata := prndata + 'HELLO WORLD !';
  // prndata := prndata + char($0A);
  //
  // prndata := prndata + chr($1B) + 'a' + chr(1);
  // prndata := prndata + chr($1B) + '!' + chr($1);
  // prndata := prndata + DateTimeToStr(NOW);
  // prndata := prndata + char($0A);
  //
  // prndata := prndata + chr($1D) + 'V' + chr(0); // CUT THE PAPER // #GS V 0 !
  //
  // {$ENDREGION}

  prndata := Self.FESCPOS.Text;
  If not OpenPrinter(PChar(FDevice), Handle, nil) then
  Begin
    Case GetLastError of
      87:
        ShowMessage('Printer name does not exists.');
    else
      ShowMessage('Error ' + IntToStr(GetLastError)); // Uses Dialogs
    End;
    Exit;
  End;

  With DocInfo1 do
  Begin
    pDocName := PChar('Print job');
    // Job name Shows in what's Printing..
    pOutputFile := nil;
    pDataType := 'RAW';
    // This data is (RAW)
  end;

  StartDocPrinter(Handle, 1, @DocInfo1);
  StartPagePrinter(Handle);
  WritePrinter(Handle, PAnsiString(prndata), Length(prndata), N);
  EndPagePrinter(Handle);
  EndDocPrinter(Handle);
  ClosePrinter(Handle);

end;

procedure TImpressora.Inicializa;
begin
  Self.FESCPOS.Text := Cmd.Zera + ComandoEspacoEntreLinhas(0) +
    ComandoPaginaCodigo(pc1252);
end;

function TImpressora.Itens: string;
begin
  Result := Self.FESCPOS.Text;
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.Create
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  Construtor
  -------------------------------------------------------------------------------<md> }

constructor TImpressora.Create(Device: string; ParametrosImpressora: TParametrosImpressora; ModoDebug: Boolean = False);
var
  comunica: string;
begin

  Parametros := ParametrosImpressora;
  FDevice := Device;

  FCmd := TEscPosComandos.Create;
  with FCmd do
  begin
    Zera := escReset;
    EspacoEntreLinhasPadrao := ESC + '2';
    EspacoEntreLinhas := escNewLine;
    FonteNormal := esc16Cpi;
    FonteA := esc16Cpi;
    FonteB := esc20Cpi;
    LigaNegrito := escBoldOn;
    DesligaNegrito := escBoldOff;
    LigaExpandido := GS + '!' + #16;
    DesligaExpandido := GS + '!' + #0;
    LigaSublinhado := ESC + '-' + #1;
    DesligaSublinhado := ESC + '-' + #0;
    LigaInvertido := GS + 'B' + #1;
    DesligaInvertido := GS + 'B' + #0;
    LigaItalico := ''; // Não existe ?
    DesligaItalico := ''; // Não existe ?
    LigaCondensado := FonteB;
    DesligaCondensado := FonteA;
    AlinhadoEsquerda := escAlignLeft;
    AlinhadoCentro := escAlignCenter;
    AlinhadoDireita := escAlignRight;
    CorteTotal := GS + 'V' + chr(0);
    CorteParcial := escFeedAndCut;
    Beep := ESC + '(A' + #4 + #0 + #48 + #55 + #03 + #10;
  end;

  FVias := 2;

  // Abrir a porta Serial

  // if UpperCase(Self.Parametros.Porta) = 'LPT1' then
  // comunica := 'LPT1'#0
  // else if UpperCase(Self.Parametros.Porta) = 'COM1' then
  // comunica := 'COM1'#0
  // else if UpperCase(Self.Parametros.Porta) = 'COM2' then
  // comunica := 'COM2'#0
  // else if UpperCase(Self.Parametros.Porta) = 'USB' then
  // comunica := 'USB'#0
  // else
  // comunica := 'LPT1';
  //
  // _iRetorno := IniciaPorta(pchar(comunica));
  // if _iRetorno < 1 then
  // ExibeMensagem('Problemas ao Abrir a porta de comunicação!', 1, 1, true);

  Self.FESCPOS := TStringList.Create;
  Self._Visual := TStringList.Create;
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.Destroy
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  Destrutor
  -------------------------------------------------------------------------------<md> }

destructor TImpressora.Destroy;
begin
  Self.FESCPOS.Free;
  Self._Visual.Free;
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.FormatarLinha
  Author:    Evaldo 18/8/2010
  Arguments: Item e o seu valor
  Result:    Linha Formatada
  Objetivo:  formata a linha para ser impressa no cupom
  -------------------------------------------------------------------------------<md> }

function TImpressora.FormatarLinha(Item, Valor: string): string;
var
  TamLinha: Integer;
begin
  TamLinha := (Self.Parametros.ColunasCupom div 2) + 8;

  Result := TUtil.PadR(Item, TamLinha, ' ') + TUtil.PadL(Valor, TamLinha, ' ');
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.ImprimeRecebimento
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Verdadeiro caso consiga imprimir ou Falso caso não consiga
  Objetivo:  imprime o cupom de venda
  -------------------------------------------------------------------------------<md> }

function TImpressaoCupons.ImprimeRecebimento: Boolean;
begin
  Imprime;
  Rodape;
  SobePapel;
  Self.FESCPOS.Clear;
  Self._Visual.Clear;
  Result := True;
end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.Rodape
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  rodapé do cupom
  -------------------------------------------------------------------------------<md> }

procedure TImpressaoCupons.Rodape;

begin
  if Self.Parametros.Debug then
    Exit;

  // Linha.Text := StrVazio;
  Self._Visual.Add(TUtil.Padc('-', Self.Parametros.ColunasCupom, '-'));

end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.SobePapel
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  Sobe o papel para ser picotado
  -------------------------------------------------------------------------------<md> }

procedure TImpressora.SobePapel;
var
  I: Integer;
  Vazio: string;
begin
  if Self.Parametros.Debug then
    Exit;

  Vazio := chr(13) + chr(10);
  for I := 0 to Self.Parametros.LinhasFinalCupom - 1 do
  begin
    Self.FESCPOS.Add(Vazio);
    Self._Visual.Add(Vazio);
  end;

end;

{ <md>-------------------------------------------------------------------------------
  Procedure: TImpressao.VerificaStatusImpressora
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    String contendo o Status
  Objetivo:  Verificar qual é o status da impressora
  -------------------------------------------------------------------------------<md> }

function TImpressora.VerificaStatusImpressora: string;
begin
  if Parametros.Debug then
  begin
    Result := StrImpressoraOk;
    Exit;
  end;

end;

{ TParametrosImpressora }

{ <md>-------------------------------------------------------------------------------
  Procedure: TParametrosImpressora.Create
  Author:    Evaldo 18/8/2010
  Arguments: Nenhum
  Result:    Nenhum
  Objetivo:  Construtor
  -------------------------------------------------------------------------------<md> }

{ TImpressaoRelFechaCaixa }

{ TConfigLogo }

constructor TConfigLogo.Create;
begin
  FKeyCode1 := 32;
  FKeyCode2 := 32;
  FFatorX := 1;
  FFatorY := 1;
  FIgnorarLogo := False;
end;

end.
