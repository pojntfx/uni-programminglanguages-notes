# Uni Programming Languages Notes

Notes for the programming languages (Aktuelle Programmiersprachen) course at HdM Stuttgart.

[![Deliverance CI](https://github.com/pojntfx/uni-programminglanguages-notes/actions/workflows/deliverance.yaml/badge.svg)](https://github.com/pojntfx/uni-programminglanguages-notes/actions/workflows/deliverance.yaml)

## Overview

You can [view the notes on GitHub pages](https://pojntfx.github.io/uni-programminglanguages-notes/), [download them from GitHub releases](https://github.com/pojntfx/uni-programminglanguages-notes/releases/latest) or [check out the source on GitHub](https://github.com/pojntfx/uni-programminglanguages-notes).

## Contributing

To contribute, please use the [GitHub flow](https://guides.github.com/introduction/flow/) and follow our [Code of Conduct](./CODE_OF_CONDUCT.md).

To build and open a note locally, run the following:

```shell
$ git clone https://github.com/pojntfx/uni-programminglanguages-notes.git
$ cd uni-programminglanguages-notes
$ ./configure
$ make depend
$ make dev-pdf/your-note # Use Bash completion to list available targets
# In another terminal
$ make open-pdf/your-note # Use Bash completion to list available targets
```

The note should now be opened. Whenever you change a source file, it will automatically be re-compiled.

## License

Uni Programming Languages Notes (c) 2022 Felicitas Pojtinger and contributors

SPDX-License-Identifier: AGPL-3.0
