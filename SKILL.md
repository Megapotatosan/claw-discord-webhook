# SKILL: discord-webhook

This skill provides a **standardized way to send rich Discord messages (Embeds)** from an OpenClaw Agent, especially useful in **Isolated Sessions (Cron Jobs)** where the Agent lacks a paired Discord identity.

## When to Use

- When running a **Cron Job** with `sessionTarget: "isolated"`.
- When you want to send **Rich Embeds** (Titles, Colors, Footers, Timestamps).
- When the system `delivery: announce` fails due to "Pairing Required".

## Usage Instructions

To use this skill, the Agent must perform the following steps:

1.  **Generate Content**: Prepare the text, summary, or report.
2.  **Construct JSON Payload**: Create a JSON file (e.g., `/tmp/discord_webhook_<id>.json`) with the correct Discord Webhook structure (username, avatar, embeds).
3.  **Execute Helper Script**: Run the provided `send.sh` script to deliver the payload.

### Step 1: JSON Payload Structure

The JSON file MUST follow this structure. All fields are optional but recommended for rich formatting.

```json
{
  "username": "Bot Name ",
  "avatar_url": "https://example.com/avatar.png",
  "embeds": [
    {
      "title": "📝 Title Here",
      "description": "Main content goes here. Supports **Markdown** and [Links](https://example.com).",
      "url": "https://title-link.com",
      "color": 3447003, // Decimal color code (Blue: 3447003, Green: 3066993, Red: 15158332, Gold: 16776960)
      "footer": {
        "text": "OpenClaw • Generated via Isolated Session",
        "icon_url": "https://example.com/footer-icon.png"
      },
      "timestamp": "2023-10-27T10:00:00.000Z" // ISO 8601 string
    }
  ]
}
```

**Common Colors (Decimal):**
- 🔵 **Blue**: `3447003` (Info/News)
- 🟢 **Green**: `3066993` (Success/Healthcheck OK)
- 🔴 **Red**: `15158332` (Error/Alert)
- 🟡 **Gold**: `16776960` (Investment/Money)

### Step 2: Sending the Webhook

Use the `exec` tool to run the helper script.

**Command:**
```bash
~/.openclaw/workspace/skills/discord-webhook/send.sh "<WEBHOOK_URL>" "<JSON_FILE_PATH>"
```

**Example:**
```bash
~/.openclaw/workspace/skills/discord-webhook/send.sh "https://discord.com/api/webhooks/..." "/tmp/discord_report.json"
```

## Example Workflow (Cron Job Prompt)

When writing a Cron Job `payload.message`, you can now simply say:

> "Use the **discord-webhook skill** to send a report. Generate a summary of X, save it as JSON with a Blue embed, and send it to [WEBHOOK_URL]."

The Agent will read this skill, understand the JSON structure, and execute the script.
