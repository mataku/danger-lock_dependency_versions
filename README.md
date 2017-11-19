[![Build Status](https://travis-ci.org/mataku/danger-lock_library_versions.svg?branch=master)](https://travis-ci.org/mataku/danger-lock_library_versions)

# danger-lock_library_versions

A [Danger](http://danger.systems/ruby/) plugin for managing dependency files.

Check files which should be committed to version control (e.g., `Gemfile` and `Gemfile.lock`, `Cartfile` and `Cartfile.resolved`).

## Installation

Add this line to your Gemfile:

```
$ gem danger-lock_dependency_versions
```

## Usage

First, create `.lock_list.yml` and add key-value pair to check.

```yaml
Gemfile: Gemfile.lock
Cartfile: Cartfile.resolved
```

Add to Dangerfile.

```
lock_dependency_versions.check
```

If lockfile has not committed to version control, post a failure comment by Danger.

### Methods

```
check(warning: boolean)
```

if specify `warning: true`, set comment status to warning. (default: false)
