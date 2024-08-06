unit Relatorio.TRPedido;

interface

uses
  ACBrUtil, ACBrValidador, System.SysUtils, System.Generics.Collections,
  Relatorio.TRBase,
  Dominio.Entidades.TPedido, Dominio.Entidades.TEmitente, Dominio.Entidades.Pedido.Pagamentos.Pagamento,
  Dominio.Entidades.TItemPedido, Dominio.Entidades.TParcelas,
  Dominio.Entidades.TCliente;

type

  TRPedido = class(TRBase)
  private
    procedure GerarItens(itens: TObjectList<TItemPedido>);
    procedure GerarTotais(Pedido: TPedido);
    procedure GerarParcelas(Pedido: TPedido);
    procedure GerarObsCliente(Pedido: TPedido);
    procedure GerarObsParcela(Parcelas: TObjectList<TParcelas>);
    procedure GerarDadosPedido(Pedido: TPedido; via: Integer);
    procedure GerarCodigoBarras(Pedido: TPedido);
    procedure GerarDadosConsumidor(Emitente: TEmitente; Pedido: TPedido);
    procedure GerarPagamento(Pedido: TPedido);
    function TemParcelas(Pedido: TPedido): boolean;
    procedure GerarAssinatura(Emitente: TEmitente; Pedido: TPedido);
  public
    procedure ImprimeCupom(Emitente: TEmitente; Pedido: TPedido; ParcelasAtrasadas: TObjectList<TParcelas>);
  end;

implementation

{ TRPedido }

uses Util.Funcoes;

procedure TRPedido.ImprimeCupom(Emitente: TEmitente; Pedido: TPedido; ParcelasAtrasadas: TObjectList<TParcelas>);
var
  LTemParcela: boolean;
begin
  inherited;
  LTemParcela := TemParcelas(Pedido);

  Self.Cabecalho(Emitente);
  Self.GerarDadosPedido(Pedido, 1);
  Self.GerarItens(Pedido.itens);
  Self.GerarTotais(Pedido);
  Self.GerarPagamento(Pedido);

  if LTemParcela then
    Self.GerarParcelas(Pedido);
  Self.GerarDadosConsumidor(Emitente, Pedido);
  Self.GerarObsCliente(Pedido);

  if LTemParcela then
  begin
    GerarAssinatura(Emitente, Pedido);
    Self.GerarObsParcela(ParcelasAtrasadas);
  end;
  Self.SobePapel;
  Self.Rodape;

  if FParametrosImpressora.IMPRIMIR2VIAS and LTemParcela then
  begin

    Self.Cabecalho(Emitente);
    Self.GerarDadosPedido(Pedido, 2);

    // if FParametrosImpressora.IMPRIMIRITENS2VIA then
    Self.GerarItens(Pedido.itens);

    Self.GerarTotais(Pedido);
    Self.GerarPagamento(Pedido);
    Self.GerarParcelas(Pedido);
    Self.GerarDadosConsumidor(Emitente, Pedido);
    Self.GerarAssinatura(Emitente, Pedido);
    Self.GerarCodigoBarras(Pedido);
    Self.SobePapel;
    Self.Rodape;
  end;

  Self.imprimir;
end;

procedure TRPedido.GerarDadosPedido(Pedido: TPedido; via: Integer);
var
  LinhaCmd: string;
