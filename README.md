# Golden Koi Windows Bootstrap (Clawdbot)

One-command bootstrap to install **Clawdbot** on Windows (WSL2-first, production-friendly).

## Goals
- Fast: minimal manual steps (only one UAC prompt if needed)
- Safe: no secrets in repo; secrets are loaded from `D:\\secrets\\*.env`
- Reproducible: pinned versions & explicit install steps
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

## Secrets
Put secrets in `D:\\secrets\\` (not tracked by git). Example:

- `D:\\secrets\\clawdbot_telegram.env`
- `D:\\secrets\\telegram_news_bot.env`

## Notes
This is a bootstrap repo for Golden Koi ops. You can fork it.
