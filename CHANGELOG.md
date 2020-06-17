# halostatue/fish-utils Changelog

## 2.0.1

- Fixed a bug with `cat`.

## 2.0

- Removed several core functions from `halostatue/fish-utils` and put them in
  `halostatue/fish-utils-core`. This change should be unnoticeable if you are
  using `fisher`.

- Removed network functions from `halostatue/fish-utils` and put them in
  `halostatue/fish-utils-net`. It is necessary to add this to your
  `fishfile`.

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
