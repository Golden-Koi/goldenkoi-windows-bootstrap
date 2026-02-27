# Clawdbot Windows Bootstrap

One-command bootstrap to install **Clawdbot** on Windows (WSL2-first, production-friendly).

## Goals
- Fast: minimal manual steps (only one UAC prompt if needed)
- Safe: no app-specific credentials, API keys, or secrets in this repo
- Reproducible: explicit install steps
- Self-healing: Task Scheduler auto-start + restart strategy

## Quick start (PowerShell)
Run in **Windows PowerShell**:

```powershell
Set-ExecutionPolicy -Scope Process Bypass -Force
irm https://raw.githubusercontent.com/Golden-Koi/goldenkoi-windows-bootstrap/main/install_clawdbot_windows.ps1 | iex
```

## What it installs
- Git for Windows (if missing)
- Node.js LTS (if missing)
- WSL2 + Ubuntu (if missing)
- Clawdbot (npm global)

## Configuration
This repo does **not** ship any tokens/credentials.

After install, configure Clawdbot using Clawdbot’s own documentation and your own environment.
