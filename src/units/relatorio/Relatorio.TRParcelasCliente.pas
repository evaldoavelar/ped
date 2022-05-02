unit Relatorio.TRParcelasCliente;

interface

uses
  ACBrUtil, ACBrValidador, System.SysUtils,
  System.Generics.Collections,
  Relatorio.TRBase, Data.DB,
  Dominio.Entidades.TCliente,
  Dominio.Entidades.TParcelas,
  Dominio.Entidades.TEmitente, Util.Funcoes;

type

  TRParcelasCliente = class(TRBase)
  strict private
  private
    procedure Descricao(Cliente: TCliente);
    procedure ListaParcelas(Descricao: string; parcelas: TObjectList<TParcelas>);

  public
    procedure Imprime(Cliente: TCliente; Emitente: TEmitente; ParcelasVencidas: TObjectList<TParcelas>; ParcelasVencendo: TObjectList<TParcelas>);
  end;

implementation

{ TRParcelasCliente }

procedure TRParcelasCliente.Descricao(Cliente: TCliente);
var
  LinhaCmd: string;
begin

  Buffer.Add(ACBrStr(escAlignLeft + esc20Cpi + 'Cliente: ' + Cliente.CODIGO + ' ' + Cliente.Nome));

  if Length(TUtil.ExtrairNumeros(Cliente.CNPJ_CNPF)) > 11 then
    LinhaCmd := 'CNPJ: ' + FormatarCNPJ(Cliente.CNPJ_CNPF)
  else
    LinhaCmd := 'CPF: ' + FormatarCPF(Cliente.CNPJ_CNPF);

  LinhaCmd := esc20Cpi + ACBrStr(PadSpace(LinhaCmd + '|' +
    'DATA: ' + DateToStr(now), Self.ColunasFonteCondensada, '|'));

  Buffer.Add(esc20Cpi + LinhaCmd);

  LinhaCmd := Trim(Trim(Cliente.ENDERECO) + ' ' +
    Trim(Cliente.NUMERO) + ' ' + Trim(Cliente.COMPLEMENTO) + ' ' +
    Trim(Cliente.BAIRRO) + ' ' + Trim(Cliente.CIDADE) + ' ' +
    Trim(Cliente.UF));
  if LinhaCmd <> '' then
    Buffer.Add(esc20Cpi + LinhaCmd);
end;

procedure TRParcelasCliente.ListaParcelas(Descricao: string;
  parcelas:
  TObjectList<TParcelas>);
var
  parcela: TParcelas;
  Total: Currency;
begin

  Buffer.Add(escAlignLeft + esc20Cpi + Self.LinhaSimples);

  Total := 0;

  Buffer.Add(ACBrStr(escAlignCenter + esc20Cpi + escBoldOn + Descricao + escBoldOff));

  if parcelas.Count = 0 then
  begin
    Buffer.Add('');
    Buffer.Add(esc20Cpi + 'NENHUMA PARCELA ENCONTRADA');
    Exit;
  end;

  // Buffer.Add(Self.LinhaSimples);
  Buffer.Add(esc20Cpi + PadSpace('PARCELA|VENCIMENTO|VALOR', Self.ColunasFonteCondensada, '|'));
  Buffer.Add(escAlignLeft + esc20Cpi + Self.LinhaSimples);

  for parcela in parcelas do
  begin

    Buffer.Add(esc20Cpi +
      ACBrStr(
      PadSpace(
      IntToStr(parcela.numparcela) + 'ª Parcela do pedido ' + Format('%.*d', [6, parcela.IDPEDIDO]) + '|' +
      FormatDateTime('dd/mm/yyyy', parcela.VENCIMENTO) + '|' +
      FormatFloat('R$ #,###,##0.00', parcela.VALOR),
      Self.ColunasFonteCondensada, '|')
      )
      );

    Total := Total + parcela.VALOR;
  end;

  Buffer.Add(ACBrStr(escAlignRight + esc20Cpi + escBoldOn + 'Total: ' + FormatCurr('R$ 0.,00', Total) + escBoldOff));

end;

procedure TRParcelasCliente.Imprime(Cliente: TCliente;
  Emitente:
  TEmitente;
  ParcelasVencidas, ParcelasVencendo: TObjectList<TParcelas>);
begin
  Self.Cabecalho(Emitente);
  Self.Descricao(Cliente);
  Self.ListaParcelas('PARCELAS VENCIDAS', ParcelasVencidas);
  Self.ListaParcelas('PARCELAS A VENCER', ParcelasVencendo);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

end.
