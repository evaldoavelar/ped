unit Impressao.TEpson;

interface


uses ACBrValidador, ACBrPosPrinter, ACBrUtil, pcnNFe, SysUtils, Classes,
 Impressao.TTextoImpressao;

type

  TTextoImpressaoSerial = class(TTextoImpressao)

  private
    function PadL(texto: string; const Len: integer; const Ch: Char): string;
    function PadR(texto: string; const Len: integer; const Ch: Char): string;
    function ReplicaChar(const Ch: Char; const Len: integer): string;
    function ComandoEspacoEntreLinhas(Espacos: Byte): AnsiString;
    function ComandoLogo: AnsiString;
    function ComandoPaginaCodigo(APagCodigo: TACBrPosPaginaCodigo): AnsiString;
    function GetColunasFonteCondensada: Integer;
    function GetColunasFonteNormal: Integer;

  public
    constructor create(); override;
    procedure addNegritoCentralizado(texto: string); overload; override;
    procedure addNegritoEsquerda(texto: string); overload; override;
    procedure addNegritoCentralizado(texto: string; comando: string); overload; override;
    procedure addSeparador(carcater: Char); overload; override;
    procedure addSeparador(carcater: Char; tam: integer); overload; override;
    procedure addColuna(textos: array of string; tamanhosPercent: array of Integer); override;
    procedure addTexto(texto: string); overload; override;
    procedure addTexto(texto: string; comando: string); overload; override;
    procedure addTextoCondensado(texto: string);  override;
    procedure addTextoCentro(texto: string);overload; override;
    procedure addTextoCentro(texto: string; separador: Char); overload; override;
    procedure addCentralizado(texto: string); override;
    procedure addColunaValor(coluna: string; valor: string); overload; override;
    procedure addColunaValor(coluna: string; tamColuna: Integer; valor: string; separador: Char); overload; override;
    procedure addCodigoBarras(texto: string); overload; override;
    procedure Guilhotina(espacos: Integer); override;
    procedure GerarClicheEmpresa(emit: TEmit); override;
    procedure add(itens: TStringList); override;
    function getTexto: TStringList;
    procedure Clear;

  end;
implementation


{ TTextoImpressaoEpson }

uses Util.Funcoes;

procedure TTextoImpressaoSerial.add(itens: TStringList);
begin
  Self.textoImpressao.AddStrings(itens);
end;

procedure TTextoImpressaoSerial.addCentralizado(texto: string);
begin
  Self.textoImpressao.Add(TCMDImpressao.cCmdFontePequena + TCMDImpressao.cCmdAlinhadoCentro + texto);
end;

procedure TTextoImpressaoSerial.addCodigoBarras(texto: string);
var
  FLinhaCmd: string;
begin

  FLinhaCmd := chr(29) + 'h' + chr(50) +
    chr(29) + 'w' + chr(2) +
    chr(29) + 'H0' +
    chr(29) + 'kI' + chr(24) + '{C' + AscToBcd(texto, 22);

  Self.textoImpressao.Add(FLinhaCmd);

end;

procedure TTextoImpressaoSerial.addColuna(textos: array of string;
  tamanhosPercent: array of Integer);
var
  coluna: string;
  I: Integer;
  tam: Integer;
  linha: string;
