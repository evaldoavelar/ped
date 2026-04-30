#Requires -Version 5.1
<#
.SYNOPSIS
    Simula localmente o pipeline CI do build.yml sem precisar do GitHub Actions.

.DESCRIPTION
    Executa os mesmos steps do workflow na pasta atual (src/).
    Use para validar o build antes de fazer push.

.EXAMPLE
    # Build Release (padrão)
    .\build-local.ps1

    # Build Debug com output verbose
    .\build-local.ps1 -Config Debug -Verbose

    # Pular boss install (dependências já instaladas)
    .\build-local.ps1 -SkipBoss
#>
param(
    [string] $Config      = 'Release',
    [string] $Platform    = 'Win32',
    [string] $ProjectFile = 'PED.dproj',
    [string] $ExeOutput   = 'Exe',
    [string] $DcuOutput   = 'DCU',
    [string] $BdsRsvars   = 'C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\rsvars.bat',
    [switch] $SkipBoss,
    [switch] $Verbose
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ── Helpers ──────────────────────────────────────────────────────────────────
function Step([string]$name) {
    Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
    Write-Host " $name" -ForegroundColor Cyan
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
}

function Fail([string]$msg) {
    Write-Host "`n[FALHA] $msg" -ForegroundColor Red
    exit 1
}

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Push-Location $scriptDir

$start = Get-Date

# ── Step 2: EnvOptions.proj ───────────────────────────────────────────────────
Step "2. Configurar caminhos de biblioteca (EnvOptions.proj)"
$envSrc = "$env:APPDATA\Embarcadero\BDS\22.0\EnvOptions.proj"
if (-not (Test-Path $envSrc)) {
    Fail "EnvOptions.proj nao encontrado em: $envSrc"
}
Write-Host "EnvOptions.proj encontrado: $envSrc" -ForegroundColor Green
Write-Host "(Em CI esse arquivo seria copiado para o perfil NetworkService — localmente ja esta no perfil correto)"

# ── Step 3: BOSS install ──────────────────────────────────────────────────────
if (-not $SkipBoss) {
    Step "3. Instalar dependencias BOSS"

    # Adiciona caminho comum do BOSS ao PATH da sessão
    $bossPath = "$env:USERPROFILE\.boss\bin"
    if (Test-Path "$bossPath\boss.exe") {
        $env:PATH = "$bossPath;$env:PATH"
    }

    $boss = Get-Command boss -ErrorAction SilentlyContinue
    if (-not $boss) {
        Fail "boss.exe nao encontrado no PATH.`nBaixe em: https://github.com/HashLoad/boss/releases"
    }
    Write-Host "Usando: $($boss.Source)" -ForegroundColor Green

    & boss install
    if ($LASTEXITCODE -ne 0) { Fail "boss install falhou (exit code $LASTEXITCODE)" }
    Write-Host "Dependencias instaladas com sucesso." -ForegroundColor Green
} else {
    Write-Host "`n[SKIP] boss install ignorado (-SkipBoss)" -ForegroundColor Yellow
}

# ── Step 4: Criar diretórios ──────────────────────────────────────────────────
Step "4. Criar diretorios de saida"
New-Item -ItemType Directory -Force -Path $ExeOutput | Out-Null
New-Item -ItemType Directory -Force -Path $DcuOutput  | Out-Null
Write-Host "Exe  -> $((Resolve-Path $ExeOutput).Path)"
Write-Host "DCU  -> $((Resolve-Path $DcuOutput).Path)"

# ── Step 5/6: Build via MSBuild ───────────────────────────────────────────────
Step "5. Build $Config/$Platform"

if (-not (Test-Path $BdsRsvars)) {
    Fail "rsvars.bat nao encontrado em: $BdsRsvars`nVerifique o caminho do RAD Studio 22.0."
}
if (-not (Test-Path $ProjectFile)) {
    Fail "Arquivo de projeto nao encontrado: $ProjectFile"
}

$verbosity = if ($Verbose) { 'detailed' } else { 'normal' }

# DCC_ForceExecute=true: redireciona todos os caminhos longos (-U, -I, -O, -R)
# para o arquivo .cmds em vez de colocá-los na linha de comando do DCC32.
# Isso contorna o limite de ~32.767 chars do CreateProcess do Windows quando o
# BOSS adiciona centenas de diretórios ao DCC_UnitSearchPath.
# Referência: CodeGear.Delphi.Targets, target __GenerateSearchPathFile (linha ~308).
$forceExec = '/p:DCC_ForceExecute=true'

# Monta o cmd inline: chama rsvars.bat para configurar o ambiente da
# sessão cmd e em seguida chama msbuild — tudo na MESMA subshell.
$buildCmd = @"
call "$BdsRsvars"
if %ERRORLEVEL% neq 0 exit /b 1
msbuild.exe "$ProjectFile" /t:Build /p:Config=$Config /p:Platform=$Platform /p:DCC_ExeOutput=$ExeOutput /p:DCC_DcuOutput=$DcuOutput /p:DCC_BplOutput=$DcuOutput /p:DCC_DcpOutput=$DcuOutput $forceExec /nologo /verbosity:$verbosity
"@

$tmp = [System.IO.Path]::GetTempFileName() + ".bat"
$buildCmd | Set-Content -Path $tmp -Encoding Ascii

cmd.exe /c $tmp
$buildExit = $LASTEXITCODE
Remove-Item $tmp -Force -ErrorAction SilentlyContinue

if ($buildExit -ne 0) { Fail "Build falhou (exit code $buildExit)" }
Write-Host "Build concluido com sucesso." -ForegroundColor Green

# ── Step 7: Verificar executável ──────────────────────────────────────────────
Step "6. Verificar executavel gerado"
$projectBaseName = [System.IO.Path]::GetFileNameWithoutExtension($ProjectFile)
$exe = Join-Path $ExeOutput ("$projectBaseName.exe")
if (-not (Test-Path $exe)) {
    Fail "Executavel nao encontrado: $exe"
}
$item = Get-Item $exe
Write-Host "Executavel : $($item.FullName)"       -ForegroundColor Green
Write-Host "Tamanho    : $([math]::Round($item.Length / 1KB, 1)) KB"
Write-Host "Gerado em  : $($item.LastWriteTime)"

# ── Resumo ────────────────────────────────────────────────────────────────────
$elapsed = (Get-Date) - $start
Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green
Write-Host " BUILD LOCAL CONCLUIDO em $($elapsed.ToString('mm\:ss'))" -ForegroundColor Green
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Green

Pop-Location
