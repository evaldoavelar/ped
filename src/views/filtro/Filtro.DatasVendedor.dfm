inherited frmFiltroDataVendedor: TfrmFiltroDataVendedor
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnl1: TPanel
    inherited img2: TImage
      ExplicitLeft = 0
      ExplicitTop = 2
      ExplicitWidth = 370
      ExplicitHeight = 124
    end
    object Label2: TLabel [7]
      Left = 16
      Top = 69
      Width = 54
      Height = 13
      Caption = 'Vendedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbbVendedor: TComboBox
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
      OnSelect = cbbVendedorSelect
    end
  end
  inherited pnl2: TPanel
    inherited btnImprimir: TBitBtn
      OnClick = btnImprimirClick
    end
  end
end
