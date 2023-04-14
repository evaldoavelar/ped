unit Dao.TDaoVendedor;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Error, System.Generics.Collections,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Sistema.TLog, Dao.IDaoVendedor,
  Dominio.Entidades.TVendedor;

type

  TDaoVendedor = class(TDaoBase, IDaoVendedor)
  private
    procedure ObjectToParams(ds: TFDQuery; vendedor: TVendedor);
    function ParamsToObject(ds: TFDQuery): TVendedor;

  public
    procedure ExcluirVendedor(codigo: string);
    procedure IncluiVendedor(vendedor: TVendedor);
    procedure ValidaVendedor(vendedor: TVendedor);
    function Listar(campo, valor: string): TDataSet; overload;
    function Listar(descricao: string): TObjectList<TVendedor>; overload;
    function Listar(): TObjectList<TVendedor>; overload;
    procedure AtualizaVendedor(vendedor: TVendedor);
    function GetVendedor(codigo: string): TVendedor;
    function GetVendedorbyNome(nome: string): TVendedor;

    function GeraID: string;
  end;

implementation

uses
  Util.Exceptions;

{ TDaoVendedor }

procedure TDaoVendedor.ExcluirVendedor(codigo: string);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  VENDEDOR '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
      TLog.d(qry);
      qry.ExecSQL;
    except
      on E: EFDDBEngineException do
      begin
        if E.Kind = ekFKViolated then
          raise Exception.Create('O registro n�o pode ser exclu�do porque est� amarrado a outro registro.')
        else
          raise;
      end;
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha ExcluirVendedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoVendedor.AtualizaVendedor(vendedor: TVendedor);
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'update VENDEDOR '
        + '  set'
        + '     NOME = :NOME, '
        + '     COMISSAOV = :COMISSAOV,   '
        + '     COMISSAOP = :COMISSAOP,   '
        + '     SENHA = :SENHA,   '
        + '     PODEACESSARCADASTROVENDEDOR = :PODEACESSARCADASTROVENDEDOR, '
        + '     PODERECEBERPARCELA = :PODERECEBERPARCELA, '
        + '     PODECANCELARPEDIDO = :PODECANCELARPEDIDO, '
        + '     PODECANCELARORCAMENTO = :PODECANCELARORCAMENTO, '
        + '     DATAALTERACAO = :DATAALTERACAO, '
        + '     PODEACESSARPARAMETROS = :PODEACESSARPARAMETROS '
        + 'where       '
        + '     CODIGO = :CODIGO ';

      ValidaVendedor(vendedor);
      ObjectToParams(qry, vendedor);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha AtualizaVendedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoVendedor.GeraID: string;
begin
  Result := Format('%.3d', [AutoIncremento('VENDEDOR', 'CODIGO')]);
end;

function TDaoVendedor.GetVendedor(codigo: string): TVendedor;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  VENDEDOR '
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

        if E.message.Contains('unavailable database') then
          raise Exception.Create('Banco de dados n�o dispon�vel')
        else
          raise TDaoException.Create('Falha GetVendedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoVendedor.GetVendedorbyNome(nome: string): TVendedor;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  VENDEDOR '
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
        raise TDaoException.Create('Falha ao GetVendedorbyNome: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

procedure TDaoVendedor.IncluiVendedor(vendedor: TVendedor);
var
  qry: TFDQuery;
begin

  if Self.GetVendedorbyNome(vendedor.nome) <> nil then
    raise Exception.Create('Vendedor J� existe j� existe');

  vendedor.codigo := Self.GeraID;

  qry := Self.Query();
  try
    try
      qry.SQL.Text := ''
        + 'INSERT INTO  VENDEDOR '
        + '            (CODIGO, '
        + '             NOME, '
        + '             SENHA, '
        + '             PODEACESSARCADASTROVENDEDOR, '
        + '             PODERECEBERPARCELA, '
        + '             PODECANCELARPEDIDO, '
        + '             PODECANCELARORCAMENTO, '
        + '             PODEACESSARPARAMETROS, '
        + '             DATAALTERACAO, '
        + '             COMISSAOP, '
        + '             COMISSAOV ) '
        + 'VALUES      (:CODIGO, '
        + '             :NOME, '
        + '             :SENHA, '
        + '             :PODEACESSARCADASTROVENDEDOR, '
        + '             :PODERECEBERPARCELA, '
        + '             :PODECANCELARPEDIDO, '
        + '             :PODECANCELARORCAMENTO, '
        + '             :PODEACESSARPARAMETROS, '
        + '             :DATAALTERACAO, '
        + '             :COMISSAOP, '
        + '             :COMISSAOV )';

      ValidaVendedor(vendedor);
      ObjectToParams(qry, vendedor);

      TLog.d(qry);
      qry.ExecSQL;

    except
      on E: Exception do
      begin
        TLog.d(E.message);
        raise TDaoException.Create('Falha IncluiVendedor: ' + E.message);
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

end;

function TDaoVendedor.Listar: TObjectList<TVendedor>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  Result := TObjectList<TVendedor>.Create();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   VENDEDOR '
      + 'order by NOME';

    TLog.d(qry);
    qry.Open;

    while not qry.Eof do
    begin
      Result.Add(ParamsToObject(qry));
      qry.Next;
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Vendedor: ' + E.message);
    end;
  end;

end;

function TDaoVendedor.Listar(descricao: string): TObjectList<TVendedor>;
var
  qry: TFDQuery;
begin

  qry := Self.Query();
  Result := TObjectList<TVendedor>.Create();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   VENDEDOR '
      + ' where UPPER( nome ) like UPPER( ' + QuotedStr('%' + descricao + '%') + ')'
      + 'order by NOME';

    TLog.d(qry);
    qry.Open;

    while not qry.Eof do
    begin
      Result.Add(ParamsToObject(qry));
      qry.Next;
    end;

  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha Listar Vendedor: ' + E.message);
    end;
  end;

end;

function TDaoVendedor.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := Self.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   VENDEDOR '
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
      raise TDaoException.Create('Falha Listar Vendedor: ' + E.message);
    end;
  end;
end;

procedure TDaoVendedor.ObjectToParams(ds: TFDQuery;
  vendedor:
  TVendedor);
begin
  try

    EntityToParams(ds, vendedor);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha ao associar par�metros TDaoVendedor: ' + E.message);
    end;
  end;
end;

function TDaoVendedor.ParamsToObject(ds: TFDQuery): TVendedor;
begin
  try
    Result := TVendedor.Create();
    FieldsToEntity(ds, Result);
  except
    on E: Exception do
    begin
      TLog.d(E.message);
      raise TDaoException.Create('Falha no ParamsToObject: ' + E.message);
    end;
  end;

end;

procedure TDaoVendedor.ValidaVendedor(vendedor: TVendedor);
begin
  if Trim(vendedor.nome) = '' then
    raise Exception.Create('Nome n�o informado');
end;

end.
