inherited frmFiltroParcelas: TfrmFiltroParcelas
  Caption = 'Filtro Parcelas'
  ClientHeight = 672
  ClientWidth = 957
  ExplicitWidth = 973
  ExplicitHeight = 711
  PixelsPerInch = 96
  TextHeight = 13
  inherited splEsquerda: TSplitter
    Height = 604
    ExplicitHeight = 520
  end
  inherited pnlEsquerda: TPanel
    Height = 604
    ExplicitHeight = 604
    DesignSize = (
      153
      604)
    inherited img2: TImage
      Height = 602
      ExplicitLeft = -1
      ExplicitTop = -4
      ExplicitWidth = 151
      ExplicitHeight = 602
    end
    object Bevel1: TBevel [1]
      Left = 6
      Top = 462
      Width = 123
      Height = 106
      Anchors = [akLeft, akBottom]
      Shape = bsFrame
    end
    object Label1: TLabel [3]
      Left = 33
      Top = 494
      Width = 47
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Vencendo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitTop = 394
    end
    object Label2: TLabel [4]
      Left = 33
      Top = 517
      Width = 42
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Vencidas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitTop = 417
    end
    object Label4: TLabel [5]
      Left = 35
      Top = 540
      Width = 44
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Recebido'
      Color = 5258796
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      ExplicitTop = 405
    end
    object Label3: TLabel [6]
      Left = 32
      Top = 467
      Width = 48
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Legenda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      ExplicitTop = 408
    end
    inherited lblPesquisa: TLabel
      Font.Color = 10639360
    end
    inherited lblInforme: TLabel
      Font.Color = 10639360
    end
    object Label5: TLabel [9]
      Left = 32
      Top = 307
      Width = 50
      Height = 13
      Caption = 'Vencidas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 859320
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      OnClick = chkVencidasClick
    end
    inherited cbbPesquisa: TComboBox
      Font.Color = 10639360
      Text = 'Nome Cliente'
      Items.Strings = (
        'Nome Cliente'
        'C'#243'digo Cliente'
        'Numero do Pedido')
    end
    inherited edtValor: TEdit
      Font.Color = 10639360
    end
    inherited BTN_Consultar: TBitBtn
      Left = 40
      Top = 350
      Font.Color = 10639360
      TabOrder = 6
      ExplicitLeft = 40
      ExplicitTop = 350
    end
    inherited chkEntreDatas: TCheckBox
      Color = 15790320
      ParentColor = False
    end
    inherited edtDataInicial: TJvDateEdit
      Font.Color = 10639360
      ParentFont = False
    end
    inherited edtDataFinal: TJvDateEdit
      Font.Color = 10639360
      ParentFont = False
    end
    object Panel1: TPanel
      Left = 15
      Top = 538
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 50176
      ParentBackground = False
      TabOrder = 9
    end
    object Panel3: TPanel
      Left = 15
      Top = 517
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 859320
      ParentBackground = False
      TabOrder = 8
    end
    object Panel2: TPanel
      Left = 15
      Top = 493
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 15641856
      ParentBackground = False
      TabOrder = 7
    end
    object chkVencidas: TCheckBox
      Left = 14
      Top = 305
      Width = 15
      Height = 17
      Color = 859320
      ParentColor = False
      TabOrder = 5
      OnClick = chkVencidasClick
    end
  end
  inherited dbGridResultado: TJvDBUltimGrid
    Width = 801
    Height = 604
    OnDrawColumnCell = dbGridResultadoDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo Cliente'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 295
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'numparcela'
        Title.Caption = 'Parcela N'#250'mero'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'Pedido'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Valor'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'vencimento'
        Title.Caption = 'Vencimento'
        Width = 80
        Visible = True
      end>
  end
  inherited jvPnl1: TJvNavPanelHeader
    Top = 604
    Width = 957
    Height = 68
    ExplicitTop = 604
    ExplicitWidth = 957
    ExplicitHeight = 68
    DesignSize = (
      957
      68)
    object Label7: TLabel [0]
      Left = 171
      Top = 6
      Width = 57
      Height = 19
      Caption = 'Totais:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblTotalAVencer: TLabel [1]
      Left = 253
      Top = 6
      Width = 62
      Height = 19
      Hint = 'Parcelas Vencendo'
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15641856
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object lblTotalReceber: TLabel [2]
      Left = 611
      Top = 6
      Width = 62
      Height = 19
      Hint = 'Parcelas Recebidas'
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 50176
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object lblTotalVencidas: TLabel [3]
      Left = 435
      Top = 6
      Width = 62
      Height = 19
      Hint = 'Parcelas Vencidas'
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 1387502
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    inherited BTN_Voltar: TBitBtn
      Left = 843
      Top = 36
      TabOrder = 4
      ExplicitLeft = 843
      ExplicitTop = 36
    end
    object btnDetalhes: TBitBtn
      Left = 289
      Top = 36
      Width = 96
      Height = 28
      Action = actDetalhes
      Caption = 'Detalhes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object btnImprimir: TBitBtn
      Left = 172
      Top = 36
      Width = 96
      Height = 28
      Action = actImprimir
      Caption = 'Imprimir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object btnReceber: TBitBtn
      Left = 15
      Top = 36
      Width = 140
      Height = 28
      Action = actReceber
      Caption = 'Receber'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object pnl1: TPanel
      Left = 66
      Top = 29
      Width = 718
      Height = 1
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
    end
  end
  inherited actConsulta: TActionList
    object actDetalhes: TAction
      Caption = 'Detalhes'
      OnExecute = actDetalhesExecute
    end
    object actImprimir: TAction
      Caption = 'Imprimir'
      OnExecute = actImprimirExecute
    end
    object actReceber: TAction
      Caption = 'Receber'
      OnExecute = actReceberExecute
    end
  end
  inherited dsBase: TDataSource
    Left = 504
    Top = 200
  end
end
