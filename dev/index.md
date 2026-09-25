# Ocsigen-i18n

Ocsigen-i18n provides internationalisation (i18n) support for OCaml applications. Translations are described in TSV (tab-separated values) files; a code generator turns them into OCaml functions and a PPX extension provides a convenient `[%i18n ...]` syntax to use them.

## Manual

- [Introduction](./intro.md) — overview, installation and quick start
- [Code generator](./generator.md) — the `ocsigen-i18n` command and its options
- [PPX rewriter](./ppx.md) — the `[%i18n ...]` syntax
- [Template syntax](./templates.md) — how to write the TSV translation files

## API

- [`Ppx`](./Ppx.md) — the PPX rewriter library
