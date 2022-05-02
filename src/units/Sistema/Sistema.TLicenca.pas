unit Sistema.TLicenca;

interface

uses Util.Funcoes, System.Classes, System.SysUtils, System.DateUtils, System.Types,
  Util.TSerial, Util.Exceptions, Util.VclFuncoes;

type

  TLicenca = class
  private
    fDiasRestantes: Integer;
    fLicencaVencida: Boolean;
    fDataDoSOMenorQueAplicacao: Boolean;
    fDataDoSOMenorQueUltimoAcesso: Boolean;
    fDataIncioMenorQueDataDoSO: Boolean;
    fCnpjIguais: Boolean;
    FDataVencimento: TDate;
    FDataDeIncio: TDate;
    FcnpjLicenca: string;
    function AbreArquivo(arquivo: string): string;
    function SerialToDate(numero: string): TDate;
    procedure SetDiasRestantes(const Value: Integer);
    procedure SetDataDoSOMenorQueAplicacao(const Value: Boolean);
    procedure SetDataDoSOMenorQueUltimoAcesso(const Value: Boolean);
    procedure SetLicencaVencida(const Value: Boolean);
    procedure SetDataIncioMenorQueDataDoSO(const Value: Boolean);
    procedure SetCnpjIguais(const Value: Boolean);
    procedure SetDataDeIncio(const Value: TDate);
    procedure SetDataVencimento(const Value: TDate);
    procedure SetcnpjLicenca(const Value: string);
  public

    property LicencaVencida: Boolean read fLicencaVencida write SetLicencaVencida;
    property DataDoSOMenorQueAplicacao: Boolean read fDataDoSOMenorQueAplicacao write SetDataDoSOMenorQueAplicacao;
    property DataDoSOMenorQueUltimoAcesso: Boolean read fDataDoSOMenorQueUltimoAcesso write SetDataDoSOMenorQueUltimoAcesso;
    property DataIncioMenorQueDataDoSO: Boolean read fDataIncioMenorQueDataDoSO write SetDataIncioMenorQueDataDoSO;
    property CnpjIguais: Boolean read fCnpjIguais write SetCnpjIguais;
    property DataDeIncio: TDate read FDataDeIncio write SetDataDeIncio;
    property DataVencimento: TDate read FDataVencimento write SetDataVencimento;
    property cnpjLicenca: string read FcnpjLicenca write SetcnpjLicenca;

    property DiasRestantes: Integer read fDiasRestantes write SetDiasRestantes;
    procedure GeraArquivoLicenca(arquivo: string; cnpj: string; DataDeIncio, DataDeValidade: TDate);
    function LicencaValida(arquivo: string; cnpj: string; DataHoje: TDate): Boolean;
    constructor create;
  end;

implementation

{ TLicenca }

constructor TLicenca.create;
begin

end;

procedure TLicenca.GeraArquivoLicenca(arquivo: string; cnpj: string; DataDeIncio, DataDeValidade: TDate);
var
  arquivoLicenca: TStringList;
  txtLicenca: string;
  serial: TSerial;
begin

  serial := TSerial.create;
  serial.NbrSegsEdt := 3; // numero de segmentos
  serial.SegSizeEdt := 6; // tamanho do segmento
  serial.DefField.Add('Inicio=6'); // campo e tamanho do campo
  serial.DefField.Add('Validade=6'); // campo e tamanho do campo
  serial.DefField.Add('cnpj=6'); // campo e tamanho do campo

  serial.DataField.Add('Inicio=' + FormatDateTime('ddmmyy', DataDeIncio)); // campo e valor do campo
  serial.DataField.Add('Validade=' + FormatDateTime('ddmmyy', DataDeValidade)); // campo e valor do campo
  serial.DataField.Add('cnpj=' + Copy(cnpj, length(cnpj) - 6, 6)); // campo e valor do campo

  txtLicenca := serial.MakeLicense;

  FreeAndNil(serial);

  arquivoLicenca := TStringList.create();
  try
    arquivoLicenca.Text := txtLicenca;
    arquivoLicenca.SaveToFile(arquivo);
  finally
    FreeAndNil(arquivoLicenca);
  end;
end;

function TLicenca.AbreArquivo(arquivo: string): string;
var
  arquivoLicenca: TStringList;
  serial: TSerial;
