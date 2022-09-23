unit Dao.IDaoParcelas;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  Data.DB,
  Dao.TDaoBase, Sistema.TLog,
  Dominio.Entidades.TParcelas;

type

  IDaoParcelas = interface
    ['{D928AF6A-69C1-49D6-ACFD-C5266D2E9CDC}']
    procedure IncluiParcelas(Parcelas: TParcelas);
    procedure AtualizaParcelas(Parcelas: TParcelas);
    procedure BaixaParcelas(Parcelas: TParcelas);
    procedure ExtornaParcelas(Parcelas: TParcelas);
    function GeTParcela(NUMPARCELA, IDPEDIDO: Integer): TParcelas;
    function GeTParcelas(IDPEDIDO: Integer): TObjectList<TParcelas>; overload;
    function GeTParcelas(IDPEDIDO: Integer; SEQPAGTO:INTEGER): TObjectList<TParcelas>; overload;
    function GeTParcelasPorCliente(CODCLiente: string; status: string): TObjectList<TParcelas>; overload;
    function GeTParcelasVencidasPorCliente(CODCLiente: string; dataAtual: TDate): TObjectList<TParcelas>; overload;
    function GeTParcelasVencendoPorCliente(CODCLiente: string; dataAtual: TDate): TObjectList<TParcelas>; overload;

    function GeTParcelas(dataInicial, dataFinal: TDate): TDataSet; overload;
    function GeTParcelas(campo: string; valor: string; dataInicial, dataFinal: TDate): TDataSet; overload;
    function GeTParcelas(campo: string; valor: string): TDataSet; overload;

    function GeTParcelasTotal(CODCLiente: string; status: string): currency;
    function GetNumeroDeParcelasVencendo(dataInicial, dataFinal: TDate): Integer;
    function GetNumeroDeParcelasVencidas(dataAtual: TDate): Integer; overload;
    function GetNumeroDeParcelasVencidas(dataAtual: TDate; CODCLiente: string): Integer; overload;

    function GetParcelaVencidasObj(dataAtual: TDate): TObjectList<TParcelas>; overload;
    function GetParcelaVencendoObj(dataInicial, dataFinal: TDate): TObjectList<TParcelas>;

    function GetParcelaVencidasDS(dataAtual: TDate): TDataSet; overload;
    function GetParcelaVencidasDS(campo: string; valor: string; dataAtual: TDate): TDataSet; overload;

    function GetParcelaVencendoDS(dataInicial, dataFinal: TDate): TDataSet;
  end;

implementation

end.
