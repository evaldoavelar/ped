inherited frmParcelasVencendo: TfrmParcelasVencendo
  BorderStyle = bsDialog
  Caption = 'Vencimentos nos pr'#243'ximos 30 dias'
  ClientHeight = 530
  ClientWidth = 554
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnShow = FormShow
  ExplicitWidth = 560
  ExplicitHeight = 558
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 489
    Width = 554
    Height = 41
    Align = alBottom
    Color = 15790320
    ParentBackground = False
    TabOrder = 1
    DesignSize = (
      554
      41)
    object btn1: TBitBtn
      Left = 442
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 0
    end
    object btnImprimir: TBitBtn
      Left = 16
      Top = 8
      Width = 97
      Height = 25
      Action = actImprimir
      Caption = 'Imprimir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
  end
  object CategoryPanelGroup: TCategoryPanelGroup
    Left = 0
    Top = 0
    Width = 554
    Height = 489
    VertScrollBar.Tracking = True
    Align = alClient
    ChevronColor = clWhite
    ChevronHotColor = 4227072
    Color = clWindow
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    GradientBaseColor = 5258796
    GradientColor = 5258796
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWhite
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = [fsBold]
    ParentFont = False
    PopupMenu = pm1
    TabOrder = 0
    object CategoryPanel1: TCategoryPanel
      Top = 0
      Height = 81
      Caption = 'CategoryPanel1'
      TabOrder = 0
      Visible = False
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 550
        Height = 33
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 8
          Width = 31
          Height = 13
          Caption = 'Label1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15641856
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 72
          Top = 8
          Width = 31
          Height = 13
          Caption = 'Label1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15641856
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 360
          Top = 8
          Width = 31
          Height = 13
          Caption = 'Label1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15641856
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object btn2: TSpeedButton
          Left = 443
          Top = 1
          Width = 19
          Height = 18
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 15641856
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object pm1: TPopupMenu
    Left = 232
    Top = 264
    object actCloseALL1: TMenuItem
      Action = actOpenALL
    end
    object Expandir1: TMenuItem
      Action = actCloseALL
    end
  end
  object ActionList1: TActionList
    Left = 320
    Top = 248
    object actCloseALL: TAction
      Caption = 'Fechar'
      OnExecute = actCloseALLExecute
    end
    object actOpenALL: TAction
      Caption = 'Expandir'
      OnExecute = actOpenALLExecute
    end
    object actImprimir: TAction
      Caption = 'Imprimir'
      OnExecute = actImprimirExecute
    end
  end
end
