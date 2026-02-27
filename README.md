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
- **Email** (optional): SMTP credentials or provider token

Nothing above is provided by this repo; you plug your own credentials into your own Clawdbot config.

## Tutorial / setup guide (recommended)
- Official Clawdbot docs: https://docs.clawd.bot

## Optional API keys (bring your own)
These are optional. Only get the keys you actually plan to use.

- **Brave Search API** (web search): https://api.search.brave.com/
- **Model provider** (pick one):
  - OpenAI: https://platform.openai.com/
  - Anthropic: https://console.anthropic.com/
  - OpenRouter: https://openrouter.ai/
- **Telegram Bot** (notifications): create via @BotFather

## Optional: Golden Koi tutorial (coming soon)
We plan to publish a step-by-step “Windows bootstrap → agent setup” guide later.
(For now, please use the official Clawdbot docs above.)
