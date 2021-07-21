object WebModulePrincipal: TWebModulePrincipal
  OldCreateOrder = False
  Actions = <>
  Height = 187
  Width = 456
  object DSServer1: TDSServer
    Left = 144
    Top = 16
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    Left = 240
    Top = 16
  end
  object DSRESTWebDispatcher1: TDSRESTWebDispatcher
    Server = DSServer1
    Left = 144
    Top = 96
  end
end
