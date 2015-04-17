#----- PROPERTIES SECTION START -----#

$work_dir = "E:\epam\ps\midland\auto\cebatchtool\test\15"
$old_array = @(">15<", ">15-YEAR<", ">T10<", ">10 PAY LEVEL PREMIUM TERM INSURANCE WITH A RENEWAL PROVISION TO AGE 95<", ">LEVEL TERM 10<")
Write-Host "Old array length =" $old_array.length
$new_array = @(">10<", ">10-YEAR<", ">T15<", ">15 PAY LEVEL PREMIUM TERM INSURANCE WITH A RENEWAL PROVISION TO AGE 95<", ">LEVEL TERM 15<")
Write-Host "New array length =" $new_array.length

#----- PROPERTIES SECTION END -----#

#----- EXECUTION SECTION START -----#

for ($i=0; $i -lt $old_array.length; $i++) {
Write-Host $old_array[$i] "- >" $new_array[$i] "cycle..."

	$items = Get-ChildItem –Path $work_dir -recurse
	foreach ($item in $items)
	{
		if ($item.Attributes -ne "Directory")
		{
		$file = Get-Content $item.FullName
		$containsWord = $file | % { $_ -match $old_array[$i] }
		if ($containsWord -contains $true) { Write-Host $item.FullName "has corrections:" $old_array[$i] "- >" $new_array[$i] }
		(Get-Content $item.FullName ) | 
		Foreach-Object {
			$_ -replace $old_array[$i], $new_array[$i]
			} | Set-Content $item.FullName
	}
	}

}

#----- EXECUTION SECTION END -----#