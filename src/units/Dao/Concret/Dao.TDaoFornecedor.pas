unit Dao.TDaoFornecedor;

interface

uses
  System.Generics.Collections,
  System.SysUtils, System.Classes,
  FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog, Dao.IDaoFornecedor,
  Dominio.Entidades.TFornecedor;

type

  TDaoFornecedor = class(TDaoBase, IDaoFornecedor)
  private
    procedure ObjectToParams(ds: TFDQuery; Fornecedor: TFornecedor);
    function ParamsToObject(ds: TFDQuery): TFornecedor;

  public
    procedure ExcluirFornecedor(codigo: string);
    procedure IncluiFornecedor(Fornecedor: TFornecedor);
    procedure ValidaForma(Fornecedor: TFornecedor);
    procedure AtualizaFornecedors(Fornecedor: TFornecedor);
    function GeFornecedor(codigo: string): TFornecedor;
    function GetFornecedorByName(nome: string): TFornecedor;
    function Lista(): TDataSet;
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(aNome: string): TObjectList<TFornecedor>; overload;
    function ListaObject(): TObjectList<TFornecedor>;
    function GeraID: string;

  end;

implementation

{ TDaoFornecedor }

uses Dominio.Entidades.TFactory, Util.Exceptions;

procedure TDaoFornecedor.ExcluirFornecedor(codigo: string);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  fornecedor '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro não pode ser excluído porque está amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluirFornecedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoFornecedor.AtualizaFornecedors(Fornecedor: TFornecedor);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'UPDATE fornecedor '
        + 'SET    nome = :NOME, '
        + '       fantasia = :FANTASIA, '
        + '       contato = :CONTATO, '
        + '       cnpj_cnpf = :CNPJ_CNPF, '
        + '       ie_rg = :IE_RG, '
        + '       im = :IM, '
        + '       endereco = :ENDERECO, '
        + '       numero = :NUMERO, '
        + '       complemento = :COMPLEMENTO, '
        + '       bairro = :BAIRRO, '
        + '       cidade = :CIDADE, '
        + '       uf = :UF, '
        + '       cep = :CEP, '
        + '       telefone = :TELEFONE, '
        + '       celular = :CELULAR, '
        + '       fax = :FAX, '
        + '       pais_bacen = :PAIS_BACEN, '
        + '       pais_nome = :PAIS_NOME, '
        + '       situacao = :SITUACAO, '
        + '       email = :EMAIL, '
        + '       observacoes = :OBSERVACOES '
        + 'WHERE  codigo = :CODIGO';

      ValidaForma(Fornecedor);
      ObjectToParams(qry, Fornecedor);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaFornecedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoFornecedor.GeraID: string;
begin
  Result := Format('%.6d', [AutoIncremento('FORNECEDOR ', 'CODIGO')]);
end;

function TDaoFornecedor.GeFornecedor(codigo: string): TFornecedor;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Fornecedor '
        + 'where  '
        + '    codigo = :codigo ';

      qry.ParamByName('codigo').AsString := codigo;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTFornecedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoFornecedor.GetFornecedorByName(nome: string): TFornecedor;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Fornecedor '
        + 'where  '
        + '    nome = :nome ';

      qry.ParamByName('nome').AsString := nome;
      TLog.d(qry);
      qry.Open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTFornecedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoFornecedor.IncluiFornecedor(Fornecedor: TFornecedor);
var
  qry: TFDQuery;
