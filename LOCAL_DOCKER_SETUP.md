# What-I-Did-Copilot Local Docker Setup (macOS)

This setup runs the personal report locally and keeps data persistent across container rebuilds.

## What persists

- `cache/` keeps day-level analysis cache, so unchanged days are not reprocessed.
- `reports/` keeps generated HTML reports.

## Prerequisites

- Docker Desktop running
- Existing Copilot activity on your machine
- Optional for richer AI analysis: GitHub token (`gh auth token`)

## One-time setup

1. From this folder, copy env template:

```bash
cp .env.example .env
```

2. Optional: open `.env` and paste your token into `GITHUB_TOKEN=`.

3. To use Azure Foundry / Azure OpenAI for AI analysis, set these in `.env`:

```bash
WHATIDID_API_URL=https://<your-resource>.openai.azure.com/openai/deployments/<deployment>/chat/completions
WHATIDID_MODEL=gpt-5.4
WHATIDID_API_KEY=<your-secret-key>
WHATIDID_API_AUTH=api-key
WHATIDID_API_VERSION=2024-10-21
WHATIDID_API_PROVIDER=azure
```

If your endpoint already includes `api-version` in the URL, leave
`WHATIDID_API_VERSION=` empty.

## Run

Default 7-day report:

```bash
docker compose run --rm whatidid
```

30-day report:

```bash
docker compose run --rm whatidid --30D --out-dir /app/reports
```

Specific range:

```bash
docker compose run --rm whatidid --from 2026-07-01 --to 2026-07-31 --out-dir /app/reports
```

Force refresh (re-analyze even if cached):

```bash
docker compose run --rm whatidid --7D --refresh --out-dir /app/reports
```

## Where output is written

- Reports: `reports/report_<label>.html`
- Cache files: `cache/<date>.json`

## Notes

- Container runs Linux, so auto-open behavior is skipped, but HTML files are still written.
- On macOS, VS Code session data is mounted from `~/Library/Application Support/Code/User`
  into the Linux container path `~/.config/Code/User` so harvest can see it.
- If no sessions are found, confirm these host paths exist:
  - `~/.copilot/session-state`
  - `~/Library/Application Support/Code/User`
