unit Dao.TDaoVendedor;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Error, System.Generics.Collections,
  Data.DB, FireDAC.Comp.Client,
  Dao.TDaoBase, Dao.IDaoVendedor,
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
    function Listar(): TObjectList<TVendedor>; overload;
    procedure AtualizaVendedor(vendedor: TVendedor);
    function GetVendedor(codigo: string): TVendedor;
    function GetVendedorbyNome(nome: string): TVendedor;

    function GeraID: string;
  end;

implementation

uses
  Util.Exceptions, Dominio.Entidades.TFactory;

{ TDaoVendedor }

procedure TDaoVendedor.ExcluirVendedor(codigo: string);
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'delete  '
        + 'from  VENDEDOR '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
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
        raise TDaoException.Create('Falha ExcluirVendedor: ' + E.Message);
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

  qry := TFactory.Query();
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
        + '     PODEACESSARPARAMETROS = :PODEACESSARPARAMETROS '
        + 'where       '
        + '     CODIGO = :CODIGO ';

      ValidaVendedor(vendedor);
      ObjectToParams(qry, vendedor);

      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha AtualizaVendedor: ' + E.Message);
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

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  VENDEDOR '
        + 'WHERE '
        + '     CODIGO = :CODIGO';

      qry.ParamByName('CODIGO').AsString := codigo;
      qry.open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha GetVendedor: ' + E.Message);
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

  qry := TFactory.Query();
  try
    try
      qry.SQL.Text := ''
        + 'select *  '
        + 'from  VENDEDOR '
        + 'WHERE '
        + '     NOME = :NOME';

      qry.ParamByName('NOME').AsString := nome;
      qry.open;

      if qry.IsEmpty then
        Result := nil
      else
        Result := ParamsToObject(qry);

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha ao GetVendedorbyNome: ' + E.Message);
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
    raise Exception.Create('Vendedor Já existe já existe');

  vendedor.codigo := Self.GeraID;

  qry := TFactory.Query();
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
        + '             :COMISSAOP, '
        + '             :COMISSAOV )';

      ValidaVendedor(vendedor);
      ObjectToParams(qry, vendedor);

      qry.ExecSQL;

    except
      on E: Exception do
      begin
        raise TDaoException.Create('Falha IncluiVendedor: ' + E.Message);
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

  qry := TFactory.Query();
  Result := TObjectList<TVendedor>.Create();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   VENDEDOR '
      + 'order by NOME';

    qry.open;

   while not qry.Eof do
   begin
     Result.Add( ParamsToObject(qry) );
     qry.Next;
   end;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Vendedor: ' + E.Message);
    end;
  end;

end;

function TDaoVendedor.Listar(campo, valor: string): TDataSet;
var
  qry: TFDQuery;
begin

  qry := TFactory.Query();

  try
    qry.SQL.Text := ''
      + 'select *  '
      + 'from   VENDEDOR '
      + 'WHERE '
      + ' UPPER( ' + campo + ') like UPPER( ' + QuotedStr(valor) + ') '
      + 'order by NOME';

    qry.open;

    Result := qry;

  except
    on E: Exception do
    begin
      raise TDaoException.Create('Falha Listar Vendedor: ' + E.Message);
    end;
  end;

end;

procedure TDaoVendedor.ObjectToParams(ds: TFDQuery; vendedor: TVendedor);
begin
  try

    EntityToParams(ds, vendedor);
    // if ds.Params.FindParam('CODIGO') <> nil then
    // ds.Params.ParamByName('CODIGO').AsString := vendedor.codigo;
    // if ds.Params.FindParam('NOME') <> nil then
    // ds.Params.ParamByName('NOME').AsString := vendedor.nome;
    // if ds.Params.FindParam('COMISSAOV') <> nil then
    // ds.Params.ParamByName('COMISSAOV').AsCurrency := vendedor.COMISSAOV;
    // if ds.Params.FindParam('COMISSAOP') <> nil then
    // ds.Params.ParamByName('COMISSAOP').AsCurrency := vendedor.COMISSAOP;
    // if ds.Params.FindParam('SENHA') <> nil then
    // ds.Params.ParamByName('SENHA').AsString := vendedor.SENHA;
    // if ds.Params.FindParam('PODERECEBERPARCELA') <> nil then
    // ds.Params.ParamByName('PODERECEBERPARCELA').AsBoolean := vendedor.PODERECEBERPARCELA;
    // if ds.Params.FindParam('PODECANCELARPEDIDO') <> nil then
    // ds.Params.ParamByName('PODECANCELARPEDIDO').AsBoolean := vendedor.PODECANCELARPEDIDO;
    // if ds.Params.FindParam('PODEACESSARCADASTROVENDEDOR') <> nil then
    // ds.Params.ParamByName('PODEACESSARCADASTROVENDEDOR').AsBoolean := vendedor.PODEACESSARCADASTROVENDEDOR;
  except
    on E: Exception do
      raise TDaoException.Create('Falha ao associar parâmetros TDaoVendedor: ' + E.Message);
  end;
end;

function TDaoVendedor.ParamsToObject(ds: TFDQuery): TVendedor;
begin
  try
    Result := TVendedor.Create();
    FieldsToEntity(ds, Result);

    // Result.codigo := ds.FieldByName('CODIGO').AsString;
    // Result.nome := ds.FieldByName('NOME').AsString;
    // Result.SENHA := ds.FieldByName('SENHA').AsString;
    // Result.COMISSAOV := ds.FieldByName('COMISSAOV').AsCurrency;
    // Result.COMISSAOP := ds.FieldByName('COMISSAOP').AsCurrency;
    // Result.PODERECEBERPARCELA := ds.FieldByName('PODERECEBERPARCELA').AsInteger = 1;
    // Result.PODECANCELARPEDIDO := ds.FieldByName('PODECANCELARPEDIDO').AsInteger = 1;
    // Result.PODEACESSARCADASTROVENDEDOR := ds.FieldByName('PODEACESSARCADASTROVENDEDOR').AsInteger = 1;
  except
    on E: Exception do
      raise TDaoException.Create('Falha no ParamsToObject: ' + E.Message);
  end;

end;

procedure TDaoVendedor.ValidaVendedor(vendedor: TVendedor);
begin
  if Trim(vendedor.nome) = '' then
    raise Exception.Create('Nome não informado');
end;

end.
