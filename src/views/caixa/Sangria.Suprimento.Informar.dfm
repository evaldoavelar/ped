inherited FrmSangria: TFrmSangria
  BorderStyle = bsDialog
  Caption = 'Sangria'
  ClientHeight = 355
  ClientWidth = 300
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 306
  ExplicitHeight = 386
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 128
    Width = 53
    Height = 13
    Caption = 'Hist'#243'rico:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6179124
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 80
    Width = 127
    Height = 13
    Caption = 'Valor do Recebimento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6179124
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 16
    Top = 104
    Width = 124
    Height = 13
    Caption = 'Forma de Pagamento:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6179124
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblSangriaSuprimento: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 294
    Height = 40
    Align = alTop
    Alignment = taCenter
    BiDiMode = bdLeftToRight
    Caption = 'SANGRIA'
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6179124
    Font.Height = -29
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBiDiMode = False
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    Transparent = True
    ExplicitWidth = 120
  end
  object mmoHISTORICO: TMemo
    Left = 16
    Top = 147
    Width = 265
    Height = 134
    Color = 15524818
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10639360
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
    OnChange = edtFormaChange
  end
  object edtForma: TEdit
    Left = 160
    Top = 105
    Width = 121
    Height = 21
    TabStop = False
    Color = 15524818
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 10639360
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 16
    ParentFont = False
    TabOrder = 1
    Text = 'Dinheiro'
    OnChange = edtFormaChange
  end
  object btnOk: TBitBtn
    Left = 78
    Top = 306
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancelar: TBitBtn
    Left = 192
    Top = 307
    Width = 89
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Cancelar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 4
    OnClick = btnCancelarClick
  end
  object edtValor: TJvCalcEdit
    Left = 161
    Top = 68
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
    TabOrder = 0
    DecimalPlacesAlwaysShown = False
    OnChange = edtValorChange
  end
  object JvEnterAsTab1: TJvEnterAsTab
    Left = 55
    Top = 53
  end
end
