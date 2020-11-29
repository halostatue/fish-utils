# halostatue/fish-utils

Utility functions for [fish shell][]. Most have been ported from my zsh
dotfiles.

[![Version][]][]

## Installation

Install with [Fisher][] (recommended):

```fish
# Fisher 3.x
fisher add halostatue/fish-utils

# Fisher 4.0+: dependencies must be specified explicitly
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

### await, signal

A process can `await` a `signal` provided by another process.

```fish
process 1> await notifications
process 2> echo 'Hello' | signal notifications
process 1>
'Hello'
```

The `await` command may optionally have a parameter `--progress` that will
print a '.' every second while waiting for the signal.

### cat

A wrapper around `bat` and `mdless` if either is installed.

### clone-tree

Clones the entire directory structure of a `source` directory into another,
using tar with pipes. if `target` does not exist, it will be created. If the
command `pv` is present, it will be used to present a progress view.

```fish
clone-tree source target
```

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

### md5pwd

Creates an MD5 hash for the current working directory.

### mess

Creates a working 'mess' directory where new things may be played with.

## pidwd

Prints the current working directory of the provided PID.

```fish
test (pidwd %self) = $PWD; and echo Works
```

## pipeset

Set one or more variables to the output of the pipe.

```fish
cat README.md | pipeset -g readme
```

## rot13

```fish
echo N fvzcyr Pnrfne pvcure. | rot13 # A simple Caesar cipher.
```

## title

Sets the terminal title for the current shell. With `-c`/`--cwd` the current
path will be put in the title either before, or with `-a`/`--after`, after
the provided text.

## urlencode

URL encodes the provided string.

## License

[MIT](LICENCE.md)

[fish shell]: https://fishshell.com 'friendly interactive shell'
[version]: https://img.shields.io/github/tag/halostatue/fish-kiex.svg?label=Version

[![Version][]]: https://github.com/halostatue/fish-kiex/releases
[Fisher]: https://github.com/jorgebucaran/fisher
[fish]: https://github.com/fish-shell/fish-shell
