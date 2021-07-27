inherited FrmEstoqueAtualizar: TFrmEstoqueAtualizar
  Caption = 'Estoque'
  ClientHeight = 432
  ClientWidth = 760
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 776
  ExplicitHeight = 471
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 760
    Height = 432
    ActivePage = tsEntrada
    Align = alClient
    TabOrder = 0
    object tsEntrada: TTabSheet
      Caption = 'tsEntrada'
      object jvPnl1: TPanel
        Left = 0
        Top = 0
        Width = 752
        Height = 63
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Color = 16513014
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Yu Gothic UI Semibold'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object GridPanel1: TGridPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 746
          Height = 63
          Align = alTop
          BevelOuter = bvNone
          ColumnCollection = <
            item
              Value = 60.251106069949760000
            end
            item
              Value = 21.014516731306680000
            end
            item
              Value = 18.734377198743560000
            end>
          ControlCollection = <
            item
              Column = 0
              Control = pnl1
              Row = 0
            end
            item
              Column = 1
              Control = Panel2
              Row = 0
            end
            item
              Column = 2
              Control = Panel7
              Row = 0
            end>
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5066061
          Font.Height = -11
          Font.Name = 'Yu Gothic UI Semibold'
          Font.Style = []
          ParentFont = False
          RowCollection = <
            item
              Value = 100.000000000000000000
            end>
          TabOrder = 0
          object pnl1: TPanel
            Left = 0
            Top = 0
            Width = 449
            Height = 63
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object Panel1: TPanel
              Left = 0
              Top = 0
              Width = 146
              Height = 63
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object Label5: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 140
                Height = 14
                Align = alTop
                Caption = 'QUANTIDADE:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 3815994
                Font.Height = -11
                Font.Name = 'Yu Gothic Medium'
                Font.Style = []
                ParentFont = False
                ExplicitWidth = 74
              end
              object Panel12: TPanel
                AlignWithMargins = True
                Left = 3
                Top = 23
                Width = 128
                Height = 26
                Margins.Right = 15
                Align = alTop
                BevelKind = bkFlat
                BevelOuter = bvNone
                Caption = 'pnl1'
                Color = 15000804
                ParentBackground = False
                ShowCaption = False
                TabOrder = 0
                object btnIncrementaQuantidade: TSpeedButton
                  Left = 91
                  Top = 0
                  Width = 33
                  Height = 22
                  Margins.Left = 0
                  Margins.Top = 5
                  Margins.Right = 5
                  Margins.Bottom = 5
                  Action = actIncrementaQuantidade
                  Align = alRight
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 5066061
                  Font.Height = -16
                  Font.Name = 'Yu Gothic Medium'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ExplicitLeft = 102
                  ExplicitTop = -2
                  ExplicitHeight = 17
                end
                object btnSubtraiQuantidade: TSpeedButton
                  Left = 0
                  Top = 0
                  Width = 33
                  Height = 22
                  Margins.Left = 5
                  Margins.Top = 5
                  Margins.Right = 0
                  Margins.Bottom = 5
                  Action = actSubtraiQuantidade
                  Align = alLeft
                  Flat = True
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 5066061
                  Font.Height = -19
                  Font.Name = 'Yu Gothic Medium'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ExplicitHeight = 49
                end
                object edtQuantidade: TEdit
                  Left = 33
                  Top = 0
                  Width = 58
                  Height = 22
                  Margins.Left = 0
                  Margins.Top = 6
                  Margins.Right = 0
                  Margins.Bottom = 6
                  Align = alClient
                  Alignment = taCenter
                  BevelInner = bvNone
                  BevelOuter = bvNone
                  BorderStyle = bsNone
                  Color = clWhite
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 5066061
                  Font.Height = -13
                  Font.Name = 'Segoe UI'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 0
                  Text = '1'
                  OnKeyPress = edtQuantidadeKeyPress
                end
              end
            end
            object Panel5: TPanel
              Left = 146
              Top = 0
              Width = 303
              Height = 63
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 1
              object lbl2: TLabel
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 297
                Height = 13
                Align = alTop
                Caption = 'PRODUTO'
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 5066061
                Font.Height = -11
                Font.Name = 'Yu Gothic UI Semibold'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
                Transparent = True
                ExplicitWidth = 51
              end
              object edtPesquisaProduto: TAutoComplete
                AlignWithMargins = True
                Left = 3
                Top = 24
                Width = 297
                Height = 25
                Margins.Top = 5
                Align = alTop
                CharCase = ecUpperCase
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 5066061
                Font.Height = -13
                Font.Name = 'Yu Gothic Medium'
                Font.Style = []
                ParentFont = False
                TabOrder = 0
                Text = 'PESQUISA...'
                OnClick = edtPesquisaProdutoClick
                OnKeyPress = edtPesquisaProdutoKeyPress
                OnKeyUp = edtPesquisaProdutoKeyUp
                DropDownWidth = 0
              end
            end
          end
          object Panel2: TPanel
            Left = 449
            Top = 0
            Width = 156
            Height = 63
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            DesignSize = (
              156
              63)
            object Label2: TLabel
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 150
              Height = 13
              Hint = 'N'#218'MERO DA NOTA FISCAL DE COMPRA'
              Align = alTop
              Caption = 'N'#218'MERO NF'
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5066061
              Font.Height = -11
              Font.Name = 'Yu Gothic UI Semibold'
              Font.Style = [fsBold]
              ParentColor = False
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              Transparent = True
              ExplicitWidth = 64
            end
            object edtNumeroNF: TEdit
              AlignWithMargins = True
              Left = 3
              Top = 24
              Width = 150
              Height = 25
              Margins.Top = 5
              Align = alTop
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5066061
              Font.Height = -13
              Font.Name = 'Yu Gothic UI Semibold'
              Font.Style = []
              MaxLength = 40
              ParentFont = False
              TabOrder = 1
              OnKeyPress = edtNumeroNFKeyPress
            end
            object Panel6: TPanel
              Left = 214
              Top = 23
              Width = 28
              Height = 22
              Anchors = [akTop, akRight]
              BevelOuter = bvNone
              Color = 10640128
              ParentBackground = False
              TabOrder = 0
              object Image6: TImage
                Left = 0
                Top = 0
                Width = 28
                Height = 22
                Align = alClient
                Center = True
                Picture.Data = {
                  0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
                  00200806000000737A7AF4000000097048597300000EC400000EC401952B0E1B
                  000001204944415478DA63641860C038EA8051078C3A60D40144AA6382D2FF90
                  D8C8005D1CC6FF376C4260601DF0E7CF9F4E2626260F520CFEF7EFDF11161696
                  6CAA38E0CB972F3C9C9C9C7B818E30FBFFFF3F032323441B8C8D4E032DBFF2FD
                  FB777B1E1E9E7754710008000D146163633B087484163E7540473CF8F5EB9735
                  0707C73362CC25250D30011D21C3CECE7E18C896C3A1E615D0725BA0E5B718A8
                  9C0BE0D9F0E7CF9F1AACACAC204788A0A9F9044C2B8EC050BAC040836C8892F7
                  81BE340126B0BD40260F34EE7F012DF7045A7E004D1F6D1C0075840BD0119B81
                  4C96BF7FFF8602436503167DB42D88808E080386001FD0F239E49A41AE03F0C5
                  2F51714F890390EB056C16A3D3547300B2C1E8009BC5A395D1A803461D30EA80
                  A1E100006B296B2134B39A4A0000000049454E44AE426082}
                ExplicitTop = 4
                ExplicitHeight = 25
              end
              object btnIncluirProduto1: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 22
                Height = 16
                Align = alClient
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 10639360
                Font.Height = -13
                Font.Name = 'Yu Gothic UI Semibold'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                ExplicitLeft = 6
                ExplicitTop = 6
                ExplicitHeight = 18
              end
            end
          end
          object Panel7: TPanel
            Left = 605
            Top = 0
            Width = 141
            Height = 63
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 2
            DesignSize = (
              141
              63)
            object Panel8: TPanel
              Left = 217
              Top = 23
              Width = 28
              Height = 22
              Anchors = [akTop, akRight]
              BevelOuter = bvNone
              Color = 10640128
              ParentBackground = False
              TabOrder = 1
              object Image4: TImage
                Left = 0
                Top = 0
                Width = 28
                Height = 22
                Align = alClient
                Center = True
                Picture.Data = {
                  0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
                  00200806000000737A7AF4000000097048597300000EC400000EC401952B0E1B
                  000001204944415478DA63641860C038EA8051078C3A60D40144AA6382D2FF90
                  D8C8005D1CC6FF376C4260601DF0E7CF9F4E2626260F520CFEF7EFDF11161696
                  6CAA38E0CB972F3C9C9C9C7B818E30FBFFFF3F032323441B8C8D4E032DBFF2FD
                  FB777B1E1E9E7754710008000D146163633B087484163E7540473CF8F5EB9735
                  0707C73362CC25250D30011D21C3CECE7E18C896C3A1E615D0725BA0E5B718A8
                  9C0BE0D9F0E7CF9F1AACACAC204788A0A9F9044C2B8EC050BAC040836C8892F7
                  81BE340126B0BD40260F34EE7F012DF7045A7E004D1F6D1C0075840BD0119B81
                  4C96BF7FFF8602436503167DB42D88808E080386001FD0F239E49A41AE03F0C5
                  2F51714F890390EB056C16A3D3547300B2C1E8009BC5A395D1A803461D30EA80
                  A1E100006B296B2134B39A4A0000000049454E44AE426082}
                ExplicitTop = 4
                ExplicitHeight = 25
              end
              object SpeedButton2: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 22
                Height = 16
                Align = alClient
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 10639360
                Font.Height = -13
                Font.Name = 'Yu Gothic UI Semibold'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                ExplicitLeft = 6
                ExplicitTop = 6
                ExplicitHeight = 18
              end
            end
            object Panel9: TPanel
              Left = 7
              Top = 22
              Width = 28
              Height = 24
              BevelOuter = bvNone
              Color = 10640128
              ParentBackground = False
              TabOrder = 0
              object Image5: TImage
                Left = 0
                Top = 0
                Width = 28
                Height = 24
                Align = alClient
                Center = True
                Picture.Data = {
                  0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
                  00200806000000737A7AF4000000097048597300000EC400000EC401952B0E1B
                  000001204944415478DA63641860C038EA8051078C3A60D40144AA6382D2FF90
                  D8C8005D1CC6FF376C4260601DF0E7CF9F4E2626260F520CFEF7EFDF11161696
                  6CAA38E0CB972F3C9C9C9C7B818E30FBFFFF3F032323441B8C8D4E032DBFF2FD
                  FB777B1E1E9E7754710008000D146163633B087484163E7540473CF8F5EB9735
                  0707C73362CC25250D30011D21C3CECE7E18C896C3A1E615D0725BA0E5B718A8
                  9C0BE0D9F0E7CF9F1AACACAC204788A0A9F9044C2B8EC050BAC040836C8892F7
                  81BE340126B0BD40260F34EE7F012DF7045A7E004D1F6D1C0075840BD0119B81
                  4C96BF7FFF8602436503167DB42D88808E080386001FD0F239E49A41AE03F0C5
                  2F51714F890390EB056C16A3D3547300B2C1E8009BC5A395D1A803461D30EA80
                  A1E100006B296B2134B39A4A0000000049454E44AE426082}
                ExplicitTop = 4
                ExplicitHeight = 25
              end
              object btnIncluir: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 3
                Width = 22
                Height = 18
                Action = actIncluir
                Align = alClient
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 10639360
                Font.Height = -13
                Font.Name = 'Yu Gothic UI Semibold'
                Font.Style = []
                ParentFont = False
                ParentShowHint = False
                ShowHint = True
                ExplicitLeft = 6
                ExplicitTop = 6
              end
            end
          end
        end
      end
      object pnl3: TPanel
        AlignWithMargins = True
        Left = 25
        Top = 68
        Width = 702
        Height = 3
        Margins.Left = 25
        Margins.Top = 5
        Margins.Right = 25
        Margins.Bottom = 5
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel9'
        Color = 500714
        ParentBackground = False
        ShowCaption = False
        TabOrder = 1
      end
      object scrlProdutos: TScrollBox
        Left = 0
        Top = 76
        Width = 752
        Height = 284
        Margins.Left = 15
        Margins.Top = 0
        Margins.Right = 15
        Margins.Bottom = 6
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = 16382457
        ParentColor = False
        TabOrder = 2
        object pnl2: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 746
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object pnlNumero: TPanel
            Left = 0
            Top = 0
            Width = 40
            Height = 41
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
            Height = 41
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
            Width = 562
            Height = 41
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
              Width = 554
              Height = 16
              Margins.Left = 5
              Margins.Bottom = 0
              Align = alTop
              AutoSize = False
              Caption = 'OL'#201'O MOTOR 5W30 SINT'#201'TICO SELENIA'
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
              Width = 562
              Height = 22
              Align = alClient
              BevelOuter = bvNone
              ParentColor = True
              TabOrder = 0
              object lblPreco: TLabel
                AlignWithMargins = True
                Left = 30
                Top = 0
                Width = 131
                Height = 19
                Margins.Left = 30
                Margins.Top = 0
                Align = alLeft
                AutoSize = False
                Caption = '1,00  UNIDADE(S)'
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
                Width = 170
                Height = 19
                Margins.Top = 0
                Align = alLeft
                Alignment = taCenter
                AutoSize = False
                Caption = 'NOTA FISCAL: 9.999.999,99'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 10639360
                Font.Height = -11
                Font.Name = 'Segoe UI'
                Font.Style = [fsBold]
                ParentFont = False
                WordWrap = True
              end
            end
          end
          object pnlCancelar: TPanel
            Left = 695
            Top = 0
            Width = 51
            Height = 41
            Align = alRight
            BevelOuter = bvNone
            Color = clWhite
            Padding.Left = 5
            Padding.Right = 5
            ParentBackground = False
            TabOrder = 3
            object img1: TImage
              Left = 5
              Top = 0
              Width = 41
              Height = 41
              Align = alClient
              Center = True
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
                00200806000000737A7AF4000000097048597300000EC400000EC401952B0E1B
                000001DA4944415478DAEDD5314FC2401400E0DE5D29841603C10809AC1A0766
                E2803191C9C5FFE0A271D138187F82A3D1490713F537986862D0C1C9C4C120A3
                617400020468D1EBB5F561C010BC06F03438F4920E3D5EEF7D69DF7B2069C20B
                79000FE001FE3DA01D8D269546E354B2ED8C84509E05831BFE4623CF8BD563B1
                697FADB68F2C2BED60FC48C3E1BD60B95C1102309F2F474C73B977EF2054659A
                96559ACDA7FEB8663C3E03C972D8B252BD3DCBE7BB954D332B04B008B1E050DC
                BF3788E025FF8C830B0FC9311C20CBCF98B1D4E07E0FF1AEAAAFBCE49D65635C
                27B61D1102504D5B9075FD46721CEDFBD3A80ADFBA04DF7C9EF72CD4CB9A6218
                674280CE325535430CE38A8B70594C5537155D3F1E1637721BBA21060F70C648
                3E16A01F815CDEC4B8C9C70674ABFD1E0A6E8E0B40A80585B938D8A2BF02706B
                350E823B278400A326FF096228A0335E0395CA1D724B8ED01B146680B35F3543
                A12518DB0521005394134CE93AF737283838A0E0D6A28E2C5F13C65684003009
                1F1063695EF25EB5BBB528005E00302BFA060E09A55B5F874AFC56EB47A06E9C
                AD284732A5DB4280562231152895CEE1FF6015C66EDDF2FB7760BC5EF0626928
                9426EDF60120920E2197CD647237522C1A4280BF5E1EC003788089033E00C7CF
                FC219818FEDD0000000049454E44AE426082}
              ExplicitLeft = -24
              ExplicitTop = -32
              ExplicitWidth = 105
              ExplicitHeight = 105
            end
            object btnCancelar: TSpeedButton
              Left = 5
              Top = 0
              Width = 41
              Height = 41
              Hint = 'CANCELAR O PRODUTO'
              Align = alClient
              Flat = True
              ParentShowHint = False
              ShowHint = True
              ExplicitLeft = 10
              ExplicitHeight = 36
            end
          end
        end
      end
      object Panel13: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 360
        Width = 752
        Height = 40
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 3
        object Panel4: TPanel
          Left = 627
          Top = 0
          Width = 125
          Height = 40
          Align = alRight
          BevelOuter = bvNone
          Color = 14671839
          TabOrder = 0
          object btnIncluir1: TBitBtn
            AlignWithMargins = True
            Left = -1
            Top = 3
            Width = 123
            Height = 34
            Action = actProximo
            Align = alRight
            Caption = 'FINALIZAR'
            TabOrder = 0
          end
        end
      end
    end
    object tsConcluido: TTabSheet
      Caption = 'tsConcluido'
      ImageIndex = 1
      object Label4: TLabel
        Left = 0
        Top = 0
        Width = 752
        Height = 360
        Align = alClient
        Alignment = taCenter
        Caption = 'CONCLU'#205'DO!!!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10640128
        Font.Height = -75
        Font.Name = 'Yu Gothic Medium'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitTop = 44
        ExplicitWidth = 521
        ExplicitHeight = 96
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 360
        Width = 752
        Height = 40
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 4
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 0
        ExplicitTop = 0
        object Panel10: TPanel
          AlignWithMargins = True
          Left = 641
          Top = 3
          Width = 108
          Height = 34
          Align = alRight
          BevelOuter = bvNone
          Color = 10640128
          ParentBackground = False
          TabOrder = 0
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitHeight = 40
          object Label1: TLabel
            Left = 39
            Top = 8
            Width = 28
            Height = 17
            Caption = 'SAIR'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Yu Gothic UI Semibold'
            Font.Style = []
            ParentFont = False
          end
          object btnSair: TSpeedButton
            Left = 0
            Top = 0
            Width = 108
            Height = 34
            Action = actSair
            Align = alClient
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Yu Gothic UI Semibold'
            Font.Style = []
            ParentFont = False
            ExplicitLeft = 1
            ExplicitHeight = 40
          end
        end
      end
    end
  end
  object ActionList1: TActionList
    Left = 575
    Top = 248
    object actNovo: TAction
      Caption = 'actNovo'
      ShortCut = 45
      OnExecute = actNovoExecute
    end
    object actSalvar: TAction
      Caption = 'F10 | SALVAR'
      ShortCut = 121
    end
    object actExcluir: TAction
      Caption = 'EXCLUIR'
    end
    object actProximo: TAction
      Caption = 'FINALIZAR'
      OnExecute = actProximoExecute
    end
    object actIncrementaQuantidade: TAction
      Caption = '+'
      OnExecute = actIncrementaQuantidadeExecute
    end
    object actSubtraiQuantidade: TAction
      Caption = '-'
      OnExecute = actSubtraiQuantidadeExecute
    end
    object actIncluir: TAction
      OnExecute = actIncluirExecute
    end
    object actSair: TAction
      OnExecute = actSairExecute
    end
  end
end
