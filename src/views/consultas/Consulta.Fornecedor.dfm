inherited frmConsultaFornecedor: TfrmConsultaFornecedor
  Caption = 'Consulta Fornecedor'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGridResultado: TJvDBUltimGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 80
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
        FieldName = 'FANTASIA'
        Title.Caption = 'Fantasia'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CONTATO'
        Title.Caption = 'Contato'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ_CNPF'
        Title.Caption = 'CNPJ/CNPF'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IE_RG'
        Title.Caption = 'IE/RG'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IM'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ENDERECO'
        Title.Caption = 'Endere'#231'o'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'N'#250'mero'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPLEMENTO'
        Title.Caption = 'Complemento'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BAIRRO'
        Title.Caption = 'Bairro'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CIDADE'
        Title.Caption = 'Cidade'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CEP'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TELEFONE'
        Title.Caption = 'Telefone'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CELULAR'
        Title.Caption = 'Celular'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FAX'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMAIL'
        Title.Caption = 'Email'
        Width = 300
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
  inherited jvPnl1: TPanel
    inherited BTN_Incluir: TBitBtn
      Left = 518
      ExplicitLeft = 518
    end
    inherited cbbPesquisa: TComboBox
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        '')
    end
  end
end
