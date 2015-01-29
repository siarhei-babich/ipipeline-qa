$DIR = "d:\Temp\Test\Read"

ForEach ($file in ((Get-ChildItem $DIR -Recurse) | Where-Object { $_.IsReadOnly -eq $True }))
{
	Write-Host $file.FullName "Read-Only =" $file.IsReadOnly "-> will be changed to False..."
	Set-ItemProperty $file.FullName -Name IsReadOnly -Value $false
}
#Remove-Item "$DIR\new"

#$FOLDER = "$DIR\Folder"