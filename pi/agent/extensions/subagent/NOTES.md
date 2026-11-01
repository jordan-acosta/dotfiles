# Changes from pi's bundled example

`index.ts` differs from pi 1.4.0's `examples/extensions/subagent/index.ts` to fix a hang where a finished subagent never returned to the parent.

## The bug

While running pi through `pi-cursor-sdk`, a `coder` subagent implemented a multi-file change over about 27 minutes. Its edits were complete, but the `subagent` tool call never returned. The parent agent sat waiting until the turn was cancelled by hand. Cancelling made the extension throw `Subagent was aborted` and discard everything the subagent had produced, including its final report. Subagents run with `--no-session`, so the report wasn't on disk either.

It wasn't a timeout: the bridge's default MCP tool timeout is 60 minutes.

## Cause

The extension spawned the subagent with piped stdout and stderr and treated it as finished only on Node's `close` event. `close` fires once the process has exited **and** every stdio stream is closed. Any process the subagent starts inherits those pipes, so a descendant that outlives the subagent (for example a long build or test moved to the background by Cursor's shell, which backgrounds commands after about 30 seconds) keeps the pipe open. `close` never fires and the promise never resolves.

The hang wasn't reproduced end to end through pi. The mechanism was reproduced with a standalone Node script: a child that prints a line, starts `sleep 30 &`, and exits never got `close`, while an `exit`-based check returned after about a second.

## Fix

In `runSingleAgent`:

- **Finish when the process exits.** On `exit`, wait `EXIT_DRAIN_GRACE_MS` (1 s) for remaining stdout, then resolve. `close` still resolves immediately if it fires first.
- **Finish after the run settles.** pi's JSON mode emits `agent_settled` when a run has no automatic work left. After it arrives, the subagent gets `SETTLED_EXIT_GRACE_MS` (5 s) to exit; if it hasn't, it's sent `SIGTERM` and the result already collected is returned with exit code 0.
- **Release the pipes.** A single `finish()` resolves once, clears timers, flushes the buffered line, and destroys the stdout and stderr streams so lingering descendants don't keep handles open in the parent.
- **Keep output on cancel.** Cancelling no longer throws. It returns the result with `stopReason: "aborted"` and `errorMessage: "Subagent was aborted"`, and `getResultOutput` appends the subagent's last output after the error for any failed result. The `SIGKILL` fallback now checks `exitCode`/`signalCode` instead of `proc.killed`, which is true as soon as a signal is sent.

## Updating from upstream

When pi ships a new version of the example, diff it against this copy and reapply the changes above unless upstream has fixed the hang itself.
