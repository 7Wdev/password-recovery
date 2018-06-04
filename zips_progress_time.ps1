clear
Write-Host `n`n`n`n`n`n`n

$passwords = Get-Content "passwords.txt"
$count = $passwords.Length
$7ZipPath = "C:\Program Files\7-Zip\7z.exe"

Get-ChildItem "." -Filter *.zip |
Foreach-Object {
	$i = 0
	$sw = [Diagnostics.Stopwatch]::StartNew()
	Write-Host Processing file: $_
	foreach ($password in $passwords)
	{
		& $7ZipPath "t" $_ "-p$password" > $null 2> $null
		if ($?)
		{
			Write-Host "Valid password: "$password
			[console]::beep(500,300)
			Write-Host time = $sw.Elapsed.ToString()
			pause
			exit
		}
		$i++
		Write-Progress -Activity "Testing passwords" -status "$i/$count done" -percentComplete ($i/$count*100)
	}
	$sw.Stop()
	Write-Host time = $sw.Elapsed.ToString()
}
pause