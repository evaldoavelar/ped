unit Util.Funcoes;

interface

uses System.Classes, System.MaskUtils, System.SysUtils,
  System.DateUtils, Util.Exceptions;

type

  TStrArray = array of string;

  TUtil = class
  private

  public

    class function FirstDayOfWeek(Date: TDateTime): TDateTime; static;
    class function LastDayOfWeek(Date: TDateTime): TDateTime; static;

    class function FirstDayOfMonth(Date: TDateTime): TDateTime; static;
    class function LastDayOfMonth(Date: TDateTime): TDateTime; static;
    class function Truncar(Valor: currency; casas: Integer): currency; static;

    class function DiretorioApp: string;
    class function CalcularValorPercentual(Valor, Percent: Integer): Integer; static;
    class function PadC(vstring: string; const Len: Integer; const Ch: Char): string; static;
    class function PadR(const s: String; const Len: Integer; const Ch: Char): String; static;
    class function PadL(const s: String; const Len: Integer; const Ch: Char): String; static;
    class function ReplicaChar(const Ch: Char; const Len: Integer): string; static;

    class function ExtrairNumeros(AString: string): string; static;
    class function MAskCNPJCpf(cpfcnpj: string): string;
    class procedure ValidaCNPJCNPF(cpfcnpj: string);
    class function MaskTelefone(telefone: string): string;
    class function Explode(var AFields: TStrArray; ADelimiter, ATexto: String): Integer; overload;
    class function Explode(value: string; const Ch: Char): TStringList; overload;

    class function UStrToCurrDef(value: string): currency;
    class function UStrToCurrFloat(value: string): currency;
    class function UStrToIntDef(value: string): currency;

    // class procedure AlteraComponentsColor()

    class procedure ReplaceTimer(value: TDateTime); overload; static;
    class function ReplaceTimer(value: TDateTime; Hour, Min, Sec, MSec: Word): TDateTime; overload; static;
    class function ValidaCPF(cpfcnpj: string): Boolean;
    class function ValidaCNPJ(CNPJ: string): Boolean; static;
    class function IFF<T>(aExpressao: Boolean; aResultFalse, aResultTrue: T): T; static;

  end;

implementation

uses
  System.StrUtils;

{ TUtil }

class function TUtil.ValidaCPF(cpfcnpj: string): Boolean;
var
  i: Integer;
  Want: Char;
  Wvalid: Boolean;
  Wdigit1, Wdigit2: Integer;

begin

  if cpfcnpj = '' then
  begin
    Result := False;
    Exit;
  end;

  Wdigit1 := 0;
  Wdigit2 := 0;
  Want := cpfcnpj[1]; // variavel para testar se o cpfcnpj é repetido como 111.111.111-11
  Delete(cpfcnpj, ansipos('.', cpfcnpj), 1); // retira as mascaras se houver
  Delete(cpfcnpj, ansipos('.', cpfcnpj), 1);
  Delete(cpfcnpj, ansipos('-', cpfcnpj), 1);

  if Length(cpfcnpj) <> 11 then
  begin
    Result := False;
    Exit;
  end;

  // testar se o cpfcnpj é repetido como 111.111.111-11
  for i := 1 to Length(cpfcnpj) do
  begin
    if cpfcnpj[i] <> Want then
    begin
      Wvalid := True; // se o cpfcnpj possui um digito diferente ele passou no primeiro teste
      Break
    end
    else
      Wvalid := False;
  end;
  // se o cpfcnpj é composto por numeros repetido retorna falso
  if Wvalid = False then
  begin
    Result := False;
    Exit;
  end;

  // executa o calculo para o primeiro verificador
  for i := 1 to 9 do
  begin
    Wdigit1 := Wdigit1 + (StrToInt(cpfcnpj[10 - i]) * (i + 1));
  end;

  // Wdigit1 :=( (  (11 – (Wdigit1 mod 11) ) mod 11) mod 10 );
  Wdigit1 := (((11 - (Wdigit1 mod 11)) mod 11) mod 10);

  // verifica se o 1° digito confere
  if IntToStr(Wdigit1) <> cpfcnpj[10] then
  begin
    Result := False;
    Exit;
  end;

  for i := 1 to 10 do
  begin
    Wdigit2 := Wdigit2 + (StrToInt(cpfcnpj[11 - i]) * (i + 1));
  end;
  Wdigit2 := (((11 - (Wdigit2 mod 11)) mod 11) mod 10);
  { formula do segundo verificador
    soma=1°*2+2°*3+3°*4.. até 10°*11
    digito1 = 11 – soma mod 11
    se digito > 10 digito1 =0
  }

  // confere o 2° digito verificador
  if IntToStr(Wdigit2) <> cpfcnpj[11] then
  begin
    Result := False;
    Exit;
  end;

  // se chegar até aqui o cpf é valido
  Result := True;
end;

