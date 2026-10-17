# Codex

What CyberTerm does with OpenAI's Codex — the CLI, and the copy inside the
ChatGPT desktop app — and what it changes on your computer.

## What you get in the app

- Codex's permission requests, answered from your phone.
- A notification when Codex finishes.
- Your Codex sessions and their transcripts.
- Its background tasks: commands it left running past their turn, with
  their output, stopped from your phone.
- Starting and resuming Codex sessions on the computer from the app, with
  the model and effort level you pick. A model, effort or mode chosen while
  a session runs is used from its next start (Codex sets them when it
  starts).
- Your Codex rate limits.

## What `setup` changes

`setup` adds hooks to `~/.codex/hooks.json` (or `$CODEX_HOME/hooks.json`
if you set that). Each one runs `cyberterm-agent-hook codex`. Your own
settings and hooks are kept, and the previous file is saved as
`hooks.json.cyberterm.bak`.

Codex only runs a hook you've trusted, so `setup` also marks these hooks —
and only these — as trusted in Codex's `config.toml`, the way Codex's own
"trust" does. It asks Codex itself for the hooks' hashes
(`codex app-server`), so nothing breaks if Codex changes how it hashes.

To add or remove just these hooks:

```sh
cyberterm-agentd install-hooks codex
cyberterm-agentd uninstall-hooks codex
```

## Usage limits

CyberTerm asks Codex for your account's rate limits (`codex app-server`),
at most once a minute, while the app is connected. CyberTerm never reads
your Codex login; Codex fetches the numbers itself.

## What it reads

- **Sessions** in `~/.codex/sessions/`, when the app asks to show them.

## What it stores

- `~/.config/cyberterm/codex-hooks-trust.json`: the hooks it last
  trusted, so it only asks Codex again when they change.

## Other approval apps

If another app also approves Codex's requests, both keep working: each one
asks you, the first answer counts, and the other clears itself. CyberTerm
doesn't change the other app's hooks.
