inherited FrmConfiguracoes: TFrmConfiguracoes
  BorderStyle = bsDialog
  Caption = 'Configura'#231#245'es'
  ClientHeight = 403
  ClientWidth = 796
  OnShow = FormShow
  ExplicitWidth = 812
  ExplicitHeight = 442
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 362
    Width = 796
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btnOk: TBitBtn
      Left = 696
      Top = 6
      Width = 75
      Height = 25
      Action = actOk
      Caption = 'Ok'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
  end
  object pgc1: TPageControl
    Left = 0
    Top = 0
    Width = 796
    Height = 362
    ActivePage = ts2
    Align = alClient
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'Empresa'
      object Label1: TLabel
        Left = 13
        Top = 3
        Width = 71
        Height = 13
        Caption = 'Raz'#227'o Social'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 395
        Top = 7
        Width = 48
        Height = 13
        Caption = 'Fantasia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 13
        Top = 53
        Width = 25
        Height = 13
        Caption = 'Cnpj'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 13
        Top = 102
        Width = 72
        Height = 13
        Caption = 'Respons'#225'vel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 298
        Top = 53
        Width = 103
        Height = 13
        Caption = 'Inscri'#231#227'o Estadual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 554
        Top = 53
        Width = 108
        Height = 13
        Caption = 'Inscri'#231#227'o Municipal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 14
        Top = 151
        Width = 22
        Height = 13
        Caption = 'Rua'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 409
        Top = 151
        Width = 34
        Height = 13
        Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 14
        Top = 200
        Width = 38
        Height = 13
        Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 409
        Top = 200
        Width = 38
        Height = 13
        Caption = 'Compl:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 611
        Top = 200
        Width = 14
        Height = 13
        Caption = 'UF'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 665
        Top = 200
        Width = 20
        Height = 13
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 272
        Top = 200
        Width = 47
        Height = 13
        Caption = 'N'#250'mero:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 14
        Top = 249
        Width = 30
        Height = 13
        Caption = 'Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbl2: TLabel
        Left = 566
        Top = 251
        Width = 20
        Height = 13
        Caption = 'Fax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 409
        Top = 251
        Width = 49
        Height = 13
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtRazaoSocial: TEdit
        Left = 13
        Top = 22
        Width = 372
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 0
        OnChange = edtRazaoSocialChange
      end
      object edtFantasia: TEdit
        Left = 405
        Top = 22
        Width = 372
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 1
        OnChange = edtRazaoSocialChange
      end
      object edtCpf: TEdit
        Left = 13
        Top = 72
        Width = 244
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 2
        OnChange = edtRazaoSocialChange
      end
      object edtIE: TEdit
        Left = 298
        Top = 72
        Width = 223
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 3
        OnChange = edtRazaoSocialChange
      end
      object edtResponsavel: TEdit
        Left = 13
        Top = 121
        Width = 327
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        TabOrder = 5
        OnChange = edtRazaoSocialChange
      end
      object edtIM: TEdit
        Left = 554
        Top = 72
        Width = 223
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 4
        OnChange = edtRazaoSocialChange
      end
      object edtRua: TEdit
        Left = 14
        Top = 170
        Width = 371
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        TabOrder = 6
        OnChange = edtRazaoSocialChange
      end
      object edtBairro: TEdit
        Left = 405
        Top = 170
        Width = 372
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 30
        ParentFont = False
        TabOrder = 7
        OnChange = edtRazaoSocialChange
      end
      object edtCidade: TEdit
        Left = 14
        Top = 219
        Width = 243
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 35
        ParentFont = False
        TabOrder = 8
        OnChange = edtRazaoSocialChange
      end
      object edtComplemento: TEdit
        Left = 409
        Top = 219
        Width = 184
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 40
        ParentFont = False
        TabOrder = 10
        OnChange = edtRazaoSocialChange
      end
      object edtUF: TEdit
        Left = 610
        Top = 219
        Width = 42
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 2
        ParentFont = False
        TabOrder = 11
        OnChange = edtRazaoSocialChange
      end
      object edtCEP: TMaskEdit
        Left = 665
        Top = 219
        Width = 112
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        EditMask = '99999-999;0;'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 9
        ParentFont = False
        TabOrder = 12
        Text = ''
        OnChange = edtRazaoSocialChange
      end
      object edtNumero: TEdit
        Left = 271
        Top = 219
        Width = 123
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 9
        OnChange = edtRazaoSocialChange
      end
      object edtTelefone: TMaskEdit
        Left = 409
        Top = 270
        Width = 113
        Height = 21
        Color = 15524818
        EditMask = '\(00\)0000-00000;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 14
        Text = ''
        OnChange = edtRazaoSocialChange
      end
      object edtFax: TMaskEdit
        Left = 566
        Top = 270
        Width = 119
        Height = 21
        Color = 15524818
        EditMask = '\(00\)0000-0000;0;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 13
        ParentFont = False
        TabOrder = 15
        Text = ''
        OnChange = edtRazaoSocialChange
      end
      object edtEmail: TEdit
        Left = 14
        Top = 268
        Width = 367
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 13
        OnChange = edtRazaoSocialChange
      end
    end
    object ts2: TTabSheet
      Caption = 'Par'#226'metros'
      ImageIndex = 1
      object lbl1: TLabel
        Left = 16
        Top = 232
        Width = 155
        Height = 13
        Caption = 'Validade do Or'#231'amento em Dias:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object chkVenderClienteBloqueado: TCheckBox
        Left = 16
        Top = 101
        Width = 217
        Height = 17
        Caption = 'Vender Para Cliente Bloqueado'
        TabOrder = 3
        OnClick = chkVenderClienteBloqueadoClick
      end
      object chkAtualizaClienteNaVenda: TCheckBox
        Left = 16
        Top = 55
        Width = 265
        Height = 17
        Caption = 'Atualizar Informa'#231#245'es do Cliente na Venda'
        TabOrder = 1
        OnClick = chkVenderClienteBloqueadoClick
      end
      object chkBakcup: TCheckBox
        Left = 16
        Top = 78
        Width = 265
        Height = 17
        Caption = 'Fazer Backup Di'#225'rio'
        TabOrder = 2
        OnClick = chkVenderClienteBloqueadoClick
      end
      object chkBloquearClienteComAtraso: TCheckBox
        Left = 16
        Top = 31
        Width = 313
        Height = 17
        Caption = 'Bloquear Automaticamente Cliente Com Parcelas em Atraso '
        TabOrder = 0
        OnClick = chkVenderClienteBloqueadoClick
      end
      object edtValidadeOrcamento: TEdit
        Left = 16
        Top = 251
        Width = 121
        Height = 21
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        NumbersOnly = True
        ParentFont = False
        TabOrder = 5
        OnChange = edtRazaoSocialChange
      end
      object rgPesquisaPor: TRadioGroup
        Left = 13
        Top = 180
        Width = 265
        Height = 49
        Caption = 'Pesquisar Produto na Venda  Por:'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Items.Strings = (
          'Descri'#231#227'o'
          'C'#243'digo/C'#243'digo Barras')
        ParentFont = False
        TabOrder = 4
        OnClick = rgPesquisaPorClick
      end
      object chkInformarParceiroNaVenda: TCheckBox
        Left = 16
        Top = 125
        Width = 217
        Height = 17
        Caption = 'Informar Parceiro Na Venda'
        TabOrder = 6
        OnClick = chkVenderClienteBloqueadoClick
      end
      object chkExibirObservacao: TCheckBox
        Left = 16
        Top = 149
        Width = 217
        Height = 17
        Caption = 'Exibir Observa'#231#227'o'
        TabOrder = 7
        OnClick = chkVenderClienteBloqueadoClick
      end
    end
    object tsLogoMarca: TTabSheet
      Caption = 'Logo Marca'
      ImageIndex = 2
      object Label17: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 782
        Height = 13
        Align = alTop
        Caption = 'Logo marca para Impress'#227'o em Etiquetas (130 x 43 pixels)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 333
      end
      object imgComprovante: TImage
        AlignWithMargins = True
        Left = 3
        Top = 22
        Width = 782
        Height = 268
        Align = alClient
        Center = True
        Proportional = True
        ExplicitLeft = 0
        ExplicitTop = 2
        ExplicitWidth = 698
        ExplicitHeight = 352
      end
      object Panel1: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 296
        Width = 782
        Height = 35
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btnAnexarComprovante: TBitBtn
          Left = 16
          Top = 8
          Width = 121
          Height = 25
          Caption = 'Carregar'
          TabOrder = 0
          OnClick = btnAnexarComprovanteClick
        end
      end
    end
    object tsImpressora: TTabSheet
      Caption = 'Impressora'
      ImageIndex = 3
      object grp1: TGroupBox
        Left = 9
        Top = 21
        Width = 249
        Height = 121
        Caption = 'Impressora Termica'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label16: TLabel
          Left = 20
          Top = 20
          Width = 34
          Height = 13
          Caption = 'Modelo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cbxImpressoraTermicaModelo: TComboBox
          Left = 20
          Top = 36
          Width = 219
          Height = 21
          TabOrder = 0
          OnChange = cbxImpressoraTermicaModeloChange
        end
        object chkImprimir2Vias: TCheckBox
          Left = 20
          Top = 71
          Width = 265
          Height = 17
          Caption = 'Imprimir Comprovante em 2 Vias'
          TabOrder = 1
          OnClick = chkVenderClienteBloqueadoClick
        end
        object chkImprimirItens2Via: TCheckBox
          Left = 20
          Top = 94
          Width = 265
          Height = 17
          Caption = 'Imprimir Via da Loja Resumido'
          TabOrder = 2
          OnClick = chkVenderClienteBloqueadoClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 10
        Top = 159
        Width = 249
        Height = 73
        Caption = 'Impressora Tinta/Laser'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label18: TLabel
          Left = 20
          Top = 20
          Width = 34
          Height = 13
          Caption = 'Modelo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 10639360
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object cbbImpressoraTinta: TComboBox
          Left = 20
          Top = 36
          Width = 219
          Height = 21
          TabOrder = 0
          OnChange = cbxImpressoraTermicaModeloChange
        end
      end
    end
    object tsCaixa: TTabSheet
      Caption = 'Caixa'
      ImageIndex = 4
      object Label19: TLabel
        Left = 11
        Top = 24
        Width = 98
        Height = 16
        Caption = 'N'#250'mero do Caixa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtNumeroDoCaixa: TEdit
        Left = 22
        Top = 47
        Width = 271
        Height = 24
        CharCase = ecUpperCase
        Color = 15524818
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 10
        ParentFont = False
        TabOrder = 0
        OnChange = edtRazaoSocialChange
      end
      object chkFuncionarComoCliente: TCheckBox
        Left = 13
        Top = 90
        Width = 313
        Height = 17
        Caption = 'Funcionar Como Cliente'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 10639360
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = chkVenderClienteBloqueadoClick
      end
    end
  end
  object act1: TActionList
    Left = 98
    Top = 368
    object actOk: TAction
      Caption = 'actOk'
      OnExecute = actOkExecute
    end
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 134
    Top = 364
  end
  object dlgSavePic: TSavePictureDialog
    Filter = 
      'All (*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.jpg;*.jpeg;*.gif;*.png;*.t' +
      'if;*.tiff;*.ico;*.emf;*.wmf)|*.gif;*.png;*.jpg;*.jpeg;*.bmp;*.jp' +
      'g;*.jpeg;*.gif;*.png;*.tif;*.tiff;*.ico;*.emf;*.wmf|GIF Image (*' +
      '.gif)|*.gif|Portable Network Graphics (*.png)|*.png|JPEG Image F' +
      'ile (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg|Bitmaps (*.bmp' +
      ')|*.bmp|JPEG Images (*.jpg)|*.jpg|JPEG Images (*.jpeg)|*.jpeg|GI' +
      'F Images (*.gif)|*.gif|PNG Images (*.png)|*.png|TIFF Images (*.t' +
      'if)|*.tif|TIFF Images (*.tiff)|*.tiff|Icons (*.ico)|*.ico|Enhanc' +
      'ed Metafiles (*.emf)|*.emf|Metafiles (*.wmf)|*.wmf'
    Left = 30
    Top = 367
  end
  object dlgOpenPic: TOpenPictureDialog
    Filter = 'Jpg|*.jpg|*.jpeg|Todos|*.*'
    Left = 62
    Top = 367
  end
end
