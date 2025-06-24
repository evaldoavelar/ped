inherited frmConfirmaBaixa: TfrmConfirmaBaixa
  BorderStyle = bsDialog
  Caption = 'Confirma Baixa'
  ClientHeight = 308
  ClientWidth = 371
  OnShow = FormShow
  ExplicitWidth = 387
  ExplicitHeight = 347
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 371
    Height = 308
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label11: TLabel
      Left = 26
      Top = 91
      Width = 72
      Height = 16
      Caption = 'Parcela(s):'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblParcela: TLabel
      Left = 115
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
      Left = 17
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
      Left = 115
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
      Left = 59
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
      Width = 345
      Height = 19
      Caption = 'Confirma o Recebimento da(s) Parcela(s)?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2832832
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 4
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
      Left = 115
      Top = 202
      Width = 121
      Height = 21
      ShowNullDate = False
      TabOrder = 0
      OnChange = edtDatBaixaChange
    end
    object edtValor: TJvCalcEdit
      Left = 112
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
    object GridPanel1: TGridPanel
      Left = 0
      Top = 267
      Width = 371
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      ColumnCollection = <
        item
          Value = 50.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = BitBtn1
          Row = 0
        end
        item
          Column = 1
          Control = btnCancelar
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 2
      object BitBtn1: TBitBtn
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 180
        Height = 35
        Align = alClient
        Caption = '&Pagamento'
        ModalResult = 6
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object btnCancelar: TBitBtn
        AlignWithMargins = True
        Left = 189
        Top = 3
        Width = 179
        Height = 35
        Align = alClient
        Caption = '&Cancelar'
        ModalResult = 2
        TabOrder = 1
      end
    end
  end
end
