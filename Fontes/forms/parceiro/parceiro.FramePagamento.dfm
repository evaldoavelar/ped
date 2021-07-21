object FramePagamento: TFramePagamento
  Left = 0
  Top = 0
  Width = 451
  Height = 74
  Align = alTop
  TabOrder = 0
  object Panel11: TPanel
    AlignWithMargins = True
    Left = 5
    Top = 5
    Width = 441
    Height = 64
    Margins.Left = 5
    Margins.Top = 5
    Margins.Right = 5
    Margins.Bottom = 5
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl2'
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 53
    object Panel12: TPanel
      AlignWithMargins = True
      Left = 100
      Top = 3
      Width = 338
      Height = 58
      Align = alClient
      BevelOuter = bvNone
      Caption = 'pnl2'
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 1
      ExplicitHeight = 47
      object lblValor: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 3
        Width = 335
        Height = 36
        Margins.Left = 0
        Align = alClient
        Alignment = taRightJustify
        Caption = 'R$ 100,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7368816
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
        ExplicitLeft = 237
        ExplicitWidth = 98
        ExplicitHeight = 30
      end
      object lblComissao: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 42
        Width = 325
        Height = 13
        Margins.Left = 10
        Margins.Top = 0
        Align = alBottom
        Alignment = taRightJustify
        Caption = 'R$ 2,50'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7368816
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitLeft = 298
        ExplicitTop = 31
        ExplicitWidth = 37
      end
    end
    object Panel13: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 91
      Height = 58
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'pnl2'
      Color = clWhite
      ParentBackground = False
      ShowCaption = False
      TabOrder = 0
      ExplicitHeight = 47
      object lblForma: TLabel
        AlignWithMargins = True
        Left = 5
        Top = 3
        Width = 83
        Height = 13
        Margins.Left = 5
        Margins.Bottom = 0
        Align = alTop
        Caption = 'DINHEIRO'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7368816
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 52
      end
      object lblCondicao: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 19
        Width = 78
        Height = 13
        Margins.Left = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'comiss'#227'o: 3%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7368816
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 68
      end
    end
  end
end
