function a_function {
	Write-Output '---------------Alias----------------'; 
	Get-Command -CommandType Alias 
}
Set-Alias a a_function


function c_function {
	cls
}
Set-Alias c c_function


function d_function {
    if ($args.Count -eq 2) {
        if (Test-Path ".git") {
            git diff --color-words $args[0] $args[1]
        } else {
            git diff --color-words --no-index $args[0] $args[1]
        }
    } elseif ($args.Count -eq 1) {
        if (Test-Path ".git") {
            git diff --color-words $args[0]
        } else {
            Write-Host "ERROR: If this is not a git directory you need at least two arguments to see any differences."
        }
    } elseif ($args.Count -eq 0) {
        if (Test-Path ".git") {
            git diff --color-words
        } else {
            Write-Host "ERROR: If this is not a git directory you need at least two arguments to see any differences."
        }
    } else {
        if (Test-Path ".git") {
            ForEach ($arg in $args) {
                git diff --color-words $arg
            }
        } else {
            Write-Host "ERROR: If this is not a git directory you need at least two arguments to see any differences."
        }
    }
}
Set-Alias d d_function


function f_function {
  [CmdletBinding()]
  param(
    [Parameter(Position=0, ValueFromRemainingArguments=$true)]
    [string[]]$args
  )

  if ($args.Count -eq 0) {  # No arguments given
    Get-ChildItem . -Recurse -ErrorAction SilentlyContinue
  }
  elseif ($args.Count -eq 1) {
    if (Test-Path $args[0] -PathType Leaf) {  # Searches therm in a file
      Get-Content $args[0]
    }
    elseif (Test-Path $args[0] -PathType Container) {  # Searches files in directory
      Get-ChildItem $args[0] -Recurse -ErrorAction SilentlyContinue
    }
    else {  # Searches therm in all files
      Get-ChildItem . -Recurse -ErrorAction SilentlyContinue |
        ForEach-Object { Get-Content $_.FullName } |
        Select-String $args[0]
    }
  }
  elseif ($args.Count -gt 1) {
    $temp = $args[0]
    $i = 1
    while ($i -lt $args.Count) {
      if (Test-Path $temp -PathType Leaf) {  # Searches therm in a file
        Get-Content $temp | Select-String $args[$i]
      }
      elseif (Test-Path $temp -PathType Container) {  # Searches file in directory
        $files = Get-ChildItem $temp -Recurse -ErrorAction SilentlyContinue |
          Where-Object { $_.Name -like $args[$i] }
        if ($files.Count -gt 0) {  # Show files matching argument
          Get-Content $files.FullName
        }
        else {  # Show list of other matching files in elements of directory
          Get-ChildItem $temp -Recurse -ErrorAction SilentlyContinue |
            ForEach-Object { Get-Content $_.FullName } |
            Select-String $args[$i]
        }
      }
      else {  # Literal search in therm
        $temp | Select-String $args[$i]
      }
      $i += 1
    }
  }
}
Set-Alias f f_function


function i_function {
  if ($args.Count -eq 0) {
    Get-ChildItem -Directory -Path $PWD -Recurse | Select-Object FullName
  } else {
    ForEach ($arg in $args) {
      if (Test-Path $arg -PathType Container) {
        Get-ChildItem -Directory -Path $arg -Recurse | Select-Object FullName
      } else {
        Write-Host "ERROR: A valid path to a folder is expected, skipping argument $arg"
      }
    }
  }
}
Set-Alias i i_function


function j_function { 
	Get-Job | Format-List -Property ID, Name, State, HasMoreData, Location, Command, InstanceID 
}
Set-Alias j j_function


function k_function {
  param(
    [int]$port = 0
  )
  if ($port -eq 0) {
    # Ask for port number to kill
    Write-Host "Kill port number:"
    $portkillnumber = Read-Host
    $pids = (Get-NetTCPConnection -LocalPort $portkillnumber -ErrorAction SilentlyContinue).OwningProcess
  } else {
    $pids = (Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue).OwningProcess
  }
  if (-not $pids) {
    Write-Host "No process found listening on port $($port -or $portkillnumber)"
    return
  }
  foreach ($pid in $pids) {
    try {
      $process = Get-Process -Id $pid -ErrorAction Stop
      $process.Kill()
      Write-Host "Process with ID $($process.Id) killed"
    } catch {
      Write-Host "Failed to kill process with ID $pid"
    }
  }
}
Set-Alias k k_function


