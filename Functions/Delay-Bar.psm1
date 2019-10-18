<#
	.NAME
		Delay-Bar
	
	.SYNOPSIS
		Delay-Bar - Display a progress bar counting seconds
	
	.DESCRIPTION 
		This function displays a progress bar counting seconds

	.PARAMETER Seconds
		seconds to count
		
	.PARAMETER Message
		Message to display during count
	
    .EXAMPLE
		Delay-Bar -Seconds 10 -$Message "Delay the next VM startup"
DA-#>

Function Delay-Bar {
	Param (
	[Parameter(Mandatory=$true)] [int]$Seconds,
	[string]$Message
	)
	$I = 0
		While($I -lt $Seconds) {
		$P = $I/$Seconds*100
		Write-Progress -Activity $Message -Status "$P% Complete:" -PercentComplete $P;
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