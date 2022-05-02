unit Relatorio.TRVendasDoDia;

interface

uses
  ACBrUtil, System.SysUtils,
  System.Generics.Collections,
  Relatorio.TRBase, Data.DB,
  Dominio.Entidades.TParcelas,
  Dominio.Entidades.TEmitente, Dominio.Entidades.TVendedor;

type

  TRVendasDoDia = class(TRBase)
  strict private
  private
    procedure Totalizadores(Totalizadores: TList < TPair < string, string >> );
    procedure Assinatura(vendedor: TVendedor; Emitente: TEmitente);
    procedure Descricao(Titulo: string; DataInicio, DataFim: TDate; Emissor: TVendedor; vendedor: TVendedor);

  public
    procedure Imprime(DataInicio, DataFim: TDate; vendedor: TVendedor; Emitente: TEmitente; Totalizadores: TList < TPair < string, string >> ); overload;
    procedure Imprime(Emissor: TVendedor; DataInicio, DataFim: TDate; vendedor: TVendedor; Emitente: TEmitente; Totalizadores: TList < TPair < string, string >> ); overload;
  end;

implementation

{ TRVendasDoDia }

procedure TRVendasDoDia.Imprime(DataInicio, DataFim: TDate; vendedor: TVendedor; Emitente: TEmitente; Totalizadores: TList < TPair < string, string >> );
begin
  Self.Cabecalho(Emitente);
  Self.Descricao('TOTALIZADORES', DataInicio, DataFim, vendedor,nil);
  Self.Totalizadores(Totalizadores);
  // Self.Assinatura(vendedor, Emitente);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

procedure TRVendasDoDia.Imprime(Emissor: TVendedor; DataInicio, DataFim: TDate; vendedor: TVendedor; Emitente: TEmitente; Totalizadores: TList < TPair < string, string >> );
begin
  Self.Cabecalho(Emitente);
  Self.Descricao('TOTALIZADORES POR VENDEDOR', DataInicio, DataFim,Emissor, vendedor);
  Self.Totalizadores(Totalizadores);
  Self.Assinatura(vendedor, Emitente);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

procedure TRVendasDoDia.Descricao(Titulo: string; DataInicio, DataFim: TDate; Emissor: TVendedor; vendedor: TVendedor);
var
  LinhaCmd: string;
begin

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + Titulo + escBoldOff;
  Buffer.Add(LinhaCmd);

  if Assigned(vendedor) then
  begin
    Buffer.Add(esc20Cpi + PadSpace('Vendedor: ' + vendedor.CODIGO + '  ' +
      vendedor.NOME, Self.ColunasFonteCondensada, '|'));
  end;

  LinhaCmd := escAlignLeft + esc20Cpi +
    'Período: '
    + FormatDateTime('dd/mm/yyyy', DataInicio)
    + ' até '
    + FormatDateTime('dd/mm/yyyy', DataFim);
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignLeft + esc20Cpi +
    'Emissão: '
    + FormatDateTime('dd/mm/yyyy hh:mm:ss', now);
  Buffer.Add(LinhaCmd);

  Buffer.Add(esc20Cpi + PadSpace('Emitido por: ' + Emissor.CODIGO + '  ' +
    Emissor.NOME, Self.ColunasFonteCondensada, '|'));

  Buffer.Add(Self.LinhaSimples);
end;

procedure TRVendasDoDia.Totalizadores(Totalizadores: TList < TPair < string, string >> );
var
  item: TPair<string, string>;
begin
  for item in Totalizadores do
  begin
    Buffer.Add(esc20Cpi + PadSpace(item.Key + '|' + item.Value, Self.ColunasFonteCondensada, '|'));
  end;
end;

procedure TRVendasDoDia.Assinatura(vendedor: TVendedor; Emitente: TEmitente);
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

end.
