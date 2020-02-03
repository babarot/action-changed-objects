action-changed-objects
======================

[![](https://github.com/b4b4r07/action-changed-objects/workflows/release/badge.svg)](https://github.com/b4b4r07/action-changed-objects/releases)

Get changed objects compared with Git commit in `origin/master`

![](demo.png)

This action depends on https://github.com/b4b4r07/changed-objects

## Usage

A whole example is here:

```yaml
name: Get changed objects

on:
  push:
    branches:
      - '*'
      - '!master'

jobs:
  show:
    runs-on: ubuntu-latest
    name: Get changed objects
    steps:
    - name: Checkout
      uses: actions/checkout@v1
    - name: Get changed objects
      uses: b4b4r07/action-changed-objects@master
      with:
        added: 'true'
        deleted: 'false'
        modified: 'true'
      id: objects
    - name: Show the previous result
      run: |
        echo ${{ steps.objects.outputs.changed }}
```

## Customizing

### inputs

The following are optional as `step.with` keys

| Name       | Type   | Description              | Default |
| ---------- | ------ | -------------------------| ------- |
| `added`    | Boolean | Filter added objects    | false   |
| `deleted`  | Boolean | Filter deleted objects  | false   |
| `modified` | Boolean | Filter modified objects | false   |
| `dirname`  | Boolean | Return the result with each directory name | false   |

### outputs

The following outputs can be accessed via `${{ steps.<step-id>.outputs }}` from this action

| Name | Type | Description |
| ---- | ---- | ----------- |
| changed  | String  | Changed objects compared with current branch and origin/master. It may be separated by a space |

### environment variables

The following are as `step.env` keys

| Name | Description |
| ---- | ----------- |
| `CLI_LOG`  | Log with each level (`TRACE`, `DEBUG`, `INFO`, `WARN` and `ERROR`) |

## License

[MIT](https://b4b4r07.mit-license.org/)
