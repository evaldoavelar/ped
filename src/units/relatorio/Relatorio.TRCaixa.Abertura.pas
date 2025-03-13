unit Relatorio.TRCaixa.Abertura;

interface

uses
  ACBrUtil, System.SysUtils,
  System.Generics.Collections,
  Relatorio.TRBase, Data.DB,
  Dominio.Entidades.TEmitente, Dominio.Entidades.TVendedor;

type

  TRCaixaAbertura = class(TRBase)
  strict private
  private
    procedure Totalizadores(Totalizadores: TList < TPair < string, string >> );
    procedure Assinatura(vendedor: TVendedor; Emitente: TEmitente);
    procedure Descricao(Titulo: string; Data: TDate; vendedor: TVendedor);

  public
    procedure Imprime(Data: TDate; vendedor: TVendedor; Emitente: TEmitente; Totalizadores: TList < TPair < string, string >> ); overload;
  end;

implementation

{ TRVendasDoDia }

procedure TRCaixaAbertura.Imprime(Data: TDate; vendedor: TVendedor; Emitente: TEmitente; Totalizadores: TList < TPair < string, string >> );
begin
  Self.Cabecalho(Emitente);
  Self.Descricao('ABERTURA DE CAIXA', Data, vendedor);
  Self.Totalizadores(Totalizadores);
  Self.Assinatura(vendedor, Emitente);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

procedure TRCaixaAbertura.Descricao(Titulo: string; Data: TDate; vendedor: TVendedor);
var
  LinhaCmd: string;
begin

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + Titulo + escBoldOff;
  Buffer.Add(LinhaCmd);

  if Assigned(vendedor) then
  begin
    Buffer.Add(esc20Cpi + escBoldOn + PadSpace('Vendedor: ' + vendedor.CODIGO + '  ' +
      vendedor.NOME, Self.ColunasFonteCondensada, '|') + escBoldOff);
  end;

  LinhaCmd := escAlignLeft + esc20Cpi + 'Emissão: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', now);
  Buffer.Add(LinhaCmd);


  Buffer.Add(Self.LinhaSimples);
end;

procedure TRCaixaAbertura.Totalizadores(Totalizadores: TList < TPair < string, string >> );
var
  item: TPair<string, string>;
begin
  for item in Totalizadores do
  begin
    Buffer.Add(esc20Cpi + PadSpace(item.Key + '|' + item.Value, Self.ColunasFonteCondensada, '|'));
  end;
end;

procedure TRCaixaAbertura.Assinatura(vendedor: TVendedor; Emitente: TEmitente);
var
  LinhaCmd: string;
begin
  Buffer.Add(escNewLine);

  LinhaCmd := escAlignCenter + esc20Cpi +
    '_____________________________________________________';
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'ASSINATURA VENDEDOR';
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOff + Emitente.CIDADE + ', ' + FormatDateTime('dddd d mmmm yyyy', now);
  Buffer.Add(LinhaCmd);
end;

end.
