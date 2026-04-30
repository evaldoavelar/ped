object frmFiltroMesAno: TfrmFiltroMesAno
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Totalizador Mensal'
  ClientHeight = 197
  ClientWidth = 340
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 340
    Height = 190
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object lblMesInicio: TLabel
      Left = 16
      Top = 16
      Width = 60
      Height = 13
      Caption = 'M'#234's Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAnoInicio: TLabel
      Left = 210
      Top = 16
      Width = 59
      Height = 13
      Caption = 'Ano Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMesFim: TLabel
      Left = 16
      Top = 61
      Width = 52
      Height = 13
      Caption = 'M'#234's Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblAnoFim: TLabel
      Left = 210
      Top = 61
      Width = 51
      Height = 13
      Caption = 'Ano Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblNumeroCaixa: TLabel
      Left = 16
      Top = 107
      Width = 95
      Height = 13
      Caption = 'N'#250'mero do Caixa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object cbbMesInicio: TComboBox
      Left = 16
      Top = 35
      Width = 178
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtAnoInicio: TEdit
      Left = 210
      Top = 35
      Width = 112
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 1
    end
    object cbbMesFim: TComboBox
      Left = 16
      Top = 80
      Width = 178
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object edtAnoFim: TEdit
      Left = 210
      Top = 80
      Width = 112
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 3
    end
    object cbbNumeroDoCaixa: TComboBox
      Left = 16
      Top = 126
      Width = 306
      Height = 21
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 164
    Width = 340
    Height = 33
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 169
    object btnImprimir: TBitBtn
      Left = 112
      Top = 2
      Width = 100
      Height = 25
      Action = actImprimir
      Caption = 'Ok'
      TabOrder = 0
    end
    object btnCancelar: TBitBtn
      Left = 224
      Top = 3
      Width = 100
      Height = 25
      Action = actCancelar
      Caption = 'Cancelar'
      TabOrder = 1
    end
  end
  object actList: TActionList
    Left = 296
    Top = 8
    object actImprimir: TAction
      Caption = 'Imprimir'
      OnExecute = actImprimirExecute
    end
    object actCancelar: TAction
      Caption = 'Cancelar'
      OnExecute = actCancelarExecute
    end
  end
end
