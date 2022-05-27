unit Relatorio.FRBase;

interface

uses
  SysUtils, Classes, Forms, DB, DBClient, Graphics,
  frxClass, frxExportPDF, frxDBSet, frxBarcode;

type

  TRelatorioFastReportBase = class(TInterfacedObject)
  private
    FIncorporarFontesPdf: Boolean;
    FBorderIcon: TBorderIcons;
    FPrintOnSheet: Integer;
    FExibeCaptionButton: Boolean;
    FPrintMode: TfrxPrintMode;
    FIncorporarBackgroundPdf: Boolean;
    FFastFile: String;
    FfrxReport: TfrxReport;
    FfrxPDFExport: TfrxPDFExport;
    FfrxBarCodeObject: TfrxBarCodeObject;
    FMargemEsquerda: Double;
    FMargemDireita: Double;
    FUsaSeparadorPathPDF: Boolean;
    FMostraPreview: Boolean;
    FNomeDocumento: String;
    FPArquivoPDF: String;
    FNumCopias: Integer;
    FExpandeLogoMarca: Boolean;
    FMostraStatus: Boolean;
    FMargemSuperior: Double;
    FMargemInferior: Double;
    FLogo: String;
    FMostraSetup: Boolean;
    FImpressora: String;
    FAOwner: TComponent;
    FFastFileDir: String;
    procedure frxReportBeforePrint(Sender: TfrxReportComponent);

    procedure SetNumCopias(const Value: Integer);
    procedure SetPathPDF(const Value: String);
    procedure frxReportPreview(Sender: TObject);
    procedure SetFastFileDir(const Value: String);
  protected
    function GetPreparedReport: TfrxReport;
    procedure SetDataSetsToFrxReport; virtual; abstract;
    procedure CarregaDados; virtual; abstract;
    function PrepareReport(): Boolean;
    procedure ExportPDF(aTituloPDF: string);
    procedure CopyDataSet(aDSOrigem: TDataset; aDSDestino: TDataset);

  public
    property PrintMode: TfrxPrintMode read FPrintMode write FPrintMode default pmDefault;
    property PrintOnSheet: Integer read FPrintOnSheet write FPrintOnSheet default 0;
    property ExibeCaptionButton: Boolean read FExibeCaptionButton write FExibeCaptionButton default False;
    property BorderIcon: TBorderIcons read FBorderIcon write FBorderIcon;
    property IncorporarBackgroundPdf: Boolean read FIncorporarBackgroundPdf write FIncorporarBackgroundPdf;
    property IncorporarFontesPdf: Boolean read FIncorporarFontesPdf write FIncorporarFontesPdf;

    property Impressora: String read FImpressora write FImpressora;
    { @prop NomeDocumento - Define/retorna o nome do documento para exportação PDF.
      @links TACBrDFeReport.NomeDocumento :/ }
    property NomeDocumento: String read FNomeDocumento write FNomeDocumento;
    { @prop NumCopias - Define/retorna a quantidade de copias para Imprimir.
      @links TACBrDFeReport.NumCopias :/ }
    property NumCopias: Integer read FNumCopias write SetNumCopias default 1;
    { @prop MostraPreview - Define/retorna se exibi a pre-visualização da impressão.
      @links TACBrDFeReport.MostraPreview :/ }
    property MostraPreview: Boolean read FMostraPreview write FMostraPreview default True;
    { @prop MostraSetup - Define/retorna se exibi a tela de seleção de impressoras ao imprimir.
      @links TACBrDFeReport.MostraSetup :/ }
    property MostraSetup: Boolean read FMostraSetup write FMostraSetup default False;
    { @prop MostraStatus - Define/retorna se exibi a situação da impressão.
      @links TACBrDFeReport.MostraStatus :/ }
    property MostraStatus: Boolean read FMostraStatus write FMostraStatus default True;
    { @prop ArquivoPDF - Retorna o nome do arquivo PDF que foi gerado.
      @links TACBrDFeReport.ArquivoPDF :/ }
    property ArquivoPDF: String read FPArquivoPDF write FPArquivoPDF;
    { @prop UsaSeparadorPathPDF - Define/retorna se usa os separadores no camindo do PDF.
      @links TACBrDFeReport.UsaSeparadorPathPDF :/ }
    property UsaSeparadorPathPDF: Boolean read FUsaSeparadorPathPDF write FUsaSeparadorPathPDF default False;
    { @prop Logo - Define/retorna o caminho do arquivo de logo para impressão.
      @links TACBrDFeReport.Logo :/ }
    property Logo: String read FLogo write FLogo;

    property MargemInferior: Double read FMargemInferior write FMargemInferior;
    { @prop MargemSuperior - Define/retorna a margem superior.
      @links TACBrDFeReport.MargemSuperior :/ }
    property MargemSuperior: Double read FMargemSuperior write FMargemSuperior;
    { @prop MargemEsquerda - Define/retorna a margem esquerda.
      @links TACBrDFeReport.MargemEsquerda :/ }
    property MargemEsquerda: Double read FMargemEsquerda write FMargemEsquerda;
    { @prop MargemDireita - Define/retorna a margem direita.
      @links TACBrDFeReport.MargemDireita :/ }
    property MargemDireita: Double read FMargemDireita write FMargemDireita;
    { @prop ExpandirLogoMarca - Define/retorna se de expandir a logomarca na impressão.
      @links TACBrDFeReport.ExpandeLogoMarca :/ }
    property ExpandeLogoMarca: Boolean read FExpandeLogoMarca write FExpandeLogoMarca default False;

    property FastFile: String read FFastFile write FFastFile;
    property FastFileDir: String read FFastFileDir write SetFastFileDir;
    property frxReport: TfrxReport read FfrxReport;
    property frxPDFExport: TfrxPDFExport read FfrxPDFExport;
  public
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
  end;

