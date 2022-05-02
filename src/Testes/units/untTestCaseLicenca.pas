unit untTestCaseLicenca;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, Sistema.TLicenca, System.SysUtils, System.DateUtils,
  System.Classes, Util.Exceptions;

type
  // Test methods for class TLicenca

  TestTLicenca = class(TTestCase)
  strict private
    FLicenca: TLicenca;
    FArquivoLicenca: string;
  private

  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLicencaPodeValidarZeroDiasRestantes;
    procedure TestLicencaNaoPodeValidarAlteracaoNoArquivo;
    procedure TestLicencaDataInicioMenorQueSO;
    procedure TestLicencaNaoPodeValidarLicencaVencida;
    procedure TestLicencaPodeValidarLicenca;

  end;

implementation

uses
  Vcl.Forms;

procedure TestTLicenca.SetUp;
begin
  FLicenca := TLicenca.Create;
  FArquivoLicenca := ExtractFilePath(Application.exeName) + '\licenca.evd';

end;

procedure TestTLicenca.TearDown;
begin
  FLicenca.Free;
  FLicenca := nil;
end;

procedure TestTLicenca.TestLicencaPodeValidarLicenca;
var
  ReturnValue: Boolean;
  DataIncio: TDate;
  DataValidade: TDate;
  DataSO: TDate;
  cnpj:string;
begin

  cnpj := '123456';
  DataIncio := Now;
  DataValidade := incDay(Now, 10);
  DataSO := incDay(Now, 5);

  FLicenca.GeraArquivoLicenca(FArquivoLicenca,cnpj, DataIncio, DataValidade);
  FLicenca.Free;

  FLicenca := TLicenca.Create;

  ReturnValue := FLicenca.LicencaValida(FArquivoLicenca,cnpj, DataSO);

  CheckTrue(ReturnValue, 'Deveria retornar true - Licen�a  v�lida');
  CheckEquals(4, FLicenca.DiasRestantes);

end;

procedure TestTLicenca.TestLicencaPodeValidarZeroDiasRestantes;
var
  ReturnValue: Boolean;
  DataIncio: TDate;
  DataValidade: TDate;
  DataSO: TDate;
  cnpj:string;
begin

  cnpj := '123456';

  DataIncio := Now;
  DataValidade := incDay(Now, 10);
  DataSO := incDay(Now, 10);

  FLicenca.GeraArquivoLicenca(FArquivoLicenca,cnpj, DataIncio, DataValidade);

  ReturnValue := FLicenca.LicencaValida(FArquivoLicenca,cnpj, DataSO);

  CheckTrue(ReturnValue, 'Deveria retornar true - Licen�a  v�lida');
  CheckEquals(0, FLicenca.DiasRestantes);
end;

procedure TestTLicenca.TestLicencaNaoPodeValidarLicencaVencida;
var
  ReturnValue: Boolean;
  DataIncio: TDate;
  DataValidade: TDate;
  DataSO: TDate;
  cnpj:string;
begin

  cnpj := '123456';

  DataIncio := Now;
  DataValidade := incDay(Now, 10);
  DataSO := incDay(Now, 11);

  FLicenca.GeraArquivoLicenca(FArquivoLicenca,cnpj, DataIncio, DataValidade);

  ReturnValue := FLicenca.LicencaValida(FArquivoLicenca,cnpj,DataSO);

  CheckFalse(ReturnValue, 'Deveria retornar falso - Licen�a vencida');
  CheckEquals(-1, FLicenca.DiasRestantes);

end;

procedure TestTLicenca.TestLicencaDataInicioMenorQueSO;
var
  ReturnValue: Boolean;
  DataIncio: TDate;
  DataValidade: TDate;
  DataSO: TDate;
  cnpj:string;
begin

  cnpj := '123456';

  DataIncio := Now;
  DataValidade := incDay(Now, 10);
  DataSO := incDay(Now, -10);

  FLicenca.GeraArquivoLicenca(FArquivoLicenca,cnpj, DataIncio, DataValidade);

  ReturnValue := FLicenca.LicencaValida(FArquivoLicenca,cnpj, DataSO);

  CheckFalse(ReturnValue, 'Deveria retornar false - Licen�a data so so foi alterada');
  CheckEquals(-1, FLicenca.DiasRestantes);

end;

procedure TestTLicenca.TestLicencaNaoPodeValidarAlteracaoNoArquivo;
var
  ReturnValue: Boolean;
  arquivo: TStringList;
  txt: string;
  cnpj:string;
begin

  cnpj := '123456';

  FLicenca.GeraArquivoLicenca(FArquivoLicenca,cnpj, Now, incDay(Now, 10));

  arquivo := TStringList.Create;
  arquivo.LoadFromFile(FArquivoLicenca);
  txt := Trim(arquivo.Text);
  arquivo.Text := Copy(txt, 0, 2) + 'D' + Copy(txt, 3, length(txt) - 1);
  arquivo.SaveToFile(FArquivoLicenca);
  arquivo.Free;

  StartExpectingException(TValidacaoException);
  ReturnValue := FLicenca.LicencaValida(FArquivoLicenca,cnpj, Now);
  StopExpectingException();

  CheckFalse(ReturnValue, 'validou Licen�a alterada!');
end;

initialization

// Register any test cases with the test runner
RegisterTest(TestTLicenca.Suite);

end.