begin

  Buffer.Add(escAlignCenter + esc16Cpi + escBoldOn + 'NÃO É DOCUMENTO FISCAL' +
    escBoldOff + esc20Cpi);

  if via = 1 then
    LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'Via Cliente' +
      escBoldOff
  else
    LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'Via Loja' + escBoldOff;

  Buffer.Add(LinhaCmd);

  LinhaCmd := esc20Cpi + ACBrStr(PadSpace('PEDIDO Nº: ' + Pedido.NUMERO + '|' +
    'DATA: ' + DateToStr(Pedido.DATAPEDIDO) + '  ' +
    TimeToStr(Pedido.HORAPEDIDO), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(LinhaCmd);

  Buffer.Add(esc20Cpi + PadSpace('Vendedor: ' + Pedido.Vendedor.CODIGO + '  ' +
    Pedido.Vendedor.NOME, Self.ColunasFonteCondensada, '|'));

  // Buffer.Add('<code128c>' + Pedido.NUMERO + '</code128c>');

end;

procedure TRPedido.GerarItens(itens: TObjectList<TItemPedido>);
var
  i: Integer;
  nTamDescricao: Integer;
  VlrLiquido: Double;
  sItem, sCodigo, sDescricao, sQuantidade, sUnidade, sVlrUnitario, sVlrProduto,
    LinhaCmd: String;
  item: TItemPedido;
begin
  Buffer.Add(escAlignLeft + esc20Cpi + Self.LinhaSimples);
  Buffer.Add(esc20Cpi +
    ACBrStr(PadSpace('#|CODIGO|DESCRIÇÃO|QTD|UN|VL UN R$|VL TOTAL R$',
    Self.ColunasFonteCondensada, '|')));
  Buffer.Add(Self.LinhaSimples);

  for item in itens do
  begin

    sItem := IntToStrZero(item.SEQ, 3);
    sDescricao := Trim(item.DESCRICAO);
    sUnidade := Trim(item.UND);
    sVlrProduto := FormatFloatBr(item.VALOR_TOTAL, '###,###,##0.00');
    sCodigo := item.CODPRODUTO;
    sVlrUnitario := FloatToStrF(item.VALOR_UNITA, ffNumber, 9, 3);
    sQuantidade := FloatToStrF(item.QTD, ffNumber, 9, 3);

    LinhaCmd := sItem + ' ' + sCodigo + ' ' + sDescricao;
    Buffer.Add(escAlignLeft + esc20Cpi + LinhaCmd);

    LinhaCmd := PadRight(sQuantidade, 15) + ' ' + PadRight(sUnidade, 6) + ' X '
      + PadRight(sVlrUnitario, 13) + '|' + sVlrProduto;
    LinhaCmd := PadSpace(LinhaCmd, Self.ColunasFonteCondensada, '|');
    Buffer.Add(escAlignLeft + esc20Cpi + LinhaCmd);

    // VlrLiquido := (Prod.QCom * Prod.VUnCom) + Prod.vOutro - Prod.vDesc;

    // desconto
    if item.VALOR_DESCONTO > 0 then
    begin
      LinhaCmd := escAlignLeft + esc20Cpi +
        PadSpace('desconto ' + padLeft(FormatFloatBr(item.VALOR_DESCONTO,
        '-0.00'), 15, ' '), Self.ColunasFonteCondensada, '|');
      Buffer.Add(escAlignLeft + esc20Cpi + LinhaCmd);
    end;

  end;
end;

procedure TRPedido.GerarPagamento(Pedido: TPedido);
begin
  Buffer.Add(' ');
  Buffer.Add(esc20Cpi + PadSpace('FORMA DE PAGAMENTO|VALOR PAGO R$', Self.ColunasFonteCondensada, '|'));

  for VAR Pagto in Pedido.Pagamentos.FormasDePagamento do
  begin
    Buffer.Add(esc20Cpi + PadSpace(Pagto.DESCRICAO + '|' + FormatFloat('#,###,##0.00',
      Pagto.Valor ), Self.ColunasFonteCondensada, '|'));
  end;

  Buffer.Add(esc20Cpi + PadSpace('Troco|' + FormatFloat('-#,###,##0.00',
    Pedido.Troco), Self.ColunasFonteCondensada, '|'));
end;

procedure TRPedido.GerarTotais(Pedido: TPedido);
begin
  Buffer.Add(Self.LinhaSimples);
  Buffer.Add(esc20Cpi + PadSpace('QTD. TOTAL DE ITENS|' +
    FloatToStr(Pedido.Volume), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + PadSpace('Subtotal|' + FormatFloat('#,###,##0.00',
    Pedido.ValorBruto), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + PadSpace('Descontos|' + FormatFloat('-#,###,##0.00',
    Pedido.VALORDESC), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + PadSpace('Acréscimos|' + FormatFloat('+#,###,##0.00',
    Pedido.VALORACRESCIMO), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + PadSpace('Total|' + FormatFloat('#,###,##0.00',
    Pedido.ValorLiquido), Self.ColunasFonteCondensada, '|'));

end;

function TRPedido.TemParcelas(Pedido: TPedido): boolean;
begin
  result := false;
  for VAR Pagto in Pedido.Pagamentos.FormasDePagamento do
    if Pagto.Parcelas.Count > 0 then
    begin
      result := true;
      break;
    end;

end;

procedure TRPedido.GerarParcelas(Pedido: TPedido);
var
  i: Integer;
  { Total, } Troco: Real;
  parcela: TParcelas;
begin
  // Total := 0;

  for VAR Pagto in Pedido.Pagamentos.FormasDePagamento do
  begin

    if Pagto.Parcelas.Count = 0 then
      Continue;

    Buffer.Add(escNewLine);

    Buffer.Add(esc20Cpi + escBoldOn + escAlignLeft +
      PadSpace('VALOR A PARCELAR R$|' + FormatFloat('#,###,##0.00',
      Pagto.Valor), Self.ColunasFonteCondensada, '|') + escBoldOff +
      esc20Cpi);

    Buffer.Add(escAlignLeft + esc20Cpi + PadSpace('PARCELA|VENCIMENTO|VALOR',
      Self.ColunasFonteCondensada, '|'));

    for parcela in Pagto.Parcelas do
    begin
      Buffer.Add(esc20Cpi + ACBrStr(PadSpace(IntToStr(parcela.NUMPARCELA) +
        'ª      ' + '|' + DateToStr(parcela.VENCIMENTO) + '|' +
        FormatFloat('R$ #,###,##0.00', parcela.Valor),
        Self.ColunasFonteCondensada, '|')));
      // Total := Total + FpNFe.pag.Items[i].vPag;
    end;
  end;

end;

procedure TRPedido.GerarObsCliente(Pedido: TPedido);
var
  TextoObservacao: AnsiString;
begin
  TextoObservacao := Trim(Pedido.OBSERVACAO);
  if TextoObservacao <> '' then
  begin
    Buffer.Add(Self.LinhaSimples);
    Buffer.Add(ACBrStr(escAlignCenter + esc20Cpi + escBoldOn + 'OBSERVAÇÕES' +
      escBoldOff));
    Buffer.Add(esc20Cpi + TextoObservacao);

  end;
end;

procedure TRPedido.GerarObsParcela(Parcelas: TObjectList<TParcelas>);
var
  i: Integer;
  { Total, } Troco: Real;
  parcela: TParcelas;
  Total: Currency;
begin
  // Total := 0;

  if Parcelas.Count = 0 then
    exit;

  Buffer.Add(Self.LinhaSimples);
  Buffer.Add(ACBrStr(escAlignCenter + esc20Cpi + escBoldOn + 'O CLIENTE POSSUI AS SEGUINTES PARCELAS PENDENTES' +
    escBoldOff));

  Buffer.Add(escAlignLeft + esc20Cpi + PadSpace('PARCELA|VENCIMENTO|VALOR',
    Self.ColunasFonteCondensada, '|'));

  Total := 0;

  for parcela in Parcelas do
  begin
    Buffer.Add(esc20Cpi + ACBrStr(PadSpace(IntToStr(parcela.NUMPARCELA) +
      'ª      ' + '|' + DateToStr(parcela.VENCIMENTO) + '|' +
      FormatFloat('R$ #,###,##0.00', parcela.Valor),
      Self.ColunasFonteCondensada, '|')));
    // Total := Total + FpNFe.pag.Items[i].vPag;

    Total := Total + parcela.Valor;
  end;

  Buffer.Add(escAlignRight + 'Total: R$ ' + FormatFloat('R$ #,###,##0.00', Total));

end;

procedure TRPedido.GerarCodigoBarras(Pedido: TPedido);
var
  L, A, M: Integer;
  CmdBarCode: Char;
  Cmd128, Code128c: AnsiString;
  i, s: Integer;
  ACodBar: string;
begin
  Buffer.Add(escNewLine);

  CmdBarCode := 'I';
  Cmd128 := '{B';

  ACodBar := Pedido.NUMERO;

  if CmdBarCode = 'I' then // Cod128
  begin
    if Copy(String(ACodBar), 1, 1) <> '{' then
      ACodBar := Cmd128 + ACodBar;
  end;

  L := 0;
  A := 50;
  M := 0;

  Code128c := escGS + 'w' + AnsiChr(L) + // Largura
    escGS + 'h' + AnsiChr(A) + // Altura
    escGS + 'H' + AnsiChr(M) + // HRI (numero impresso abaixo do cod.barras)
    escGS + 'k' + CmdBarCode + AnsiChr(Length(ACodBar)) + ACodBar;

  Buffer.Add(Code128c);
end;

procedure TRPedido.GerarDadosConsumidor(Emitente: TEmitente; Pedido: TPedido);
var
  LinhaCmd: String;
  CNPJ_CNPF: string;
begin
  CNPJ_CNPF := TUtil.ExtrairNumeros(Pedido.Cliente.CNPJ_CNPF);

  Buffer.Add(Self.LinhaSimples);
  LinhaCmd := escAlignCenter + esc16Cpi + escBoldOn + 'CLIENTE' + escBoldOff;
  Buffer.Add(LinhaCmd);

  if Length(TUtil.ExtrairNumeros(Pedido.Cliente.CNPJ_CNPF)) > 11 then
    LinhaCmd := 'CNPJ: ' + FormatarCNPJ(CNPJ_CNPF)
  else
    LinhaCmd := 'CPF: ' + FormatarCPF(CNPJ_CNPF);

  Buffer.Add(esc20Cpi + LinhaCmd);

  LinhaCmd := Pedido.Cliente.CODIGO + ' ' + Trim(Pedido.Cliente.NOME);
  if LinhaCmd <> '' then
  begin
    if Length(LinhaCmd) > Self.ColunasFonteNormal then
      LinhaCmd := esc20Cpi + LinhaCmd;

    Buffer.Add(LinhaCmd);
  end;

  LinhaCmd := Trim(Trim(Pedido.Cliente.ENDERECO) + ' ' +
    Trim(Pedido.Cliente.NUMERO) + ' ' + Trim(Pedido.Cliente.COMPLEMENTO) + ' ' +
    Trim(Pedido.Cliente.BAIRRO) + ' ' + Trim(Pedido.Cliente.CIDADE) + ' ' +
    Trim(Pedido.Cliente.UF));
  if LinhaCmd <> '' then
    Buffer.Add(esc20Cpi + LinhaCmd);

end;

procedure TRPedido.GerarAssinatura(Emitente: TEmitente; Pedido: TPedido);
var
  LinhaCmd: String;
begin
  Buffer.Add(escNewLine);

  LinhaCmd := escAlignCenter + esc20Cpi +
    '_____________________________________________________';
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn +
    'Reconheço e pagarei a dívida acima';
  Buffer.Add(LinhaCmd);

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOff + Emitente.CIDADE + ', ' +
    FormatDateTime('dddd d mmmm yyyy', Pedido.DATAPEDIDO);
  Buffer.Add(LinhaCmd);
end;

end.
