# Troubleshooting the chat → GitHub → OpenSCAD viewer loop

## GitHub has a revision, but OpenSCAD shows the old model

1. Ask assistant for the **exact remote commit SHA** and changed `.scad` path.
2. In the local clone: `git status`, `git branch --show-current`, `git log -1 --oneline`.
3. If clean and on the correct branch, `git pull --ff-only origin main` (adapt the branch name if different).
4. Check OpenSCAD opened **the local clone's source file**, not a stale file in Downloads.
5. Turn on **Design → Automatic Reload and Preview**. Press **F5** if needed; F6 fully renders.

## Assistant can read GitHub but cannot commit

Do not assume this is a failure of Git or OpenSCAD. Inspect the **actual tools exposed in the current chat session**. Some native GitHub account integrations supply repository context only. Confirm repository scope and the authenticated account, and use an approved connection exposing **create/update file and commit** actions where available. ChatGPT and Claude each have multiple GitHub connection/workflow options; assess capabilities, not brand names.

Use a **small authorized test commit** to verify write access. Don't share tokens in chat. If a session genuinely lacks write actions, say so and give the complete source and local commit instructions as an explicit fallback.

## Git pull refuses

Stop and inspect `git status`, local commits and branch names. Preserve uncommitted local work. A `--ff-only` failure can indicate divergent local and remote histories. Do not default to `git reset --hard`, forced push or an unexplained rebase.

## Model renders but printing or fit fails

Distinguish:
- F5 preview vs **F6 final render** and actual mesh export.
- CAD dimensions vs mesh extents vs slicer toolpaths vs physical tolerance.
- Filament, plate and nozzle selection vs modeled geometry.
- Poor layer adhesion, elephant foot, shrinkage, bridges and support scars vs incorrect measurements.

Prefer a small focused test over large uncontrolled adjustments. Preserve the working baseline.

## Image and file formats

- `.scad`: source; editable geometric parameters and code.
- `.stl`: triangulated export; usable for printing but not parametric source.
- `.3mf`: geometry container *or* slicer job; establish which.
- `.png` / `.jpg`: photographs or illustrations, not a substitute for source.
- Generated images may look plausible but depict **incorrect** geometry. For publication, use model-based CAD renders for exact part views and clearly label illustration art.
- For GitHub binary image commits, use a tool that genuinely supports binary file content and verify remote files; don't categorically claim writing is impossible if write-capable actions exist.

## Safety and rights

Use extra caution for parts under stress, heat, UV, electrical use, food contact or medical/structural purposes. Printing a model does not certify it. Check rights and licenses for third-party files and derivative models.
