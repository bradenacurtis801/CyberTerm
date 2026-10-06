# Claude Code

What CyberTerm does with Claude Code, and what it changes on your computer.

## What you get in the app

- Claude Code's permission requests ("Claude wants to run …") and its
  multiple-choice questions, answered from your phone.
- A notification when Claude finishes.
- Your Claude Code sessions and their transcripts (images are left out).
- Your Claude usage: the 5-hour and 7-day limits.

## What `setup` changes

`setup` adds hooks to `~/.claude/settings.json` (or
`$CLAUDE_CONFIG_DIR/settings.json` if you set that). Each one runs
`cyberterm-agent-hook claude`. Your own settings and hooks are kept, and
the previous file is saved as `settings.json.cyberterm.bak`.

To add or remove just these hooks:

```sh
cyberterm-agentd install-hooks claude
cyberterm-agentd uninstall-hooks claude
```

## Usage limits

CyberTerm reads your usage by running Claude Code's own `/usage` command,
at most once a minute and only when the app asks. That doesn't use any of
your limits, doesn't save a session, and runs with hooks turned off.
CyberTerm never reads your Claude login; Claude Code fetches the numbers
itself.

For exact, live numbers while you work, you can also make CyberTerm
Claude Code's status line:

```sh
cyberterm-agentd install-statusline
```

If you already have a status line, it keeps working and looks the same.
One side effect: with any custom status line, Claude Code hides most of
its keyboard hints at the bottom of the screen. To undo it, run
`cyberterm-agentd uninstall-statusline`.

## What it reads

- **Transcripts** in `~/.claude/projects/`, when the app asks to show your
  sessions.
- **Your account's display name and plan** from `~/.claude.json`, to label
  the usage card.

## What it stores

- `~/.config/cyberterm/usage-claude.json`: your latest usage numbers.
- `~/.cache/cyberterm/claude-usage/`: the folder `/usage` runs from.
  Claude Code keeps an empty project folder for it under
  `~/.claude/projects/`.

## Other approval apps

If another app also approves Claude Code's requests (for example Moshi),
both keep working: each one asks you, the first answer counts, and the
other clears itself. CyberTerm doesn't change the other app's hooks.
