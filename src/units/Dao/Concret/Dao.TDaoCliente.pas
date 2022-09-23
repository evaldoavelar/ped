unit Dao.TDaoCliente;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Error,
  Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, System.Generics.Collections,
  Dao.TDaoBase, Dao.IDAOCliente,
  Dominio.Entidades.TCliente;

type

  TDaoCliente = class(TDaoBase, IDAOCliente)
  private
    procedure ObjectToParams(ds: TFDQuery; Cliente: TCliente);
    function ParamsToObject(ds: TFDQuery): TCliente;

  public
    procedure ValidaCliente(Cliente: TCliente);
    procedure IncluiCliente(Cliente: TCliente);
    procedure AtualizaCliente(Cliente: TCliente);
    function GeTCliente(codigo: string): TCliente;
    function GeTClienteByName(nome: string): TCliente;
    function GeTClientesByName(nome: string): TObjectList<TCliente>;
    procedure ExcluirCliente(codigo: string);
    function GeraID: string;
    function Listar(campo: string; valor: string): TDataSet;
  end;

implementation

uses
  Util.Exceptions, Dominio.Entidades.TFactory, Util.Funcoes, Sistema.TLog;

{ TDaoVendedor }

procedure TDaoCliente.AtualizaCliente(Cliente: TCliente);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    try
      qry.SQL.Text := ''
        + 'UPDATE cliente '
        + 'SET    codigo = :CODIGO, '
        + '       nome = :NOME, '
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
        + '       cob_endereco = :COB_ENDERECO, '
        + '       cob_numero = :COB_NUMERO, '
        + '       cob_complemento = :COB_COMPLEMENTO, '
        + '       cob_bairro = :COB_BAIRRO, '
        + '       cob_cidade = :COB_CIDADE, '
        + '       cob_uf = :COB_UF, '
        + '       cob_cep = :COB_CEP, '
        + '       telefone = :TELEFONE, '
        + '       celular = :CELULAR, '
        + '       fax = :FAX, '
        + '       email = :EMAIL, '
        + '       renda = :RENDA, '
        + '       cadastro = :CADASTRO, '
        + '       ultima_venda = :ULTIMA_VENDA, '
        + '       observacoes = :OBSERVACOES, '
        + '       nascimento = :NASCIMENTO, '
        + '       est_civil = :EST_CIVIL, '
        + '       pai = :PAI, '
        + '       mae = :MAE, '
        + '       naturalidade = :NATURALIDADE, '
        + '       loctra = :LOCTRA, '
        + '       local = :LOCAL, '
        + '       profissao = :PROFISSAO, '
        + '       conjuge = :CONJUGE, '
        + '       bloqueado = :BLOQUEADO '
        + 'WHERE  codigo = :CODIGO';

      ObjectToParams(qry, Cliente);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        begin
          TLog.d(E.message);
          raise TDaoException.Create('Falha Atualizar Cliente: ' + E.message);
        end;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TDaoCliente.ExcluirCliente(codigo: string);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  cliente '
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
        raise TDaoException.Create('Falha ExcluirCliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoCliente.GeraID: STRING;
begin
  Result := Format('%.6d', [AutoIncremento('CLIENTE', 'CODIGO')]);
end;

function TDaoCliente.GeTCliente(codigo: string): TCliente;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  cliente '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
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
        raise TDaoException.Create('Falha GeTCliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoCliente.GeTClienteByName(nome: string): TCliente;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  cliente '
        + 'WHERE '
        + '     NOME = :NOME';

      qry.ParamByName('NOME').AsString := nome;
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
        raise TDaoException.Create('Falha GeTClienteByName: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoCliente.GeTClientesByName(nome: string): TObjectList<TCliente>;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  cliente '
        + 'WHERE '
        + '  UPPER( nome ) like UPPER( ' + QuotedStr(nome + '%') + ')'
        + ' order by nome ';

      // qry.ParamByName('NOME').AsString := '%' + nome + '%';
      TLog.d(qry);
      qry.Open;

      Result := TObjectList<TCliente>.Create();

      while not qry.Eof do
      begin
        Result.Add(ParamsToObject(qry));
        qry.Next;
      end;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha GeTClienteByName: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoCliente.IncluiCliente(Cliente: TCliente);
var
  qry: TFDQuery;
begin

  if Self.GeTClienteByName(Cliente.nome) <> nil then
    raise Exception.Create('Já existe um cliente com este nome');

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO cliente '
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
        + '             cob_endereco, '
        + '             cob_numero, '
        + '             cob_complemento, '
        + '             cob_bairro, '
        + '             cob_cidade, '
        + '             cob_uf, '
        + '             cob_cep, '
        + '             telefone, '
        + '             celular, '
        + '             fax, '
        + '             email, '
        + '             renda, '
        + '             cadastro, '
        + '             ultima_venda, '
        + '             observacoes, '
        + '             nascimento, '
        + '             est_civil, '
        + '             pai, '
        + '             mae, '
        + '             naturalidade, '
        + '             loctra, '
        + '             local, '
        + '             profissao, '
        + '             conjuge, '
        + '             bloqueado) '
        + 'VALUES      (:CODIGO, '
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
        + '             :COB_ENDERECO, '
        + '             :COB_NUMERO, '
        + '             :COB_COMPLEMENTO, '
        + '             :COB_BAIRRO, '
        + '             :COB_CIDADE, '
        + '             :COB_UF, '
        + '             :COB_CEP, '
        + '             :TELEFONE, '
        + '             :CELULAR, '
        + '             :FAX, '
        + '             :EMAIL, '
        + '             :RENDA, '
        + '             :CADASTRO, '
        + '             :ULTIMA_VENDA, '
        + '             :OBSERVACOES, '
        + '             :NASCIMENTO, '
        + '             :EST_CIVIL, '
        + '             :PAI, '
        + '             :MAE, '
        + '             :NATURALIDADE, '
        + '             :LOCTRA, '
        + '             :LOCAL, '
        + '             :PROFISSAO, '
        + '             :CONJUGE, '
        + '             :BLOQUEADO);';

      ValidaCliente(Cliente);
      ObjectToParams(qry, Cliente);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha Inserir Cliente: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoCliente.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from  cliente '
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
      raise TDaoException.Create('Falha Listar Cliente: ' + E.message);
    end;
  end;

end;

procedure TDaoCliente.ObjectToParams(ds: TFDQuery; Cliente: TCliente);
begin
  EntityToParams(ds, Cliente);

  /// /  EntityToParams(ds,Cliente);
  // if ds.Params.FindParam('CODIGO') <> nil then
  // ds.ParamByName('CODIGO').AsString := Cliente.codigo;
  //
  // if ds.Params.FindParam('NOME') <> nil then
  // ds.ParamByName('NOME').AsString := Cliente.nome;
  //
  // if ds.Params.FindParam('FANTASIA') <> nil then
  // ds.ParamByName('FANTASIA').AsString := Cliente.FANTASIA;
  //
  // if ds.Params.FindParam('CONTATO') <> nil then
  // ds.ParamByName('CONTATO').AsString := Cliente.CONTATO;
  //
  // if ds.Params.FindParam('CNPJ_CNPF') <> nil then
  // ds.ParamByName('CNPJ_CNPF').AsString := Cliente.CNPJ_CNPF;
  //
  // if ds.Params.FindParam('IE_RG') <> nil then
  // ds.ParamByName('IE_RG').AsString := Cliente.IE_RG;
  //
  // if ds.Params.FindParam('IM') <> nil then
  // ds.ParamByName('IM').AsString := Cliente.IM;
  //
  // if ds.Params.FindParam('ENDERECO') <> nil then
  // ds.ParamByName('ENDERECO').AsString := Cliente.ENDERECO;
  //
  // if ds.Params.FindParam('NUMERO') <> nil then
  // ds.ParamByName('NUMERO').AsString := Cliente.NUMERO;
  //
  // if ds.Params.FindParam('COMPLEMENTO') <> nil then
  // ds.ParamByName('COMPLEMENTO').AsString := Cliente.COMPLEMENTO;
  //
  // if ds.Params.FindParam('BAIRRO') <> nil then
  // ds.ParamByName('BAIRRO').AsString := Cliente.BAIRRO;
  //
  // if ds.Params.FindParam('CIDADE') <> nil then
  // ds.ParamByName('CIDADE').AsString := Cliente.CIDADE;
  //
  // if ds.Params.FindParam('UF') <> nil then
  // ds.ParamByName('UF').AsString := Cliente.UF;
  //
  // if ds.Params.FindParam('CEP') <> nil then
  // ds.ParamByName('CEP').AsString := Cliente.CEP;
  //
  // if ds.Params.FindParam('COB_ENDERECO') <> nil then
  // ds.ParamByName('COB_ENDERECO').AsString := Cliente.COB_ENDERECO;
  //
  // if ds.Params.FindParam('COB_NUMERO') <> nil then
  // ds.ParamByName('COB_NUMERO').AsString := Cliente.COB_NUMERO;
  //
  // if ds.Params.FindParam('COB_COMPLEMENTO') <> nil then
  // ds.ParamByName('COB_COMPLEMENTO').AsString := Cliente.COB_COMPLEMENTO;
  //
  // if ds.Params.FindParam('COB_BAIRRO') <> nil then
  // ds.ParamByName('COB_BAIRRO').AsString := Cliente.COB_BAIRRO;
  //
  // if ds.Params.FindParam('COB_CIDADE') <> nil then
  // ds.ParamByName('COB_CIDADE').AsString := Cliente.COB_CIDADE;
  //
  // if ds.Params.FindParam('COB_UF') <> nil then
  // ds.ParamByName('COB_UF').AsString := Cliente.COB_UF;
  //
  // if ds.Params.FindParam('COB_CEP') <> nil then
  // ds.ParamByName('COB_CEP').AsString := Cliente.COB_CEP;
  //
  // if ds.Params.FindParam('TELEFONE') <> nil then
  // ds.ParamByName('TELEFONE').AsString := Cliente.TELEFONE;
  //
  // if ds.Params.FindParam('CELULAR') <> nil then
  // ds.ParamByName('CELULAR').AsString := Cliente.CELULAR;
  //
  // if ds.Params.FindParam('FAX') <> nil then
  // ds.ParamByName('FAX').AsString := Cliente.FAX;
  //
  // if ds.Params.FindParam('EMAIL') <> nil then
  // ds.ParamByName('EMAIL').AsString := Cliente.EMAIL;
  //
  // if ds.Params.FindParam('RENDA') <> nil then
  // ds.ParamByName('RENDA').AsCurrency := Cliente.RENDA;
  //
  // if ds.Params.FindParam('CADASTRO') <> nil then
  // ds.ParamByName('CADASTRO').AsDateTime := Cliente.CADASTRO;
  //
  // if ds.Params.FindParam('ULTIMA_VENDA') <> nil then
  // ds.ParamByName('ULTIMA_VENDA').AsDateTime := Cliente.ULTIMA_VENDA;
  //
  // if ds.Params.FindParam('OBSERVACOES') <> nil then
  // ds.ParamByName('OBSERVACOES').AsString := Cliente.OBSERVACOES;
  //
  // if ds.Params.FindParam('NASCIMENTO') <> nil then
  // ds.ParamByName('NASCIMENTO').AsDateTime := Cliente.NASCIMENTO;
  //
  // if ds.Params.FindParam('EST_CIVIL') <> nil then
  // ds.ParamByName('EST_CIVIL').AsString := Cliente.EST_CIVIL;
  //
  // if ds.Params.FindParam('PAI') <> nil then
  // ds.ParamByName('PAI').AsString := Cliente.PAI;
  //
  // if ds.Params.FindParam('MAE') <> nil then
  // ds.ParamByName('MAE').AsString := Cliente.MAE;
  //
  // if ds.Params.FindParam('NATURALIDADE') <> nil then
  // ds.ParamByName('NATURALIDADE').AsString := Cliente.NATURALIDADE;
  //
  // if ds.Params.FindParam('LOCTRA') <> nil then
  // ds.ParamByName('LOCTRA').AsString := Cliente.LOCTRA;
  //
  // if ds.Params.FindParam('LOCAL') <> nil then
  // ds.ParamByName('LOCAL').AsString := Cliente.LOCAL;
  //
  // if ds.Params.FindParam('PROFISSAO') <> nil then
  // ds.ParamByName('PROFISSAO').AsString := Cliente.PROFISSAO;
  //
  // if ds.Params.FindParam('CONJUGE') <> nil then
  // ds.ParamByName('CONJUGE').AsString := Cliente.CONJUGE;
  //
  // if ds.Params.FindParam('BLOQUEADO') <> nil then
  // ds.ParamByName('BLOQUEADO').AsBoolean := Cliente.BLOQUEADO;

end;

function TDaoCliente.ParamsToObject(ds: TFDQuery): TCliente;
begin
  try
    Result := TCliente.Create();
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
    // Result.COB_ENDERECO := ds.FieldByName('COB_ENDERECO').AsString;
    // Result.COB_NUMERO := ds.FieldByName('COB_NUMERO').AsString;
    // Result.COB_COMPLEMENTO := ds.FieldByName('COB_COMPLEMENTO').AsString;
    // Result.COB_BAIRRO := ds.FieldByName('COB_BAIRRO').AsString;
    // Result.COB_CIDADE := ds.FieldByName('COB_CIDADE').AsString;
    // Result.COB_UF := ds.FieldByName('COB_UF').AsString;
    // Result.COB_CEP := ds.FieldByName('COB_CEP').AsString;
    // Result.TELEFONE := ds.FieldByName('TELEFONE').AsString;
    // Result.CELULAR := ds.FieldByName('CELULAR').AsString;
    // Result.FAX := ds.FieldByName('FAX').AsString;
    // Result.EMAIL := ds.FieldByName('EMAIL').AsString;
    // Result.RENDA := ds.FieldByName('RENDA').AsCurrency;
    // Result.CADASTRO := ds.FieldByName('CADASTRO').AsDateTime;
    // Result.ULTIMA_VENDA := ds.FieldByName('ULTIMA_VENDA').AsDateTime;
    // Result.OBSERVACOES := ds.FieldByName('OBSERVACOES').AsString;
    // Result.NASCIMENTO := ds.FieldByName('NASCIMENTO').AsDateTime;
    // Result.EST_CIVIL := ds.FieldByName('EST_CIVIL').AsString;
    // Result.PAI := ds.FieldByName('PAI').AsString;
    // Result.MAE := ds.FieldByName('MAE').AsString;
    // Result.NATURALIDADE := ds.FieldByName('NATURALIDADE').AsString;
    // Result.LOCTRA := ds.FieldByName('LOCTRA').AsString;
    // Result.LOCAL := ds.FieldByName('LOCAL').AsString;
    // Result.PROFISSAO := ds.FieldByName('PROFISSAO').AsString;
    // Result.CONJUGE := ds.FieldByName('CONJUGE').AsString;
    // Result.BLOQUEADO := ds.FieldByName('BLOQUEADO').AsInteger = 1;
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject Cliente: ' + E.message);
    end;
  end;

end;

procedure TDaoCliente.ValidaCliente(Cliente: TCliente);
begin
  if Trim(Cliente.nome) = '' then
    raise Exception.Create('Nome do Cliente não informado');

  // if Trim(Cliente.CNPJ_CNPF) <> '' then
  TUtil.ValidaCNPJCNPF(Cliente.CNPJ_CNPF);

end;

end.