class function TUtil.ValidaCNPJ(CNPJ: string): Boolean;
var
  dg1, dg2: Integer;
  x, total: Integer;
  ret: Boolean;
begin
  ret := False;

  // Analisa os formatos
  if Length(CNPJ) = 18 then
    if (Copy(CNPJ, 3, 1) + Copy(CNPJ, 7, 1) + Copy(CNPJ, 11, 1) + Copy(CNPJ, 16, 1) = '../-') then
    begin
      CNPJ := Copy(CNPJ, 1, 2) + Copy(CNPJ, 4, 3) + Copy(CNPJ, 8, 3) + Copy(CNPJ, 12, 4) + Copy(CNPJ, 17, 2);
      ret := True;
    end;
  if Length(CNPJ) = 14 then
  begin
    ret := True;
  end;
  // Verifica
  if ret then
  begin
    try
      // 1° digito
      total := 0;
      for x := 1 to 12 do
      begin
        if x < 5 then
          inc(total, StrToInt(Copy(CNPJ, x, 1)) * (6 - x))
        else
          inc(total, StrToInt(Copy(CNPJ, x, 1)) * (14 - x));
      end;
      dg1 := 11 - (total mod 11);
      if dg1 > 9 then
        dg1 := 0;
      // 2° digito
      total := 0;
      for x := 1 to 13 do
      begin
        if x < 6 then
          inc(total, StrToInt(Copy(CNPJ, x, 1)) * (7 - x))
        else
          inc(total, StrToInt(Copy(CNPJ, x, 1)) * (15 - x));
      end;
      dg2 := 11 - (total mod 11);
      if dg2 > 9 then
        dg2 := 0;
      // Validação final
      if (dg1 = StrToInt(Copy(CNPJ, 13, 1))) and (dg2 = StrToInt(Copy(CNPJ, 14, 1))) then
        ret := True
      else
        ret := False;
    except
      ret := False;
    end;
    // Inválidos
    case AnsiIndexStr(CNPJ, ['00000000000000', '11111111111111', '22222222222222', '33333333333333', '44444444444444',
      '55555555555555', '66666666666666', '77777777777777', '88888888888888', '99999999999999']) of

      0 .. 9:
        ret := False;

    end;
  end;
  Result := ret;

end;

class function TUtil.IFF<T>(aExpressao: Boolean; aResultFalse, aResultTrue: T): T;
begin
  if (aExpressao) then
  begin
    Result := aResultTrue
  end
  else
  begin
    Result := aResultFalse
  end;
end;

class function TUtil.Explode(value: string; const Ch: Char): TStringList;
var
  c: Word;
  Source: string;
begin
  Result := TStringList.Create;
  c := 0;

  Source := value;
  while Source <> '' do
  begin
    if Pos(Ch, Source) > 0 then
    begin
      Result.ADD(Copy(Source, 1, Pos(Ch, Source) - 1));
      Delete(Source, 1, Length(Result[c]) + Length(Ch));
    end
    else
    begin
      Result.ADD(Source);
      Source := '';
    end;
    inc(c);
  end;
end;

class procedure TUtil.ReplaceTimer(value: TDateTime);
var
  newTime: TDateTime;
begin
  newTime := EncodeTime(0, 0, 0, 0);
  ReplaceTime(value, newTime);
end;

