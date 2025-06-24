unit Relatorio.FREtiquetas.Modelo3x2;

interface

uses
  Relatorio.FRBase,
  MidasLib,
  System.Classes,
  frxDBSet,
  System.SysUtils,
  Datasnap.DBClient,
  Data.DB,
  Graphics, System.Rtti,
  frxClass,

  frxBarcode,
  frxGaugeView,
  frxTableObject,
  Sistema.TParametros,
  Impressao.Etiquetas;

type

  TFREtiquetasModelo3x2 = class(TRelatorioFastReportBase)
  private
    FParametros: TParametros;
    FfrxEmitente: TfrxDBDataset;
    FfrxEtiqueta1: TfrxDBDataset;
    FfrxEtiqueta2: TfrxDBDataset;
    FfrxEtiqueta3: TfrxDBDataset;
    FfrxEtiqueta4: TfrxDBDataset;
    FfrxEtiqueta5: TfrxDBDataset;
    FfrxEtiqueta6: TfrxDBDataset;
    cdsEmitente: TClientDataSet;
    cdsEtiqueta1: TClientDataSet;
    cdsEtiqueta2: TClientDataSet;
    cdsEtiqueta3: TClientDataSet;
    cdsEtiqueta4: TClientDataSet;
    cdsEtiqueta5: TClientDataSet;
    cdsEtiqueta6: TClientDataSet;
    FEtiquetas: Tarray<TImpressaoEtiquetas>;
    FClientDataSets: Tarray<TClientDataSet>;
    procedure SetDataSetsToFrxReport; override;
    procedure CarregaDados; override;
    procedure ObjectToDataSet(aObj: Tobject; aDs: TClientDataSet);
    procedure CriarDataSets;
  public
    procedure Imprimir(LEtiquetas: Tarray<TImpressaoEtiquetas>; aCopias: integer);
    procedure PDF(LEtiquetas: Tarray<TImpressaoEtiquetas>);
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;

  end;

implementation

uses
  Factory.Dao, Utils.Rtti, Utils.ArrayUtil, Factory.Entidades;

{ TFREtiquetasModelo3x2 }

procedure TFREtiquetasModelo3x2.CarregaDados;
VAR
  I: integer;
  LEtiqueta: TImpressaoEtiquetas;
  dsEmitente: TDataSet;
begin
  inherited;

  dsEmitente := TFactory.new.DaoEmitente.GetEmitenteAsDataSet();

  CopyDataSet(dsEmitente, cdsEmitente);

  dsEmitente.free;

  for I := Low(FEtiquetas) to High(FEtiquetas) do
    ObjectToDataSet(FEtiquetas[I], FClientDataSets[I]);

end;

procedure TFREtiquetasModelo3x2.ObjectToDataSet(aObj: Tobject; aDs: TClientDataSet);
begin
  aDs.Append;
  TRttiUtil.ForEachProperties(aObj,
    procedure(prop: TRttiProperty)
    begin
      aDs.FieldByName(prop.Name).Value := prop.GetValue(aObj).AsVariant;
    end);
  aDs.FieldByName('imgLogo').Assign(FParametros.LOGOMARCAETIQUETA.Picture.Graphic);
  aDs.post;
end;

procedure TFREtiquetasModelo3x2.PDF(LEtiquetas: Tarray<TImpressaoEtiquetas>);
begin
  FEtiquetas := LEtiquetas;
  SELF.ExportPDF('Etiquetas 3x2');
end;

procedure TFREtiquetasModelo3x2.CriarDataSets;
VAR
  I: integer;
  LDs: TClientDataSet;
