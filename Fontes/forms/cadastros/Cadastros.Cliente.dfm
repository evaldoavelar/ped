inherited frmCadastroCliente: TfrmCadastroCliente
  Caption = 'Cadastro Cliente'
  ClientWidth = 678
  OnKeyPress = FormKeyPress
  ExplicitWidth = 684
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    Top = 83
    Width = 678
    Height = 397
    ExplicitTop = 83
    ExplicitWidth = 678
    ExplicitHeight = 397
    inherited pgcPrincipal: TPageControl
      Width = 672
      Height = 391
      ActivePage = ts1
      ExplicitWidth = 672
      ExplicitHeight = 391
      object ts1: TTabSheet
        Caption = 'Dados'
        object lbl3: TLabel
          Left = 43
          Top = 8
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
        object Label3: TLabel
          Left = 47
          Top = 46
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
        object Label4: TLabel
          Left = 29
          Top = 122
          Width = 49
          Height = 13
          Caption = 'Cnpj/Cpf'
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
        object Label8: TLabel
          Left = 331
          Top = 121
          Width = 69
          Height = 13
          Caption = 'Insc Est./RG'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
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
        object Label2: TLabel
          Left = 33
          Top = 80
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
        object Label11: TLabel
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
        object Label15: TLabel
          Left = 23
          Top = 156
          Width = 59
          Height = 13
          Caption = 'Data Nasc.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtCpf: TEdit
          Left = 87
          Top = 114
          Width = 179
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 18
          ParentFont = False
          TabOrder = 3
          OnExit = edtCpfExit
        end
        object edtEmail: TEdit
          Left = 87
          Top = 245
          Width = 367
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 7
          OnChange = edtCodigoChange
        end
        object edtIE: TEdit
          Left = 406
          Top = 114
          Width = 179
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
          TabOrder = 4
          OnChange = edtCodigoChange
        end
        object edtCodigo: TEdit
          Left = 87
          Top = 3
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
        object edtFantasia: TEdit
          Left = 87
          Top = 75
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          TabOrder = 2
          OnChange = edtCodigoChange
        end
        object edtContato: TEdit
          Left = 87
          Top = 208
          Width = 369
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
          TabOrder = 6
          OnChange = edtCodigoChange
        end
        object edtNascimento: TJvDateEdit
          Left = 87
          Top = 153
          Width = 121
          Height = 21
          Color = 15524818
          ShowNullDate = False
          TabOrder = 5
          OnExit = edtNascimentoExit
        end
        object chkBloqueado: TCheckBox
          Left = 50
          Top = 335
          Width = 97
          Height = 17
          Caption = 'Bloqueado'
          TabOrder = 10
          OnClick = chkBloqueadoClick
        end
        object edtTelefone: TMaskEdit
          Left = 87
          Top = 280
          Width = 115
          Height = 21
          Color = 15524818
          EditMask = '\(99\)99999-9999;9;_'
          MaxLength = 14
          TabOrder = 8
          Text = '(  )     -    '
          OnChange = edtCodigoChange
        end
        object edtCelular: TMaskEdit
          Left = 319
          Top = 280
          Width = 115
          Height = 21
          Color = 15524818
          EditMask = '\(99\)99999-9999;9;_'
          MaxLength = 14
          TabOrder = 9
          Text = '(  )     -    '
          OnChange = edtCodigoChange
        end
        object edtNome: TEdit
          Left = 85
          Top = 39
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          TabOrder = 1
          OnChange = edtCodigoChange
        end
      end
      object ts2: TTabSheet
        Caption = 'Endere'#231'o Resid'#234'ncia'
        ImageIndex = 1
        object Label5: TLabel
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
        object Label6: TLabel
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
        object Label7: TLabel
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
        object Label9: TLabel
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
        object edtRua: TEdit
          Left = 71
          Top = 24
          Width = 554
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
          TabOrder = 0
          OnChange = edtCodigoChange
        end
        object edtBairro: TEdit
          Left = 71
          Top = 55
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          TabOrder = 1
          OnChange = edtCodigoChange
        end
        object edtCidade: TEdit
          Left = 71
          Top = 86
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 35
          ParentFont = False
          TabOrder = 2
          OnChange = edtCodigoChange
        end
        object edtNumero: TEdit
          Left = 269
          Top = 196
          Width = 123
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 6
          OnChange = edtCodigoChange
        end
        object edtUF: TEdit
          Left = 71
          Top = 156
          Width = 42
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 4
          OnChange = edtCodigoChange
        end
        object edtComplemento: TEdit
          Left = 71
          Top = 118
          Width = 554
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
          TabOrder = 3
          OnChange = edtCodigoChange
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
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 9
          ParentFont = False
          TabOrder = 5
          Text = ''
          OnChange = edtCodigoChange
        end
      end
      object TabSheet1: TTabSheet
        Caption = 'Endere'#231'o Cobran'#231'a'
        ImageIndex = 3
        object Label16: TLabel
          Left = 18
          Top = 40
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
        object Label17: TLabel
          Left = 41
          Top = 70
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
        object Label18: TLabel
          Left = 34
          Top = 101
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
        object Label19: TLabel
          Left = 29
          Top = 133
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
        object Label20: TLabel
          Left = 51
          Top = 171
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
        object Label21: TLabel
          Left = 51
          Top = 211
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
        object Label22: TLabel
          Left = 226
          Top = 208
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
        object edtCobRua: TEdit
          Left = 79
          Top = 32
          Width = 554
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
          TabOrder = 0
          OnChange = edtCodigoChange
        end
        object edtCobBairro: TEdit
          Left = 79
          Top = 63
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 30
          ParentFont = False
          TabOrder = 1
          OnChange = edtCodigoChange
        end
        object edtCobCidade: TEdit
          Left = 79
          Top = 94
          Width = 554
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 35
          ParentFont = False
          TabOrder = 2
          OnChange = edtCodigoChange
        end
        object edtCobCompl: TEdit
          Left = 79
          Top = 126
          Width = 554
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
          TabOrder = 3
          OnChange = edtCodigoChange
        end
        object edtCobUF: TEdit
          Left = 79
          Top = 164
          Width = 42
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 2
          ParentFont = False
          TabOrder = 4
          OnChange = edtCodigoChange
        end
        object edtCobNumero: TEdit
          Left = 277
          Top = 204
          Width = 123
          Height = 24
          CharCase = ecUpperCase
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 6
          OnChange = edtCodigoChange
        end
        object edtCobCEP: TMaskEdit
          Left = 79
          Top = 204
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
          OnChange = edtCodigoChange
        end
      end
      object ts3: TTabSheet
        Caption = 'Observa'#231#227'o'
        ImageIndex = 2
        object mmoObservacao: TMemo
          Left = 9
          Top = 24
          Width = 640
          Height = 313
          BorderStyle = bsNone
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxLength = 1000
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
          OnChange = edtCodigoChange
        end
      end
    end
  end
  inherited pnlBotoes: TPanel
    Width = 678
    ExplicitWidth = 678
    inherited lblAtalhos: TLabel
      Font.Color = 10639360
    end
  end
  inherited pnlTop: TPanel
    Width = 678
    Height = 83
    ExplicitWidth = 678
    ExplicitHeight = 83
    inherited Label1: TLabel
      Left = 13
      ExplicitLeft = 13
    end
    inherited lblCliente: TLabel
      Top = 44
      ExplicitTop = 44
    end
    inherited edtPesquisa: TSearchBox
      Top = 19
      ExplicitTop = 19
    end
    inherited btnPesquisar: TBitBtn
      Top = 17
      ExplicitTop = 17
    end
  end
end
