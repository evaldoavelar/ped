inherited frmFiltroOrcamentos: TfrmFiltroOrcamentos
  Caption = 'Filtro Or'#231'amentos'
  ClientHeight = 598
  ExplicitHeight = 637
  PixelsPerInch = 96
  TextHeight = 13
  inherited splEsquerda: TSplitter
    Height = 559
    ExplicitHeight = 616
  end
  inherited pnlEsquerda: TPanel
    Height = 559
    ExplicitHeight = 559
    inherited img2: TImage
      Height = 557
      ExplicitLeft = -1
      ExplicitTop = 3
      ExplicitWidth = 151
      ExplicitHeight = 614
    end
    inherited lblPesquisa: TLabel
      Font.Color = 10639360
    end
    inherited lblInforme: TLabel
      Font.Color = 10639360
    end
    object Bevel1: TBevel [4]
      Left = 10
      Top = 439
      Width = 122
      Height = 74
      Anchors = [akLeft, akBottom]
      Shape = bsFrame
    end
    object Label3: TLabel [5]
      Left = 43
      Top = 445
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
    object Label6: TLabel [6]
      Left = 43
      Top = 484
      Width = 25
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Ativo'
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
    object Label1: TLabel [7]
      Left = 43
      Top = 465
      Width = 37
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Vencido'
      Color = 5258796
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5259564
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      ExplicitTop = 522
    end
    inherited cbbPesquisa: TComboBox
      Font.Color = 10639360
      Items.Strings = (
        'Nome'
        'Numero do Or'#231'amento')
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
      OnKeyPress = edtDataFinalKeyPress
    end
    object Panel1: TPanel
      Left = 23
      Top = 483
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
    object Panel3: TPanel
      Left = 23
      Top = 464
      Width = 14
      Height = 15
      Anchors = [akLeft, akBottom]
      BevelOuter = bvNone
      Color = 859320
      ParentBackground = False
      TabOrder = 6
    end
  end
  inherited dbGridResultado: TJvDBUltimGrid
    Height = 559
    OnDrawColumnCell = dbGridResultadoDrawColumnCell
    OnDblClick = dbGridResultadoDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'N'#250'mero'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAORCAMENTO'
        Title.Caption = 'Data'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATAVENCIMENTO'
        Title.Caption = 'Vencimento'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'VOLUME'
        Title.Caption = 'Volume'
        Width = 65
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
        FieldName = 'VALORDESC'
        Title.Caption = 'Desconto'
        Width = 90
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
        FieldName = 'CLIENTE'
        Title.Caption = 'Cliente'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HORAORCAMENTO'
        Title.Caption = 'Hora'
        Width = 70
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
        FieldName = 'STATUS'
        Title.Caption = 'Status'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACOES'
        Title.Caption = 'Observa'#231#245'es'
        Width = 300
        Visible = True
      end>
  end
  inherited jvPnl1: TJvNavPanelHeader
    Top = 559
    Height = 39
    ExplicitTop = 559
    ExplicitHeight = 39
    inherited BTN_Voltar: TBitBtn
      Top = 7
      TabOrder = 1
      ExplicitTop = 7
    end
    object btnDetalhes: TBitBtn
      Left = 361
      Top = 8
      Width = 96
      Height = 28
      Action = actAlterar
      Caption = 'Alterar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object btnImprimir: TBitBtn
      Left = 16
      Top = 6
      Width = 169
      Height = 28
      Action = actImprimir
      Caption = 'Imprimir Or'#231'amento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object btnNovo: TBitBtn
      Left = 240
      Top = 8
      Width = 96
      Height = 28
      Action = actNovo
      Caption = 'Novo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 10639360
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited actConsulta: TActionList
    object actCancelaOrcamento: TAction
      Caption = 'Cancelar Orcamento'
      OnExecute = actCancelaOrcamentoExecute
    end
    object actNovo: TAction
      Caption = 'Novo'
      OnExecute = actNovoExecute
    end
    object actAlterar: TAction
      Caption = 'Alterar'
      OnExecute = actAlterarExecute
    end
    object actImprimir: TAction
      Caption = 'Imprimir Or'#231'amento'
      OnExecute = actImprimirExecute
    end
    object actCopiarOrcamento: TAction
      Caption = 'Copiar'
    end
  end
end
