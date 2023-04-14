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

uses Util.Exceptions;

procedure TDaoFornecedor.ExcluirFornecedor(codigo: string);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
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

  qry := Self.Query();
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
        + '       DATAALTERACAO = :DATAALTERACAO, '
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

  qry := Self.Query();
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

  qry := Self.Query();
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

  qry := Self.Query();
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
        + '             DATAALTERACAO, '
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
        + '             :DATAALTERACAO, '
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

  qry := Self.Query();

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

  qry := Self.Query();

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

  qry := Self.Query();
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

  qry := Self.Query();
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
