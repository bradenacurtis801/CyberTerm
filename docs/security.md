# Security and privacy

What the CyberTerm host agent (`cyberterm-agentd`) can reach, what it
stores, and how the CyberTerm app talks to it.

## How the app reaches it

The agent opens no port to your network.

- **The local gateway** listens on `127.0.0.1` only, on a random port. The
  app reaches it through the SSH connection you already make to this
  computer, by forwarding that port over SSH. So anyone who can reach the
  gateway can already log in to your account over SSH.
- **Every request needs a token.** Even on `127.0.0.1`, each request must
  carry a 256-bit token. Other user accounts on a shared machine can reach
  `127.0.0.1`, but they can't read the token, so they can't use the
  gateway.
- **The hook socket** is how Claude Code's hooks talk to the agent. It's a
  Unix socket that only your user account can open: the socket file has
  permissions `0600` and its folder `0700`.

## What it stores

| Where | What |
|---|---|
| `~/.config/cyberterm/gateway-token` | The gateway token (`0600`). To replace it, delete it and run `cyberterm-agentd setup`; the app picks up the new one the next time it connects. |
| `~/.config/cyberterm/agentd.json` | The current port and token, which the app reads over SSH (`0600`). Removed when the agent stops. |
| `~/.config/cyberterm/usage-claude.json` | Your latest Claude usage numbers, so they survive a restart. |
| `~/.cache/cyberterm/` | The hook socket, and the folder the usage check runs from. |
| `~/.claude/settings.json` | The hooks `setup` adds (and the status line, if you chose it). The previous version is kept as `settings.json.cyberterm.bak`. |

## What it reads

- **Claude Code's transcripts** (`~/.claude/projects/`), when the app asks
  to show your sessions. Images are removed before anything is sent.
- **Your Claude account's display name and plan**, from `~/.claude.json`,
  to label the usage card. It never reads your Claude login or token.
- **Usage**, by running `claude -p /usage`. That's a local command: it
  doesn't send a prompt or use your limits. It's run without saving a
  session and with hooks turned off.

## What it sends, and where

Only to the CyberTerm app, over your SSH connection. There's no CyberTerm
server, analytics or telemetry.

## Approvals

When Claude Code asks for permission, the agent waits up to 60 seconds for
your answer in the app. If none comes, Claude Code asks you in the terminal
as usual. An answer from somewhere else (the terminal, or another approval
app) also works: the first answer counts, and the app's prompt clears.
