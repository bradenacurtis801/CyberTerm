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

It runs on **macOS** and **Linux**. Windows support is planned (see the
[roadmap](#roadmap)).

CyberTerm is in early testing (alpha). Expect rough edges, and please
[report them](#problems-and-questions).

## How it works

- Your phone talks to this program **over your own SSH connection** to the
  computer: on your home or office network, or over a VPN you already use.
  There's no CyberTerm server or account in between.
- **The app has to be connected to see anything.** While it is, requests,
  questions and replies show up live. When the app is closed or can't
  reach the computer, nothing reaches your phone yet: there are no
  notifications while you're away. Anything still waiting is there when
  you reconnect.
- **Your agents keep running on your computer** whether or not your phone
  is connected. Answering a request from the phone is the same as
  answering it at the keyboard; the first answer counts.

## Supported agents

| Agent | Status | Details |
|---|---|---|
| Claude Code | Supported | [docs/agents/claude-code.md](docs/agents/claude-code.md) |
| Codex | Next | Its hooks work the way CyberTerm needs |
| Gemini CLI | Planned | |
| OpenCode | Planned | |
| Amp | Planned | |

Other agents (Cursor, GitHub Copilot, Kimi Code, Qwen Code and more) are
being looked at. An agent can be supported once it lets another program
see and answer its requests; we only list it here once that works and is
tested. Each supported agent gets its own page under
[docs/agents/](docs/agents/).

## Install

### macOS and Linux, with Homebrew

```sh
brew tap bradenacurtis801/cyberterm https://github.com/bradenacurtis801/CyberTerm
brew trust --formula bradenacurtis801/cyberterm/cyberterm-agent
brew install cyberterm-agent
cyberterm-agentd setup
```

Homebrew asks you to trust formulas from outside its own repositories.
The `brew trust` line does that for this one formula only.

### macOS and Linux, without Homebrew

```sh
tag=$(curl -fsSL "https://api.github.com/repos/bradenacurtis801/CyberTerm/releases?per_page=1" | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p' | head -n 1)
curl --proto '=https' --tlsv1.2 -LsSf "https://github.com/bradenacurtis801/CyberTerm/releases/download/$tag/cyberterm-agent-installer.sh" | sh
cyberterm-agentd setup
```

The first line finds the newest release. While CyberTerm is in testing,
every release is a pre-release, and GitHub's usual "latest release" link
skips those.

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

## Roadmap

What's coming, roughly in order. Plans can change; this list is kept up
to date as they do.

1. **Codex.** The same as Claude Code today: its requests, questions,
   sessions and transcripts in the app.
2. **Gemini CLI, then OpenCode and Amp.** Each one once it's working and
   tested; see [Supported agents](#supported-agents).
3. **Windows.** This program running on Windows computers, not just macOS
   and Linux.
4. **Notifications when you're away.** Today the app only hears from your
   computer while it's connected (see [How it works](#how-it-works)). This
   adds phone notifications when an agent needs you or finishes, even with
   the app closed or away from your network. Delivering them takes a small
   relay service, since phones only get notifications through Apple's and
   Google's servers. It will be **opt-in**, it will carry only what the
   notification says (never your code or transcripts), and everything else
   keeps working without it.

## Problems and questions

Please [open an issue](https://github.com/bradenacurtis801/CyberTerm/issues).
Include the output of `cyberterm-agentd status` and the last lines of the
log.
