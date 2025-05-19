inherited frmFiltroDatasNumCaixa: TfrmFiltroDatasNumCaixa
  Caption = 'Datas'
  TextHeight = 13
  inherited pnl1: TPanel
    inherited img2: TImage
      ExplicitLeft = 2
      ExplicitTop = -4
      ExplicitWidth = 370
      ExplicitHeight = 124
    end
    object Label2: TLabel [7]
      Left = 16
      Top = 69
      Width = 95
      Height = 13
      Caption = 'N'#250'mero do Caixa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbbNumeroDoCaixa: TComboBox
      Left = 16
      Top = 88
      Width = 302
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited act1: TActionList
    Left = 344
    Top = 8
  end
end
