unit Relatorio.TRTotalizadorMensal;

interface

uses
  ACBrUtil, System.SysUtils,
  System.Generics.Collections,
  Relatorio.TRBase,
  Dominio.Entidades.TEmitente,
  Dominio.Entidades.TVendedor,
  Dominio.Entidades.TTotalizadorMensal;

type

  TRTotalizadorMensal = class(TRBase)
  private
    procedure ImprimeCabecalhoDescricao(const aTitulo: string;
      dataInicio, dataFim: TDate; Emissor: TVendedor; const aNumCaixa: string);
    procedure ImprimeItens(Totais: TObjectList<TTotalizadorMensalItem>);
  public
    procedure Imprime(Emissor: TVendedor; dataInicio, dataFim: TDate;
      const aNumCaixa: string; Emitente: TEmitente;
      Totais: TObjectList<TTotalizadorMensalItem>);
  end;

implementation

const
  MESES: array[1..12] of string = (
    'JANEIRO', 'FEVEREIRO', 'MAR' + #199 + 'O', 'ABRIL', 'MAIO', 'JUNHO',
    'JULHO', 'AGOSTO', 'SETEMBRO', 'OUTUBRO', 'NOVEMBRO', 'DEZEMBRO'
  );

{ TRTotalizadorMensal }

procedure TRTotalizadorMensal.ImprimeCabecalhoDescricao(const aTitulo: string;
  dataInicio, dataFim: TDate; Emissor: TVendedor; const aNumCaixa: string);
var
  LMesInicio, LAnoInicio, LMesFim, LAnoFim: Word;
  LDummy: Word;
  LPeriodo: string;
  LInfoCaixa: string;
begin
  DecodeDate(dataInicio, LAnoInicio, LMesInicio, LDummy);
  DecodeDate(dataFim, LAnoFim, LMesFim, LDummy);

  if (LMesInicio = LMesFim) and (LAnoInicio = LAnoFim) then
    LPeriodo := MESES[LMesInicio] + ' DE ' + IntToStr(LAnoInicio)
  else if LAnoInicio = LAnoFim then
    LPeriodo := MESES[LMesInicio] + ' A ' + MESES[LMesFim] + ' DE ' + IntToStr(LAnoInicio)
  else
    LPeriodo := MESES[LMesInicio] + '/' + IntToStr(LAnoInicio) + ' A ' +
      MESES[LMesFim] + '/' + IntToStr(LAnoFim);

  Buffer.Add(escAlignCenter + esc20Cpi + escBoldOn + aTitulo + escBoldOff);

  Buffer.Add(escAlignLeft + esc20Cpi +
    'Período: ' + LPeriodo);

  Buffer.Add(escAlignLeft + esc20Cpi +
    'Emissão: ' + FormatDateTime('dd/mm/yyyy hh:mm:ss', Now));

  Buffer.Add(esc20Cpi + PadSpace('Emitido por: ' + Emissor.CODIGO + '  ' +
    Emissor.NOME, Self.ColunasFonteCondensada, '|'));

  Buffer.Add(Self.LinhaSimples);

  if aNumCaixa.Trim = '' then
    LInfoCaixa := 'VENDAS EM TODOS OS CAIXAS'
  else
    LInfoCaixa := 'CAIXA: ' + aNumCaixa;

  Buffer.Add(escAlignLeft + esc20Cpi + escBoldOn + LInfoCaixa + escBoldOff);
end;

procedure TRTotalizadorMensal.ImprimeItens(Totais: TObjectList<TTotalizadorMensalItem>);
var
  i: Integer;
  LItem: TTotalizadorMensalItem;
  LMesAtual, LAnoAtual: Integer;
  LLinhaMes: string;
  LLinhaValor: string;
begin
  LMesAtual := -1;
  LAnoAtual := -1;

  for i := 0 to Pred(Totais.Count) do
  begin
    LItem := Totais[i];

    if (LItem.Mes <> LMesAtual) or (LItem.Ano <> LAnoAtual) then
    begin
      if LMesAtual <> -1 then
        Buffer.Add('');

      LMesAtual := LItem.Mes;
      LAnoAtual := LItem.Ano;

      LLinhaMes := MESES[LMesAtual] + ' ' + IntToStr(LAnoAtual);
      Buffer.Add(escAlignLeft + esc16Cpi + escBoldOn + LLinhaMes + escBoldOff);
    end;

    LLinhaValor := LItem.Descricao + ' (' + IntToStr(LItem.Quantidade) + ')' +
      '|' + 'R$ ' + FormatFloat(',0.00', LItem.Total);
    Buffer.Add(esc20Cpi + PadSpace(LLinhaValor, Self.ColunasFonteCondensada, '|'));
  end;
end;

procedure TRTotalizadorMensal.Imprime(Emissor: TVendedor; dataInicio, dataFim: TDate;
  const aNumCaixa: string; Emitente: TEmitente;
  Totais: TObjectList<TTotalizadorMensalItem>);
begin
  Self.Cabecalho(Emitente);
  Self.ImprimeCabecalhoDescricao('TOTALIZADOR MENSAL', dataInicio, dataFim,
    Emissor, aNumCaixa);
  Self.ImprimeItens(Totais);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

end.
