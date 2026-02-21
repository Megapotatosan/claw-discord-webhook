# OpenClaw Skill: Discord Webhook

This OpenClaw skill provides a standardized way to send rich Discord messages (Embeds) from an Agent, especially useful in **Isolated Sessions (Cron Jobs)** where the Agent lacks a paired Discord identity.

## Features
- **Bypasses Identity Issues**: Sends via Webhook URL, avoiding `pairing required` errors in Isolated Sessions.
- **Rich Embeds**: Supports Titles, Colors, Footers, Timestamps via JSON payload.
- **Simple Usage**: Encapsulates `curl` logic in a helper script.

## Installation

1. Clone this repository into your OpenClaw skills directory:
   ```bash
   git clone https://github.com/Megapotatosan/claw-discord-webhook.git ~/.openclaw/workspace/skills/discord-webhook
   ```

2. Ensure the helper script is executable:
   ```bash
   chmod +x ~/.openclaw/workspace/skills/discord-webhook/send.sh
   ```

## Usage

In your OpenClaw Agent Prompt (e.g., Cron Job `payload.message`), instruct the agent:

> "Use the **discord-webhook skill** to send a report. Generate a summary, save it as JSON with a Blue embed, and send it to [WEBHOOK_URL]."

See `SKILL.md` for detailed JSON structure and examples.

## License
MIT
