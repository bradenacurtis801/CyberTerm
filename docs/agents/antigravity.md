# Antigravity

What CyberTerm does with Google's Antigravity CLI (`agy`), and what it
changes on your computer. Antigravity replaces Gemini CLI, which CyberTerm
no longer lists.

## What you get in the app

- Antigravity's permission prompts, answered from your phone — for a
  session started from the app (or in one of CyberTerm's terminals):
  CyberTerm reads them from its screen.
- A notification when Antigravity finishes.
- Your Antigravity conversations and their transcripts.
- Its background tasks, with their output, stopped from your phone.
- Starting and resuming Antigravity sessions on the computer from the app,
  and switching its mode (default, accept edits, plan) while it runs.

## What `setup` changes

`setup` adds one entry, `"cyberterm"`, to Antigravity's hooks file,
`~/.gemini/config/hooks.json`. Each hook runs `cyberterm-agent-hook`.
Anything else in the file is kept, and the previous file is saved as
`hooks.json.cyberterm.bak`.

To add or remove just these hooks:

```sh
cyberterm-agentd install-hooks antigravity
cyberterm-agentd uninstall-hooks antigravity
```

## What it reads

- **Conversations**: Antigravity's index,
  `~/.gemini/antigravity-cli/conversation_summaries.db`, and each
  conversation's transcript under `~/.gemini/antigravity-cli/brain/`, when
  the app asks to show them.