begin

  I := 0;
  coluna := textos[i];
  tam := trunc(TUtil.CalcularValorPercentual( self.Colunas,tamanhosPercent[i]));
  linha := Padr(coluna, tam, ' ');

  for I := 1 to Length(textos) - 2 do
  begin
    coluna := textos[i];
    tam := trunc(TUtil.CalcularValorPercentual( self.Colunas,tamanhosPercent[i]));
    linha := linha + Padr(coluna, tam, ' ');
  end;

  i := Length(textos) - 1;
  coluna := textos[i];
  tam := trunc(TUtil.CalcularValorPercentual( self.Colunas,tamanhosPercent[i]));
  linha := linha + Padl(coluna, tam, ' ');

  Self.textoImpressao.Add('<c>' + linha + '</ce>' + #10);

end;

procedure TTextoImpressaoSerial.addColunaValor(coluna: string; tamColuna: Integer; valor: string;
  separador: Char);
var
  // tamColuna: Integer;
  linha: string;
begin

  // tamColuna := Self.impressoraAtiva.Colunas - tamColuna;
  linha := Padr(coluna, tamColuna, separador) + valor;
  Self.textoImpressao.Add( TCMDImpressao.cCmdFontePequena + linha + TCMDImpressao.cCmdFonteNormal);

end;

function TTextoImpressaoSerial.PadL(texto: string; const Len: integer; const Ch: Char): string;
var
  LenS: integer;
begin
  LenS := Length(texto);
  if LenS < Len then
    Result := self.ReplicaChar(Ch, Len - LenS) + texto
  else
    Result := texto;
end;

function TTextoImpressaoSerial.PadR(texto: string; const Len: integer; const Ch: Char): string;
var
  LenS: integer;
begin
  LenS := Length(texto);
  if LenS < Len then
    Result := texto + self.ReplicaChar(Ch, Len - LenS)
  else
    Result := texto;
end;

function TTextoImpressaoSerial.ReplicaChar(const Ch: Char; const Len: integer): string;
var
  I: integer;
begin
  SetLength(Result, Len);
  for I := 1 to Len do
    Result[I] := Ch;
end;

procedure TTextoImpressaoSerial.addColunaValor(coluna, valor: string);
var
  // tamColuna: Integer;
  linha: string;
begin

  // tamColuna := Self.impressoraAtiva.Colunas - tamColuna;
  linha := Padr(coluna, GetColunasFonteCondensada - Length(valor) , ' ') + valor;
  Self.textoImpressao.Add( TCMDImpressao.cCmdFontePequena + linha + TCMDImpressao.cCmdFonteNormal);
end;

procedure TTextoImpressaoSerial.addNegritoCentralizado(texto: string);
begin

  Self.textoImpressao.Add(TCMDImpressao.cCmdFontePequena + TCMDImpressao.cCmdAlinhadoCentro + TCMDImpressao.cCmdImpNegrito + texto +
    TCMDImpressao.cCmdImpFimNegrito);

end;

procedure TTextoImpressaoSerial.addNegritoCentralizado(texto, comando: string);
begin

  Self.textoImpressao.Add(comando + TCMDImpressao.cCmdAlinhadoCentro + TCMDImpressao.cCmdImpNegrito + texto + TCMDImpressao.cCmdImpFimNegrito);

end;

procedure TTextoImpressaoSerial.addNegritoEsquerda(texto: string);
begin

  Self.textoImpressao.Add(TCMDImpressao.cCmdAlinhadoEsquerda + TCMDImpressao.cCmdImpNegrito + texto + TCMDImpressao.cCmdImpFimNegrito);

end;

procedure TTextoImpressaoSerial.addSeparador(carcater: Char; tam: integer);
var
  I: Integer;
  linha: string;
begin
  linha := '';
  for I := 0 to tam - 1 do
  begin
    linha := linha + carcater;
  end;

  Self.textoImpressao.Add(TCMDImpressao.cCmdFontePequena + TCMDImpressao.cCmdAlinhadoEsquerda + linha);

end;

procedure TTextoImpressaoSerial.addSeparador(carcater: Char);
var
  I: Integer;
  linha: string;
begin
  linha := '';

  linha := linha + carcater;
  Self.textoImpressao.Add(TCMDImpressao.cCmdFonteNormal + TCMDImpressao.cCmdAlinhadoEsquerda + linha);

end;

procedure TTextoImpressaoSerial.addTexto(texto: string);
begin

  Self.textoImpressao.Add(TCMDImpressao.cCmdAlinhadoEsquerda + TCMDImpressao.cCmdFontePequena + texto);

end;

procedure TTextoImpressaoSerial.addTexto(texto, comando: string);
begin
  Self.textoImpressao.Add(comando + texto);
end;

procedure TTextoImpressaoSerial.addTextoCentro(texto: string);
begin
  Self.textoImpressao.Add(TCMDImpressao.cCmdAlinhadoCentro + TCMDImpressao.cCmdFontePequena + texto);
end;

procedure TTextoImpressaoSerial.addTextoCentro(texto: string; separador: Char);
 var cmd: string;
begin
  cmd := TUtil.PadC(texto,GetColunasFonteNormal, separador);
  Self.textoImpressao.Add(TCMDImpressao.cCmdAlinhadoCentro + TCMDImpressao.cCmdFontePequena + cmd);

end;

procedure TTextoImpressaoSerial.addTextoCondensado(texto: string);
begin
  Self.textoImpressao.Add(TCMDImpressao.cCmdFontePequena + texto);
end;

procedure TTextoImpressaoSerial.Clear;
begin
  Self.textoImpressao.text := TCMDImpressao.cCmdImpZera +
    //  TCMDImpressao.cCmdEspacoLinha +
  TCMDImpressao.cCmdPagCod +
    TCMDImpressao.cCmdFonteNormal +
    TCMDImpressao.cCmdAlinhadoCentro;
end;

constructor TTextoImpressaoSerial.create();
begin
  inherited;
  Self.textoImpressao := TStringList.Create;
  Colunas := 45;
end;

function TTextoImpressaoSerial.ComandoEspacoEntreLinhas(Espacos: Byte): AnsiString;
begin
  if Espacos = 0 then
    Result := TCMDImpressao.EspacoEntreLinhasPadrao
  else
    Result := TCMDImpressao.EspacoEntreLinhas + AnsiChr(Espacos);
end;

function TTextoImpressaoSerial.ComandoLogo: AnsiString;
begin
  //  with fpPosPrinter.ConfigLogo do
  //  begin
  //    Result := GS + '(L' + #6 + #0 + #48 + #69 +
  //              AnsiChr(KeyCode1) + AnsiChr(KeyCode2) +
  //              AnsiChr(FatorX)   + AnsiChr(FatorY);
  //  end;
end;

function TTextoImpressaoSerial.ComandoPaginaCodigo(APagCodigo: TACBrPosPaginaCodigo
  ): AnsiString;
var
  CmdPag: Integer;
begin
  case APagCodigo of
    pc437: CmdPag := 0;
    pc850: CmdPag := 2;
    pc852: CmdPag := 18;
    pc860: CmdPag := 3;
    pc1252: CmdPag := 16;
  else
    begin
      Result := '';
      Exit;
    end;
  end;

  Result := TCMDImpressao.ESC + 't' + AnsiChr(CmdPag);
end;

procedure TTextoImpressaoSerial.GerarClicheEmpresa(emit: TEmit);
var
  Cmd, LinhaCmd: string;
begin
  Self.textoImpressao.Add(TCMDImpressao.cCmdImpZera + ComandoEspacoEntreLinhas(0) + ComandoPaginaCodigo(pc1252));

  if Length(Trim(emit.xNome)) > 48 then
    Cmd := TCMDImpressao.cCmdAlinhadoCentro + TCMDImpressao.cCmdFontePequena + TCMDImpressao.cCmdImpNegrito
  else
    Cmd := TCMDImpressao.cCmdAlinhadoCentro + TCMDImpressao.cCmdFonteNormal + TCMDImpressao.cCmdImpNegrito;

  Self.textoImpressao.Add(Cmd + emit.xNome + TCMDImpressao.cCmdImpFimNegrito);

  if Trim(emit.xFant) <> '' then
  begin
    if Length(Trim(emit.xFant)) > 48 then
      Cmd := TCMDImpressao.cCmdFontePequena + TCMDImpressao.cCmdImpNegrito
    else
      Cmd := TCMDImpressao.cCmdFonteNormal + TCMDImpressao.cCmdImpNegrito;

    Self.textoImpressao.Add(Cmd + emit.xFant + TCMDImpressao.cCmdImpFimNegrito);
  end;

  Self.textoImpressao.Add(TCMDImpressao.cCmdFontePequena + QuebraLinhas(
    Trim(emit.EnderEmit.xLgr) + ', ' +
    Trim(emit.EnderEmit.nro) + '  ' +
    Trim(emit.EnderEmit.xCpl) + '  ' +
    Trim(emit.EnderEmit.xBairro) + ' ' +
    Trim(emit.EnderEmit.xMun) + '/' + Trim(emit.EnderEmit.UF) + '  ' +
    'Cep:' + FormatarCEP(IntToStr(emit.EnderEmit.CEP)) + '  ' +
    'Tel:' + FormatarFone(emit.EnderEmit.fone)
    , GetColunasFonteCondensada)
    );

  LinhaCmd := 'CNPJ: ' + FormatarCNPJ(emit.CNPJCPF);
  if Trim(emit.IE) <> '' then
  begin
    LinhaCMd := PadSpace(LinhaCmd + '|' + 'IE: ' + FormatarIE(emit.IE, emit.EnderEmit.UF),
      GetColunasFonteCondensada, '|');
  end;

  Self.textoImpressao.Add(TCMDImpressao.cCmdFontePequena + TCMDImpressao.cCmdImpNegrito + LinhaCmd + TCMDImpressao.cCmdImpFimNegrito);

  if Trim(emit.IM) <> '' then
    Self.textoImpressao.Add(TCMDImpressao.cCmdFontePequena + TCMDImpressao.cCmdImpNegrito + 'IM: ' + emit.IM + TCMDImpressao.cCmdImpFimNegrito +
      TCMDImpressao.cCmdFonteNormal);

  Self.addSeparador('-', GetColunasFonteNormal);

end;

function TTextoImpressaoSerial.GetColunasFonteCondensada: Integer;
const
  Condensada = 0.75;
begin

  Result := trunc(48 / Condensada);
end;

function TTextoImpressaoSerial.GetColunasFonteNormal: Integer;
const
  Expandida = 2;
begin

  Result := trunc(48 + 16);
end;

function TTextoImpressaoSerial.getTexto: TStringList;
begin
  Result := Self.textoImpressao;
end;

procedure TTextoImpressaoSerial.Guilhotina(espacos: Integer);
var
  I: Integer;
begin

  for I := 0 to espacos - 1 do
    Self.textoImpressao.Add(TCMDImpressao.cCmdFonteNormal + ' ');

  self.textoImpressao.Add(TCMDImpressao.cCmdCortaPapel);

end;

end.

