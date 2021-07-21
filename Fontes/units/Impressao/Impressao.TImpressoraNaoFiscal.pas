unit Impressao.TImpressoraNaoFiscal;

interface

uses SysUtils, Classes, Dialogs,
   ACBrDevice, ACBrValidador, ACBrPosPrinter, ACBrUtil, pcnNFe,
   Impressao.TTextoImpressao,Impressao.TEpson  ;

type
  TImpressoraNaoFiscal = class
  private
    FDevice: TACBrDevice;
    iRetorno: Integer;
  public
    Texto: TTextoImpressao;
    function imprimir: Integer;
    constructor create( FDevice: TACBrDevice);
  end;

implementation

{ TImpressoraNaoFiscal }



constructor TImpressoraNaoFiscal.create( FDevice: TACBrDevice);
begin

  Texto := TTextoImpressaoSerial.create();

  FDevice := FDevice;

end;

function TImpressoraNaoFiscal.imprimir: Integer;
begin
  // showmessage(Texto.Text);
  try
    FDevice.Ativar;
    FDevice.Serial.Purge;
    FDevice.EnviaString(Texto.getTexto.Text);

    if FDevice.EmLinha(5000) then
      Result := 1
    else
      Result := 0;

  finally
    FDevice.Desativar;
  end;

end;

end.