class function TUtil.ExtrairNumeros(AString: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(AString) do
    if (AString[i] in ['0' .. '9']) then
    begin
      Result := Result + AString[i];
    end;
end;

class function TUtil.Explode(var AFields: TStrArray; ADelimiter, ATexto: String): Integer;
var
  sTexto: String;
begin
  Result := 0;
  sTexto := ATexto + ADelimiter;
  if Copy(sTexto, 1, 1) = ADelimiter then
    Delete(sTexto, 1, 1);
  repeat
    SetLength(AFields, Length(AFields) + 1);
    AFields[Result] := Copy(sTexto, 0, Pos(ADelimiter, sTexto) - 1);
    Delete(sTexto, 1, Length(AFields[Result] + ADelimiter));
    inc(Result);
  until (sTexto = '');
end;

class function TUtil.FirstDayOfMonth(Date: TDateTime): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(Date, Year, Month, Day);
  Result := EncodeDate(Year, Month, 1);
end;

class function TUtil.FirstDayOfWeek(Date: TDateTime): TDateTime;
begin
  Result := StartOfTheWeek(Date);
end;

class function TUtil.LastDayOfMonth(Date: TDateTime): TDateTime;
begin
  Result := EndOfTheMonth(now);
end;

class function TUtil.LastDayOfWeek(Date: TDateTime): TDateTime;
begin
  Result := EndOfTheWeek(Date);
end;

class function TUtil.MAskCNPJCpf(cpfcnpj: string): string;
var
  vTam, xx: Integer;
  vDoc: string;
begin
  vTam := Length(cpfcnpj);
  for xx := 1 to vTam do
    if (Copy(cpfcnpj, xx, 1) <> '.') and (Copy(cpfcnpj, xx, 1) <> '-') and (Copy(cpfcnpj, xx, 1) <> '/') then
      vDoc := vDoc + Copy(cpfcnpj, xx, 1);
  cpfcnpj := vDoc;
  vTam := Length(cpfcnpj);
  vDoc := '';
  vDoc := '';
  for xx := 1 to vTam do
  begin
    vDoc := vDoc + Copy(cpfcnpj, xx, 1);
    if vTam = 11 then
    begin
      if (xx in [3, 6]) then
        vDoc := vDoc + '.';
      if xx = 9 then
        vDoc := vDoc + '-';
    end;
    if vTam = 14 then
    begin
      if (xx in [2, 5]) then
        vDoc := vDoc + '.';
      if xx = 8 then
        vDoc := vDoc + '/';
      if xx = 12 then
        vDoc := vDoc + '-';
    end;
  end;
  Result := vDoc;
end;

class function TUtil.MaskTelefone(telefone: string): string;
begin
  Result := FormatMaskText('\(00\)0000-0000;0;_', telefone);
end;

class function TUtil.DiretorioApp: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

class function TUtil.Truncar(Valor: currency; casas: Integer): currency;
var
  stValor: string;
begin
  stValor := CurrToStr(Valor);
  if Pos(FormatSettings.DecimalSeparator, stValor) = 0 then
    stValor := stValor + FormatSettings.DecimalSeparator;
  stValor := stValor + '0000';
  stValor := Copy(stValor, 1, Pos(FormatSettings.DecimalSeparator, stValor) + casas);
  Result := StrToCurr(stValor);
end;

class procedure TUtil.ValidaCNPJCNPF(cpfcnpj: string);
begin

end;

class function TUtil.CalcularValorPercentual(Valor: Integer; Percent: Integer): Integer;
begin
  Result := Trunc(((Percent * Valor) / 100));
end;

class function TUtil.ReplaceTimer(value: TDateTime; Hour, Min, Sec,
  MSec: Word): TDateTime;
var
  newTime: TDateTime;
begin
  newTime := EncodeTime(Hour, Min, Sec, MSec);
  ReplaceTime(value, newTime);

  Result := value;
end;

class function TUtil.ReplicaChar(const Ch: Char; const Len: Integer): string;
var
  i: Integer;
begin
  SetLength(Result, Len);
  for i := 1 to Len do
    Result[i] := Ch;
end;

class function TUtil.UStrToCurrDef(value: string): currency;
begin
  try
    Result := StrToCurr(value);
  except
    on E: Exception do
      raise TValidacaoException.Create(value + ' não é um numero válido');
  end;
end;

class function TUtil.UStrToCurrFloat(value: string): currency;
begin
  try
    Result := StrToFloat(value);
  except
    on E: Exception do
      raise TValidacaoException.Create(value + ' não é um numero inteiro válido');
  end;
end;

class function TUtil.UStrToIntDef(value: string): currency;
begin
  try
    Result := StrToInt(value);
  except
    on E: Exception do
      raise TValidacaoException.Create(value + ' não é um numero inteiro válido');
  end;
end;

class function TUtil.PadC(vstring: string; const Len: Integer; const Ch: Char): string;
var
  i, J: Integer;
  Pad: string;
  Impar: Boolean;
begin
  i := Length(vstring);
  if i < Len then
  begin
    J := Len - i;
    Impar := J mod 2 = 1;
    J := J div 2;
    Pad := TUtil.ReplicaChar(Ch, J);
    Result := Pad + vstring + Pad;
    if Impar then
      Result := Result + Ch;
  end
  else if i > Len then
  begin
    J := i - Len;
    Impar := J mod 2 = 1;
    J := J div 2;
    Result := vstring;
    Delete(Result, i - J + 1, J);
    Delete(Result, 1, J);
    if Impar then
    begin
      Dec(i, J * 2);
      Delete(Result, i, 1);
    end;
  end
  else
    Result := vstring;
end;

class function TUtil.PadR(const s: String; const Len: Integer; const Ch: Char): String;
var
  LenS: Integer;
begin
  LenS := Length(s);
  if LenS < Len then
    Result := s + TUtil.ReplicaChar(Ch, Len - LenS)
  else if LenS > Len then
    Result := Copy(s, 1, Len)
  else
    Result := s;
end;

class function TUtil.PadL(const s: String; const Len: Integer; const Ch: Char): String;
var
  LenS: Integer;
begin
  LenS := Length(s);
  if LenS < Len then
    Result := TUtil.ReplicaChar(Ch, Len - LenS) + s
  else if LenS > Len then
    Result := Copy(s, LenS - Len + 1, Len)
  else
    Result := s;
end;

end.
