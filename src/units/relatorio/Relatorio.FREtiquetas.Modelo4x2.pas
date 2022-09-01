unit Relatorio.FREtiquetas.Modelo4x2;

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
  frxExportPDF,
  frxBarcode,
  frxGaugeView,
  frxTableObject,
  Sistema.TParametros,
  Dominio.Entidades.TEmitente, Impressao.Etiquetas;

type

  TFREtiquetasModelo4x2 = class(TRelatorioFastReportBase)
  private
    FfrxEmitente: TfrxDBDataset;
    FfrxEtiqueta1: TfrxDBDataset;
    cdsEmitente: TClientDataSet;
    cdsEtiqueta1: TClientDataSet;

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
  Dominio.Entidades.TFactory, Utils.Rtti, Utils.ArrayUtil;

{ TFREtiquetasModelo4x2 }

procedure TFREtiquetasModelo4x2.CarregaDados;
VAR
  I: integer;
  LEtiqueta: TImpressaoEtiquetas;
  dsEmitente: TDataSet;
begin
  inherited;

  dsEmitente := TFactory.DaoEmitente.GetEmitenteAsDataSet();

  CopyDataSet(dsEmitente, cdsEmitente);

  dsEmitente.free;

  for I := Low(FEtiquetas) to High(FEtiquetas) do
    ObjectToDataSet(FEtiquetas[I], FClientDataSets[I]);

end;

procedure TFREtiquetasModelo4x2.ObjectToDataSet(aObj: Tobject; aDs: TClientDataSet);
begin
  aDs.Append;
  TRttiUtil.ForEachProperties(aObj,
    procedure(prop: TRttiProperty)
    begin
      if (aDs.FindField(prop.Name) <> nil) then
        aDs.FieldByName(prop.Name).Value := prop.GetValue(aObj).AsVariant;
    end);
  aDs.FieldByName('imgLogo').Assign(TFactory.Parametros.LOGOMARCAETIQUETA.Picture.Graphic);
  aDs.post;
end;

procedure TFREtiquetasModelo4x2.PDF(LEtiquetas: Tarray<TImpressaoEtiquetas>);
begin
  FEtiquetas := LEtiquetas;
  SELF.ExportPDF('Etiquetas 4x2');
end;

procedure TFREtiquetasModelo4x2.CriarDataSets;
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
    LDs.FieldDefs.Add('Contem', ftString, 250);
    LDs.FieldDefs.Add('ContemDescricao', ftString, 250);
    LDs.FieldDefs.Add('Observacao', ftString, 250);
    LDs.FieldDefs.Add('Codigo', ftString, 30);
    LDs.FieldDefs.Add('Descricao', ftString, 250);
    LDs.FieldDefs.Add('ImprimirValidade', ftBoolean);
    LDs.CreateDataSet;
  end;
end;

constructor TFREtiquetasModelo4x2.Create(AOwner: TComponent);
begin
  inherited;
  SELF.NomeDocumento := 'ETIQUETAS 4x2';
  SELF.NumCopias := 1;
  SELF.Impressora := TFactory.Parametros.ImpressoraTinta.MODELOIMPRESSORATINTA;
  SELF.FastFile := TFactory.Parametros.DIRETORIORELATORIOS + '\ETIQUETAS-4x2.fr3';
  SELF.FastFileDir := TFactory.Parametros.DIRETORIORELATORIOS;
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

  CriarDataSets;

end;

destructor TFREtiquetasModelo4x2.Destroy;
var
  I: integer;
begin
  for I := Low(FClientDataSets) to High(FClientDataSets) do
    FClientDataSets[I].free;

  FfrxEtiqueta1.free;
  cdsEmitente.free;
  FfrxEmitente.free;
  inherited;
end;

procedure TFREtiquetasModelo4x2.Imprimir(LEtiquetas: Tarray<TImpressaoEtiquetas>; aCopias: integer);
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

procedure TFREtiquetasModelo4x2.SetDataSetsToFrxReport;
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
end;

end.
