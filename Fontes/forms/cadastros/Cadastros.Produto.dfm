inherited frmCadastroProduto: TfrmCadastroProduto
  Caption = 'Cadastro Produto'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    inherited pgcPrincipal: TPageControl
      ActivePage = ts1
      object ts1: TTabSheet
        Caption = 'Produto'
        object lbl3: TLabel
          Left = 55
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
          Left = 15
          Top = 75
          Width = 78
          Height = 13
          Caption = 'C'#243'digo Barras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 38
          Top = 107
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
        object Label4: TLabel
          Left = 47
          Top = 147
          Width = 46
          Height = 13
          Caption = 'Unidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 16
          Top = 359
          Width = 95
          Height = 13
          Caption = #218'ltima Altera'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 216
          Top = 359
          Width = 75
          Height = 13
          Caption = #218'ltima Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl2: TLabel
          Left = 25
          Top = 265
          Width = 64
          Height = 13
          Caption = 'Fornecedor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 405
          Top = 359
          Width = 81
          Height = 13
          Caption = 'Data Cadastro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 2
          Top = 217
          Width = 87
          Height = 13
          Caption = 'Pre'#231'o de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCodigo: TEdit
          Tag = 1
          Left = 99
          Top = 35
          Width = 179
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edtCodigoChange
        end
        object edtBarras: TEdit
          Left = 99
          Top = 70
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 1
          OnChange = edtCodigoChange
        end
        object edtDescricao: TEdit
          Left = 99
          Top = 102
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 40
          ParentFont = False
          TabOrder = 2
          OnChange = edtCodigoChange
        end
        object edtUltimaAlteracao: TJvDateEdit
          Tag = 1
          Left = 116
          Top = 357
          Width = 81
          Height = 21
          Color = 15524818
          Enabled = False
          ShowButton = False
          ShowNullDate = False
          TabOrder = 10
          OnChange = edtUltimaAlteracaoChange
        end
        object edtUltimVenda: TJvDateEdit
          Tag = 1
          Left = 297
          Top = 357
          Width = 80
          Height = 21
          Color = 15524818
          Enabled = False
          ShowButton = False
          ShowNullDate = False
          TabOrder = 11
          OnChange = edtUltimaAlteracaoChange
        end
        object chkBloqueado: TCheckBox
          Left = 38
          Top = 302
          Width = 97
          Height = 17
          Caption = 'Bloqueado'
          Color = 10639360
          ParentColor = False
          TabOrder = 9
          OnClick = chkBloqueadoClick
        end
        object edtCodFornecedor: TEdit
          Tag = 1
          Left = 95
          Top = 260
          Width = 109
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          OnChange = edtCodigoChange
        end
        object edtNomeFornecedor: TEdit
          Tag = 1
          Left = 223
          Top = 260
          Width = 381
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          OnChange = edtCodigoChange
        end
        object btnPesquisaCliente: TBitBtn
          Left = 612
          Top = 261
          Width = 20
          Height = 23
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = btnPesquisaClienteClick
        end
        object edtDataCadastro: TJvDateEdit
          Tag = 1
          Left = 492
          Top = 357
          Width = 91
          Height = 21
          Color = 15524818
          Enabled = False
          ShowButton = False
          ShowNullDate = False
          TabOrder = 12
          OnChange = edtUltimaAlteracaoChange
        end
        object cbbUND: TComboBox
          Left = 99
          Top = 142
          Width = 166
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 3
          ParentFont = False
          TabOrder = 3
          OnChange = edtCodigoChange
          Items.Strings = (
            'UND'
            'CM'
            'CM2'
            'CM3'
            'KG'
            'L'
            'M'
            'M2'
            'M3'
            'MM')
        end
        object chkFracionado: TCheckBox
          Left = 99
          Top = 181
          Width = 192
          Height = 17
          Caption = 'Vender em Quantidade Fracionada'
          TabOrder = 4
          OnClick = chkBloqueadoClick
        end
        object edtPreco1: TJvCalcEdit
          Left = 98
          Top = 211
          Width = 121
          Height = 27
          Alignment = taLeftJustify
          Color = 15524818
          DisplayFormat = '###,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 5
          DecimalPlacesAlwaysShown = False
          OnChange = edtCustoMedioChange
          OnKeyPress = edtCustoMedioKeyPress
        end
      end
      object ts2: TTabSheet
        Caption = 'Pre'#231'o'
        ImageIndex = 1
        object lbl1: TLabel
          Left = 36
          Top = 48
          Width = 69
          Height = 13
          Caption = 'Custo M'#233'dio'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 36
          Top = 80
          Width = 84
          Height = 13
          Caption = 'Pre'#231'o de Custo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 34
          Top = 116
          Width = 102
          Height = 16
          Caption = 'Pre'#231'o de Venda'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 35
          Top = 152
          Width = 99
          Height = 13
          Caption = 'Pre'#231'o de Atacado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 35
          Top = 192
          Width = 98
          Height = 13
          Caption = 'Margem de Lucro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCustoMedio: TJvCalcEdit
          Left = 148
          Top = 45
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          Color = 15524818
          DisplayFormat = '###,##0.00'
          ShowButton = False
          TabOrder = 0
          DecimalPlacesAlwaysShown = False
          OnChange = edtCustoMedioChange
          OnKeyPress = edtCustoMedioKeyPress
        end
        object edtPrecoCusto: TJvCalcEdit
          Left = 148
          Top = 80
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          Color = 15524818
          DisplayFormat = '###,##0.00'
          ShowButton = False
          TabOrder = 1
          DecimalPlacesAlwaysShown = False
          OnChange = edtCustoMedioChange
          OnKeyPress = edtCustoMedioKeyPress
        end
        object edtPrecovenda: TJvCalcEdit
          Left = 148
          Top = 111
          Width = 121
          Height = 27
          Alignment = taLeftJustify
          Color = 15524818
          DisplayFormat = '###,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          OnChange = edtCustoMedioChange
          OnKeyPress = edtCustoMedioKeyPress
        end
        object edtPrecoAtacado: TJvCalcEdit
          Left = 148
          Top = 150
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          Color = 15524818
          DisplayFormat = '###,##0.00'
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = False
          OnChange = edtCustoMedioChange
          OnKeyPress = edtCustoMedioKeyPress
        end
        object edtMargemLucro: TJvCalcEdit
          Left = 148
          Top = 189
          Width = 121
          Height = 21
          Alignment = taLeftJustify
          Color = 15524818
          DisplayFormat = '###,##0.00'
          ShowButton = False
          TabOrder = 4
          DecimalPlacesAlwaysShown = False
          OnChange = edtCustoMedioChange
          OnKeyPress = edtCustoMedioKeyPress
        end
      end
      object ts3: TTabSheet
        Caption = 'Observa'#231#227'o'
        ImageIndex = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object mmoObservacao: TMemo
          Left = 9
          Top = 24
          Width = 640
          Height = 313
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 5000
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          OnChange = edtCodigoChange
        end
      end
    end
  end
  inherited pnlBotoes: TPanel
    inherited lblAtalhos: TLabel
      Font.Color = 10639360
    end
    inherited btnSalvar: TBitBtn
      Left = 119
      ExplicitLeft = 119
    end
    inherited btnCacenlar: TBitBtn
      Left = 312
      ExplicitLeft = 312
    end
    inherited btnExcluir: TBitBtn
      Left = 398
      ExplicitLeft = 398
    end
  end
  inherited pnlTop: TPanel
    inherited edtPesquisa: TSearchBox
      ParentCustomHint = False
      ParentBiDiMode = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
    end
  end
  inherited act1: TActionList
    Left = 280
    Top = 216
  end
  inherited JvEnterAsTab1: TJvEnterAsTab
    AllowDefault = False
    Left = 368
  end
end