implementation

{ TRelatorioFastReportBase }

{ TRelatorioFastReportBase }

procedure TRelatorioFastReportBase.CopyDataSet(aDSOrigem, aDSDestino: TDataset);
begin
  try

    aDSOrigem.first;

    while not aDSOrigem.Eof do
    begin

      aDSDestino.Append;
      for var I := 0 to aDSOrigem.FieldCount - 1 do
      begin
        var
        field := aDSDestino.FindField(aDSOrigem.Fields[I].FieldName);

        if field <> nil then
          field.Value := aDSOrigem.Fields[I].Value;
      end;
      aDSDestino.Post;
      aDSOrigem.Next
    end;

  except
    on e: exception do
    begin
      raise exception.Create('CopyDataSet: ' + e.Message);
    end;
  end;
end;

constructor TRelatorioFastReportBase.Create(AOwner: TComponent);
begin
  FAOwner := AOwner;
  FFastFile := '';
  FExibeCaptionButton := False;
  FBorderIcon := [biSystemMenu, biMaximize, biMinimize];
  FIncorporarFontesPdf := True;
  FIncorporarBackgroundPdf := True;

  FfrxReport := TfrxReport.Create(nil);
  // Antes de alterar a linha abaixo, queira verificar o seguinte tópico:
  // https://www.projetoacbr.com.br/forum/topic/51505-travamento-preview-de-v%C3%A1rias-danfes/
  FfrxReport.EngineOptions.UseGlobalDataSetList := False;
  FfrxReport.PreviewOptions.Buttons := [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind,
    pbOutline, pbPageSetup, pbTools, pbNavigator, pbExportQuick];
  FfrxReport.PreviewOptions.ZoomMode := zmPageWidth;
  with FfrxReport do
  begin
    EngineOptions.DoublePass := True;
    StoreInDFM := False;
    OnBeforePrint := frxReportBeforePrint;
    OnReportPrint := 'frxReportOnReportPrint';
  end;

  FfrxPDFExport := TfrxPDFExport.Create(nil);
  with FfrxPDFExport do
  begin
    Background := FIncorporarBackgroundPdf;
    EmbeddedFonts := FIncorporarFontesPdf;
    Subject := 'Exportando DANFE ';
    ShowProgress := False;
  end;
end;

destructor TRelatorioFastReportBase.Destroy;
begin
  FfrxReport.Free;
  FfrxPDFExport.Free;
  FfrxBarCodeObject.Free;
  inherited;
end;

procedure TRelatorioFastReportBase.ExportPDF(aTituloPDF: string);
var
  fsShowDialog: Boolean;
