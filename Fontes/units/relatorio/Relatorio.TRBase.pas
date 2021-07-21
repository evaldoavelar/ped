unit Relatorio.TRBase;

interface

uses
  system.SysUtils, ACBrValidador, ACBrUtil,
  system.Classes, Winapi.Windows, Winapi.WinSpool,
  Dominio.Entidades.TEmitente,
  Impressao.TParametrosImpressora;

type

  TRBase = class
  private
    FBuffer: TStringList;
    FColunasFonteNormal: Integer;
    FEspacoEntreLinhas: byte;
    procedure SetBuffer(const Value: TStringList);
    function GetColunasFonteExpandida: Integer;
    function GetColunasFonteCondensada: Integer;
  protected
    FParametrosImpressora: TParametrosImpressora;

    procedure Cabecalho(Emitente: TEmitente);
    procedure Rodape;
    procedure SobePapel;
    function LinhaSimples: string;
    function Zera: string;

    property ColunasFonteExpandida: Integer read GetColunasFonteExpandida;
    property ColunasFonteCondensada: Integer read GetColunasFonteCondensada;
    property ColunasFonteNormal: Integer read FColunasFonteNormal write FColunasFonteNormal default 48;
    property EspacoEntreLinhas: byte read FEspacoEntreLinhas write FEspacoEntreLinhas default 0;

    property Buffer: TStringList read FBuffer;
  public
    constructor create(ParametrosImpressora: TParametrosImpressora);
    destructor Destroy; override;
    procedure imprimir;
  end;

const

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
  escGS  = #29 ;

  escExpandedOn = chr(27) + 'W' + chr(1);
  escExpandedOff = chr(27) + 'W' + chr(0);

  escAlignLeft = chr(27) + chr(97) + chr(48); // Align Text to the Left
  escAlignCenter = chr(27) + chr(97) + chr(49); // Align Text to the Center
  escAlignRight = chr(27) + chr(97) + chr(50); // Align Text to the Right

implementation

{ TRPedido }

function TRBase.Zera: string;
var
  CmdPag: Integer;
begin
  // case APagCodigo of
  // pc437: CmdPag := 0;
  // pc850: CmdPag := 2;
  // pc852: CmdPag := 18;
  // pc860: CmdPag := 3;
  // pc1252: CmdPag := 16;
  // else
  // begin
  // Result := '';
  // Exit;
  // end;
  // end;

  Result := chr(27) + 't' + chr(16);
end;

function TRBase.LinhaSimples: string;
begin
  Result := AnsiString(escBoldOff + esc16Cpi + StringOfChar('-', Self.ColunasFonteNormal))
end;

function TRBase.GetColunasFonteExpandida: Integer;
begin
  Result := trunc(ColunasFonteNormal / 2)
end;

function TRBase.GetColunasFonteCondensada: Integer;
begin
  Result := trunc(ColunasFonteNormal / 0.75)
end;

procedure TRBase.Cabecalho(Emitente: TEmitente);
var
  Cmd, LinhaCmd: String;
begin
  Buffer.Add(Self.Zera);

  if Length(Trim(Emitente.RAZAO_SOCIAL)) > Self.ColunasFonteNormal then
    Cmd := escAlignCenter + esc20Cpi + escBoldOn
  else
    Cmd := esc16Cpi + escAlignCenter + escBoldOn;

  Buffer.Add(Cmd + Emitente.RAZAO_SOCIAL + escBoldOff);

  if Trim(Emitente.FANTASIA) <> '' then
  begin
    if Length(Trim(Emitente.FANTASIA)) > Self.ColunasFonteNormal then
      Cmd := escAlignCenter + esc20Cpi + escBoldOn
    else
      Cmd := esc16Cpi + escAlignCenter + escBoldOn;

    Buffer.Add(Cmd + Emitente.FANTASIA + escBoldOff);
  end;

  Buffer.Add(esc20Cpi + QuebraLinhas(
    Trim(Emitente.ENDERECO) + ', ' +
    Trim(Emitente.NUM) + '  ' +
    Trim(Emitente.COMPLEMENTO) + '  ' +
    Trim(Emitente.BAIRRO) + ' ' +
    Trim(Emitente.CIDADE) + '/' + Trim(Emitente.UF) + '  ' +
    'Cep:' + FormatarCEP((Emitente.CEP)) + '  ' +
    'Tel:' + FormatarFone(Emitente.TELEFONE)
    , Self.ColunasFonteCondensada)
    );

  LinhaCmd := 'CNPJ: ' + FormatarCNPJ(Emitente.CNPJ);
  if Trim(Emitente.IE) <> '' then
  begin
    LinhaCmd := PadSpace(LinhaCmd + '|' + 'IE: ' + FormatarIE(Emitente.IE, Emitente.UF),
      Self.ColunasFonteCondensada, '|');
  end;

  Buffer.Add(escAlignLeft + esc20Cpi + escBoldOn + LinhaCmd + escBoldOff);

  if Trim(Emitente.IM) <> '' then
    Buffer.Add(escAlignLeft + esc20Cpi + escBoldOn + 'IM: ' + Emitente.IM + escBoldOff);

  Buffer.Add(esc16Cpi + Self.LinhaSimples);

end;

constructor TRBase.create(ParametrosImpressora: TParametrosImpressora);
begin
  FParametrosImpressora := ParametrosImpressora;
  FBuffer := TStringList.create;
  Self.FColunasFonteNormal := 48;
end;

destructor TRBase.Destroy;
begin
  FreeAndNil(Self.FBuffer);
  inherited;
end;

procedure TRBase.imprimir;
Var
  Handle: THandle;
  N: DWord;
  DocInfo1: TDocInfo1;
  P: byte;
  I: Integer;
  prndata: AnsiString;
begin
  try
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

    prndata := Self.Buffer.Text;
    If not OpenPrinter(PChar(FParametrosImpressora.MODELOIMPRESSORA), Handle, nil) then
    Begin
      Case GetLastError of
        87:
          raise Exception.create('Impressora não existe.');
      else
        raise Exception.create('Error ' + IntToStr(GetLastError)); // Uses Dialogs
      End;
    End;

    With DocInfo1 do
    Begin
      pDocName := PChar(ParamStr(0));
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
  except
    on E: Exception do
      raise Exception.create('Falha na impressão: ' + E.Message);
  end;
end;

procedure TRBase.Rodape;
begin
  // pular linhas e cortar o papel
  Buffer.Add(escFeedAndCut)
end;

procedure TRBase.SetBuffer(const Value: TStringList);
begin
  FBuffer := Value;
end;

procedure TRBase.SobePapel;
var
  I: Integer;
begin
  // for I := 0 to 3 do
  Buffer.Add(escNewLine)
end;

end.
