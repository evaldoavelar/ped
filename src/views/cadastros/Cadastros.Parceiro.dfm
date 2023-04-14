inherited frmCadastroParceiro: TfrmCadastroParceiro
  Caption = 'Cadastro de Parceiro'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    inherited pgcPrincipal: TPageControl
      ActivePage = tsParceiro
      object tsParceiro: TTabSheet
        Caption = 'Parceiro'
        object Label2: TLabel
          Left = 54
          Top = 86
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
        object lbl3: TLabel
          Left = 48
          Top = 48
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
        object edtDescricao: TEdit
          Left = 92
          Top = 81
          Width = 498
          Height = 24
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 1
          OnChange = edtDescricaoChange
        end
        object edtCodigo: TEdit
          Tag = 1
          Left = 92
          Top = 43
          Width = 179
          Height = 24
          TabStop = False
          CharCase = ecUpperCase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnChange = edtDescricaoChange
        end
        object chkINATIVO: TCheckBox
          Left = 61
          Top = 146
          Width = 217
          Height = 17
          Caption = 'Inativo'
          TabOrder = 2
          OnClick = chkINATIVOClick
        end
      end
    end
  end
end
