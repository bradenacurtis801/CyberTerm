# CyberTerm host agent

The CyberTerm app lets you follow and approve your coding agents (Claude
Code today) from your phone. This is the small program that runs on your
computer to make that work: `cyberterm-agentd`.

With it running, the app can:

- show you Claude Code's permission requests and questions, and send back
  your answer;
- tell you when Claude finishes;
- list your Claude Code sessions and show their transcripts;
- show your Claude usage (the 5-hour and 7-day limits).

It runs on **macOS** and **Linux**. Windows support is coming.

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

1. **Connects Claude Code to CyberTerm.** It adds a few hooks to
   `~/.claude/settings.json`. Your own settings and hooks are kept, and the
   previous file is saved as `settings.json.cyberterm.bak`.
2. **Runs CyberTerm in the background.** It starts now, starts again when
   you log in, and restarts if it stops. On macOS that's a launch agent; on
   Linux, a systemd user service.

Run `setup` again any time; it only changes what's needed.

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
| `cyberterm-agentd uninstall` | Remove the background service and everything it added to Claude Code's settings |
| `cyberterm-agentd run` | Run in the foreground, for troubleshooting (stop the service first) |
| `cyberterm-agentd --help` | Everything else |

**Logs:** on macOS, `~/Library/Logs/cyberterm/agentd.log`. On Linux, run
`journalctl --user -u cyberterm-agentd`.

## Upgrade

```sh
brew upgrade cyberterm-agent    # or run the install script again
cyberterm-agentd setup          # restarts the background service on the new version
```

## Usage limits

CyberTerm reads your Claude usage by running Claude Code's own `/usage`
command, at most once a minute and only when the app asks. That doesn't
use any of your limits.

For exact, live numbers while you work, you can also make CyberTerm
Claude Code's status line:

```sh
cyberterm-agentd install-statusline
```

If you already have a status line, it keeps working and looks the same.
One side effect: with any custom status line, Claude Code hides most of
its keyboard hints at the bottom of the screen. To undo it, run
`cyberterm-agentd uninstall-statusline`.

## Other apps that approve Claude Code's requests

If another app on this computer also approves Claude Code's requests (for
example Moshi), `setup` and the CyberTerm app tell you. Both keep working:
each one asks you, the first answer counts, and the other clears itself.
CyberTerm never changes another app's settings.

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
- **Your Claude login is never read.** Usage comes from Claude Code itself.

[docs/security.md](docs/security.md) has the details.

## Problems and questions

Please [open an issue](https://github.com/bradenacurtis801/CyberTerm/issues).
Include the output of `cyberterm-agentd status` and the last lines of the
log.