begin
  for I := Low(FClientDataSets) to High(FClientDataSets) do
  begin
    LDs := FClientDataSets[I];
    LDs.FieldDefs.Add('Hora', ftTime);
    LDs.FieldDefs.Add('Data', ftDate);
    LDs.FieldDefs.Add('imgLogo', ftBlob);
    LDs.FieldDefs.Add('Validade', ftDate);
    LDs.FieldDefs.Add('Peso', ftString, 30);
    LDs.FieldDefs.Add('Preco', ftString, 30);
    LDs.FieldDefs.Add('Codigo', ftString, 30);
    LDs.FieldDefs.Add('Descricao', ftString, 250);
    LDs.CreateDataSet;
  end;
end;

constructor TFREtiquetasModelo3x2.Create(AOwner: TComponent);
begin
  inherited;
  FParametros := TFactoryEntidades.Parametros;
  SELF.NomeDocumento := 'ETIQUETAS 3x2';
  SELF.NumCopias := 1;
  SELF.Impressora := FParametros.ImpressoraTinta.MODELOIMPRESSORATINTA;
  SELF.FastFile := FParametros.DIRETORIORELATORIOS + '\ETIQUETAS.fr3';
  SELF.FastFileDir := FParametros.DIRETORIORELATORIOS;
  SELF.MostraPreview := true;
  frxReport.PreviewOptions.ZoomMode := zmDefault;
  // cdsEmitente
  if not Assigned(cdsEmitente) then
  begin
    cdsEmitente := TClientDataSet.Create(nil);
    FfrxEmitente := TfrxDBDataset.Create(nil);
    with FfrxEmitente do
    begin
      DataSet := cdsEmitente;
      OpenDataSource := False;
      UserName := 'Emitente';
    end;

    cdsEmitente.FieldDefs.Add('CNPJ', ftString, 18);
    cdsEmitente.FieldDefs.Add('RAZAO_SOCIAL', ftString, 60);
    cdsEmitente.FieldDefs.Add('FANTASIA', ftString, 60);
    cdsEmitente.FieldDefs.Add('ENDERECO', ftString, 60);
    cdsEmitente.FieldDefs.Add('NUM', ftString, 10);
    cdsEmitente.FieldDefs.Add('COMPLEMENTO', ftString, 60);
    cdsEmitente.FieldDefs.Add('BAIRRO', ftString, 60);
    cdsEmitente.FieldDefs.Add('CIDADE', ftString, 60);
    cdsEmitente.FieldDefs.Add('UF', ftString, 2);
    cdsEmitente.FieldDefs.Add('CEP', ftString, 9);
    cdsEmitente.FieldDefs.Add('TELEFONE', ftString, 20);
    cdsEmitente.FieldDefs.Add('IE', ftString, 20);
    cdsEmitente.FieldDefs.Add('IM', ftString, 20);
    cdsEmitente.FieldDefs.Add('EMAIL', ftString, 100);
    cdsEmitente.CreateDataSet;

  end;

  // cdsEtiqueta1
  if not Assigned(cdsEtiqueta1) then
  begin
    cdsEtiqueta1 := TClientDataSet.Create(nil);
    FfrxEtiqueta1 := TfrxDBDataset.Create(nil);
    with FfrxEtiqueta1 do
    begin
      DataSet := cdsEtiqueta1;
      OpenDataSource := False;
      UserName := 'Etiqueta1';
    end;

    TArrayUtil<TClientDataSet>.Append(FClientDataSets, cdsEtiqueta1);
  end;

  // cdsEtiqueta2
  if not Assigned(cdsEtiqueta2) then
  begin
    cdsEtiqueta2 := TClientDataSet.Create(nil);
    FfrxEtiqueta2 := TfrxDBDataset.Create(nil);
    with FfrxEtiqueta2 do
    begin
      DataSet := cdsEtiqueta2;
      OpenDataSource := False;
      UserName := 'Etiqueta2';
    end;

    TArrayUtil<TClientDataSet>.Append(FClientDataSets, cdsEtiqueta2);
  end;

  // cdsEtiqueta3
  if not Assigned(cdsEtiqueta3) then
  begin
    cdsEtiqueta3 := TClientDataSet.Create(nil);
    FfrxEtiqueta3 := TfrxDBDataset.Create(nil);
    with FfrxEtiqueta3 do
    begin
      DataSet := cdsEtiqueta3;
      OpenDataSource := False;
      UserName := 'Etiqueta3';
    end;

    TArrayUtil<TClientDataSet>.Append(FClientDataSets, cdsEtiqueta3);
  end;

  // cdsEtiqueta4
  if not Assigned(cdsEtiqueta4) then
  begin
    cdsEtiqueta4 := TClientDataSet.Create(nil);
    FfrxEtiqueta4 := TfrxDBDataset.Create(nil);
    with FfrxEtiqueta4 do
    begin
      DataSet := cdsEtiqueta4;
      OpenDataSource := False;
      UserName := 'Etiqueta4';
    end;

    TArrayUtil<TClientDataSet>.Append(FClientDataSets, cdsEtiqueta4);
  end;

  // cdsEtiqueta5
  if not Assigned(cdsEtiqueta5) then
  begin
    cdsEtiqueta5 := TClientDataSet.Create(nil);
    FfrxEtiqueta5 := TfrxDBDataset.Create(nil);
    with FfrxEtiqueta5 do
    begin
      DataSet := cdsEtiqueta5;
      OpenDataSource := False;
      UserName := 'Etiqueta5';
    end;

    TArrayUtil<TClientDataSet>.Append(FClientDataSets, cdsEtiqueta5);
  end;

  // cdsEtiqueta6
  if not Assigned(cdsEtiqueta6) then
  begin
    cdsEtiqueta6 := TClientDataSet.Create(nil);
    FfrxEtiqueta6 := TfrxDBDataset.Create(nil);
    with FfrxEtiqueta6 do
    begin
      DataSet := cdsEtiqueta6;
      OpenDataSource := False;
      UserName := 'Etiqueta6';
    end;

    TArrayUtil<TClientDataSet>.Append(FClientDataSets, cdsEtiqueta6);
  end;

  CriarDataSets;

