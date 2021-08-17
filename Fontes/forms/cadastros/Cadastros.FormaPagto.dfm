inherited frmCadastroFormaPagto: TfrmCadastroFormaPagto
  Caption = 'Cadastro de Pagamentos'
  ClientHeight = 586
  ClientWidth = 693
  KeyPreview = True
  ExplicitWidth = 699
  ExplicitHeight = 615
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    Width = 693
    Height = 470
    ExplicitWidth = 693
    ExplicitHeight = 470
    inherited pgcPrincipal: TPageControl
      Width = 687
      Height = 464
      ActivePage = ts1
      ExplicitWidth = 687
      ExplicitHeight = 464
      object ts1: TTabSheet
        Caption = 'Pagamento'
        object lbl3: TLabel
          Left = 48
          Top = 40
          Width = 38
          Height = 13
          Caption = 'C'#243'digo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 31
          Top = 78
          Width = 55
          Height = 13
          Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCodigo: TEdit
          Left = 92
          Top = 35
          Width = 179
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edtCodigoChange
        end
        object edtDescricao: TEdit
          Left = 92
          Top = 73
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 1
          OnChange = edtCodigoChange
        end
        object Panel1: TPanel
          AlignWithMargins = True
          Left = 58
          Top = 106
          Width = 245
          Height = 43
          Margins.Left = 12
          Margins.Top = 10
          Margins.Right = 12
          BevelOuter = bvNone
          TabOrder = 2
          object Label5: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 0
            Width = 24
            Height = 40
            Margins.Top = 0
            Align = alLeft
            Alignment = taRightJustify
            Caption = 'TIPO'
            Layout = tlCenter
            ExplicitHeight = 13
          end
          object cbbTipo: TComboBox
            AlignWithMargins = True
            Left = 33
            Top = 7
            Width = 209
            Height = 25
            Margins.Top = 7
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 5066061
            Font.Height = -13
            Font.Name = 'Yu Gothic Medium'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cbbTipoChange
          end
        end
        object Panel3: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 151
          Width = 678
          Height = 327
          Margins.Left = 0
          Margins.Top = 4
          Margins.Right = 0
          Margins.Bottom = 0
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 3
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 678
            Height = 39
            Margins.Top = 0
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label8: TLabel
              AlignWithMargins = True
              Left = 47
              Top = 3
              Width = 142
              Height = 27
              Align = alLeft
              Caption = 'CONDI'#199#195'O DE PAGAMENTO'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 5066061
              Font.Height = -11
              Font.Name = 'Yu Gothic UI Semibold'
              Font.Style = []
              ParentFont = False
              Layout = tlCenter
              ExplicitHeight = 13
            end
            object Image2: TImage
              AlignWithMargins = True
              Left = 10
              Top = 3
              Width = 31
              Height = 27
              Margins.Left = 10
              Align = alLeft
              Center = True
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D49484452000000300000
                003008060000005702F987000000097048597300000EC400000EC401952B0E1B
                0000058F4944415478DAED980D4C535714C7DBF7D5D7F695423F02D6AF09A248
                DC9C8661B6B8B04D85253254A61BE8321D32A6314A883AB7186716341A594370
                411CC36936F16BCCA951E3DC186EB265449C844DC6A6A20202560BB6B4AFEFAB
                AF3B0F07E91C385A6DBB253D69C2E3BE7BEEFDFFCE3BF79CD7CA65FF7393875A
                401820D402C200A116100608B5803040A8058401FCF041BCAE45AF31D1EBEF60
                3EE203C686F20B08C0A312E0B7E88701407C9CEFAF0D1B2CA8004BF736C86A9B
                6E265ED93EA72954000F021B72D3CC5DF5584DC3B54C9AE1D770823B699451FB
                785B7146B3E4B3F6E077C80759297EA75240ABD0944DDF44B4745873184EC8E7
                79E1B1FE71254954B83EC97E53BFE28B7427C36E88D169165F37BFD4120C8061
                A550ECBA93A65BDDBDAB185EC873BBC5C87F2C82C899B89186715D56FBA25E9A
                35AB487C07BD3BBBC06B4A68CE8029FFD8131C2F2C76325CAC288A945BF42409
                6E5137D85CB592D83C6194A1A8F16A579BB46EC218C3D84B5B5EBC1B7480F4D2
                F3B2BAA6D65417CBAF5410F849442EB703408AB4B08A246A78C11D03035B458F
                87EC73F0DCDB1543913B53E34D639BAE5BDE87F96B29A5E25D47C5ABDB8306F0
                5C512DD170A5238B66853510F5C9D15154B69D66962915C44FF0BF89E5DD4F82
                F86924819F8E50939F597A7A2B650304F7B686F1157AADFAC48DCEEE6B905696
                A71347C69D7BE7792EA000891B4E47B6DEB2E5311CBF4A70BB4DD22049102720
                A2BFD210C918BD76A6CD41CF87FCCF80FC8F95EE53902EBC5B4C663921D51B80
                C0D02BD929E3271DAE6DD9E362B9D72229D592BB1F2DDC17308088BCC3C54E17
                9B0BB94D0D44133E1AB57219CBF18510454EAFA552AC36C70158988492990073
                55048EB69338B6C54EB365DE0092E923D4F3150476BDE38EED22CC6BCC9D3D7E
                EACEC5D30303A0CC3970C8C570AFC8E47FB979400C5C9B0CDA859D567BA5C7E3
                21202D36A3285E8361724645201D6D16DB251C4509D86921CB0A5F0E00486B80
                BF4281D72E993929E5D3EADFBE82723BCB1849A5DD2ECD3C13108011AB8F2683
                D0BAFEE0F78BA1548A025E10DF821449B8B7AA071696CB268E314E6CE9ECF91A
                36E986E81EEA75B25BBD0148023B0BBE452F4F1F75FA485DFB82DB3D8E43A402
                3FC3EC5994161000C9C837F69F635861866C80027299401BA18A9474DBE9DDD2
                904A89EF88A2949534CB4FEBE97595E9B5AA25207E3DC7BB1321CD044899AA28
                8DD2DC5132AF7E74C1F109569BB300CECCEB22A49B52817F0B4D6E66C000F42B
                AA32AC76FA98F7139096D1A8C96D10D41E07CD162228D2812172022AD02948AB
                DFA1278C846A9503C22BA275544992DEDD7EEEA6F88CCDC9AC8362900E4F4B84
                7B87A3342A809AFBB32F7A7C0658507E013BFE43F32588E684BF1D48F840F48E
                44EB341FF7D869158AC8308D5AE570B8D83428AB6D71265D855EAB715CBCDC9E
                09757F0DA45B328A2276058E958FD0693EBC5A34A7D5572D7E014806D568B9DD
                E92A1B6A49288F1CE4723D8A20A5D3E2A3AB2C368EBCD1655D0ACD2E1F7A432C
                8EA1AD90FF25E36274158D85B3EDFE68782880A70AAB55172F77DE803E60E81B
                E83F97885C06113D0595C83C2FD974B6FA17ABA9ABBB7725E4F772E99D08EED5
                4377364F898D3E72F6ED67B98711EE2FC04027A6720F6E72D0DC7B7D83A89C01
                71FBA1AB9A17241B9B3FAFB34C86032DA5499647E621E0DE092DA534CF9D6AFC
                BE3C67C670F609FCAB44FCFA9306E8C817A003EF3519B5A5E953B496CADAAE59
                F03A21094F85A7C140F3DA0715A8B8AD786EB38FFB04E7652E6F6F2D52BE7446
                DF6693379E8969BA764B7AA7B143F5D9693250A57F6C9B73C7C7F5830BE0B559
                DF78CCEAA32F8C36523F9EDF388BF15378D00144D9BF400D63EE60F703FA9DF8
                FEDF858612250EE137D86F493E897ED400DE62EEBF1ECCD7579F470EF09FB230
                40A82D0C106A0B0384DAC200A1B63040A8ED4F9D02674F828BE2E40000000049
                454E44AE426082}
              ExplicitLeft = 24
              ExplicitTop = 6
              ExplicitHeight = 25
            end
            object pnl1: TPanel
              AlignWithMargins = True
              Left = 15
              Top = 33
              Width = 648
              Height = 3
              Margins.Left = 15
              Margins.Top = 0
              Margins.Right = 15
              Align = alBottom
              BevelOuter = bvNone
              Caption = 'Panel9'
              Color = 500714
              ParentBackground = False
              ShowCaption = False
              TabOrder = 0
            end
          end
          object GridPanel1: TGridPanel
            Left = 0
            Top = 39
            Width = 678
            Height = 288
            Align = alClient
            BevelOuter = bvNone
            ColumnCollection = <
              item
                Value = 100.000000000000000000
              end>
            ControlCollection = <
              item
                Column = 0
                Control = Panel2
                Row = 0
              end>
            RowCollection = <
              item
                Value = 81.284868089103410000
              end
              item
                Value = 18.715131910896590000
              end>
            TabOrder = 1
            object Panel2: TPanel
              Left = 0
              Top = 0
              Width = 678
              Height = 234
              Align = alClient
              BevelOuter = bvNone
              Color = clWhite
              ParentBackground = False
              TabOrder = 0
              object pgcEndereco: TPageControl
                Left = 0
                Top = 69
                Width = 678
                Height = 165
                Align = alClient
                Style = tsFlatButtons
                TabOrder = 0
              end
              object Panel9: TPanel
                AlignWithMargins = True
                Left = 15
                Top = 3
                Width = 648
                Height = 63
                Margins.Left = 15
                Margins.Right = 15
                Align = alTop
                BevelOuter = bvNone
                Color = 15658734
                ParentBackground = False
                TabOrder = 1
                object GridPanel3: TGridPanel
                  AlignWithMargins = True
                  Left = 3
                  Top = 3
                  Width = 642
                  Height = 57
                  Align = alClient
                  BevelOuter = bvNone
                  ColumnCollection = <
                    item
                      Value = 59.372989892035750000
                    end
                    item
                      Value = 18.830556447045180000
                    end
                    item
                      Value = 15.017262974148580000
                    end
                    item
                      Value = 6.779190686770488000
                    end>
                  ControlCollection = <
                    item
                      Column = 0
                      Control = Panel10
                      Row = 0
                    end
                    item
                      Column = 1
                      Control = Panel11
                      Row = 0
                    end
                    item
                      Column = 2
                      Control = Panel12
                      Row = 0
                    end
                    item
                      Column = 3
                      Control = Panel13
                      Row = 0
                    end>
                  RowCollection = <
                    item
                      Value = 100.000000000000000000
                    end>
                  TabOrder = 0
                  object Panel10: TPanel
                    AlignWithMargins = True
                    Left = 3
                    Top = 3
                    Width = 375
                    Height = 51
                    Align = alClient
                    BevelOuter = bvNone
                    ParentColor = True
                    TabOrder = 0
                    object Label13: TLabel
                      Left = 0
                      Top = 0
                      Width = 375
                      Height = 13
                      Align = alTop
                      Caption = 'DESCRI'#199#195'O:'
                      ExplicitWidth = 63
                    end
                    object edtCondicaoDescricao: TEdit
                      AlignWithMargins = True
                      Left = 3
                      Top = 19
                      Width = 369
                      Height = 21
                      Margins.Top = 6
                      Align = alTop
                      CharCase = ecUpperCase
                      Color = clWhite
                      MaxLength = 30
                      TabOrder = 0
                      ExplicitLeft = 2
                    end
                  end
                  object Panel11: TPanel
                    AlignWithMargins = True
                    Left = 384
                    Top = 3
                    Width = 114
                    Height = 51
                    Align = alClient
                    BevelOuter = bvNone
                    ParentColor = True
                    TabOrder = 1
                    object Label6: TLabel
                      Left = 0
                      Top = 0
                      Width = 114
                      Height = 13
                      Align = alTop
                      Caption = 'QUANTAS VEZES'
                      ExplicitWidth = 81
                    end
                    object edtCondicaoQuantasVezes: TEdit
                      AlignWithMargins = True
                      Left = 3
                      Top = 19
                      Width = 108
                      Height = 21
                      Margins.Top = 6
                      Align = alTop
                      CharCase = ecUpperCase
                      Color = clWhite
                      MaxLength = 10
                      NumbersOnly = True
                      TabOrder = 0
                      ExplicitLeft = 2
                    end
                  end
                  object Panel12: TPanel
                    AlignWithMargins = True
                    Left = 504
                    Top = 3
                    Width = 90
                    Height = 51
                    Align = alClient
                    BevelOuter = bvNone
                    ParentColor = True
                    TabOrder = 2
                    object Label7: TLabel
                      Left = 0
                      Top = 0
                      Width = 90
                      Height = 13
                      Align = alTop
                      Caption = 'ACR'#201'SCIMO'
                      ExplicitWidth = 60
                    end
                    object edtCondicaoAcrescimo: TEdit
                      AlignWithMargins = True
                      Left = 3
                      Top = 19
                      Width = 84
                      Height = 21
                      Margins.Top = 6
                      Align = alTop
                      CharCase = ecUpperCase
                      Color = clWhite
                      MaxLength = 19
                      TabOrder = 0
                      OnEnter = edtCondicaoAcrescimoEnter
                      OnExit = edtCondicaoAcrescimoExit
                      OnKeyPress = edtCondicaoAcrescimoKeyPress
                    end
                  end
                  object Panel13: TPanel
                    AlignWithMargins = True
                    Left = 600
                    Top = 3
                    Width = 39
                    Height = 51
                    Align = alClient
                    BevelOuter = bvNone
                    ParentColor = True
                    TabOrder = 3
                    DesignSize = (
                      39
                      51)
                    object Panel14: TPanel
                      Left = 9
                      Top = 17
                      Width = 27
                      Height = 26
                      Anchors = [akTop, akRight]
                      BevelOuter = bvNone
                      Color = 10640128
                      ParentBackground = False
                      TabOrder = 0
                      object img1: TImage
                        Left = 0
                        Top = 0
                        Width = 27
                        Height = 26
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
                        ExplicitLeft = -3
                        ExplicitTop = 8
                      end
                      object btnIncluirCondicao: TSpeedButton
                        Left = 0
                        Top = 0
                        Width = 27
                        Height = 26
                        Align = alClient
                        Flat = True
                        OnClick = btnIncluirCondicaoClick
                        ExplicitLeft = 8
                        ExplicitTop = 8
                        ExplicitWidth = 23
                        ExplicitHeight = 22
                      end
                    end
                  end
                end
              end
              object scrlbxMeiosPagamentos: TScrollBox
                AlignWithMargins = True
                Left = 15
                Top = 69
                Width = 648
                Height = 159
                Margins.Left = 15
                Margins.Top = 0
                Margins.Right = 15
                Margins.Bottom = 6
                Align = alClient
                BevelInner = bvNone
                BevelOuter = bvNone
                BorderStyle = bsNone
                Color = 15921906
                ParentColor = False
                TabOrder = 2
              end
            end
          end
        end
        object chkATIVO: TCheckBox
          AlignWithMargins = True
          Left = 341
          Top = 117
          Width = 55
          Height = 17
          Margins.Left = 18
          Margins.Top = 12
          AllowGrayed = True
          BiDiMode = bdLeftToRight
          Caption = 'ATIVO?'
          ParentBiDiMode = False
          TabOrder = 4
          OnClick = chkATIVOClick
        end
      end
    end
  end
  inherited pnlBotoes: TPanel
    Top = 535
    Width = 693
    ExplicitTop = 535
    ExplicitWidth = 693
    inherited lblAtalhos: TLabel
      Font.Color = 10639360
    end
  end
  inherited pnlTop: TPanel
    Width = 693
    ExplicitWidth = 693
    inherited Image1: TImage
      Width = 693
      ExplicitWidth = 693
    end
  end
end