begin

  if Self.GetFornecedorByName(Fornecedor.nome) <> nil then
    raise Exception.Create('Fornecedor já existe');

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO fornecedor '
        + '            (codigo, '
        + '             nome, '
        + '             fantasia, '
        + '             contato, '
        + '             cnpj_cnpf, '
        + '             ie_rg, '
        + '             im, '
        + '             endereco, '
        + '             numero, '
        + '             complemento, '
        + '             bairro, '
        + '             cidade, '
        + '             uf, '
        + '             cep, '
        + '             telefone, '
        + '             celular, '
        + '             fax, '
        + '             pais_bacen, '
        + '             pais_nome, '
        + '             situacao, '
        + '             email, '
        + '             observacoes) '
        + 'VALUES     ( :CODIGO, '
        + '             :NOME, '
        + '             :FANTASIA, '
        + '             :CONTATO, '
        + '             :CNPJ_CNPF, '
        + '             :IE_RG, '
        + '             :IM, '
        + '             :ENDERECO, '
        + '             :NUMERO, '
        + '             :COMPLEMENTO, '
        + '             :BAIRRO, '
        + '             :CIDADE, '
        + '             :UF, '
        + '             :CEP, '
        + '             :TELEFONE, '
        + '             :CELULAR, '
        + '             :FAX, '
        + '             :PAIS_BACEN, '
        + '             :PAIS_NOME, '
        + '             :SITUACAO, '
        + '             :EMAIL, '
        + '             :OBSERVACOES )';

      ValidaForma(Fornecedor);
      ObjectToParams(qry, Fornecedor);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Pagamento Cliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoFornecedor.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  Fornecedor '
      + 'WHERE '
      + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + 'order by NOME';

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;

end;

function TDaoFornecedor.Lista: TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  Fornecedor '
      + 'order by NOME';

    TLog.d(qry);
    qry.Open;

    Result := qry;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Pagto: ' + E.message);
    end;
  end;
end;

function TDaoFornecedor.ListaObject: TObjectList<TFornecedor>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  Result := TObjectList<TFornecedor>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Fornecedor '
        + 'order by NOME';

      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Fornecedor: ' + E.message);
    end;
  end;

end;

function TDaoFornecedor.Listar(aNome: string): TObjectList<TFornecedor>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  Result := TObjectList<TFornecedor>.Create();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  Fornecedor '
        + 'WHERE '
        + ' UPPER( NOME) like  UPPER( :NOME ) '
        + ' order by nome ';

      if Length(aNome) > 60 then
        aNome := copy(aNome, 0, 60);

      qry.ParamByName('NOME').AsString := aNome + '%';
      TLog.d(qry);
      qry.Open;

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.next;
      end;

    finally
      FreeAndNil(qry);
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Fornecedor: ' + E.message);
    end;
  end;

end;

procedure TDaoFornecedor.ObjectToParams(ds: TFDQuery; Fornecedor: TFornecedor);
begin
  try
    EntityToParams(ds, Fornecedor);
    // if ds.Params.FindParam('CODIGO') <> nil then
    // ds.Params.ParamByName('CODIGO').AsString := Fornecedor.codigo;
    // if ds.Params.FindParam('NOME') <> nil then
    // ds.Params.ParamByName('NOME').AsString := Fornecedor.nome;
    // if ds.Params.FindParam('FANTASIA') <> nil then
    // ds.Params.ParamByName('FANTASIA').AsString := Fornecedor.FANTASIA;
    // if ds.Params.FindParam('CONTATO') <> nil then
    // ds.Params.ParamByName('CONTATO').AsString := Fornecedor.CONTATO;
    // if ds.Params.FindParam('CNPJ_CNPF') <> nil then
    // ds.Params.ParamByName('CNPJ_CNPF').AsString := Fornecedor.CNPJ_CNPF;
    // if ds.Params.FindParam('IE_RG') <> nil then
    // ds.Params.ParamByName('IE_RG').AsString := Fornecedor.IE_RG;
    // if ds.Params.FindParam('IM') <> nil then
    // ds.Params.ParamByName('IM').AsString := Fornecedor.IM;
    // if ds.Params.FindParam('ENDERECO') <> nil then
    // ds.Params.ParamByName('ENDERECO').AsString := Fornecedor.ENDERECO;
    // if ds.Params.FindParam('NUMERO') <> nil then
    // ds.Params.ParamByName('NUMERO').AsString := Fornecedor.NUMERO;
    // if ds.Params.FindParam('COMPLEMENTO') <> nil then
    // ds.Params.ParamByName('COMPLEMENTO').AsString := Fornecedor.COMPLEMENTO;
    // if ds.Params.FindParam('BAIRRO') <> nil then
    // ds.Params.ParamByName('BAIRRO').AsString := Fornecedor.BAIRRO;
    // if ds.Params.FindParam('CIDADE') <> nil then
    // ds.Params.ParamByName('CIDADE').AsString := Fornecedor.CIDADE;
    // if ds.Params.FindParam('UF') <> nil then
    // ds.Params.ParamByName('UF').AsString := Fornecedor.UF;
    // if ds.Params.FindParam('CEP') <> nil then
    // ds.Params.ParamByName('CEP').AsString := Fornecedor.CEP;
    // if ds.Params.FindParam('TELEFONE') <> nil then
    // ds.Params.ParamByName('TELEFONE').AsString := Fornecedor.TELEFONE;
    // if ds.Params.FindParam('CELULAR') <> nil then
    // ds.Params.ParamByName('CELULAR').AsString := Fornecedor.CELULAR;
    // if ds.Params.FindParam('FAX') <> nil then
    // ds.Params.ParamByName('FAX').AsString := Fornecedor.FAX;
    // if ds.Params.FindParam('PAIS_BACEN') <> nil then
    // ds.Params.ParamByName('PAIS_BACEN').AsString := Fornecedor.PAIS_BACEN;
    // if ds.Params.FindParam('PAIS_NOME') <> nil then
    // ds.Params.ParamByName('PAIS_NOME').AsString := Fornecedor.PAIS_NOME;
    // if ds.Params.FindParam('SITUACAO') <> nil then
    // ds.Params.ParamByName('SITUACAO').AsString := Fornecedor.SITUACAO;
    // if ds.Params.FindParam('EMAIL') <> nil then
    // ds.Params.ParamByName('EMAIL').AsString := Fornecedor.EMAIL;
    // if ds.Params.FindParam('OBSERVACOES') <> nil then
    // ds.Params.ParamByName('OBSERVACOES').AsString := Fornecedor.OBSERVACOES;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar parâmetros TFornecedor: ' + E.message);
    end;
  end;
