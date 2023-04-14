unit Util.TCript;

interface

uses System.Classes, System.SysUtils,
  DCPrc4, DCPsha1;

type

  TCript = class
  private
    class function StringCripty(chave: string; buffer: string; Cript: Boolean): string;
  public
    class function StringDescripty(chave, buffer: string): string; static;
    class function StringEncripty(chave, buffer: string): string; static;

  end;

implementation



class function TCript.StringCripty(chave: string; buffer: string; Cript: Boolean): string;
var
  Cipher: TDCP_rc4;
begin
  if buffer = '' then
    Exit;
  Cipher := TDCP_rc4.Create(nil);
  Cipher.InitStr(chave, TDCP_sha1);
  // initialize the cipher with a hash of the passphrase[
  if Cript then // se true criptografar
    Result := Cipher.EncryptString(buffer)
  else
    Result := Cipher.DecryptString(buffer);
  Cipher.Burn;
  Cipher.free;

end;

class function TCript.StringDescripty(chave: string; buffer: string): string;
begin
  Result := StringCripty(chave, buffer, False);
end;



class function TCript.StringEncripty(chave: string; buffer: string): string;
begin
  Result := StringCripty(chave, buffer, True);
end;


end.
