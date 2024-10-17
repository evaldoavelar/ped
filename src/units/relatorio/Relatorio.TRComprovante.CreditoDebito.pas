unit Relatorio.TRComprovante.CreditoDebito;

interface


uses
  ACBrUtil, ACBrValidador, System.SysUtils, System.Generics.Collections,
  Relatorio.TRBase, Dominio.Entidades.TFormaPagto.Tipo,
  Dominio.Entidades.TPedido, Dominio.Entidades.TEmitente, Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TCliente;

type

  TRComprovanteCreditoDebito = class(TRBase)
  private
    procedure Comprovante(aPedido: TPedido; aPgato: TPEDIDOPAGAMENTO);
  public
    procedure Imprime(Emitente: TEmitente; Pedido: TPedido);
  end;

implementation

uses Util.Funcoes;

{ TRComprovanteCreditoDebito }

procedure TRComprovanteCreditoDebito.Comprovante(aPedido: TPedido; aPgato: TPEDIDOPAGAMENTO);
var
  LinhaCmd: string;
begin

  case aPgato.TipoPagamento of
    Debito:
      Buffer.Add(escAlignCenter + esc16Cpi + escBoldOn + 'COMPROVANTE DE DÉBITO' + escBoldOff + esc20Cpi);
    Credito:
      Buffer.Add(escAlignCenter + esc16Cpi + escBoldOn + 'COMPROVANTE DE CRÉDITO' + escBoldOff + esc20Cpi);
    Pix:
      Buffer.Add(escAlignCenter + esc16Cpi + escBoldOn + 'COMPROVANTE DE PIX' + escBoldOff + esc20Cpi);
  end;

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'Via Loja' + escBoldOff;
  Buffer.Add(LinhaCmd);

  LinhaCmd := esc20Cpi + ACBrStr(PadSpace('PEDIDO Nº: ' + aPedido.NUMERO + '|' +
    'DATA: ' + DateToStr(aPedido.DATAPEDIDO) + '  ' +
    TimeToStr(aPedido.HORAPEDIDO), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(LinhaCmd);

  Buffer.Add(esc20Cpi + PadSpace('Vendedor: ' + aPedido.Vendedor.CODIGO + '  ' +
    aPedido.Vendedor.NOME, Self.ColunasFonteCondensada, '|'));

  Buffer.Add(' ');

  case aPgato.TipoPagamento of
    Credito:
      Buffer.Add(esc20Cpi +
        PadSpace(aPgato.DESCRICAO + ' ' + aPgato.QUANTASVEZES.ToString + 'x|' +
        FormatFloat('#,###,##0.00', aPgato.Valor), Self.ColunasFonteCondensada, '|'));
  else
    Buffer.Add(esc20Cpi +
      PadSpace(aPgato.DESCRICAO + '|' + FormatFloat('#,###,##0.00', aPgato.Valor), Self.ColunasFonteCondensada, '|'));
  end;

end;

procedure TRComprovanteCreditoDebito.Imprime(Emitente: TEmitente;
  Pedido: TPedido);
begin
  for var Pagto in Pedido.Pagamentos.FormasDePagamento do
  begin
    if Pagto.TipoPagamento in [TTipoPagto.Credito, TTipoPagto.Debito, TTipoPagto.Pix] then
    begin
      Self.Cabecalho(Emitente);
      Self.Comprovante(Pedido, Pagto);
      Self.SobePapel;
      Self.Rodape;
    end;
  end;

  Self.imprimir;
end;

end.
