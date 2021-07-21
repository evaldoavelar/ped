unit Util.TSerial;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils;

type

  TDefRec = record
    FieldName: string;
    FieldValue: string;
    FieldLength: integer;
    MaxFieldLength: integer;
    VariableFlag: boolean;
  end;

  TSerial = class
  strict private
    Definerecs, Datarecs: array of TDefRec;
    keylist: TStringlist;

    EncryptKeys: TStringlist;
    err: string;
  private

    procedure MakeEncDec;
    function MakeDatarecs: boolean;
    procedure Shuffle(var deck: string);

  public
    SeedNumber: integer;
    NbrSegsEdt: integer;
    SegSizeEdt: integer;
    DataField: TStringlist;
    DefField: TStringlist;

    function MakeLicense: string;
    function Decrypt(s: string): string;

    constructor create;
    destructor destroy;override;
  end;

var
  masterkey: string = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  encryptkey: string;

implementation

{ TSerial }

constructor TSerial.create;
begin
  keylist := TStringlist.create;;
  EncryptKeys := TStringlist.create;
  DefField := TStringlist.create;
  DataField := TStringlist.create;
  SeedNumber := RandSeed;

  NbrSegsEdt := 1;
  SegSizeEdt := 6;
  encryptkey := '6WPSJD580OATR3BZKYIGV91CXE27NUMLHQ4F';
  EncryptKeys.add(masterkey);
  EncryptKeys.add(encryptkey);
end;

destructor TSerial.destroy;
begin
  FreeAndNil(keylist);
  FreeAndNil(EncryptKeys);
  FreeAndNil(DefField);
  FreeAndNil(DataField);

  inherited;
end;

procedure TSerial.MakeEncDec;
Var
  i: integer;
begin
  encryptkey := masterkey;
  for i := 1 to 3 do
    Shuffle(encryptkey);
  keylist.clear;
  for i := 1 to length(encryptkey) do
    keylist.add(masterkey[i]);
  with EncryptKeys do
  begin
    clear;
    add(masterkey);
    add(encryptkey);
  end;
end;

procedure TSerial.Shuffle(var deck: string);
var
  i, n: integer;
  temp: Char;
begin
  i := length(deck);
  while i > 1 do
  begin
    n := random(i) + 1;
    temp := deck[i];
    deck[i] := deck[n];
    deck[n] := temp;
    dec(i);
  end;

end;

function TSerial.MakeDatarecs: boolean;

{ ------------ IsValidDef -------------- }
  function IsvalidDef(var err: string): boolean;
  var
    i, vspace: integer;
    s2: string;

  begin
    err := '';

    result := true;
    setlength(Definerecs, DefField.count);
    for i := 0 to DefField.count - 1 do
      with DefField, Definerecs[i] do
      begin
        if (length(names[i]) = 0) or (length(values[names[i]]) = 0) then
        begin
          err := 'Invalid field definition:' + DefField[i];
          result := false;
          exit;
        end;
        FieldName := names[i];
        s2 := values[FieldName];
        if s2[1] = 'V' then
        begin
          vspace := 1;
          VariableFlag := true;
          System.delete(s2, 1, 1);
        end
        else
        begin
          VariableFlag := false;
          vspace := 0;
        end;
        MaxFieldLength := strtointdef(s2, 0);

        if (MaxFieldLength = 0) or (upcase(s2[1]) = 'X')
        { a leading "X" would have converted the number as hexadecimal! }
        then
        begin
          err := format('Invalid field length: %s', [s2]);
          result := false;
          exit;
        end;
        inc(MaxFieldLength, vspace);
      end;
  end; { IsValidDef }

var
  i, j: integer;
  s: string;
  err: string;
  OK: boolean;
begin
  if (not IsvalidDef(err)) then
  begin
    raise Exception.create(err);
  end;

  result := true;
  { defs look OK, continue }

  setlength(Datarecs, DataField.count);
  s := '';
  for i := 0 to DataField.count - 1 do
  begin
    Datarecs[i].FieldName := DataField.names[i];
    { find the defrec entry }
    OK := false;
    for j := 0 to high(Definerecs) do
    begin
      if Uppercase(Definerecs[j].FieldName) = Uppercase(Datarecs[i].FieldName) then
      begin
        Datarecs[i].MaxFieldLength := Definerecs[j].MaxFieldLength;
        Datarecs[i].VariableFlag := Definerecs[j].VariableFlag;
        OK := true;
        break;
      end;
    end;
    if not OK then
    begin
      raise Exception.create('Data field line: "' + DataField[i] + '" not defined.');
    end;

    Datarecs[i].FieldValue := Trim(Uppercase(DataField.values[Datarecs[i].FieldName]));

