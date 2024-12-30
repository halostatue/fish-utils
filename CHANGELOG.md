# halostatue/fish-utils Changelog

## 4.0.0 / 2024-12-29

- Update Code of Conduct to Contributor Covenant 2.1.

- Added completions.

- Removed `color_test` without replacement.

- Added comments to help identify the source of plugins when installed with
  Fisher.

- Added a GitHub Action for testing. Converted makefile to casey/just.

- From this release, release tags will drop `.x` (e.g., `@v4`, `@v4.0`).

## 3.0.1 / 2023-09-29

- Added `max` and `min` functions. Modified `latest_modified_file` to use the
  new `max` function. These functions are also made available as `__max` and
  `__min`.

- Fixed various issues around usage and error messages added as part of 3.0.

## 3.0 / 2023-09-26

- Removed functions:

  - `cat` is better handled in a user's `config.fish` file as an `abbr`.
  - `await` and `signal` have been removed as I have never used them.
  - `pipeset` has been removed as I have never used it and it looks like this
    could now be achieved with `(COMMAND | string collect)`:

    ```fish
    set --global readme (cat README.md | string collect)
    ```

  - `title` has never been used.

- Fixed a bug with `color_test` failing because of an incorrect use of flags.

- Fixed a bug with `mess` in later versions of Fish 3 where `not command test …`
  does not work properly, but `not test …` does. The use of `command` was
  unnecessary.

- Changed `dataurl` to use `string join` instead of `tr -d`. Also added a
  `--copy` parameter that uses `fish_clipboard_copy` to copy the data URL to the
  clipboard. It is always printed.

- Reworked `clone-tree` for improved performance, cross-platform behaviour, and
  usability. The default behaviour is different from previous versions of
  `clone-tree` but is more correct in its intent.

  Previously, `clone-tree source target` would create `target/source/...`. With
  this version, `clone-tree source target` will create `target/...`. The old
  behaviour can be maintained with the `--keep-root` flag.

- Updated `md5pwd` to no longer use `is:linux` or `is:mac`. Instead, it only
  checks for `md5`, `md5sum`, and `gmd5sum`. Fixed a bug with the output of the
  `{,g}md5sum` path where the implicit newline of `pwd` was being included in
  the calculation.

- Updated `mess` to be a little more verbose if arguments are provided and the
  targets do not exist. Also change into the link directory instead of the dated
  target directory.

- Updated `pidwd` to use `string replace` for parsing.

## 2.0.1

- Fixed a bug with `cat`.

## 2.0

- Removed several core functions from `halostatue/fish-utils` and put them in
  `halostatue/fish-utils-core`. This change should be unnoticeable if you are
  using `fisher`.

- Removed network functions from `halostatue/fish-utils` and put them in
  `halostatue/fish-utils-net`. It is necessary to add this to your `fishfile`.

- Added a bunch of new functions, often found from other locations and/or
  translated from other shell scripts.

- Merged `__lscolors` and `__colortest` into `color_test` and corrected a
  display issue.

- Fixed a stupid typo with `clone-tree`. Enhanced it to allow it to create the
  `target` directory.

- Various small updates to most other functions.

## 1.2

- Deprecate MANPATH management. Will be removed in 2.0.

## 1.1.2

- Fix a bug with man.cx

## 1.1.1

- Improve is:os implementation

## 1.1

- Add more functions, fix ssh-copy-id

## 1.0.3

- Fix an issue with a regex

## 1.0.2

- Clean up some bad usage of string match

## 1.0.1

- Fix an error in argparse.

## 1.0

- Create halostatue/fish-utils
