unit Relatorio.TRSangriaSuprimento;

interface

uses
  ACBrUtil, System.SysUtils,
  System.Generics.Collections, Dominio.Entidades.TSangriaSuprimento.Tipo,
  Relatorio.TRBase, Data.DB, Dominio.Entidades.TSangriaSuprimento,
  Dominio.Entidades.TEmitente, Dominio.Entidades.TVendedor;

type

  TRSangriaSuprimento = class(TRBase)
  strict private
  private
    procedure Assinatura(vendedor: TVendedor; Emitente: TEmitente);
    procedure Descricao(SangriaSuprimento: TSangriaSuprimento; vendedor: TVendedor);

  public
    procedure Imprime(SangriaSuprimento: TSangriaSuprimento; vendedor: TVendedor; Emitente: TEmitente); overload;
  end;

implementation

uses
  Util.Funcoes;

{ TRVendasDoDia }

procedure TRSangriaSuprimento.Assinatura(vendedor: TVendedor; Emitente: TEmitente);
var
  LinhaCmd: string;
begin
  Buffer.Add(escNewLine);

  LinhaCmd := escAlignCenter + esc20Cpi +
    '_____________________________________________________';
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn +
    'ASSINATURA DO VENDEDOR';
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOff + Emitente.CIDADE + ', ' +
    FormatDateTime('dddd d mmmm yyyy', now);
  Buffer.Add(LinhaCmd);
end;

procedure TRSangriaSuprimento.Descricao(SangriaSuprimento: TSangriaSuprimento;
  vendedor: TVendedor);

var
  Titulo: string;
  sinal: string;
  LinhaCmd: string;
begin

  Titulo := TUtil.IFF<string>(
    SangriaSuprimento.TipoSangriaSuprimento = TSangriaSuprimentoTipo.Sangria,
    'SUPRIMENTO',
    'SANGRIA');

  sinal := TUtil.IFF<string>(
    SangriaSuprimento.TipoSangriaSuprimento = TSangriaSuprimentoTipo.Sangria,
    '+',
    '-');

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'Comprovante de Sangria/Suprimento' + escBoldOff;
  Buffer.Add(LinhaCmd);

  if Assigned(vendedor) then
  begin
    Buffer.Add(esc20Cpi + PadSpace('Vendedor: ' + vendedor.CODIGO + '  ' +
      vendedor.NOME, Self.ColunasFonteCondensada, '|'));
  end;

  LinhaCmd := escAlignLeft + esc20Cpi +
    'Data: ' + FormatDateTime('dd/mm/yyyy', SangriaSuprimento.Data);
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignLeft + esc20Cpi +
    'Emissão: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', now);
  Buffer.Add(LinhaCmd);

  Buffer.Add(Self.LinhaSimples);
  Buffer.Add('');
  Buffer.Add(esc20Cpi + PadSpace(Titulo + '|' + sinal + 'R$ ' + FormatFloatBr(SangriaSuprimento.Valor, '###,###,##0.00'),
    Self.ColunasFonteCondensada, '|'));
  Buffer.Add('');
  Buffer.Add(SangriaSuprimento.HISTORICO);
end;

procedure TRSangriaSuprimento.Imprime(SangriaSuprimento: TSangriaSuprimento;
  vendedor: TVendedor; Emitente: TEmitente);
begin
  Self.Cabecalho(Emitente);
  Self.Descricao(SangriaSuprimento, vendedor);
  Self.Assinatura(vendedor, Emitente);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

end.
