inherited frmCadastroFormaPagto: TfrmCadastroFormaPagto
  Caption = 'Cadastro de Parcelas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    inherited pgcPrincipal: TPageControl
      ActivePage = ts1
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
        object Label3: TLabel
          Left = 3
          Top = 118
          Width = 83
          Height = 13
          Caption = 'Quantas Vezes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 55
          Top = 153
          Width = 31
          Height = 13
          Caption = 'Juros'
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
        object edtJuros: TJvCalcEdit
          Left = 92
          Top = 150
          Width = 121
          Height = 21
          Color = 15524818
          DisplayFormat = ',0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 3
          DecimalPlacesAlwaysShown = True
          OnChange = edtQuantasVezesChange
        end
        object edtQuantasVezes: TJvCalcEdit
          Left = 92
          Top = 115
          Width = 121
          Height = 21
          Color = 15524818
          DecimalPlaces = 0
          DisplayFormat = ',0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ShowButton = False
          TabOrder = 2
          DecimalPlacesAlwaysShown = False
          OnChange = edtQuantasVezesChange
        end
      end
    end
  end
  inherited pnlBotoes: TPanel
    inherited lblAtalhos: TLabel
      Font.Color = 10639360
    end
  end
end
