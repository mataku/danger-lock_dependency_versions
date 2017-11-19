# danger-lock_library_versions

A [Danger](http://danger.systems/ruby/) plugin for managing library versions.

## Installation

Add this line to your Gemfile:

```
$ gem install danger-lock_library_versions
```

## Usage

```
lock_library_versions.check
```

if lock file has not committed to version control, post a failure comment by Danger.

### methods

```
check(warning: boolean)
```

if `warning: true`, set comment status to warning. (default: false)
