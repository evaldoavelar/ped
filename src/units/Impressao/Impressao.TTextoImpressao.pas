unit Impressao.TTextoImpressao;

interface


uses  ACBrUtil, pcnNFe, Classes;

type

  TCMDImpressao = class
  const
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
    cCmdImpZera = #27 + '@';
    cCmdEspacoLinha = #27 + '3' + #14;
    cCmdPagCod = #27 + 't' + #39;
    cCmdImpNegrito = #27 + 'E1';
    cCmdImpFimNegrito = #27 + 'E2';
    cCmdImpExpandido = #29 + '!' + #16;
    cCmdImpFimExpandido = #29 + '!' + #0;
    cCmdFonteNormal = #27 + 'M0';
    cCmdFontePequena = #27 + 'M1';
    cCmdAlinhadoEsquerda = #27 + 'a0';
    cCmdAlinhadoCentro = #27 + 'a1';
    cCmdAlinhadoDireita = #27 + 'a2';
    cCmdCortaPapel = #29 + 'V1';
    EspacoEntreLinhasPadrao = ESC + '2';
    EspacoEntreLinhas = ESC + '3';
  end;

  TTextoImpressao = class
  protected
    textoImpressao: TStringList;

  public
    Colunas: Integer;
    constructor create(); virtual;
    procedure addNegritoCentralizado(texto: string); overload; virtual; abstract;
    procedure addNegritoEsquerda(texto: string); overload; virtual; abstract;
    procedure addNegritoCentralizado(texto: string; comando: string); overload; virtual; abstract;
    procedure addSeparador(carcater: Char); overload; virtual; abstract;
    procedure addSeparador(carcater: Char; tam: integer); overload; virtual; abstract;
    procedure addColuna(textos: array of string; tamanhosPercent: array of Integer); virtual; abstract;
    procedure addTexto(texto: string); overload; virtual; abstract;
    procedure addTexto(texto: string; comando: string); overload; virtual; abstract;
    procedure addTextoCondensado(texto: string); virtual; abstract;
    procedure addTextoCentro(texto: string);overload; virtual; abstract;
    procedure addTextoCentro(texto: string;separador: Char);overload;   virtual; abstract;
    procedure addCentralizado(texto: string); virtual; abstract;
    procedure addColunaValor(coluna: string; valor: string); overload; virtual; abstract;
    procedure addColunaValor(coluna: string; tamColuna: Integer; valor: string; separador: Char); overload; virtual; abstract;
    procedure addCodigoBarras(texto: string); overload; virtual; abstract;
    procedure GerarClicheEmpresa(emit: TEmit); virtual; abstract;
    procedure Guilhotina(espacos: Integer); virtual; abstract;
    procedure add(itens: TStringList); virtual; abstract;
    function getTexto: TStringList;
    procedure Clear;

  end;
implementation

{ TTextoImpressao }

procedure TTextoImpressao.Clear;
begin
  textoImpressao.Clear;
end;

constructor TTextoImpressao.create;
begin
  textoImpressao := TStringList.Create;
end;

function TTextoImpressao.getTexto: TStringList;
begin
  result := textoImpressao;
end;

end.

