inherited frmCadastroFornecedor: TfrmCadastroFornecedor
  Caption = 'Cadastro Fornecedor'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    inherited pgcPrincipal: TPageControl
      ActivePage = ts1
      object ts1: TTabSheet
        Caption = 'Fornecedor'
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
          Left = 54
          Top = 78
          Width = 32
          Height = 13
          Caption = 'Nome'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 38
          Top = 120
          Width = 48
          Height = 13
          Caption = 'Fantasia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 61
          Top = 159
          Width = 25
          Height = 13
          Caption = 'Cnpj'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 330
          Top = 159
          Width = 75
          Height = 13
          Caption = 'Insc Estadual'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 32
          Top = 211
          Width = 45
          Height = 13
          Caption = 'Contato'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl1: TLabel
          Left = 47
          Top = 245
          Width = 30
          Height = 13
          Caption = 'Email'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 50
          Top = 280
          Width = 27
          Height = 13
          Caption = 'Fone'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbl2: TLabel
          Left = 274
          Top = 280
          Width = 39
          Height = 13
          Caption = 'Celular'
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
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edtNome: TEdit
          Left = 92
          Top = 73
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 1
          OnChange = edtNomeChange
        end
        object edtFantasia: TEdit
          Left = 92
          Top = 115
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          TabOrder = 2
          OnChange = edtNomeChange
        end
        object edtCpf: TEdit
          Left = 92
          Top = 154
          Width = 179
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 18
          ParentFont = False
          TabOrder = 3
          OnChange = edtNomeChange
        end
        object edtIE: TEdit
          Left = 411
          Top = 154
          Width = 179
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 20
          ParentFont = False
          TabOrder = 4
          OnChange = edtNomeChange
        end
        object edtContato: TEdit
          Left = 87
          Top = 208
          Width = 365
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 40
          ParentFont = False
          TabOrder = 5
          OnChange = edtNomeChange
        end
        object edtEmail: TEdit
          Left = 87
          Top = 245
          Width = 363
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 6
          OnChange = edtNomeChange
        end
        object edtTelefone: TMaskEdit
          Left = 87
          Top = 280
          Width = 113
          Height = 21
          Color = 15524818
          EditMask = '\(99\)99999-9999;9;_'
          MaxLength = 14
          TabOrder = 7
          Text = '(  )     -    '
          OnChange = edtNomeChange
        end
        object edtCelular: TMaskEdit
          Left = 319
          Top = 280
          Width = 115
          Height = 21
          Color = 15524818
          EditMask = '\(99\)99999-9999;9;_'
          MaxLength = 14
          TabOrder = 8
          Text = '(  )     -    '
          OnChange = edtNomeChange
        end
      end
      object ts2: TTabSheet
        Caption = 'Endere'#231'o'
        ImageIndex = 1
        object Label8: TLabel
          Left = 10
          Top = 32
          Width = 52
          Height = 13
          Caption = 'Endere'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 33
          Top = 62
          Width = 34
          Height = 13
          Caption = 'Bairro'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Left = 26
          Top = 93
          Width = 38
          Height = 13
          Caption = 'Cidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Left = 21
          Top = 125
          Width = 38
          Height = 13
          Caption = 'Compl:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Left = 43
          Top = 163
          Width = 14
          Height = 13
          Caption = 'UF'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 43
          Top = 203
          Width = 20
          Height = 13
          Caption = 'CEP'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 218
          Top = 200
          Width = 47
          Height = 13
          Caption = 'N'#250'mero:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtRua: TEdit
          Left = 71
          Top = 26
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 0
          OnChange = edtNomeChange
        end
        object edtCidade: TEdit
          Left = 71
          Top = 86
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 35
          ParentFont = False
          TabOrder = 2
          OnChange = edtNomeChange
        end
        object edtCEP: TMaskEdit
          Left = 71
          Top = 196
          Width = 132
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          EditMask = '99999-999;0;'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 9
          ParentFont = False
          TabOrder = 5
          Text = ''
          OnChange = edtNomeChange
        end
        object edtNumero: TEdit
          Left = 269
          Top = 196
          Width = 123
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 6
          OnChange = edtNomeChange
        end
        object edtComplemento: TEdit
          Left = 71
          Top = 118
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 40
          ParentFont = False
          TabOrder = 3
          OnChange = edtNomeChange
        end
        object edtUF: TEdit
          Left = 71
          Top = 156
          Width = 42
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 4
          OnChange = edtNomeChange
        end
        object edtBairro: TEdit
          Left = 71
          Top = 56
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          TabOrder = 1
          OnChange = edtNomeChange
        end
      end
      object ts3: TTabSheet
        Caption = 'Observa'#231#245'es'
        ImageIndex = 2
        object mmoObservacao: TMemo
          Left = 9
          Top = 24
          Width = 640
          Height = 313
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 5259564
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 1000
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          OnChange = edtNomeChange
        end
      end
    end
  end
  inherited pnlBotoes: TPanel
    inherited lblAtalhos: TLabel
      Font.Color = 10639360
    end
  end
  inherited pnlTop: TPanel
    inherited Label1: TLabel
      Color = clWhite
      ParentColor = False
    end
    inherited lblCliente: TLabel
      Color = clWhite
      ParentColor = False
    end
  end
end
