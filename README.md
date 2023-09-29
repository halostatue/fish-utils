# halostatue/fish-utils

Utility functions for [fish shell][]. Most have been ported from my zsh
dotfiles.

<img src="https://img.shields.io/github/tag/halostatue/fish-kiex.svg?label=Version" alt "">

## Installation

Install with [Fisher][] (recommended):

```fish
fisher install halostatue/fish-utils-core halostatue/fish-utils
```

<details>
<summary>Not using a package manager?</summary>

---

Copy `functions/*.fish` to your fish configuration directory preserving the
directory structure.

</details>

### System Requirements

- [fish][] 3.0+

## Functions

### `clone-tree SOURCE TARGET [OPTIONS]

Clones the entire directory structure of a `SOURCE` directory into another,
using tar with pipes. If `TARGET` does not exist, it will be created.

```fish
clone-tree source target
```

#### Options

- `-p`, `--progress`: Enables the display of a progress bar. If `pv` is not
  available, acts the same as `--verbose`. Mutually exclusive with `--verbose`.

- `-v`, `--verbose`: Shows a verbose extract display. Mutually exclusive with
  `--verbose`.

- `-k`, `--keep-root`: If provided, keeps the source directory as the root of
  the target files. That is, `clone-tree --keep-root SOURCE TARGET` will produce
  the output of `TARGET/(basename SOURCE)/...`.

### `color_test [--list[=SCALE]]`

Displays either a color test list or a color test grid. If the list

### dataurl

Creates a data-url base64 encoded value of the file.

```fish
dataurl image.jpg | pbcopy
```

### latest_modified_file

Given a list of files, returns the file that was most recently updated by
mtime. Because of limitations of fish, it is not possible to pass wildcards
that have no match to this function without first assigning them to a
variable.

```fish
echo (latest_modified_file Rakefile Gemfile) # Rakefile
set -l files Rakefile lib/tasks/*.rake
echo (latest_modified_file $files) # lib/tasks/test.rake
```

### max, min

Prints the maximum value from the provided list.

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

#### Option

- `-u`, `--using`: A string representing the command to be run to get a numeric
  value for comparison.

### md5pwd

Creates an MD5 hash for the current working directory.

### mess

Creates a working 'mess' directory where new things may be played with.

## pidwd

Prints the current working directory of the provided PID.

```fish
test (pidwd %self) = $PWD; and echo Works
```

## rot13

A simpl{e,istic} Caesar cipher.

```fish
echo N fvzcyr Pnrfne pvcure. | rot13
```

## urlencode

URL encodes the provided string.

## License

[MIT](LICENCE.md)

[fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
[fish shell]: https://fishshell.com 'friendly interactive shell'
