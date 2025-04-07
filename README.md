action-changed-objects
======================

[![](https://github.com/babarot/action-changed-objects/workflows/release/badge.svg)](https://github.com/babarot/action-changed-objects/releases)

Get changed objects compared with Git commit in `origin/main`

![](demo.png)

This action depends on https://github.com/babarot/changed-objects

## Usage

A whole example is here:

```yaml
name: Get changed objects

on:
  push:
    branches:
      - '*'
      - '!main'

jobs:
  show:
    runs-on: ubuntu-latest
    name: Get changed objects
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Get changed objects
      uses: babarot/action-changed-objects@main
      with:
        added: 'true'
        deleted: 'false'
        modified: 'true'
      env:
        LOG: 'trace'
      id: objects
    - name: Show the previous result
      run: |
        echo ${{ steps.objects.outputs.changes }}
```

## Customizing

### inputs

The following are optional as `step.with` keys

| Name       | Type   | Description              | Default |
| ---------- | ------ | -------------------------| ------- |
| `added`    | Boolean | Filter added objects    | false   |
| `deleted`  | Boolean | Filter deleted objects  | false   |
| `modified` | Boolean | Filter modified objects | false   |
| `default_branch`   | String  | Set default branch | "main" |
| `merge_base`     | String  | Set [merge-base](https://git-scm.com/docs/git-merge-base) revision | "" |
| `ignore` | String | A pattern to skip changed files (separeted in a newline) | "" |
| `group_by` | String | A pattern to show changed files with one directory group (separated in a newline) | "" |
| `dir_exist` | String | Filter by the state of dir existing ("true", "false" or "all") | "all" |
| `directories` | String | Specify directories to pass changed-objects command (space-divided) | "" |

### outputs

The following outputs can be accessed via `${{ steps.<step-id>.outputs }}` from this action

| Name | Type | Description |
| ---- | ---- | ----------- |
| changes  | String  | Changed objects compared with current branch and origin/main. It may be separated by a space |

### environment variables

The following are as `step.env` keys

| Name | Description |
| ---- | ----------- |
| `LOG`  | Log with each level (`TRACE`, `DEBUG`, `INFO`, `WARN` and `ERROR`) |

## Versus

- [lots0logs/gh-action-get-changed-files](https://github.com/lots0logs/gh-action-get-changed-files)
- [futuratrepadeira/changed-files](https://github.com/futuratrepadeira/changed-files)
- [nholden/modified-file-filter-action](https://github.com/nholden/modified-file-filter-action)

## License

[MIT](https://babarot.mit-license.org/)
