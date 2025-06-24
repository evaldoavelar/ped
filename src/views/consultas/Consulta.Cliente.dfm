inherited frmConsultaCliente: TfrmConsultaCliente
  Caption = 'Consulta Cliente'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbGridResultado: TJvDBUltimGrid
    OnDrawColumnCell = dbGridResultadoDrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'CODIGO'
        Title.Caption = 'C'#243'digo'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Title.Caption = 'Nome'
        Width = 329
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CNPJ_CNPF'
        Title.Caption = 'CNPJ/CPF'
        Width = 131
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IE_RG'
        Title.Caption = 'Identidade'
        Width = 76
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
        FieldName = 'ENDERECO'
        Title.Caption = 'Rua'
        Width = 226
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMERO'
        Title.Caption = 'N'#250'mero'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COMPLEMENTO'
        Title.Caption = 'Complemento'
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BAIRRO'
        Title.Caption = 'Bairro'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CIDADE'
        Title.Caption = 'Cidade'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CELULAR'
        Title.Caption = 'Celular'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ULTIMA_VENDA'
        Title.Caption = #217'ltima Venda'
        Visible = True
      end>
  end
  inherited jvPnl1: TPanel
    inherited cbbPesquisa: TComboBox
      Items.Strings = (
        'C'#243'digo'
        'Nome'
        'CPF')
    end
  end
end
