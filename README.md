# @hoverkraft/slidesk-theme

Official Hoverkraft theme for SliDesk presentations.

---

[![License](https://img.shields.io/badge/License-MIT-blue)](#license)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

## Overview

`@hoverkraft/slidesk-theme` delivers a production-ready Hoverkraft-branded experience for every SliDesk presentation. The theme enforces consistent styling based on the official [Hoverkraft Branding Guidelines](https://hoverkraft.cloud/en/brand-guidelines/).

## Feature Highlights

- **Enforced branding**: Colors, typography, spacing, and component styling sourced from the Hoverkraft design system.
- **Accessibility-first**: Built with high contrast ratios and readable fonts.
- **Responsive layout**: Works across different screen sizes and aspect ratios.
- **Multiple layouts**: Split views, title slides, dark slides, and more.
- **Step animations**: Progressive content reveal support.
- **Print-friendly**: Optimized print styles for handouts.

## Documentation

- Theme source lives in `packages/theme`.
- Example presentation lives in `packages/slides`.
- Generated static output is emitted to `packages/slides/build` during CI and local builds.

## Packages

| Package           | Description                                                              |
| ----------------- | ------------------------------------------------------------------------ |
| `packages/theme`  | Source for the published `@hoverkraft/slidesk-theme` package.            |
| `packages/slides` | Example SliDesk presentation showcasing the theme, used for QA and docs. |

## Installation

```bash
slidesk theme install @hoverkraft-tech/slidesk-theme
```

Reference the theme in your SliDesk presentation:

```md
/::
custom_css: node_modules/@hoverkraft/slidesk-theme/hoverkraft.css
::/

# My Presentation .[title-slide]

## Your content here...
```

## Available Slide Classes

| Class           | Description                                |
| --------------- | ------------------------------------------ |
| `.title-slide`  | Gradient background for title/intro slides |
| `.dark-slide`   | Dark navy background for emphasis          |
| `.accent-slide` | Teal gradient for call-to-action slides    |
| `.split`        | Two-column layout                          |
| `.title-top`    | Title positioned at top                    |
| `.text-left`    | Left-aligned text content                  |
| `.steps`        | Progressive content reveal                 |

## Color Palette

| Color         | Hex       | Usage                              |
| ------------- | --------- | ---------------------------------- |
| Primary       | `#1D2026` | Core headings, dark surfaces       |
| Secondary     | `#1998FF` | Links, interactive accents         |
| Accent        | `#FF5A02` | Calls to action, emphasis blocks   |
| Info          | `#00B3FF` | Informational callouts             |
| Warning       | `#FFE671` | Warning banners and highlights     |
| Danger        | `#FF696D` | Error states and destructive cues  |
| Success       | `#00D663` | Positive confirmations             |
| Neutral Light | `#506690` | Secondary text, dividers, code bg  |
| Neutral Dark  | `#000000` | Deep backgrounds, high-contrast UI |

## Development

All local workflows run through Dockerized [Slidesk](https://slidesk.github.io/slidesk-doc/docs/installation/docker/) and the provided Make targets:

```bash
make start                     # Launch Slidesk dev server on http://localhost:1337
make build                     # Export static slides + bundle CSS
make lint                      # Run repo lint suite via container
```

### Local Development

1. Clone the repository
2. Ensure Docker Desktop / Engine is available
3. Run `make start` to launch the example presentation (serves on `http://localhost:1337`)
4. Edit files in `packages/theme` to modify the theme
5. Changes will be reflected in the example presentation while the Slidesk container is running

### Using DevContainer

This repository includes a DevContainer configuration for Visual Studio Code / GitHub Codespaces:

1. Open in Visual Studio Code with the Remote Containers extension
2. Reopen in Container when prompted
3. Run `make start`

## Testing

```bash
make lint        # Run linters (Dockerized)
make build       # Build slides and copy CSS bundle
```

- The example presentation can be smoke-tested locally with `make start` (Slidesk Docker image).
- Visual testing can be done by viewing the presentation in a browser.

## Releasing

1. Update semantic versioning in `packages/theme/package.json`.
2. Build the packages with `make build`.
3. Validate the example presentation locally.
4. Publish the theme package via your preferred workflow.

## Contributing

Please review [`CONTRIBUTING.md`](CONTRIBUTING.md) for guidelines, review expectations, and code of conduct.

## Support

Questions or issues? Open an issue in the [GitHub repository](https://github.com/hoverkraft-tech/slidesk-theme) or start a discussion.

## License

MIT License — see [LICENSE](LICENSE) for details.
