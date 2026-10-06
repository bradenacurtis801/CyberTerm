# CyberTerm host agent

The CyberTerm app lets you follow and approve your coding agents from your
phone. This is the small program that runs on your computer to make that
work: `cyberterm-agentd`.

With it running, the app can:

- show you your agents' permission requests and questions, and send back
  your answer;
- tell you when an agent finishes;
- list your agent sessions and show their transcripts;
- show your agents' usage limits.

It runs on **macOS** and **Linux**. Windows support is coming.

## Supported agents

| Agent | Status | Details |
|---|---|---|
| Claude Code | Supported | [docs/agents/claude-code.md](docs/agents/claude-code.md) |
| Codex | Coming | |

More agents will be added; each one gets its own page under
[docs/agents/](docs/agents/).

## Install

### macOS and Linux, with Homebrew

```sh
brew tap bradenacurtis801/cyberterm https://github.com/bradenacurtis801/CyberTerm
brew install cyberterm-agent
cyberterm-agentd setup
```

### macOS and Linux, without Homebrew

```sh
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/bradenacurtis801/CyberTerm/releases/latest/download/cyberterm-agent-installer.sh | sh
cyberterm-agentd setup
```

This installs to `~/.local/bin`. If your shell can't find
`cyberterm-agentd` afterwards, open a new terminal window.

### What `setup` does

1. **Connects your agents to CyberTerm.** For each supported agent, it
   adds a few hooks to that agent's settings. Your own settings are kept,
   and a backup of each file it changes is saved next to it. Each agent's
   page says exactly what changes.
2. **Runs CyberTerm in the background.** It starts now, starts again when
   you log in, and restarts if it stops. On macOS that's a launch agent; on
   Linux, a systemd user service.

Run `setup` again any time, for example after installing another agent; it
only changes what's needed.

**Linux servers you only reach over SSH:** user services stop when you log
out, unless "lingering" is turned on for your account. `setup` tells you if
that's the case. The fix is:

```sh
sudo loginctl enable-linger $USER
```

## Connect your phone

In the CyberTerm app, add this computer as an SSH host and connect. The app
finds the agent on its own; there's nothing to copy or pair.

## Everyday commands

| Command | What it does |
|---|---|
| `cyberterm-agentd status` | Is it installed and running? |
| `cyberterm-agentd setup` | Install, repair, or pick up a new version |
| `cyberterm-agentd uninstall` | Remove the background service and everything it added to your agents' settings |
| `cyberterm-agentd run` | Run in the foreground, for troubleshooting (stop the service first) |
| `cyberterm-agentd --help` | Everything else |

**Logs:** on macOS, `~/Library/Logs/cyberterm/agentd.log`. On Linux, run
`journalctl --user -u cyberterm-agentd`.

## Upgrade

```sh
brew upgrade cyberterm-agent    # or run the install script again
cyberterm-agentd setup          # restarts the background service on the new version
```

## Other apps that approve your agents' requests

If another app on this computer also approves an agent's requests,
`setup` and the CyberTerm app tell you. Both keep working: each one asks
you, the first answer counts, and the other clears itself. CyberTerm never
changes another app's settings.

## Uninstall

```sh
cyberterm-agentd uninstall
brew uninstall cyberterm-agent   # or: rm ~/.local/bin/cyberterm-agentd ~/.local/bin/cyberterm-agent-hook
```

## Security and privacy

In short:

- **It's only reachable through your SSH connection.** It listens on
  `127.0.0.1` only, and every request needs a secret token that's readable
  by your user account alone.
- **Your data stays on your computer.** There's no CyberTerm server in
  between.
- **Your agents' logins are never read.**

[docs/security.md](docs/security.md) has the details.

## Problems and questions

Please [open an issue](https://github.com/bradenacurtis801/CyberTerm/issues).
Include the output of `cyberterm-agentd status` and the last lines of the
log.
