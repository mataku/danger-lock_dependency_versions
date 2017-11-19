[![Build Status](https://travis-ci.org/mataku/danger-lock_library_versions.svg?branch=master)](https://travis-ci.org/mataku/danger-lock_library_versions)

# danger-lock_library_versions

A [Danger](http://danger.systems/ruby/) plugin for managing library versions.

## Installation

Add this line to your Gemfile:

```
$ gem danger-lock_library_versions
```

## Usage

```
lock_library_versions.check
```

if lock file has not committed to version control, post a failure comment by Danger.

### Methods

```
check(warning: boolean)
```

if `warning: true`, set comment status to warning. (default: false)

## Supports
- Gemfile
  - Gemfile.lock
- Cartfile
  - Cartfile.resolved
- Podfile
  - Podfile.lock
