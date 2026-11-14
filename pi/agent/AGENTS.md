# PR descriptions

Write every PR description in this layout, as concisely as possible. Leave out anything that doesn't change what a reviewer does.

```markdown
## Problem

One or two sentences on what's wrong or missing, from the user's side.

## Solution

- **Area:** one bullet per change, with a bold lead-in naming the area (`ctl-api`, `CLI`, `Create install modal`).
  - Nest bullets only for variants, such as flag on and flag off.

One line on merge or deploy order, if it matters.

### Example

Optional. A small table when behavior differs by case.

## Tests

**Area**

| Test | Verifies |
| --- | --- |
| `TestFullName` | One sentence: the scenario and the expected result. |
```

- Give every added or updated test its own row, with its full name. No file paths, `…` shortening, or counts.
- Use one table per area, with a bold heading above it. Don't put "(unit)" or "(integration)" in headings.
- Keep the description in sync with the code when the PR changes.
