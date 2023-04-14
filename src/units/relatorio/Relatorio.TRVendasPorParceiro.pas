unit Relatorio.TRVendasPorParceiro;

interface

uses
  ACBrUtil, System.SysUtils,
  System.Generics.Collections,
  Relatorio.TRBase,
  Data.DB,
  Dominio.Entidades.TEmitente,
  Dominio.Entidades.TVendedor, Dominio.Entidades.TParceiro;

type

  TRVendasPorParceiro = class(TRBase)
  strict private
  private
    procedure Totalizadores(DataInicio, DataFim: TDate);

    procedure Descricao(Titulo: string; DataInicio, DataFim: TDate; Emissor: TVendedor; vendedor: TVendedor);

  public
    procedure Imprime(Emissor: TVendedor; DataInicio, DataFim: TDate; Emitente: TEmitente); overload;

  end;

implementation

{ TRVendasDoDia }

procedure TRVendasPorParceiro.Descricao(Titulo: string; DataInicio, DataFim: TDate; Emissor, vendedor: TVendedor);
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
    + FormatDateTime('dd/mm/yyyy', now);
  Buffer.Add(LinhaCmd);

  Buffer.Add(esc20Cpi + PadSpace('Emitido por: ' + Emissor.CODIGO + '  ' +
    Emissor.NOME, Self.ColunasFonteCondensada, '|'));

  Buffer.Add(Self.LinhaSimples);

end;

procedure TRVendasPorParceiro.Imprime(Emissor: TVendedor; DataInicio, DataFim: TDate; Emitente: TEmitente);
begin
  Self.Cabecalho(Emitente);
  Self.Descricao('VENDAS POR PARCEIRO', DataInicio, DataFim, Emissor, Emissor);
  Self.Totalizadores(DataInicio, DataFim);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

procedure TRVendasPorParceiro.Totalizadores(DataInicio, DataFim: TDate);
const
  pads: Integer = 25;
var
  Parceiros: TObjectList<TParceiro>;
  item: TPair<string, Currency>;
  Totalizadores: TList<TPair<string, Currency>>;
  Parceiro: TParceiro;
  ds: TDataSet;
  TotalVenda: Currency;
  TotalComissao: Currency;
begin
  Parceiros := fFactory.DaoParceiro.ListarAtivos();

  Buffer.Add(esc20Cpi +
    ACBrStr(PadSpace('#PARCEIRO|VENDAS R$|COMISSÃO R$',
    Self.ColunasFonteCondensada, '|')));
  Buffer.Add(Self.LinhaSimples);

  for Parceiro in Parceiros do
  begin

    Buffer.Add(esc20Cpi + escBoldOn + Parceiro.CODIGO + ' ' + Parceiro.NOME + escBoldOff);

    ds := fFactory
      .DaoParceiroVendaPagto
      .TotalizadorPorParceiro(Parceiro.CODIGO, DataInicio, DataFim);

    ds.First;
    TotalVenda := 0;
    TotalComissao := 0;

    while not ds.Eof do
    begin
      TotalVenda := TotalVenda + ds.FieldByName('venda').AsCurrency;
      TotalComissao := TotalComissao + ds.FieldByName('comissaovalor').AsCurrency;

      Buffer.Add(esc20Cpi +
        ACBrStr(
        PadSpace(
        PadRight(ds.FieldByName('descricao').AsString, pads) +
        FormatFloat('R$ #,###,##0.00', ds.FieldByName('venda').AsCurrency) + '|' +
        FormatFloat('R$ #,###,##0.00', ds.FieldByName('comissaovalor').AsCurrency),
        Self.ColunasFonteCondensada, '|')
        )
        );
      ds.Next;
    end;

    Totalizadores := fFactory
      .DaoPedido
      .TotaisParceiro(DataInicio, DataFim, Parceiro.CODIGO);

    if Totalizadores.Count > 0 then
    BEGin
      for item in Totalizadores do
      begin
        TotalVenda := TotalVenda + item.Value;
        Buffer.Add(esc20Cpi + PadSpace(PadRight(item.Key, pads) + FormatCurr('R$ 0.,00', item.Value) + '|' + '-', Self.ColunasFonteCondensada, '|'));
      end;
    End;

    Buffer.Add(esc20Cpi + escBoldOn +
      ACBrStr(
      PadSpace(
      PadRight('TOTAL', pads) +
      FormatFloat('R$ #,###,##0.00', TotalVenda) + '|' +
      FormatFloat('R$ #,###,##0.00', TotalComissao),
      Self.ColunasFonteCondensada, '|')
      ) + escBoldOff
      );

    Buffer.Add('');

    Totalizadores.Free;
    ds.Free;
  end;

  Parceiros.OwnsObjects := True;
  Parceiros.Free;
end;

end.
