object PedidoVendaPartItemCancelamento: TPedidoVendaPartItemCancelamento
  Left = 0
  Top = 0
  Width = 320
  Height = 20
  Color = clWhite
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  object pnlNumero: TPanel
    Left = 0
    Top = 0
    Width = 40
    Height = 20
    Align = alLeft
    BevelOuter = bvNone
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 4227072
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    ExplicitHeight = 19
  end
  object ViewPartVendaItens: TPanel
    AlignWithMargins = True
    Left = 43
    Top = 1
    Width = 274
    Height = 18
    Margins.Top = 1
    Margins.Bottom = 1
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -255
    ExplicitWidth = 575
    ExplicitHeight = 17
    object lblDescricao: TLabel
      Left = 0
      Top = 0
      Width = 274
      Height = 18
      Margins.Left = 10
      Margins.Bottom = 0
      Align = alClient
      AutoSize = False
      Caption = 'Cancelamento'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentColor = False
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
      ExplicitLeft = 13
      ExplicitTop = 8
      ExplicitWidth = 390
      ExplicitHeight = 26
    end
  end
end
