<#
	.NAME
		Delay-Bar
	
	.SYNOPSIS
		Delay-Bar - Display a progress bar counting seconds
	
	.DESCRIPTION 
		This function displays a progress bar counting seconds

	.PARAMETER Seconds
		seconds to count
	
    .EXAMPLE
		Delay-Bar -Seconds 10
DA-#>

Function Delay-Bar {
	Param (
	[Parameter(Mandatory=$true)] [int]$time
	)
	$I = 1
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
}

Delay-Bar 10