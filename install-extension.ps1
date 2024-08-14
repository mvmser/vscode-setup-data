<#
-------------------------------------------------------------------------------
-                VSCode Extensions Installer for Data Professionals           -
-------------------------------------------------------------------------------
Description:
    This script installs VSCode extensions that I personally recommend for
    data scientists, data engineers, and analysts. It reads the list from
    an extensions.json file in the .vscode directory and installs them using
    the VSCode CLI.

Usage:
    Run this script in PowerShell to install the recommended extensions.

Requirements:
    - Visual Studio Code installed with 'code' command in PATH.
    - An extensions.json file in the .vscode directory.

-------------------------------------------------------------------------------
#>

$extensionsFilePath = ".vscode\extensions.json"

if (-not (Test-Path $extensionsFilePath)) {
    Write-Host "extensions.json file not found at path: $extensionsFilePath"
    exit 1
}


$jsonContent = Get-Content $extensionsFilePath -Raw | ConvertFrom-Json
$extensions = $jsonContent.recommendations

if (-not (Get-Command "code" -ErrorAction SilentlyContinue)) {
    Write-Host "'code' command not found. Please ensure Visual Studio Code is installed and 'code' command is added to your PATH."
    exit 1
}

foreach ($ext in $extensions) {
    Write-Host "Installing extension: $ext"
    code --install-extension $ext
}

Write-Host "All extensions installed."