function l_function {
    ls -Force -Hidden | Format-Table -AutoSize
}
Set-Alias l l_function


function u {
    if ($args.Count -eq 0) {
        Write-Output "ERROR: You need to provide at least one argument"
        return
    }
    else {
        foreach ($url_address in $args) {
            if ($url_address -match '^[a-z]+://') {
                Start-Process $url_address
            }
            else {
                Start-Process "https://$url_address"
            }
        }
    }
}


function o_function {
    if ($args.Count -eq 0) {
        Invoke-Item (Get-Location)
    }
    else {
        Invoke-Item $args[0]
    }
}
Set-Alias o o_function


function ipe {
    $IP = Invoke-RestMethod -Uri 'https://api.ipify.org?format=text'
    Write-Output "Your public IP Address is: $IP"
}


function ipi {
    $ip = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Wi-Fi).IPAddress
    Write-Host "Your private IP Address is: $ip"
}


function ips {
    # Get the IPv4 address for the default network adapter
    $ipv4 = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -eq (Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.Virtual -eq $false }).InterfaceAlias }).IPAddress

    # Get the IPv4 address for the loopback adapter (localhost)
    $ipv4loopback = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv4' -and $_.InterfaceAlias -eq 'Loopback Pseudo-Interface 1' }).IPAddress

    # Get the IPv6 address for the default network adapter
    $ipv6 = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv6' -and $_.InterfaceAlias -eq (Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.Virtual -eq $false }).InterfaceAlias }).IPAddress

    # Get the link-local IPv6 address for the default network adapter
    $ipv6linklocal = (Get-NetIPAddress | Where-Object { $_.AddressFamily -eq 'IPv6' -and $_.InterfaceAlias -eq (Get-NetAdapter | Where-Object { $_.Status -eq 'Up' -and $_.Virtual -eq $false }).InterfaceAlias -and $_.PrefixOrigin -eq 'WellKnown' }).IPAddress

    # Print the IPv4 address for the default network adapter
    Write-Host "Private IPv4 Address: $ipv4"

    # Print the IPv4 address for the loopback adapter
    Write-Host "Loopback IPv4 Address: $ipv4loopback"

    # Print the IPv6 address for the default network adapter
    Write-Host "Private IPv6 Address: $ipv6"

    # Print the link-local IPv6 address for the default network adapter
    Write-Host "Link-local IPv6 Address: $ipv6linklocal"
}


function touch_function {
	New-Item "$args"
}
Set-Alias touch touch_function


function find_function {
	Get-ChildItem -Filter "$args" -Recurse -File
}
Set-Alias find find_function


function ping_function {
	Test-Connection "$args" | Format-Table -AutoSize
}
Set-Alias ping ping_function


function webserver_function {
	start http://localhost:4000/
	bundle exec jekyll serve
}
Set-Alias webserver webserver_function


function git_pull_function {
	git pull "$args"
}
Set-Alias pull git_pull_function


function git_push_function {
	git push "$args"
}
Set-Alias push git_push_function


function git_commit_function {
	git commit -am "$args"
}
Set-Alias commit git_commit_function


function git_checkout_function {
	git checkout "$args"
}
Set-Alias checkout git_checkout_function


function git_clone_function {
	git clone "$args"
}
Set-Alias clone git_clone_function


function git_branch_function {
	git branch "$args"
}
Set-Alias branch git_branch_function


function git_status_function {
	git status
}
Set-Alias status git_status_function


function git_add_function {
	
	for ( $i = 0; $i -lt $args.count; $i++ ) {
	git add $args} 
}
Set-Alias add git_add_function


function git_hard_function {
	git reset --hard
}
Set-Alias hard git_hard_function


function git_fetch_function {
	git fetch
}
Set-Alias fetch git_fetch_function


function git_config_function {
	git config user.name "$args[0]"
	git config user.email "$args[1]"
}
Set-Alias config git_config_function


function git_unstage_function {
	
	for ( $i = 0; $i -lt $args.count; $i++ ) {
	git rm --cached $args} 
}
Set-Alias unstage git_unstage_function


