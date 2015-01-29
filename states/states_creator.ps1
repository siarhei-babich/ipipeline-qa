param([string]$FULL_STATE_NAME = "California", [string]$ABBREVIATED_STATE_NAME = "CA")

$PREFIX_NAME= "\QoL Performer"
$TARGET_DIR = "E:\epam\ps\aig\auto\cebatchtool\qolprotector\state"

$GENERIC_FILE = Resolve-Path("$TARGET_DIR\$PREFIX_NAME, GENERIC.xml")
$TARGET_FILE = "$TARGET_DIR\$PREFIX_NAME, $FULL_STATE_NAME.xml"

Get-Content "$GENERIC_FILE" | Foreach-Object {$_ -replace "FULL_STATE_NAME", "$FULL_STATE_NAME"} | Foreach-Object {$_ -replace "ABBREVIATED_STATE_NAME", "$ABBREVIATED_STATE_NAME"} | Out-File "$TARGET_FILE" -Encoding utf8

Write-Output "$TARGET_FILE is created."