$SOURCE_DIR = "d:\Temp\Test\FGLTWO-26"
$SOURCE_FILE = "$SOURCE_DIR\FGLTWO-26, GENERIC.xml"

$TARGET_DIR = "d:\Temp\Test\FGLTWO-26"
$TARGET_FILE = "$TARGET_DIR\FGLTWO-26, All.xml"

$XPATH = "/CossDataExtract/Entities/Entity[@Type='Client']"

[xml] $SOURCE_XML_CONTENT = Get-Content -Path "$SOURCE_FILE"
[xml] $TARGET_XML_CONTENT = Get-Content -Path "$TARGET_FILE"

$CLIENT_ENTITY = $SOURCE_XML_CONTENT.SelectSingleNode("$XPATH")
$CLONED_NODE = $CLIENT_ENTITY.Clone()

$NEW_NODE = $TARGET_XML_CONTENT.ImportNode($CLONED_NODE, $true)
$TARGET_XML_CONTENT.CossDataExtract.Entities.AppendChild($NEW_NODE)

$TARGET_XML_CONTENT.Save("$TARGET_FILE")