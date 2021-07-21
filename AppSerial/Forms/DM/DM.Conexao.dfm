object DMConexao: TDMConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 265
  Width = 423
  object conMobile: TFDConnection
    Params.Strings = (
      'Database=E:\Pessoal\branches\Las\AppSerial\database\serial.db3'
      'OpenMode=ReadWrite'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = conMobileBeforeConnect
    Left = 160
    Top = 96
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 280
    Top = 96
  end
end
