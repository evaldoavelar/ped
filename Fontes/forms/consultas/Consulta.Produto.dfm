inherited FrmConsultaProdutos: TFrmConsultaProdutos
  Caption = 'Consulta Produtos'
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
        FieldName = 'BARRAS'
        Title.Caption = 'Barras'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Title.Caption = 'Descri'#231#227'o'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UND'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRECO_VENDA'
        Title.Caption = 'Pre'#231'o'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OBSERVACOES'
        Title.Caption = 'Observa'#231#245'es'
        Width = 200
        Visible = True
      end>
  end
  inherited jvPnl1: TPanel
    inherited cbbPesquisa: TComboBox
      Items.Strings = (
        'C'#243'digo'
        'C'#243'digo de Barras'
        'Descri'#231#227'o')
    end
  end
end
