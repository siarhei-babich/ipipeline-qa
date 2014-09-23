param([string]$FULL_STATE_NAME = "California", [string]$ABBREVIATED_STATE_NAME = "CA")

$SCRIPT_DIR = "d:\github\ipipeline-qa"
$TARGET_DIR = "d:\Temp\Test\FGLTWO-26"

$GENERIC_FILE = Resolve-Path("$TARGET_DIR\FGLTWO-26, GENERIC.xml")
$TARGET_FILE = "$TARGET_DIR\FGLTWO-26, $FULL_STATE_NAME.xml"

Get-Content "$GENERIC_FILE" | Foreach-Object {$_ -replace "FULL_STATE_NAME", "$FULL_STATE_NAME"} | Foreach-Object {$_ -replace "ABBREVIATED_STATE_NAME", "$ABBREVIATED_STATE_NAME"} | Out-File "$TARGET_FILE"

Write-Host "$TARGET_FILE is created."