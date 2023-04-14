unit Relatorio.TROrcamento;

interface

uses
  ACBrUtil, System.SysUtils, System.Generics.Collections,
  Relatorio.TRBase,
  Dominio.Entidades.TOrcamento, Dominio.Entidades.TEmitente,

  Dominio.Entidades.TItemOrcamento;

type

  TROrcamento = class(TRBase)
  private
    procedure GerarItens(itens: TObjectList<TItemOrcamento>);
    procedure GerarTotais(Orcamento: TOrcamento);
    procedure GerarObsCliente(Orcamento: TOrcamento);
    procedure GerarDadosOrcamento(Orcamento: TOrcamento; via: Integer);
    procedure GerarCodigoBarras(Orcamento: TOrcamento);
    procedure GerarDadosConsumidor(Emitente: TEmitente; Orcamento: TOrcamento);
  public
    procedure ImprimeCupom(Emitente: TEmitente; Orcamento: TOrcamento);
  end;

implementation

{ TROrcamento }



procedure TROrcamento.ImprimeCupom(Emitente: TEmitente; Orcamento: TOrcamento);
begin
  inherited;
  Self.Cabecalho(Emitente);
  Self.GerarDadosOrcamento(Orcamento, 1);
  Self.GerarItens(Orcamento.itens);
  Self.GerarTotais(Orcamento);
  Self.GerarDadosConsumidor(Emitente, Orcamento);
  Self.GerarObsCliente(Orcamento);
  Self.SobePapel;
  Self.Rodape;

//  Self.Cabecalho(Emitente);
//  Self.GerarDadosOrcamento(Orcamento, 2);
//
//  // if FParametrosImpressora.IMPRIMIRITENS2VIA then
//  Self.GerarItens(Orcamento.itens);
//
//  Self.GerarTotais(Orcamento);
//
//  Self.GerarDadosConsumidor(Emitente, Orcamento);
//  // Self.GerarCodigoBarras(Orcamento);
//  Self.SobePapel;
//  Self.Rodape;

  Self.imprimir;
end;

procedure TROrcamento.GerarDadosOrcamento(Orcamento: TOrcamento; via: Integer);
var
  LinhaCmd: string;
