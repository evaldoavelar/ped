inherited FrmCadastroFormaPagtoParceiro: TFrmCadastroFormaPagtoParceiro
  Caption = 'Cadastro de Formas de Pagamento Parceiro'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    inherited pgcPrincipal: TPageControl
      ActivePage = ts1
      object ts1: TTabSheet
        Caption = 'Forma de Pagamento'
        ExplicitHeight = 381
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
          Left = 5
          Top = 110
          Width = 81
          Height = 26
          Alignment = taRightJustify
          Caption = 'Percentual de Comiss'#227'o %'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object edtCodigo: TEdit
          Tag = 1
          Left = 92
          Top = 35
          Width = 179
          Height = 24
          BorderStyle = bsNone
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
        object edtDescricao: TEdit
          Left = 92
          Top = 65
          Width = 498
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
          TabOrder = 1
          OnChange = edtCodigoChange
        end
        object edtComissaoValor: TEdit
          Left = 92
          Top = 113
          Width = 121
          Height = 21
          Alignment = taRightJustify
          BorderStyle = bsNone
          Color = 15524818
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 2
          OnChange = edtCodigoChange
        end
      end
    end
  end
end
