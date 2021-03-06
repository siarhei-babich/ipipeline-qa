$dir = "d:\Temp\Test\"
$html_file = "$dir\folders_count.html"

if(Test-Path $dir)
{
       $folders = Get-ChildItem $dir -Recurse | where {$_.PSIsContainer}
       $output = @()

    foreach($folder in $folders)
    {
       $fname = $folder.Name
       $fpath = $folder.FullName
       $fcount = Get-ChildItem $fpath | where {!$_.PSIsContainer} | Measure-Object | Select-Object -Expand Count
       $obj = New-Object psobject -Property @{ "Folder Name" = $fname; "Folder Path" = $fpath; "File Count" = $fcount}
       $output += $obj
    }
       #Output to HTML
       $output | ConvertTo-Html -Fragment | Out-File $html_file
}