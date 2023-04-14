inherited frmConfirmaBaixa: TfrmConfirmaBaixa
  BorderStyle = bsDialog
  Caption = 'Confirma Baixa'
  ClientHeight = 298
  ClientWidth = 335
  OnShow = FormShow
  ExplicitWidth = 341
  ExplicitHeight = 327
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 335
    Height = 298
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label11: TLabel
      Left = 84
      Top = 91
      Width = 53
      Height = 16
      Caption = 'Parcela:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblParcela: TLabel
      Left = 154
      Top = 91
      Width = 55
      Height = 16
      Caption = 'lblParcela'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 56
      Top = 127
      Width = 81
      Height = 16
      Caption = 'Vencimento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVencimento: TLabel
      Left = 154
      Top = 127
      Width = 42
      Height = 16
      Caption = '200001'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 98
      Top = 165
      Width = 39
      Height = 16
      Caption = 'Valor:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblConfirma: TLabel
      Left = 16
      Top = 32
      Width = 301
      Height = 19
      Caption = 'Confirma o Recebimento da Parcela?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2832832
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 43
      Top = 203
      Width = 94
      Height = 16
      Caption = 'Data da Baixa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtDatBaixa: TJvDateEdit
      Left = 154
      Top = 202
      Width = 121
      Height = 21
      ShowNullDate = False
      TabOrder = 0
      OnChange = edtDatBaixaChange
    end
    object edtValor: TJvCalcEdit
      Left = 151
      Top = 160
      Width = 179
      Height = 25
      TabStop = False
      BevelOuter = bvNone
      Alignment = taLeftJustify
      BorderStyle = bsNone
      Color = clBtnFace
      DisplayFormat = 'R$ ,0.00##'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5065932
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      ShowButton = False
      TabOrder = 1
      DecimalPlacesAlwaysShown = False
    end
  end
  object BitBtn1: TBitBtn
    Left = 71
    Top = 259
    Width = 75
    Height = 25
    Caption = '&Ok'
    ModalResult = 6
    TabOrder = 1
  end
  object btnCancelar: TBitBtn
    Left = 167
    Top = 259
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 2
  end
end
