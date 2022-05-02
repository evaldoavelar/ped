object PedidoVendaFramePartItem: TPedidoVendaFramePartItem
  Left = 0
  Top = 0
  Width = 638
  Height = 42
  TabOrder = 0
  object Panel33: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 2
    Width = 632
    Height = 38
    Margins.Top = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl2'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object pnlNumero: TPanel
      Left = 0
      Top = 0
      Width = 40
      Height = 38
      Align = alLeft
      BevelOuter = bvNone
      Caption = '1'
      Color = 14211288
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
    end
    object pnlCodigoPrd: TPanel
      AlignWithMargins = True
      Left = 43
      Top = 0
      Width = 87
      Height = 38
      Margins.Top = 0
      Margins.Bottom = 0
      Align = alLeft
      BevelOuter = bvNone
      Caption = '1234567891234'
      Color = 16119285
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
    end
    object ViewPartVendaItens: TPanel
      Left = 133
      Top = 0
      Width = 499
      Height = 38
      Margins.Left = 0
      Margins.Right = 0
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      object lblDescricao: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 3
        Width = 491
        Height = 16
        Margins.Left = 5
        Margins.Bottom = 0
        Align = alTop
        AutoSize = False
        Caption = 
          'LIVRO MOSHI MOSHI KAWAII: ONDE ESTA O MOSHI MORANGO? - VERBARA E' +
          ' RIBA EDITORAS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        Transparent = True
        WordWrap = True
        ExplicitLeft = 8
        ExplicitTop = 10
        ExplicitWidth = 365
      end
      object pnlPreco: TPanel
        Left = 0
        Top = 19
        Width = 499
        Height = 19
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblTotalDesc: TLabel
          AlignWithMargins = True
          Left = 320
          Top = 0
          Width = 176
          Height = 16
          Margins.Left = 5
          Margins.Top = 0
          Align = alClient
          Caption = '17,90'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitWidth = 27
          ExplicitHeight = 13
        end
        object lblDesconto: TLabel
          AlignWithMargins = True
          Left = 255
          Top = 0
          Width = 57
          Height = 16
          Margins.Top = 0
          Align = alLeft
          Alignment = taCenter
          AutoSize = False
          Caption = '-2,79'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          ExplicitHeight = 12
        end
        object lblPreco: TLabel
          AlignWithMargins = True
          Left = 30
          Top = 0
          Width = 131
          Height = 16
          Margins.Left = 30
          Margins.Top = 0
          Align = alLeft
          AutoSize = False
          Caption = '1,00  x N  17,90'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          ExplicitHeight = 12
        end
        object lblTotal: TLabel
          AlignWithMargins = True
          Left = 167
          Top = 0
          Width = 82
          Height = 16
          Margins.Top = 0
          Align = alLeft
          Alignment = taCenter
          AutoSize = False
          Caption = '9.999.999,99'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
          ExplicitHeight = 12
        end
      end
    end
  end
end
