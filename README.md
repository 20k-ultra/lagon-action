# Lagon Action

Easily integrate [Lagon](https://lagon.dev) CLI into your Github workflows. Deploy new functions, retrieve a list of existing functions, promote functions, etc. This action supports any [arbitrary input](#other-commands) of what to do!

## Usage

Create the following workflow in your function's repository:

_./github/workflows/lagon.yml_

```yml
name: Lagon

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    name: Deploy
    steps:
      - uses: actions/checkout@v2
      - uses: lagonapp/github-action@latest
        with:
          lagon_token: ${{ secrets.LAGON_API_TOKEN }}
```

This will deploy your source code to the specified function after a commit is pushed into main.

_NOTE: Make sure the repository that gets checked out contains a `.lagon/config.json` file that specifies information such as the function_id and organization_id!_

#### Other commands

If you want to run a different command just specify it with the `command` input:

```bash
        with:
          lagon_token: ${{ secrets.LAGON_API_TOKEN }}
          command: "promote claxnlc230738q5pa7iximskm ./my-project"
```

See [CLI](https://docs.lagon.app/cli) docs for more commands.

## Inputs

Inputs are provided using the `with:` section of your workflow YML file.

| key         | Description                  | Required | Default                |
| ----------- | ---------------------------- | -------- | ---------------------- |
| lagon_token | Your Lagon API token         | true     |                        |
| command     | The Lagon CLI command to run | false    | deploy --prod          |
| site_url    | Specify Lagon API domain     | false    | https://dash.lagon.app |

`site_url` is used to specify a custom endpoint if you are using a self-hosted instance of Lagon.

## Outputs

| key | Description | Nullable |
| --- | ----------- | -------- |
|     |             |          |

No outputs for now... not sure what the CLI can output, function hash ?

## Developing

There's a test runner [script](test.sh) which uses [act](https://github.com/nektos/act) to call [test_action_workflow.yml](test_action_workflow.yml) which is setup to call the action in this repository.

Export your API token to `LAGON_API_TOKEN` so the test script can pass it to the action:

```bash
LAGON_API_TOKEN=token123 ./test.sh
```

### Manual E2E testing

If you want to run the action on Github simply push your branch and then create a repository which has a workflow that uses it. For example, make a workflow with a job that uses `lagonapp/github-action@<branch-you-are-developing>`.
