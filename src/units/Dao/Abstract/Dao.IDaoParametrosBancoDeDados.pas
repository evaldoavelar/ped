unit Dao.IDaoParametrosBancoDeDados;

interface

uses Sistema.TBancoDeDados;

type

  IDaoParametrosBancoDeDados = interface
    ['{8775978D-D0E0-4909-B7A6-3B6796ADEA08}']

    function SetNomeConfiguracao(aNomeConfiguracao: string): IDaoParametrosBancoDeDados;
    function Salvar(Parametros: TParametrosBancoDeDados): IDaoParametrosBancoDeDados;
    function Carregar(): TParametrosBancoDeDados;

  end;
implementation

end.
