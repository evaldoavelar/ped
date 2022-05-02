inherited frmFiltroVendasParceiro: TfrmFiltroVendasParceiro
  Caption = 'Filtro Vendas Parceiro'
  ExplicitTop = -182
  PixelsPerInch = 96
  TextHeight = 13
  inherited splEsquerda: TSplitter
    Height = 568
    ExplicitHeight = 568
  end
  inherited pnlEsquerda: TPanel
    Height = 568
    ExplicitHeight = 568
    inherited img2: TImage
      Height = 566
      ExplicitHeight = 566
    end
    inherited lblPesquisa: TLabel
      Font.Color = 10639360
    end
    inherited lblInforme: TLabel
      Font.Color = 10639360
    end
    object Bevel1: TBevel [4]
      Left = 10
      Top = 504
      Width = 122
      Height = 64
      Anchors = [akLeft, akBottom]
      Shape = bsFrame
    end
    object Label5: TLabel [5]
      Left = 43
      Top = 530
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
    end
    object Label6: TLabel [6]
      Left = 45
      Top = 550
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
    end
    object Label3: TLabel [7]
      Left = 43
      Top = 510
      Width = 48
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Legenda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    inherited cbbPesquisa: TComboBox
      Font.Color = 10639360
      ItemIndex = -1
      Text = ''
      Items.Strings = (
        'Nome'
        'C'#243'digo Parceiro'
        '')
    end
    inherited edtValor: TEdit
      Font.Color = 10639360
    end
    inherited BTN_Consultar: TBitBtn
      Font.Color = 10639360
    end
    inherited chkEntreDatas: TCheckBox
      Font.Color = 10639360
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
    end
    object Panel3: TPanel
      Left = 23
      Top = 529
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 859320
      ParentBackground = False
      TabOrder = 6
    end
    object Panel1: TPanel
      Left = 23
      Top = 548
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
      TabOrder = 7
    end
  end
  inherited dbGridResultado: TJvDBUltimGrid
    Height = 568
    OnDrawColumnCell = dbGridResultadoDrawColumnCell
    OnDblClick = dbGridResultadoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODPARCEIRO'
        Title.Caption = 'C'#242'digo '
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATA'
        Title.Caption = 'Data'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODVEN'
        Title.Caption = 'Vendedor'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTALPAGAMENTO'
        Title.Caption = 'Total Venda'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TOTALCOMISSAO'
        Title.Caption = 'Total Comiss'#227'o'
        Width = 90
        Visible = True
      end>
  end
  inherited jvPnl1: TJvNavPanelHeader
    Top = 568
    Height = 87
    ExplicitTop = 568
    ExplicitHeight = 87
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
    object lblTotalCancelado: TLabel [1]
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
    object lblTotalLiquidoConcluido: TLabel [2]
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
      Top = 55
      ExplicitTop = 55
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
    object btnCancelar: TBitBtn
      Left = 12
      Top = 56
      Width = 135
      Height = 28
      Action = actCancelar
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object btnDetalhes: TBitBtn
      Left = 169
      Top = 56
      Width = 96
      Height = 28
      Action = actDetalhes
      Caption = 'Detalhes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object cbbCampoSomar: TComboBox
      Left = 192
      Top = 3
      Width = 105
      Height = 21
      Hint = 'Selecione o campo para totalizar'
      Style = csDropDownList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnChange = cbbCampoSomarChange
      Items.Strings = (
        'Total Comiss'#227'o'
        'Total Venda')
    end
  end
  inherited actConsulta: TActionList
    Left = 312
    Top = 256
    object actCancelar: TAction
      Caption = 'Cancelar'
      OnExecute = actCancelarExecute
    end
    object actDetalhes: TAction
      Caption = 'Detalhes'
      OnExecute = actDetalhesExecute
    end
  end
end
