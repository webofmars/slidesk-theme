# AGENTS.md — agent instructions and operational contract

This document defines the operational guardrails for automated coding agents working in the `slidesk-theme` workspace. It summarizes how to stay aligned with Hoverkraft standards; it is not a replacement for the developer documentation referenced below.

## Organization-wide guidelines (required)

- Follow the prioritized shared instructions in [hoverkraft-tech/.github/AGENTS.md](https://github.com/hoverkraft-tech/.github/blob/main/AGENTS.md) before making any change.
- Apply the engineering guidance published in `README.md`, `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, and the Hoverkraft [branding guidelines](https://hoverkraft.cloud/en/brand-guidelines/) when editing UI, assets, or workflows.
- Honor the global engineering rules provided by the workspace owner (Clean Code, SOLID, accessibility-first, least privilege). Do not introduce new dependencies that are unmaintained or violate the licensing posture.

## Quick Start

Review these entry points before coding:

- **[Overview](README.md#overview)** — Theme purpose, supported scenarios, and how packages map to deliverables.
- **[Feature Highlights](README.md#feature-highlights)** — Canonical list of enforced branding capabilities that should not regress.
- **[Development](README.md#development)** — Toolchain prerequisites, workspace orchestration, and local preview steps.
- **[Testing](README.md#testing)** — Required lint/build/test commands and smoke-test expectations.
- **[Contributing](CONTRIBUTING.md)** — Review workflow, documentation expectations, and release/versioning rules.

## Agent-Specific Development Patterns

### Critical Workflow Knowledge

```bash
make start                      # Launch Slidesk via Docker on http://localhost:1337
make lint                       # Run lint suite via the repo's Docker linter
make lint-fix                   # Autofix lint issues through the same container
make build                      # Export static slides and copy the CSS bundle
make ci                         # Run lint + build (CI parity) for pre-submit confidence
```

- Ensure Docker Engine/Desktop is available before running any target; all tooling (Slidesk + lint) is containerized.
- Always validate visual changes through `make start`, review dark/accent/split layouts, and reload the browser at `http://localhost:1337`.
- Run `make build` after modifying CSS or `.sdf` layouts so reviewers receive the updated static output in `packages/slides/build`.
- Use `make lint`/`make lint-fix` to keep Prettier + repository lint policies aligned with CI; they invoke the Docker linter described in `Makefile`.

### Code Quality Expectations

- Keep `packages/theme/hoverkraft.css`, the `.sdf` layout files (split, accent, title, etc.), and `files.json` in sync—new components need both styling and SlideSk layout definitions.
- Maintain accessibility: preserve high-contrast palettes, focus states, readable typography, and screen-reader-friendly ordering per the branding guidelines.
- Treat `packages/slides` as the authoritative smoke-test surface; update or add demo slides whenever altering public-facing layouts or classes so reviewers can preview the change.
- Avoid ad-hoc build scripts; extend the existing Make targets or Docker-driven helpers when new automation is required, and prefer pure functions/utilities to keep side effects isolated.
- Keep versions coordinated: bump `packages/theme/package.json` (and any documented references) when behavior changes ship, following SemVer.

### Documentation Updates

- Mirror user-facing changes in `README.md` (usage, commands, configuration) and annotate new slide classes or CSS hooks so downstream teams know how to adopt them.
- Expand `packages/slides` content or comments to illustrate new capabilities; this doubles as living documentation and manual QA fodder.
- Record release-impacting updates (commands, environment expectations, assets) in the relevant sections before asking for review.
- When adding tooling, describe how to run it locally (e.g., additional Make targets or Docker commands) and update `Makefile` help text if new goals are introduced.
