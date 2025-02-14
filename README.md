# halostatue/fish-utils

[![Version][version]](https://github.com/halostatue/fish-utils/releases)

Utility functions for [fish shell][shell].

## Installation

Install with [Fisher][Fisher].

```fish
fisher install halostatue/fish-utils@v4
```

### System Requirements

- [fish][fish] 3.4+

## Functions

### `clone-tree`

Clones the entire directory structure of a `SOURCE` directory into another,
using tar with pipes. If `TARGET` does not exist, it will be created.

```fish
clone-tree SOURCE TARGET
```

#### `clone-tree` flags

- `-p`, `--progress`: Enables the display of a progress bar. If `pv` is not
  available, acts the same as `--verbose`. Mutually exclusive with `--verbose`.

- `-v`, `--verbose`: Shows a verbose extract display. Mutually exclusive with
  `--verbose`.

- `-k`, `--keep-root`: If provided, keeps the source directory as the root of
  the target files. That is, `clone-tree --keep-root SOURCE TARGET` will produce
  the output of `TARGET/(basename SOURCE)/...`.

### `dataurl`

Creates a data URL (base 64 encoded) for the contents of the provided file.

```fish
dataurl --copy image.jpg
```

#### `dataurl` flags

- `copy`: Copy the resulting data URL to the clipboard in addition to printing
  it.

- `property`: Specify the property for this data URL.

### `latest_modified_file`

Given a list of files, returns the file that was most recently updated by
`mtime`. Because of limitations of fish, it is not possible to pass wild cards
that have no match to this function without first assigning them to a variable.

```fish
echo (latest_modified_file Rakefile Gemfile) # Rakefile
set -l files Rakefile lib/tasks/*.rake
echo (latest_modified_file $files) # lib/tasks/test.rake
```

### `max`, `__max`, `min`, and `__min`

Prints the maximum/minimum value from the provided list.

The comparison must be done on numeric values, but comparisons can be done with
the `--using` option to specify a program and arguments to run against the
provided list.

```fish
$ max 31 25 92 32
92
$ min 31 25 92 32
25
$ max --using 'path mtime' *.md
CHANGELOG.md
$ max --using 'path mtime' *.md
LICENCE.md
```

#### `max`, `__max`, `min`, and `__min` flags

- `-u`, `--using`: A string representing the command to be run to get a numeric
  value for comparison.

### `md5pwd`

Creates an MD5 hash for the current working directory.

### `mess`

Creates a working 'mess' directory where new things may be played with.

## `pidwd`

Prints the current working directory of the provided PID.

```fish
test (pidwd $fish_pid) = $PWD; and echo Works
```

## `rot13`

A simple/simplistic Caesar cipher.

```fish
echo N fvzcyr/fvzcyvfgvp Pnrfne pvcure. | rot13
```

## `urlencode`

URL encodes the provided string.

## Licence

[MIT](./LICENCE.md)

## Change Log

[CHANGELOG](./CHANGELOG.md)

## Contributing

- [Contributing](./CONTRIBUTING.md)
- [Contributors](./CONTRIBUTORS.md)
- [Code of Conduct](./CODE_OF_CONDUCT.md)

[fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
[shell]: https://fishshell.com 'friendly interactive shell'
[version]: https://img.shields.io/github/tag/halostatue/fish-utils.svg?label=Version
[hfuc]: https://github.com/halostatue/fish-utils-core
