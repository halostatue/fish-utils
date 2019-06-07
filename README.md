# halostatue/fish-utils

Utility functions for the <a href=https://fishshell.com title="friendly
interactive shell">fish shell</a>.

Most have been ported over from my zsh dotfiles.

[![Releases](https://img.shields.io/github/release/halostatue/fish-utils.svg?label=latest)](https://github.com/halostatue/fish-utils/releases)

## Installation

Install with [Fisher](https://github.com/jorgebucaran/fisher) (recommended):

```fish
fisher add halostatue/fish-utils
```

<details>
<summary>Not using a package manager?</summary>

---

Copy `functions/*.fish` to your fish configuration directory preserving the
directory structure.
</details>

### System Requirements

- [fish](https://github.com/fish-shell/fish-shell) 3.0+

## Functions

### clone-tree

```fish
clone-tree source dest
```

Clones the entire directory structure of a single directory into another,
using tar with pipes.

### dataurl

```fish
dataurl image.jpg | pbcopy
```

Creates a data-url base64 encoded value of the file.

### dig1, diga

```fish
dig1 google.com
diga google.com
```

Shorthand responses from dig.

### is:os — is:freebsd, is:linux, is:mac, is:ubuntu

Tests that the current operating environment is the expected OS type. Most
are implemented in terms of is:os, which is mostly a comparison tool for
`uname -s`.

```fish
is:mac; and echo Yes; or echo No
```

### is:mac-at-least

Determines whether the MacOS version is at least the version specified:

```fish
is:mac-at-least catalina; and echo Developer; or echo Normal
```

### is:mac-terminal

Determines whether running on in MacOS and whether iTerm or Apple Terminal is
running.

### is:true

Determines whether the value provided is a true value

```fish
is:true 1; and echo yes
is:true yes; and echo yes
is:true true; and echo yes
is:true on; and echo yes
is:true no; or echo no
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

### path:after, path:before, path:unique

Manages $PATH, $MANPATH, and $CDPATH in a sane way. `path:after` and
`path:before` are simple wrappers around `path:unique`. `path:unique` adds
the list of paths provided to the global path variable.

#### path:unique Flags

Without flags, `path:unique` and its wrappers will add the provided paths, in
the provided order, to the beginning of the $PATH, even if the value was
already present. This means that:

```fish
echo $PATH # b /usr/local/bin
path:unique a b c
echo $PATH # a b c /usr/local/bin
```

- `-m`, `--man`: Manages $MANPATH instead of $PATH. Mutually exclusive with
  `-c` (`--cdpath`).
- `-c`, `--cdpath`: Manages $CDPATH instead of $PATH. Mutually exclusive with
  `-m` (`--man`).
- `-a`, `--append`: Appends the path list to the managed path. Not available on
  `path:before` and `path:after`.

    ```fish
    echo $PATH # b /usr/local/bin
    path:unique --append a b c
    echo $PATH # /usr/local/bin a b c
    ```

- `-t`, `--test`: Only appends the provided path if it exists. Off by default.

### path:clean

Removes the provided path(s) from $PATH, $MANPATH, or $CDPATH.

#### path:clean Flags

Without flags, `path:clean` will remove the provided paths from $PATH. This
means that:

```fish
echo $PATH # b /usr/local/bin
path:clean b
echo $PATH # /usr/local/bin
```

- `-m`, `--man`: Manages $MANPATH instead of $PATH. Mutually exclusive with
  `-c` (`--cdpath`).
- `-c`, `--cdpath`: Manages $CDPATH instead of $PATH. Mutually exclusive with
  `-m` (`--man`).

### path:make_unique

Run this once per type during initialization to ensure that your $PATH,
$MANPATH, or $CDPATH do not contain duplicate entries. The order of the entries
in the managed path variable will be preserved.

#### path:make_unique Flags

Without flags, `path:make_unique` will manage $PATH. This means that:

```fish
echo $PATH # /usr/local/bin /usr/local/bin
path:make_unique
echo $PATH # /usr/local/bin
```

- `-m`, `--man`: Manages $MANPATH instead of $PATH. Mutually exclusive with
  `-c` (`--cdpath`).
- `-c`, `--cdpath`: Manages $CDPATH instead of $PATH. Mutually exclusive with
  `-m` (`--man`).

## pidwd

Prints the current working directory of the provided PID.

```fish
test (pidwd %self) = $PWD; and echo Works
```

## rot13

```fish
echo N fvzcyr Pnrfne pvcure. | rot13 # A simple Caesar cipher.
```

## run_from_ssh

Returns true if the current shell was run from SSH.

## ssh-copy-id

WARNING: This port of a tested shell script from a tested zsh script has not
itself been tested.

Copies one or more SSH public key file identities to the
`~/.ssh/authorized_keys` file of a remote server.

## sshfp

Create the text required for SSHFP DNS records (SSH fingerprint) for a host.

## title

Sets the terminal title for the current shell. With `-c`/`--cwd` the current
path will be put in the title either before, or with `-a`/`--after`, after
the provided text.

## License

[MIT](LICENCE.md)
