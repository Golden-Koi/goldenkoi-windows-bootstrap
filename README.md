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

## Recommended integrations (bring your own keys)
You only need the keys for the platforms you actually use. Common examples:

- **Telegram**: create a bot via @BotFather → get a **bot token**
- **Discord**: create an application + bot → get a **bot token** (and add it to your server)
- **Slack**: create an app → **Bot Token (xoxb-...)** and required scopes
- **Cloudflare** (optional, for Pages / DNS automation): create an **API token** with least privilege
- **Email** (optional): SMTP credentials or provider token

Nothing above is provided by this repo; you plug your own credentials into your own Clawdbot config.

## Tutorial / setup guide (recommended)
If you want a step-by-step guide (and a ready-to-follow checklist), use our docs:

- Golden Koi guide: https://goldenkoi.trade (navigate to the Clawdbot / Hive guide)

(Guide is optional; this repo remains a clean bootstrap.)