end;

function TDaoFornecedor.ParamsToObject(ds: TFDQuery): TFornecedor;
begin
  try
    Result := TFornecedor.Create();
    FieldsToEntity(ds, Result);
    // Result.codigo := ds.FieldByName('CODIGO').AsString;
    // Result.nome := ds.FieldByName('NOME').AsString;
    // Result.FANTASIA := ds.FieldByName('FANTASIA').AsString;
    // Result.CONTATO := ds.FieldByName('CONTATO').AsString;
    // Result.CNPJ_CNPF := ds.FieldByName('CNPJ_CNPF').AsString;
    // Result.IE_RG := ds.FieldByName('IE_RG').AsString;
    // Result.IM := ds.FieldByName('IM').AsString;
    // Result.ENDERECO := ds.FieldByName('ENDERECO').AsString;
    // Result.NUMERO := ds.FieldByName('NUMERO').AsString;
    // Result.COMPLEMENTO := ds.FieldByName('COMPLEMENTO').AsString;
    // Result.BAIRRO := ds.FieldByName('BAIRRO').AsString;
    // Result.CIDADE := ds.FieldByName('CIDADE').AsString;
    // Result.UF := ds.FieldByName('UF').AsString;
    // Result.CEP := ds.FieldByName('CEP').AsString;
    // Result.TELEFONE := ds.FieldByName('TELEFONE').AsString;
    // Result.CELULAR := ds.FieldByName('CELULAR').AsString;
    // Result.FAX := ds.FieldByName('FAX').AsString;
    // Result.PAIS_BACEN := ds.FieldByName('PAIS_BACEN').AsString;
    // Result.PAIS_NOME := ds.FieldByName('PAIS_NOME').AsString;
    // Result.SITUACAO := ds.FieldByName('SITUACAO').AsString;
    // Result.EMAIL := ds.FieldByName('EMAIL').AsString;
    // Result.OBSERVACOES := ds.FieldByName('OBSERVACOES').AsString;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject TFornecedor: ' + E.message);
    end;
  end;
end;

procedure TDaoFornecedor.ValidaForma(Fornecedor: TFornecedor);
begin
  if Trim(Fornecedor.nome) = '' then
    raise Exception.Create('Nome não informado');

end;

end.