begin
  serial := TSerial.create;

  try
    arquivoLicenca := TStringList.create();
    try
      arquivoLicenca.LoadFromFile(arquivo);

      RESULT := serial.Decrypt(Trim(arquivoLicenca.Text));

      FreeAndNil(serial);
    finally
      FreeAndNil(arquivoLicenca);
    end;
  except
    on E: Exception do
      raise Exception.create('Falha ao ler arquivo de licença: ' + E.Message);
  end;

end;

function TLicenca.LicencaValida(arquivo: string; cnpj: string; DataHoje: TDate): Boolean;
var
  txtLicenca: string;
  dadosDoArquivo: TStringList;
  DataCriacao, fDataUltimoAcesso: TDate;
  aux: string;
begin

  // pegar o serial no arquivo
  txtLicenca := AbreArquivo(arquivo);

  // quebrar o serial (310717-100817) em strings
  dadosDoArquivo := TUtil.Explode(txtLicenca, '-');

  try
    DataDeIncio := SerialToDate(dadosDoArquivo[0]);
    DataVencimento := SerialToDate(dadosDoArquivo[1]);
    cnpjLicenca := dadosDoArquivo[2];
  except
    on E: Exception do
      raise TValidacaoException.create('Licença não é válida!');
  end;

  TUtil.ReplaceTimer(DataHoje);
  DataCriacao := TVclFuncoes.DataCriacaoAplicacao;
  TUtil.ReplaceTimer(DataCriacao);

  // fDataUltimoAcesso := GetUltimoAcesso();

  fLicencaVencida := CompareDate(DataVencimento, DataHoje) = LessThanValue;
  fDataDoSOMenorQueAplicacao := CompareDate(DataHoje, DataCriacao) = LessThanValue;
  fDataIncioMenorQueDataDoSO := CompareDate(DataHoje, DataDeIncio) = LessThanValue;
  // fDataDoSOMenorQueUltimoAcesso := (DataHoje < fDataUltimoAcesso);

  if fLicencaVencida or fDataDoSOMenorQueAplicacao then
    fDiasRestantes := -1
  else if fDataIncioMenorQueDataDoSO then
    fDiasRestantes := -1
  else
    fDiasRestantes := DaysBetween(DataHoje, DataVencimento);

  cnpj := TUtil.ExtrairNumeros(cnpj);
  aux := Copy(cnpj, length(cnpj) - 6, 6);

  fCnpjIguais := CompareStr(aux, cnpjLicenca) = 0;

  RESULT := (fDiasRestantes >= 0) and fCnpjIguais;

  // if fDiasRestantes < 0 then
  // SalvarUltimoAcesso(DataHoje);

  if Assigned(dadosDoArquivo) then
    FreeAndNil(dadosDoArquivo);

end;

function TLicenca.SerialToDate(numero: string): TDate;
var
  dia: Integer;
  mes: Integer;
  ano: Integer;
begin
  // 310717

  dia := StrToInt(Copy(numero, 0, 2));
  mes := StrToInt(Copy(numero, 3, 2));
  ano := StrToInt('20' + Copy(numero, 5, 2));

  RESULT := EncodeDate(ano, mes, dia);
end;

procedure TLicenca.SetCnpjIguais(const Value: Boolean);
begin
  fCnpjIguais := Value;
end;

procedure TLicenca.SetcnpjLicenca(const Value: string);
begin
  FcnpjLicenca := Value;
end;

procedure TLicenca.SetDataDeIncio(const Value: TDate);
begin
  FDataDeIncio := Value;
end;

procedure TLicenca.SetDataDoSOMenorQueAplicacao(
  const
  Value:
  Boolean);
begin
  fDataDoSOMenorQueAplicacao := Value;
end;

procedure TLicenca.SetDataDoSOMenorQueUltimoAcesso(
  const
  Value:
  Boolean);
begin
  fDataDoSOMenorQueUltimoAcesso := Value;
end;

procedure TLicenca.SetDataIncioMenorQueDataDoSO(
  const
  Value:
  Boolean);
begin
  fDataIncioMenorQueDataDoSO := Value;
end;

procedure TLicenca.SetDataVencimento(const Value: TDate);
begin
  FDataVencimento := Value;
end;

procedure TLicenca.SetDiasRestantes(
  const
  Value:
  Integer);
begin
  fDiasRestantes := Value;
end;

procedure TLicenca.SetLicencaVencida(
  const
  Value:
  Boolean);
begin
  fLicencaVencida := Value;
end;

end.
