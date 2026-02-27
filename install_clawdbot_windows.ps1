<#
Clawdbot Windows Bootstrap (WSL2-first)

Goals:
- Minimal interaction: single UAC prompt if needed
- No app-specific credentials, API keys, or secrets in this repo
- Prefer WSL2 Ubuntu for running clawdbot gateway (Linux parity)

This script is intentionally conservative (safe defaults).

TODO (next iteration):
- Auto-install Node.js LTS + Git (with SHA256 verification)
- Add healthcheck + auto-restart loop
- Add optional browser install + extensions
#>

$ErrorActionPreference = 'Stop'

function Write-Section($t) { Write-Host "`n=== $t ===" -ForegroundColor Cyan }

function Assert-Admin {
  $id = [Security.Principal.WindowsIdentity]::GetCurrent()
  $p = New-Object Security.Principal.WindowsPrincipal($id)
  if (-not $p.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Section "Re-launch as Administrator"
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit 0
  }
}

function Ensure-WSL2 {
  Write-Section "WSL2"
  if (-not (Get-Command wsl.exe -ErrorAction SilentlyContinue)) {
    throw "wsl.exe not found (Windows too old?)"
  }

  dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart | Out-Null
  dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart | Out-Null

  try { wsl.exe --set-default-version 2 | Out-Null } catch {}

  $distros = (wsl.exe -l -q 2>$null) -join "`n"
  if ($distros -notmatch "Ubuntu") {
    Write-Host "Ubuntu not found. Installing Ubuntu (may require Microsoft Store)…" -ForegroundColor Yellow
    try { wsl.exe --install -d Ubuntu | Out-Null } catch {
      Write-Host "WSL install command failed. Install Ubuntu manually from Microsoft Store, then rerun." -ForegroundColor Yellow
    }
  }
}

function Ensure-Node {
  Write-Section "Node.js"
  if (Get-Command node.exe -ErrorAction SilentlyContinue) { return }
  Write-Host "Node.js not found. Install Node.js LTS, then rerun." -ForegroundColor Yellow
  Write-Host "Download: https://nodejs.org/en/download" -ForegroundColor Yellow
  throw "Node.js missing"
}

function Ensure-Git {
  Write-Section "Git"
  if (Get-Command git.exe -ErrorAction SilentlyContinue) { return }
  Write-Host "Git not found. Install Git for Windows, then rerun." -ForegroundColor Yellow
  Write-Host "Download: https://git-scm.com/download/win" -ForegroundColor Yellow
  throw "Git missing"
}

function Install-Clawdbot {
  Write-Section "Install clawdbot"
  npm i -g clawdbot
  clawdbot --version
}

function Create-Task {
  Write-Section "Task Scheduler"
  $taskName = "Clawdbot-Gateway"

  # Start gateway inside Ubuntu (WSL). User can override config location in WSL as needed.
  $wslCmd = "wsl.exe -d Ubuntu -- bash -lc 'clawdbot gateway start'"

  $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command `$ErrorActionPreference='SilentlyContinue'; $wslCmd"
  $trigger = New-ScheduledTaskTrigger -AtLogOn
  $principal = New-ScheduledTaskPrincipal -UserId "$env:USERNAME" -RunLevel Highest
  $settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

  try { Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue } catch {}
  Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings | Out-Null

  Write-Host "Scheduled task created: $taskName" -ForegroundColor Green
}

Assert-Admin
Ensure-WSL2
Ensure-Git
Ensure-Node
Install-Clawdbot
Create-Task

Write-Section "Done"
Write-Host "Next: configure Clawdbot (tokens/credentials are NOT included in this repo), then run: clawdbot gateway restart" -ForegroundColor Green
