# pi

Extensions and agents for [pi](https://github.com/earendil-works/pi), laid out to mirror `~/.pi/agent`.

| Path | What it is |
| --- | --- |
| `agent/extensions/subagent/` | Subagent extension. Adds a `subagent` tool that runs agents in separate `pi` processes, each with its own context. Copied from pi's bundled example (`examples/extensions/subagent/` in pi 1.4.0), with a fix for subagents that never return; see [NOTES.md](agent/extensions/subagent/NOTES.md). |
| `agent/agents/coder.md` | General-purpose implementation agent for the subagent tool, on `cursor/sonnet-5@300k` with low thinking. |

## Install

```sh
./pi/install.sh
```

This links each entry into `~/.pi/agent`, backing up any existing non-symlink copy to `~/dotfiles-backup/pi`. Then run `/reload` in a running pi session, or start a new one.

Only the listed entries are linked. `~/.pi/agent` also holds sessions, auth and settings, which don't belong in this repo.

## Adding agents

Add a markdown file to `agent/agents/` and add its path to `links` in `install.sh`. Frontmatter:

```markdown
---
name: coder
description: What the parent agent sees when choosing an agent
model: cursor/sonnet-5@300k:low
---

System prompt.
```

The `:low` suffix on `model` sets the thinking level; agent files have no separate thinking field. Pi rereads agent files on every call, so no reload is needed after editing one.

## Checking which model a subagent used

The tool result only returns the subagent's final text. To confirm a model and thinking level, run what the extension runs:

```sh
pi --mode json -p --no-session --model cursor/sonnet-5@300k:low "Reply with exactly OK" \
  | rg -o '"(model|thinkingLevel)":"[^"]*"' | sort -u
```
