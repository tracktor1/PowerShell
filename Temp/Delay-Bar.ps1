$I = 1
$time = 10
While($I -lt $time) {
	$P = $I/$time*100
	Write-Progress -Activity "Delay the next VM startup" -Status "$I% Complete:" -PercentComplete $P;
	start-sleep 1
	$I++
	if ($host.UI.RawUI.KeyAvailable) {
		$key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp,IncludeKeyDown")
			if ($key.KeyDown -eq "True"){
				break    
			}    
	}
}
