inherited frmCadastroVendedor: TfrmCadastroVendedor
  Caption = 'Cadastro vendedor'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlContainer: TPanel
    inherited pgcPrincipal: TPageControl
      ActivePage = ts1
      object ts1: TTabSheet
        Caption = 'Vendedor'
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
          Left = 83
          Top = 185
          Width = 86
          Height = 13
          Caption = 'Comiss'#227'o Valor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label4: TLabel
          Left = 51
          Top = 226
          Width = 118
          Height = 13
          Caption = 'Comiss'#227'o Percentual'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label5: TLabel
          Left = 48
          Top = 121
          Width = 35
          Height = 13
          Caption = 'Senha'
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
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 60
          ParentFont = False
          TabOrder = 1
          OnChange = edtCodigoChange
        end
        object edtComissaoValor: TJvCalcEdit
          Left = 189
          Top = 182
          Width = 121
          Height = 21
          Color = 15524818
          DisplayFormat = ',0.00'
          ShowButton = False
          TabOrder = 3
          Visible = False
          DecimalPlacesAlwaysShown = True
          OnChange = edtCodigoChange
        end
        object edtComissaoPerc: TJvCalcEdit
          Left = 186
          Top = 223
          Width = 121
          Height = 21
          Color = 15524818
          DisplayFormat = ',0.00'
          ShowButton = False
          TabOrder = 4
          Visible = False
          DecimalPlacesAlwaysShown = True
          OnChange = edtCodigoChange
        end
        object edtSenha: TEdit
          Left = 92
          Top = 116
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
          PasswordChar = '*'
          TabOrder = 2
          OnChange = edtCodigoChange
        end
        object chkPodeCancelarPedido: TCheckBox
          Left = 54
          Top = 273
          Width = 217
          Height = 17
          Caption = 'Pode Cancelar Pedido'
          TabOrder = 6
          OnClick = chkPodeCancelarPedidoClick
        end
        object chkPodeReceberParcelas: TCheckBox
          Left = 54
          Top = 296
          Width = 217
          Height = 17
          Caption = 'Pode Receber Parcelas'
          TabOrder = 7
          OnClick = chkPodeCancelarPedidoClick
        end
        object chkPodeAcessarCadastroVendedor: TCheckBox
          Left = 54
          Top = 319
          Width = 217
          Height = 17
          Caption = 'Pode Acessar Cadastro Vendedor'
          TabOrder = 8
          OnClick = chkPodeCancelarPedidoClick
        end
        object chkPodeCancelarOrcamento: TCheckBox
          Left = 54
          Top = 250
          Width = 217
          Height = 17
          Caption = 'Pode Cancelar Or'#231'amento'
          TabOrder = 5
          OnClick = chkPodeCancelarPedidoClick
        end
        object chkPodeAcessarParametros: TCheckBox
          Left = 54
          Top = 342
          Width = 217
          Height = 17
          Caption = 'Pode Acessar os Par'#226'metros do  Sistema'
          TabOrder = 9
          OnClick = chkPodeCancelarPedidoClick
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
