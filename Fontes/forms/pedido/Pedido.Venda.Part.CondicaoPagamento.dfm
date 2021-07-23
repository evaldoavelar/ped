object ViewPartVendaFormaPagto: TViewPartVendaFormaPagto
  Left = 0
  Top = 0
  Width = 635
  Height = 46
  TabOrder = 0
  object Panel1: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 629
    Height = 40
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl2'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 52
    object Panel2: TPanel
      AlignWithMargins = True
      Left = 151
      Top = 3
      Width = 475
      Height = 34
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnl2'
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      ExplicitHeight = 46
      object lblAcrescimo: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 3
        Width = 421
        Height = 28
        Margins.Left = 0
        Align = alClient
        Alignment = taRightJustify
        Caption = '2%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10640128
        Font.Height = -24
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitLeft = 386
        ExplicitWidth = 35
        ExplicitHeight = 32
      end
      object pnl1: TPanel
        Left = 424
        Top = 0
        Width = 51
        Height = 34
        Align = alRight
        BevelOuter = bvNone
        Padding.Left = 5
        Padding.Right = 5
        TabOrder = 0
        ExplicitHeight = 46
        object img1: TImage
          Left = 5
          Top = 0
          Width = 41
          Height = 34
          Align = alClient
          Center = True
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
            003008060000005702F987000000097048597300000EC400000EC401952B0E1B
            000001724944415478DAEDD63D4AC4401407F0CC4776B2BBC1CAAD2CC4369588
            858578062F20F67B00157BF1067B0211CF201E401011042F6061B5D86C5832C9
            CC642761040DDB98086F82EF5F0D2F99E4FD924C1212F43C04BA010440378000
            E8061000DD0002A01B4000740308806EC03B4011454F3CCBF6D76DD342BC7329
            B711F057802C8E2F599EEF7CAF51AD8F89D69BEBF62F194B0D63773F5083C167
            94A6E720804288677B45F7BA1C4309F1114AB9858096006E01B42320B0801C04
            50E5713AAD00AD1107B399EA72FECE00391E5F3129CFDACC55C3E16DB4589C82
            02EC63746D1FA38B6A5C1292979C3FD41BB43EA2C6C4759D5265DF40F7F509B5
            3E24C66CD47347A39BC17279E20D40733EE74A4D5CFDCDD6936A6CC270CE8A62
            E2F679A14AED7A05600E601A00E6006503401C40F902E8FD1D40003400D70002
            FE3BE06B0D048428FB7FFF5A0D695124F68B1B35EB169204AEEEDD1AF8F55C1F
            00D041007410001D04400701D041007410009DDE0356EA265140A4618CDC0000
            000049454E44AE426082}
          ExplicitLeft = -24
          ExplicitTop = -32
          ExplicitWidth = 105
          ExplicitHeight = 105
        end
        object SpeedButton1: TSpeedButton
          Left = 5
          Top = 0
          Width = 41
          Height = 34
          Align = alClient
          Flat = True
          OnClick = SpeedButton1Click
          ExplicitLeft = 3
          ExplicitHeight = 42
        end
      end
    end
    object Panel3: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 142
      Height = 34
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnl2'
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      ExplicitHeight = 46
      object lblQuantasVezes: TLabel
        AlignWithMargins = True
        Left = 30
        Top = 22
        Width = 109
        Height = 13
        Margins.Left = 30
        Align = alTop
        Caption = 'A VISTA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10640128
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 38
      end
      object lblDescricao: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 3
        Width = 129
        Height = 13
        Margins.Left = 10
        Align = alTop
        Caption = 'DINHEIRO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10640128
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 52
      end
    end
  end
end
