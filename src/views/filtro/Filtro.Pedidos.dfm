inherited frmFiltroPedidos: TfrmFiltroPedidos
  Caption = 'Filtro Pedidos'
  ClientHeight = 672
  ClientWidth = 1089
  OnCreate = FormCreate
  ExplicitWidth = 1105
  ExplicitHeight = 711
  PixelsPerInch = 96
  TextHeight = 13
  inherited splEsquerda: TSplitter
    Height = 602
    ExplicitHeight = 536
  end
  inherited pnlEsquerda: TPanel
    Height = 602
    ExplicitHeight = 602
    DesignSize = (
      153
      602)
    inherited img2: TImage
      Height = 600
      ExplicitHeight = 502
    end
    object Bevel1: TBevel [2]
      Left = 10
      Top = 497
      Width = 122
      Height = 99
      Anchors = [akLeft, akBottom]
      Shape = bsFrame
    end
    object Label3: TLabel [3]
      Left = 43
      Top = 502
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
      ExplicitTop = 436
    end
    object Label4: TLabel [4]
      Left = 43
      Top = 522
      Width = 69
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'N'#227'o Finalizado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitTop = 456
    end
    object Label5: TLabel [5]
      Left = 43
      Top = 545
      Width = 50
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Cancelado'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Transparent = True
      ExplicitTop = 479
    end
    object Label6: TLabel [6]
      Left = 45
      Top = 567
      Width = 47
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Finalizado'
      Color = 5258796
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      ExplicitTop = 501
    end
    inherited lblPesquisa: TLabel
      Font.Color = 10639360
    end
    inherited lblInforme: TLabel
      Font.Color = 10639360
    end
    inherited cbbPesquisa: TComboBox
      Font.Color = 10639360
    end
    inherited edtValor: TEdit
      Font.Color = 10639360
    end
    inherited BTN_Consultar: TBitBtn
      Top = 302
      Font.Color = 10639360
      ExplicitTop = 302
    end
    inherited chkEntreDatas: TCheckBox
      Color = 15790320
      Font.Color = 10639360
      ParentColor = False
      ParentFont = False
    end
    inherited edtDataInicial: TJvDateEdit
      Font.Color = 10639360
      ParentFont = False
      OnKeyPress = edtDataInicialKeyPress
    end
    inherited edtDataFinal: TJvDateEdit
      Font.Color = 10639360
      ParentFont = False
      OnKeyPress = edtDataFinalKeyPress
    end
    object Panel1: TPanel
      Left = 23
      Top = 566
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 50176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 50176
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 8
    end
    object Panel2: TPanel
      Left = 23
      Top = 520
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 30167
      ParentBackground = False
      TabOrder = 6
    end
    object Panel3: TPanel
      Left = 23
      Top = 544
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 859320
      ParentBackground = False
      TabOrder = 7
    end
  end
  inherited dbGridResultado: TJvDBUltimGrid
    Width = 933
    Height = 602
    OnDrawColumnCell = dbGridResultadoDrawColumnCell
    OnDblClick = dbGridResultadoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'N'#250'mero'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAPEDIDO'
        Title.Caption = 'Data'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HORAPEDIDO'
        Title.Caption = 'Hora'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORLIQUIDO'
        Title.Caption = 'Valor L'#237'quido'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORDESC'
        Title.Caption = 'Desconto'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORENTRADA'
        Title.Caption = 'Valor Entrada'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODCLIENTE'
        Title.Caption = 'Cod. Cliente'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODVEN'
        Title.Caption = 'Cod Vendedor'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEPARCEIRO'
        Title.Caption = 'Parceiro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACOES'
        Title.Caption = 'Observa'#231#245'es'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VALORBRUTO'
        Title.Caption = 'Valor Bruto'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STATUS'
        Title.Caption = 'Status'
        Visible = True
      end>
  end
  inherited jvPnl1: TJvNavPanelHeader
    Top = 602
    Width = 1089
    Height = 70
    ExplicitTop = 602
    ExplicitWidth = 1016
    ExplicitHeight = 70
    DesignSize = (
      1089
      70)
    object Label1: TLabel [0]
      Left = 114
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
    object lblTotalLiquidoNaoFinalizado: TLabel [1]
      Left = 333
      Top = 6
      Width = 62
      Height = 19
      Hint = 'Pedidos n'#227'o Finalizados'
      Caption = 'R$ 0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 30167
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
    end
    object lblTotalCancelado: TLabel [2]
      Left = 515
      Top = 6
      Width = 62
      Height = 19
      Hint = 'Pedidos Cancelados'
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
    object lblTotalLiquidoConcluido: TLabel [3]
      Left = 691
      Top = 6
      Width = 62
      Height = 19
      Hint = 'Pedidos Finalizados'
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
    inherited BTN_Voltar: TBitBtn
      Left = 977
      Top = 38
      TabOrder = 5
      ExplicitLeft = 904
      ExplicitTop = 38
    end
    object BitBtn1: TBitBtn
      Left = 185
      Top = 38
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
    object BitBtn2: TBitBtn
      Left = 303
      Top = 38
      Width = 96
      Height = 28
      Action = actReimprimir
      Caption = 'Imprimir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
    end
    object BitBtn3: TBitBtn
      Left = 35
      Top = 38
      Width = 135
      Height = 28
      Action = actCancelar
      Caption = 'Cancelar Pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object pnl1: TPanel
      Left = 83
      Top = 31
      Width = 718
      Height = 1
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
    end
    object cbbCampoSomar: TComboBox
      Left = 192
      Top = 3
      Width = 89
      Height = 21
      Hint = 'Selecione o campo para totalizar'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = cbbCampoSomarChange
      Items.Strings = (
        'Valor L'#237'quido'
        'Valor Bruto'
        'Entrada'
        'Descontos')
    end
  end
  inherited actConsulta: TActionList
    object actReimprimir: TAction
      Caption = 'Imprimir'
      OnExecute = actReimprimirExecute
    end
    object actDetalhes: TAction
      Caption = 'Detalhes'
      OnExecute = actDetalhesExecute
    end
    object actCancelar: TAction
      Caption = 'Cancelar Pedido'
      OnExecute = actCancelarExecute
    end
  end
  inherited dsBase: TDataSource
    Left = 424
    Top = 176
  end
end
