# NWP-Presentation

Slides for the presentation of the NWP module in the DHSN-Dresten with the
topic **Vorschlag eines Systems für Laborübungen für die Ausbildung mit neuronalen Netzwerken unter
gegebenen Anforderungen**.

The slides have been created with [marp](https://marp.app/).

## TL;DR

Build artefacts aka pdf's of the slides can be found in the
[pdfs/](https://github.com/bytehaufen/DSDS-Presentation/tree/build/pdfs) folder of
the build branch.

## Interaction with the _marp-cli_ (stolen from the [marp documentation](https://github.com/marp-team/marp-cli))

[npx (`npm exec`)](https://docs.npmjs.com/cli/v7/commands/npx) is the best way to
use the latest Marp CLI if you wanted one-shot Markdown conversion
_without install_. Just run below if you have
installed [Node.js](https://nodejs.org/) v16 and later.

```bash
# Convert slide deck into HTML
npx @marp-team/marp-cli@latest ./slides/nwp-presentation.md --html --allow-local-files --engine ./engine/engine.js
npx @marp-team/marp-cli@latest ./slides/nwp-presentation.md --html --allow-local-files -o output.html --engine ./engine/engine.js

# Convert slide deck into PDF
npx @marp-team/marp-cli@latest ./slides/nwp-presentation.md  --html --allow-local-files --pdf --engine ./engine/engine.js
npx @marp-team/marp-cli@latest ./slides/nwp-presentation.md --html --allow-local-files -o output.pdf --engine ./engine/engine.js

# Convert slide deck into PowerPoint document (PPTX)
npx @marp-team/marp-cli@latest ./slides/nwp-presentation.md --html --allow-local-files --pptx --engine ./engine/engine.js
npx @marp-team/marp-cli@latest ./slides/nwp-presentation.md --html --allow-local-files -o output.pptx --engine ./engine/engine.js

# Watch mode
npx @marp-team/marp-cli@latest -w ./slides/nwp-presentation.md --html --engine ./engine/engine.js

# Server mode (Pass directory to serve)
npx @marp-team/marp-cli@latest -s ./slides --html --engine ./engine/engine.js
```

## Marp ressources

- [Marp markdown documentation](https://marpit.marp.app/markdown)
- [Marp transition documentation](https://github.com/marp-team/marp-cli/blob/main/docs/bespoke-transitions/README.md#built-in-transition)

## Orga

Presentation: 24.3.2025 and 31.3.2025
Inhalt: Vortrag
