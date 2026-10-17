# Grok Build

What CyberTerm does with xAI's Grok Build, and what it changes on your
computer.

## What you get in the app

- Grok's permission prompts and questions, answered from your phone — for
  a Grok session started from the app (or in one of CyberTerm's terminals):
  Grok asks only on its own screen, and CyberTerm reads them from there.
- A notification when Grok finishes.
- Your Grok sessions and their transcripts.
- Its background tasks, with their output, stopped from your phone.
- Starting and resuming Grok sessions on the computer from the app.
- Your Grok usage: your plan and its allowance this period.

## What `setup` changes

`setup` adds one file of its own, `~/.grok/hooks/cyberterm.json`, with
hooks that run `cyberterm-agent-hook grok`. Grok reads every file in that
folder, so nothing of yours is changed.

Grok also runs Claude Code's hooks. If CyberTerm is set up for Claude Code
too, those reach CyberTerm as well; it uses Grok's own and drops the
copies.

To add or remove just these hooks:

```sh
cyberterm-agentd install-hooks grok
cyberterm-agentd uninstall-hooks grok
```

## Usage limits

CyberTerm asks Grok itself for your plan and allowance, at most every five
minutes, while the app is connected. CyberTerm never reads your Grok login.

## What it reads

- **Sessions** in `~/.grok/sessions/`, when the app asks to show them.