{$IF defined(ANDROID)}
    for j := length(Datarecs[i].FieldValue) - 1 downto 0 do
{$ELSE}
    for j := length(Datarecs[i].FieldValue) downto 1 do
{$ENDIF}
    begin
      if not(Datarecs[i].FieldValue[j] in ['A' .. 'Z', '0' .. '9']) then
      begin
        if not Datarecs[i].VariableFlag then
        begin
          raise Exception.create(format('Note: Fixed length field %s contains illegal character "%s"'
            + #13 + 'Replaced with "X"', [Datarecs[i].FieldName, Datarecs[i].FieldValue[j]]));
        end
        else
        begin
          s := '"' + Datarecs[i].FieldValue[j] + '", ' + s;
          System.delete(Datarecs[i].FieldValue, j, 1);
        end;
      end;
    end;
    Datarecs[i].FieldLength := length(Datarecs[i].FieldValue);
    if Datarecs[i].FieldLength > Datarecs[i].MaxFieldLength then
    begin { truncate long fields }
      Datarecs[i].FieldLength := Datarecs[i].MaxFieldLength;
      Datarecs[i].FieldValue := copy(Datarecs[i].FieldValue, 1, Datarecs[i].FieldLength);
    end
    else if (not Datarecs[i].VariableFlag) and (Datarecs[i].FieldLength < Datarecs[i].MaxFieldLength) then
    begin { pad fixed length fields to fieldlength }
      Datarecs[i].FieldValue := Datarecs[i].FieldValue + DupeString('X', Datarecs[i].MaxFieldLength - Datarecs[i].FieldLength);
      Datarecs[i].FieldLength := Datarecs[i].MaxFieldLength;
    end;
  end;
  (*
    If s<>'' then showmessage
    ('Note: Special character(s) '+s+' deleted from variable length fields');
  *)
  result := true;
end;

function TSerial.MakeLicense: string;
var
  i, j, index: integer;
  // list:TStrings;
  s: string;
  encrypteddata: string;
  segs, size: integer;
begin
  // self.MakeEncDec;

  if not MakeDatarecs then
    exit; { errors found and reported }
  keylist.clear;
  if length(encryptkey) <> 36 then
  begin
    raise Exception.create('Make encryption key first');
  end;
  for i := 1 to length(encryptkey) do
    keylist.add(masterkey[i]);

  for i := 0 to high(Datarecs) do
    with Datarecs[i] do
    begin
      If VariableFlag then
      begin
        index := MaxFieldLength - length(FieldValue); { this is where to continue with the real data }
        { index is also 1 greater than the number of ranm "filler" characxters to insert }
        encrypteddata := encrypteddata + Char(ord('A') + index - 1);
        { fill unused with random characters }
        for j := 1 to index - 1 do
          encrypteddata := encrypteddata + encryptkey[random(36) + 1];
      end;
{$IF defined(ANDROID)}
      for j := 0 to length(FieldValue) do
{$ELSE}
      for j := 1 to length(FieldValue) do
{$ENDIF}
      begin
        index := keylist.indexof(FieldValue[j]);
        if index >= 0 then
          encrypteddata := encrypteddata + Trim(encryptkey[index + 1]);
      end;
    end;

  segs := NbrSegsEdt;
  size := SegSizeEdt;
  result := '';

  if segs * size = length(encrypteddata) then
  begin
    for i := 0 to segs - 1 do
    begin
      result := result + Trim(copy(encrypteddata, i * size + 1, size)) + '-';
    end;
    delete(result, length(result), 1); { delete te extra [-] }
  end
  else
  begin
    if length(Definerecs) = 0 then
      raise Exception.create('Make Encryption key first!')
    else
      raise Exception.create(format('Sum of field lengths plus count of variable fields (%d) '
        + 'must = nbr. of segments X segement size (%d)', [length(encrypteddata), segs * size]));
  end;
end;

function TSerial.Decrypt(s: string): string;
var
  decryptdata: string;
  i, j, index, len: integer;
begin

  keylist.clear;
  for i := 1 to length(encryptkey) do
    keylist.add(encryptkey[i]);

  for j := 1 to length(s) do
  begin
    index := keylist.indexof(s[j]);
    if index >= 0 then
      decryptdata := decryptdata + masterkey[index + 1]
    else
      decryptdata := decryptdata + s[j];
  end;
  result := decryptdata;

end;

end.
