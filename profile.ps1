# PowerShell profile (for a better appearance)
# R: v0.2.0, E: 2024/07/24

# Requires a Nerd/Powerline font

$global:foregroundColor = 'white'

# For the prompt
function Prompt {
	# Prompt Colors
	# Bladk DarkBlue DarkGreen DarkCyan DarkRed DarkMagenta DarkYellow
	# Gray DarkGray Blue Green Cyan Red Magenta Yellow White

	$prompt_text = "White"
	$prompt_background = "DarkGray"
	$prompt_git_background = "Blue"
	$prompt_git_text = "Black"

	# Get the current Git branch
	$git_string = "";
	git branch | foreach {
		if ($_ -match "^\* (.*)") {
			$git_string += $matches[1]
		}
	}

	# Start displaying
	$path = PWD
	Write-Host $path -foregroundColor $prompt_text -backgroundColor $prompt_background -NoNewLine
	Write-Host " " -foregroundColor $prompt_text -backgroundColor $prompt_background -NoNewLine
	if ($git_string) {
		Write-Host "$([char]57520)" -foregroundColor $prompt_background -NoNewLine -backgroundColor $prompt_git_background
		Write-Host " $([char]57504) " -foregroundColor $prompt_git_text -backgroundColor $prompt_git_background -NoNewLine
		Write-Host ($git_string) -NoNewLine -foregroundColor $prompt_git_text -backgroundColor $prompt_git_background
		Write-Host " " -NoNewLine -foregroundColor $prompt_git_text -backgroundColor $prompt_git_background
		Write-Host "$([char]57520)" -NoNewLine -foregroundColor $prompt_git_background
	}
	else {
		Write-Host "$([char]57520)" -NoNewLine -foregroundColor $prompt_background
	}

	Return " "
}
