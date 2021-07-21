unit Util.VclFuncoes;

interface

uses System.Classes, System.MaskUtils, System.SysUtils,
  System.DateUtils, Winapi.Windows, Winapi.ImageHlp,
  Vcl.Controls, Vcl.Forms, DCPrc4, DCPbase64, DCPsha1;

type

  TVclFuncoes = class
    class function VersaoEXE: string;
    class function CompararVersao(const versao1, versao2: TFileName): Integer; static;
    class procedure DisableVclStyles(Control: TControl; const ClassToIgnore: string);
    class function DataCriacaoAplicacao: TDate;
  end;

implementation

class function TVclFuncoes.DataCriacaoAplicacao: TDate;
var
  LI: TLoadedImage;
begin
  Win32Check(MapAndLoad(PAnsiChar(AnsiString(Application.ExeName)), nil, @LI, False, True));
  Result := LI.FileHeader.FileHeader.TimeDateStamp / SecsPerDay +
    UnixDateDelta;
  UnMapAndLoad(@LI);
end;

class function TVclFuncoes.CompararVersao(const versao1: TFileName; const versao2: TFileName): Integer;
var
  Items1: TStrings;
  Items2: TStrings;
  i: Integer;
  e1: Integer;
  e2: Integer;
begin
  Result := 0;
  Items1 := TStringList.Create;
  Items2 := TStringList.Create;
  try
    Items1.Delimiter := '.';
    Items1.DelimitedText := versao1;
    Items2.Delimiter := '.';
    Items2.DelimitedText := versao2;
    if Items1.Count <> Items2.Count then
      raise Exception.Create('Não é possível comparar as versões, numero de pontos diverge!');
    Result := 0;
    for i := 0 to Items1.Count - 1 do
    begin
      e1 := StrToIntDef(Items1[i], -1);
      e2 := StrToIntDef(Items2[i], -1);
      if e2 > e1 then
        Result := 1
      else if e2 < e1 then
        Result := -1;
      if Result <> 0 then
        Exit;
    end;
  finally
    Items1.free;
    Items2.free;
  end;
end;

class procedure TVclFuncoes.DisableVclStyles(Control: TControl; const ClassToIgnore: string);
var
  i: Integer;
begin
  if Control = nil then
    Exit;

  if Control.ClassNameIs(ClassToIgnore) then
    Control.StyleElements := [];

  if Control is TWinControl then
    for i := 0 to TWinControl(Control).ControlCount - 1 do
      DisableVclStyles(TWinControl(Control).Controls[i], ClassToIgnore);

end;

class function TVclFuncoes.VersaoEXE: string;
var
  VerInfoSize: Cardinal;
  VerValueSize: Cardinal;
  Dummy: Cardinal;
  PVerInfo: Pointer;
  PVerValue: PVSFixedFileInfo;
  Arquivo: string;
begin

  Result := '';

  Arquivo := Application.ExeName;
  VerInfoSize := GetFileVersionInfoSize(PWideChar(Arquivo), Dummy);
  GetMem(PVerInfo, VerInfoSize);
  try
    if GetFileVersionInfo(PChar(Arquivo), 0, VerInfoSize, PVerInfo) then
      if VerQueryValue(PVerInfo, '\', Pointer(PVerValue), VerValueSize) then
        with PVerValue^ do
          Result := Format('%d.%d.%d.%d', [
            HiWord(dwFileVersionMS), // Major
            LoWord(dwFileVersionMS), // Minor
            HiWord(dwFileVersionLS), // Release
            LoWord(dwFileVersionLS)]); // Build
  finally
    FreeMem(PVerInfo, VerInfoSize);
  end;

end;

end.
