unit Relatorio.TRParcelas;

interface

uses
  ACBrUtil, System.SysUtils,
  System.Generics.Collections,
  Relatorio.TRBase, Data.DB,
  Dominio.Entidades.TParcelas,
  Dominio.Entidades.TEmitente;

type

  TRParcela = class(TRBase)
  strict private
    procedure ListaParcelas(ds: TObjectList<TParcelas>);
    procedure DescricaoLista(descricao: string);
    procedure DescricaoVencidas(Data: TDateTime);
  public
    procedure ImprimeLista(descricao: string; Emitente: TEmitente; dataSet: TObjectList<TParcelas>);
    procedure ImprimeVencidas(DataIncio: TDate; Emitente: TEmitente; dataSet: TObjectList<TParcelas>);
  end;

implementation

{ TRParcela }

procedure TRParcela.DescricaoLista(descricao: string);
var
  LinhaCmd: string;
begin

  LinhaCmd :=  escAlignCenter + esc20Cpi + escBoldOn + 'Relatório - ' + descricao +  escBoldOff;
  Buffer.Add(LinhaCmd);

  // LinhaCmd := ' esc20Cpi ' +
  // ACBrStr(PadSpace('Data Início : ' + DateToStr(DataIncio) + '|' +
  // 'Data Final: ' + DateToStr(DataFim),
  // Self.ColunasFonteCondensada, '|'));
  //
  // Buffer.Add(LinhaCmd);

  Buffer.Add( self.LinhaSimples );
end;

procedure TRParcela.DescricaoVencidas(Data: TDateTime);
var
  LinhaCmd: string;
begin

  LinhaCmd :=  escAlignCenter + esc20Cpi + escBoldOn+' Relatório - Parcelas Vencidas '+ escBoldOff ;
  Buffer.Add(LinhaCmd);

  LinhaCmd := ACBrStr(PadSpace('Data Refêrencia : ' + DateToStr(Data) + '|',
    Self.ColunasFonteCondensada, '|'));

  Buffer.Add(LinhaCmd);

  Buffer.Add( self.LinhaSimples );

end;

procedure TRParcela.ImprimeLista(descricao: string; Emitente: TEmitente; dataSet: TObjectList<TParcelas>);
begin
  Self.Cabecalho(Emitente);
  Self.DescricaoLista(descricao);
  Self.ListaParcelas(dataSet);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

procedure TRParcela.ImprimeVencidas(DataIncio: TDate; Emitente: TEmitente; dataSet: TObjectList<TParcelas>);
begin
  Self.Cabecalho(Emitente);
  Self.DescricaoVencidas(DataIncio);
  Self.ListaParcelas(dataSet);
  Self.SobePapel;
  Self.Rodape;
  Self.imprimir;
end;

procedure TRParcela.ListaParcelas(ds: TObjectList<TParcelas>);
var
  CODIGO: string;
  parcela: TParcelas;
begin
  ds.First;

  Buffer.Add( esc20Cpi  + PadSpace('CLIENTE|PARCELA|VENCIMENTO|VALOR',
    Self.ColunasFonteCondensada, '|'));
  Buffer.Add( self.LinhaSimples );

  CODIGO := '';
  for parcela in ds do
  begin
    if CODIGO <> parcela.CODCLIENTE then
    BEGIN
      Buffer.Add(
        ACBrStr(PadSpace(
         escAlignCenter + esc20Cpi
        + parcela.CODCLIENTE
        + ' ' + parcela.NOME,
        Self.ColunasFonteCondensada, '|'))
        );

      CODIGO := parcela.CODCLIENTE;
    END;

    Buffer.Add( esc20Cpi  +
      ACBrStr(
      PadSpace(
      IntToStr(parcela.numparcela) + 'ª Parcela do pedido ' +Format('%.*d',[6, parcela.IDPEDIDO]) + '|' +
      FormatDateTime('dd/mm/yyyy', parcela.VENCIMENTO) + '|' +
      FormatFloat('R$ #,###,##0.00', parcela.VALOR),
      Self.ColunasFonteCondensada, '|')
      )
      );

  end;

end;

end.