begin

  Buffer.Add(escAlignCenter + esc16Cpi + escBoldOn + 'ORÇAMENTO' +
    escBoldOff + esc20Cpi);

  // if via = 1 then
  // LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'Via Cliente' +
  // escBoldOff
  // else
  // LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn + 'Via Loja' + escBoldOff;

 // Buffer.Add(escAlignCenter + esc20Cpi + escBoldOn + 'NÃO É DOCUMENTO FISCAL' + escBoldOff);
   LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn +
   'Orçamento Válido Até '
   + FormatDateTime('dddd d mmmm yyyy',Orcamento.DATAVENCIMENTO)+ escBoldOff;

   Buffer.Add(LinhaCmd);

  LinhaCmd := esc20Cpi + ACBrStr(PadSpace('Orcamento Nº: ' + Orcamento.NUMERO + '|' +
    'DATA: ' + DateToStr(Orcamento.DATAOrcamento) + '  ' +
    TimeToStr(Orcamento.HORAOrcamento), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(LinhaCmd);

  LinhaCmd := esc20Cpi + ACBrStr(PadSpace(
    'Cliente: ' + Orcamento.Cliente + '|'
   , Self.ColunasFonteCondensada, '|'));
  Buffer.Add(LinhaCmd);

  Buffer.Add(esc20Cpi + PadSpace('Vendedor: ' + Orcamento.Vendedor.CODIGO + '  ' +
    Orcamento.Vendedor.NOME, Self.ColunasFonteCondensada, '|'));

end;

procedure TROrcamento.GerarItens(itens: TObjectList<TItemOrcamento>);
var
  i: Integer;
  nTamDescricao: Integer;
  VlrLiquido: Double;
  sItem, sCodigo, sDescricao, sQuantidade, sUnidade, sVlrUnitario, sVlrProduto,
    LinhaCmd: String;
  item: TItemOrcamento;
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
    sVlrProduto := FormatFloatBr(item.VALOR_BRUTO, '###,###,##0.00');
    sCodigo := item.CODPRODUTO;
    sVlrUnitario := FloatToStrF(item.VALOR_UNITA, ffNumber, 9, 3);
    sQuantidade := FloatToStrF(item.QTD, ffNumber, 9, 2);

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

procedure TROrcamento.GerarTotais(Orcamento: TOrcamento);
begin
  Buffer.Add(Self.LinhaSimples);
  Buffer.Add(esc20Cpi + PadSpace('QTD. TOTAL DE ITENS|' +
    FloatToStr(Orcamento.Volume), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + PadSpace('Subtotal|' + FormatFloat('R$ #,###,##0.00',
    Orcamento.ValorBruto), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + PadSpace('Descontos|' + FormatFloat('-R$ #,###,##0.00',
    Orcamento.VALORDESC), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + escBoldOn + escAlignLeft +
    PadSpace('Total |' + FormatFloat('R$ #,###,##0.00',
    Orcamento.ValorLiquido), Self.ColunasFonteCondensada, '|') + escBoldOff +
    esc20Cpi);
end;

procedure TROrcamento.GerarObsCliente(Orcamento: TOrcamento);
var
  TextoObservacao: AnsiString;
begin
  TextoObservacao := Trim(Orcamento.OBSERVACAO);
  if TextoObservacao <> '' then
  begin
    Buffer.Add(Self.LinhaSimples);
    Buffer.Add(ACBrStr(escAlignCenter + esc20Cpi + escBoldOn + 'OBSERVAÇÕES' +
      escBoldOff));
    Buffer.Add(esc20Cpi + TextoObservacao);

  end;
end;

procedure TROrcamento.GerarCodigoBarras(Orcamento: TOrcamento);
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

  ACodBar := Orcamento.NUMERO;

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

procedure TROrcamento.GerarDadosConsumidor(Emitente: TEmitente; Orcamento: TOrcamento);
var
  LinhaCmd: String;
  CNPJ_CNPF: string;
begin
  // CNPJ_CNPF := TUtil.ExtrairNumeros(Orcamento.Cliente.CNPJ_CNPF);
  //
  // Buffer.Add(Self.LinhaSimples);
  // LinhaCmd := escAlignCenter + esc16Cpi + escBoldOn + 'CLIENTE' + escBoldOff;
  // Buffer.Add(LinhaCmd);
  //
  // LinhaCmd := esc20Cpi + ACBrStr(PadSpace(
  // 'Cliente: ' + Orcamento.Cliente + '|' +
  // 'Orçamento Válido Até: ' + DateToStr(Orcamento.DATAVENCIMENTO), Self.ColunasFonteCondensada, '|'));
  //
  // Buffer.Add(LinhaCmd);
  //
  // LinhaCmd := Trim(Trim(Orcamento.Cliente.ENDERECO) + ' ' +
  // Trim(Orcamento.Cliente.NUMERO) + ' ' + Trim(Orcamento.Cliente.COMPLEMENTO) + ' ' +
  // Trim(Orcamento.Cliente.BAIRRO) + ' ' + Trim(Orcamento.Cliente.CIDADE) + ' ' +
  // Trim(Orcamento.Cliente.UF));
  // if LinhaCmd <> '' then
  // Buffer.Add(esc20Cpi + LinhaCmd);
  //
  // Buffer.Add(escNewLine);
  //
  // LinhaCmd := escAlignCenter + esc20Cpi +
  // '_____________________________________________________';
  // Buffer.Add(LinhaCmd);
  //
  // LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn +
  // 'Reconheço e pagarei a dívida acima';
  // Buffer.Add(LinhaCmd);
  //

  LinhaCmd := escAlignCenter + esc20Cpi + escBoldOn +
   'Orçamento Válido Até '
   + FormatDateTime('dddd d mmmm yyyy',Orcamento.DATAVENCIMENTO)+ escBoldOff;

   Buffer.Add(LinhaCmd);


end;

end.
