inherited FrmParceiroInfoPagto: TFrmParceiroInfoPagto
  BorderStyle = bsDialog
  Caption = 'PARCEIRO'
  ClientHeight = 427
  ClientWidth = 488
  OnShow = FormShow
  ExplicitWidth = 494
  ExplicitHeight = 456
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 488
    Height = 384
    Align = alClient
    BevelOuter = bvNone
    Color = 15790320
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      488
      384)
    object Label1: TLabel
      Left = 12
      Top = 74
      Width = 185
      Height = 13
      Caption = 'ESCOLHA A FORMA DE PAGAMENTO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblValorPagamento: TLabel
      Left = 12
      Top = 322
      Width = 168
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'INFORE O VALOR DO PAGAMENTO'
      Font.Charset = ANSI_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 12
      Top = 11
      Width = 115
      Height = 13
      Caption = 'INFORME O PARCEIRO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Panel3: TPanel
      Left = 10
      Top = 340
      Width = 204
      Height = 32
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 13882323
      Padding.Left = 1
      Padding.Top = 1
      Padding.Right = 1
      Padding.Bottom = 1
      ParentBackground = False
      TabOrder = 3
      object edtValorPagto: TJvCalcEdit
        Left = 1
        Top = 1
        Width = 109
        Height = 30
        Margins.Left = 1
        Margins.Top = 1
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        BorderStyle = bsNone
        Color = 15329769
        DisplayFormat = ',0.00;-,0.00'
        Font.Charset = ANSI_CHARSET
        Font.Color = 10639360
        Font.Height = -24
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        MaxLength = 9
        ParentFont = False
        ShowButton = False
        TabOrder = 0
        DecimalPlacesAlwaysShown = False
        OnKeyPress = edtValorPagtoKeyPress
      end
      object Panel4: TPanel
        Left = 110
        Top = 1
        Width = 93
        Height = 30
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object btnAdicionar: TSpeedButton
          Left = 0
          Top = 0
          Width = 93
          Height = 30
          Action = actAdicionar
          Align = alClient
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitLeft = 2
        end
      end
    end
    object Panel5: TPanel
      Left = 235
      Top = 0
      Width = 253
      Height = 384
      Align = alRight
      BevelOuter = bvNone
      Color = 15066597
      ParentBackground = False
      TabOrder = 0
      object scrBoxPagamentos: TScrollBox
        Left = 0
        Top = 0
        Width = 253
        Height = 273
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 15066597
        ParentColor = False
        TabOrder = 0
        object Panel8: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 63
          Width = 247
          Height = 54
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnl2'
          Color = clWhite
          ParentBackground = False
          ShowCaption = False
          TabOrder = 1
          object Panel9: TPanel
            AlignWithMargins = True
            Left = 97
            Top = 3
            Width = 147
            Height = 48
            Align = alClient
            BevelOuter = bvNone
            Caption = 'pnl2'
            Color = clWhite
            ParentBackground = False
            ShowCaption = False
            TabOrder = 1
            object Label2: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 3
              Width = 144
              Height = 42
              Margins.Left = 0
              Align = alClient
              Alignment = taRightJustify
              Caption = 'R$ 500,00'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 10639360
              Font.Height = -21
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              Layout = tlCenter
              WordWrap = True
              ExplicitLeft = 46
              ExplicitWidth = 98
              ExplicitHeight = 30
            end
          end
          object Panel10: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 88
            Height = 48
            Align = alLeft
            BevelOuter = bvNone
            Caption = 'pnl2'
            Color = clWhite
            ParentBackground = False
            ShowCaption = False
            TabOrder = 0
            object Label4: TLabel
              AlignWithMargins = True
              Left = 10
              Top = 35
              Width = 75
              Height = 13
              Margins.Left = 10
              Align = alTop
              Caption = 'A VISTA'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7368816
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              WordWrap = True
              ExplicitWidth = 38
            end
            object Label5: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 3
              Width = 80
              Height = 26
              Margins.Left = 5
              Align = alTop
              Caption = 'CART'#195'O DE CR'#201'DITO'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7368816
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = [fsBold]
              ParentFont = False
              WordWrap = True
              ExplicitWidth = 63
            end
          end
        end
        object Panel11: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 247
          Height = 54
          Align = alTop
          BevelOuter = bvNone
          Caption = 'pnl2'
          Color = clWhite
          ParentBackground = False
          ShowCaption = False
          TabOrder = 0
          object Panel12: TPanel
            AlignWithMargins = True
            Left = 97
            Top = 3
            Width = 147
            Height = 48
            Align = alClient
            BevelOuter = bvNone
            Caption = 'pnl2'
            Color = clWhite
            ParentBackground = False
            ShowCaption = False
            TabOrder = 1
            object Label6: TLabel
              AlignWithMargins = True
              Left = 0
              Top = 3
              Width = 144
              Height = 42
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
              ExplicitLeft = 46
              ExplicitWidth = 98
              ExplicitHeight = 30
            end
          end
          object Panel13: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 88
            Height = 48
            Align = alLeft
            BevelOuter = bvNone
            Caption = 'pnl2'
            Color = clWhite
            ParentBackground = False
            ShowCaption = False
            TabOrder = 0
            object Label7: TLabel
              AlignWithMargins = True
              Left = 10
              Top = 22
              Width = 75
              Height = 13
              Margins.Left = 10
              Align = alTop
              Caption = 'A VISTA'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 7368816
              Font.Height = -11
              Font.Name = 'Segoe UI'
              Font.Style = []
              ParentFont = False
              WordWrap = True
              ExplicitWidth = 38
            end
            object Label8: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 3
              Width = 80
              Height = 13
              Margins.Left = 5
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
          end
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 273
        Width = 253
        Height = 111
        Margins.Top = 15
        Margins.Bottom = 20
        Align = alBottom
        BevelOuter = bvNone
        Color = 10639360
        ParentBackground = False
        TabOrder = 1
        object Label14: TLabel
          AlignWithMargins = True
          Left = 110
          Top = 43
          Width = 15
          Height = 17
          Margins.Left = 25
          Margins.Top = 0
          Margins.Bottom = 5
          Caption = 'R$'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 500714
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lblValorLiquido: TLabel
          AlignWithMargins = True
          Left = 142
          Top = 31
          Width = 111
          Height = 34
          AutoSize = False
          Caption = '600,00'
          Color = 6179124
          Font.Charset = ANSI_CHARSET
          Font.Color = 500714
          Font.Height = -27
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
        object Label9: TLabel
          AlignWithMargins = True
          Left = 8
          Top = 21
          Width = 125
          Height = 17
          Margins.Left = 25
          Margins.Top = 0
          Margins.Bottom = 5
          Caption = 'TOTAL PAGAMENTO'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 500714
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label10: TLabel
          AlignWithMargins = True
          Left = 8
          Top = 72
          Width = 93
          Height = 13
          Margins.Left = 25
          Margins.Top = 0
          Margins.Bottom = 5
          Caption = 'TOTAL COMISS'#195'O'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 500714
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 110
          Top = 87
          Width = 15
          Height = 17
          Margins.Left = 25
          Margins.Top = 0
          Margins.Bottom = 5
          Caption = 'R$'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 500714
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
        object lblTotalComissao: TLabel
          AlignWithMargins = True
          Left = 142
          Top = 77
          Width = 111
          Height = 29
          AutoSize = False
          Caption = '30,00'
          Color = 6179124
          Font.Charset = ANSI_CHARSET
          Font.Color = 500714
          Font.Height = -21
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Layout = tlCenter
        end
      end
    end
    object Panel7: TPanel
      Left = 12
      Top = 93
      Width = 203
      Height = 223
      BevelOuter = bvNone
      Color = clWhite
      Padding.Left = 5
      Padding.Top = 5
      Padding.Right = 5
      Padding.Bottom = 5
      ParentBackground = False
      TabOrder = 2
      object lstFormaPagto: TListBox
        Left = 5
        Top = 5
        Width = 193
        Height = 213
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ItemHeight = 17
        Items.Strings = (
          'Dinheiro'
          'Cart'#227'o Cr'#233'dito'
          'Cart'#227'o D'#233'bito'
          'Cheque')
        ParentFont = False
        TabOrder = 0
        OnEnter = lstFormaPagtoEnter
        OnExit = lstFormaPagtoExit
        OnKeyPress = lstFormaPagtoKeyPress
      end
    end
    object cbbParceiro: TComboBox
      Left = 11
      Top = 30
      Width = 204
      Height = 27
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'ALEX'
      OnKeyPress = cbbParceiroKeyPress
      Items.Strings = (
        'ALEX'
        'EGUINALDO')
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 387
    Width = 482
    Height = 40
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    Color = 16119285
    ParentBackground = False
    TabOrder = 1
    object Label11: TLabel
      Left = 0
      Top = 0
      Width = 196
      Height = 40
      Align = alLeft
      Alignment = taCenter
      Caption = 'F6-Excluir Pagamento  End-Finaliza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitHeight = 13
    end
    object btnIncluir: TBitBtn
      Left = 293
      Top = 6
      Width = 75
      Height = 25
      Action = actIncluir
      Caption = 'Finaliza'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnCancelar: TBitBtn
      Left = 393
      Top = 6
      Width = 75
      Height = 25
      Action = actCancelar
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object ActionList1: TActionList
    Left = 232
    Top = 216
    object actAdicionar: TAction
      Caption = 'Adicionar >>'
      OnExecute = actAdicionarExecute
    end
    object actIncluir: TAction
      Caption = 'Finaliza'
      ShortCut = 35
      OnExecute = actIncluirExecute
    end
    object actCancelar: TAction
      Caption = 'Cancelar'
      ShortCut = 27
      OnExecute = actCancelarExecute
    end
    object actExcluiPagamento: TAction
      Caption = 'actExcluiPagamento'
      ShortCut = 117
      OnExecute = actExcluiPagamentoExecute
    end
  end
end