end;

destructor TFREtiquetasModelo3x2.Destroy;
var
  I: integer;
begin
  for I := Low(FClientDataSets) to High(FClientDataSets) do
    FClientDataSets[I].free;

  FfrxEtiqueta1.free;
  FfrxEtiqueta2.free;
  FfrxEtiqueta3.free;
  FfrxEtiqueta4.free;
  FfrxEtiqueta5.free;
  FfrxEtiqueta6.free;

  cdsEmitente.free;
  FfrxEmitente.free;
  inherited;
end;

procedure TFREtiquetasModelo3x2.Imprimir(LEtiquetas: Tarray<TImpressaoEtiquetas>; aCopias: integer);
begin
  FEtiquetas := LEtiquetas;
  SELF.NumCopias := aCopias;

  if PrepareReport() then
  begin
    if SELF.MostraPreview then
      frxReport.ShowPreparedReport()
    else
      frxReport.Print;
  end;
end;

procedure TFREtiquetasModelo3x2.SetDataSetsToFrxReport;
begin
  inherited;
  // Incluir no arquivo Fr3
  // <Datasets>
  // <item DataSetName="Emitente"/>
  // <item DataSetName="Etiqueta1"/>
  // </Datasets>

  frxReport.EnabledDataSets.Clear;
  frxReport.EnabledDataSets.Add(FfrxEmitente);
  frxReport.EnabledDataSets.Add(FfrxEtiqueta1);
  frxReport.EnabledDataSets.Add(FfrxEtiqueta2);
  frxReport.EnabledDataSets.Add(FfrxEtiqueta3);
  frxReport.EnabledDataSets.Add(FfrxEtiqueta4);
  frxReport.EnabledDataSets.Add(FfrxEtiqueta5);
  frxReport.EnabledDataSets.Add(FfrxEtiqueta6);
end;

end.