begin
  if PrepareReport() then
  begin
    frxPDFExport.Author := 'VALUE TI';
    frxPDFExport.Creator := 'VALUE TI';
    frxPDFExport.Producer := 'VALUE TI';
    frxPDFExport.Title := aTituloPDF;
    frxPDFExport.Subject := aTituloPDF;
    frxPDFExport.Keywords := aTituloPDF;
    frxPDFExport.EmbeddedFonts := IncorporarFontesPdf;
    frxPDFExport.Background := IncorporarBackgroundPdf;

    fsShowDialog := frxPDFExport.ShowDialog;
    try
      frxPDFExport.ShowDialog := False;
      frxPDFExport.FileName := ArquivoPDF;

      if not DirectoryExists(ExtractFileDir(frxPDFExport.FileName)) then
        ForceDirectories(ExtractFileDir(frxPDFExport.FileName));

      frxReport.Export(frxPDFExport);
    finally
      frxPDFExport.ShowDialog := fsShowDialog;
    end;
  end
  else
    frxPDFExport.FileName := '';
end;

procedure TRelatorioFastReportBase.frxReportBeforePrint(Sender: TfrxReportComponent);
var
  qrcode: String;
  CpTituloReport, CpLogomarca, CpDescrProtocolo, CpTotTrib, CpContingencia1, CpContingencia2: TfrxComponent;
begin

  CpTituloReport := frxReport.FindObject('ReportTitle1');
  // if Assigned(CpTituloReport) then
  // CpTituloReport.Visible := cdsParametros.FieldByName('Imagem').AsString <> '';

  CpLogomarca := frxReport.FindObject('ImgLogo');
  if Assigned(CpLogomarca) and Assigned(CpTituloReport) then
    CpLogomarca.Visible := CpTituloReport.Visible;

end;

function TRelatorioFastReportBase.GetPreparedReport: TfrxReport;
begin

  if Trim(FFastFile).IsEmpty then
    Result := nil
  else
  begin
    if PrepareReport() then
      Result := frxReport
    else
      Result := nil;
  end;

end;

function TRelatorioFastReportBase.PrepareReport(): Boolean;
var
  I: Integer;
  wProjectStream: TStringStream;
  Page: TfrxReportPage;
begin
  Result := False;

  SetDataSetsToFrxReport;

  if FastFile.IsEmpty = False then
  begin
    if not(uppercase(copy(FastFile, length(FastFile) - 3, 4)) = '.FR3') then
    begin
      wProjectStream := TStringStream.Create(FastFile);
      frxReport.FileName := '';
      frxReport.LoadFromStream(wProjectStream);
      wProjectStream.Free;
    end
    else
    begin
      if FileExists(FastFile) then
        frxReport.LoadFromFile(FastFile)
      else
        raise exception.Create(Format('Caminho do arquivo de impressão do DANFE "%s" inválido.', [FastFile]));
    end;
  end
  else
    raise exception.Create('Caminho do arquivo de impressão do DANFE não assinalado.');

  frxReport.PrintOptions.Copies := FNumCopias;
  frxReport.PrintOptions.ShowDialog := FMostraSetup;
  frxReport.PrintOptions.PrintMode := FPrintMode;
  // Precisamos dessa propriedade porque impressoras não fiscais cortam o papel quando há muitos itens. O ajuste dela deve ser necessariamente após a carga do arquivo FR3 pois, antes da carga o componente é inicializado
  frxReport.PrintOptions.PrintOnSheet := FPrintOnSheet; // Essa propriedade pode trabalhar em conjunto com a printmode
  frxReport.ShowProgress := FMostraStatus;
  frxReport.PreviewOptions.AllowEdit := False;
  frxReport.PreviewOptions.ShowCaptions := FExibeCaptionButton;
  frxReport.OnPreview := frxReportPreview;

  // Define a impressora
  if FImpressora.IsEmpty = False then
    frxReport.PrintOptions.Printer := FImpressora;

  if NomeDocumento.IsEmpty = False then
    frxReport.FileName := NomeDocumento;

  CarregaDados;

  Result := frxReport.PrepareReport;

  // for I := 0 to (frxReport.PreviewPages.Count - 1) do
  // begin
  // Page.PrintIfEmpty := True;
  // end;

end;

procedure TRelatorioFastReportBase.frxReportPreview(Sender: TObject);
begin
  frxReport.PreviewForm.BorderIcons := FBorderIcon;
end;

procedure TRelatorioFastReportBase.SetFastFileDir(const Value: String);
begin
  FFastFileDir := Value;
end;

procedure TRelatorioFastReportBase.SetNumCopias(const Value: Integer);
begin
  FNumCopias := Value;
end;

procedure TRelatorioFastReportBase.SetPathPDF(const Value: String);
begin

end;

end.