function steamshare {
    $firewallRule = Get-NetFirewallRule -DisplayName "Steamshare"

    if ($firewallRule) {
        if ($firewallRule.Enabled -eq "False") {
            Write-Host "SteamShare firewall rule is disabled. Enabling..."
			Enable-NetFirewallRule -DisplayName "Steamshare"
        } else {
			Write-Host "SteamShare firewall rule is enabled. Disabling..."
			Disable-NetFirewallRule -DisplayName "Steamshare"
        }
    } else {
        Write-Host "SteamShare firewall rule not found. Enabling..."
        New-NetFirewallRule -DisplayName "Steamshare" -Direction Outbound -Program "C:\Program Files (x86)\Steam\steam.exe" -Action Allow
    }
}


function speed {
    # The test file has to be a 10MB file for the math to work. If you want to change sizes, modify the math to match
    $TestFile = 'https://ftp.sunet.se/mirror/parrotsec.org/parrot/misc/10MB.bin'
    $TempFile = Join-Path -Path $env:TEMP -ChildPath 'testfile.tmp'
    $WebClient = New-Object Net.WebClient
    $TimeTaken = Measure-Command { $WebClient.DownloadFile($TestFile,$TempFile) } | Select-Object -ExpandProperty TotalSeconds
    $SpeedMbps = (10 / $TimeTaken) * 8
    $Message = "{0:N2} Mbit/sec" -f ($SpeedMbps)
    $Message
}

# Install yt_dlp if not already installed
# pip install yt-dlp

function download_video {
    param (
        [string]$url,
        [string]$outputDirectory = "."
    )

    yt-dlp $url -f mp4 -o "$outputDirectory/%(title)s.%(ext)s"
}

function download_audio {
    param (
        [string]$url,
        [string]$outputDirectory = "."
    )

    yt-dlp -x --audio-format wav $url -o "$outputDirectory/%(title)s.%(ext)s"
}

function download_video_playlist {
    param (
        [string]$url,
        [string]$outputDirectory = "."
    )

    yt-dlp --yes-playlist --format mp4 $url -o "$outputDirectory/%(playlist_title)s/%(title)s.%(ext)s"
}

function download_audio_playlist {
    param (
        [string]$url,
        [string]$outputDirectory = "."
    )

    yt-dlp -x --audio-format wav --yes-playlist $url -o "$outputDirectory/%(playlist_title)s/%(title)s.%(ext)s"
}

function wav_to_mp3 {
    param (
        [string]$inputPath,
        [string]$outputPath = $null
    )

    # Check if input file exists
    if (-not (Test-Path $inputPath -PathType Leaf)) {
        Write-Host "Error: Input WAV file not found."
        return
    }

    # Determine output path
    if (-not $outputPath) {
        $outputPath = [System.IO.Path]::ChangeExtension($inputPath, "mp3")
    } elseif (Test-Path $outputPath -PathType Container) {
        # If $outputPath is a directory path, use input filename with mp3 extension
        $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($inputPath) + ".mp3"
        $outputPath = [System.IO.Path]::Combine($outputPath, $outputFileName)
    }

    # Convert WAV to MP3 using FFmpeg
    & ffmpeg -i "$inputPath" "$outputPath"

    Write-Host "Conversion completed: $inputPath -> $outputPath"
}


function batch_wav_to_mp3 {
    param (
        [string]$inputPath = $null,
        [string]$outputPath = $null
    )

    if (-not $inputPath) {
        $inputPath = Get-Location
    }

    # If output path is not provided, perform in-place conversion
    if (-not $outputPath) {
        $outputPath = $inputPath
        $inputPath = Get-Location
    }

    # Convert WAV files to MP3
    $wavFiles = Get-ChildItem -Path $inputPath -Filter "*.wav" -File
    foreach ($wavFile in $wavFiles) {
        $mp3FileName = [System.IO.Path]::ChangeExtension($wavFile.Name, "mp3")
        $mp3FilePath = Join-Path -Path $outputPath -ChildPath $mp3FileName
        & ffmpeg -i $wavFile.FullName $mp3FilePath
        Write-Host "Conversion completed: $($wavFile.FullName) -> $mp3FilePath"
    }
}

