# Lagon Deploy Action

Easily integrate Lagon CLI operations into your Github workflow. Deploy new functions, retrieve a list of existing functions, promote functions, etc. This action supports any arbitrary input of what to do.

### Usage

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
      - name: Publish
        uses: lagonapp/github-action@latest
        with:
          lagon_token: ${{ secrets.LAGON_API_TOKEN }}
          command: deploy --prod
          config: '{
            "function_id":${{ vars.LAGON_FUNCTION_ID }},
            "organization_id": ${{ vars.LAGON_ORG_ID }},
          }'
```

This will deploy your source code to the specified function after a commit is merged into main.

## Inputs

Inputs are provided using the `with:` section of your workflow YML file.

| key         | Description                  | Required | Default                |
| ----------- | ---------------------------- | -------- | ---------------------- |
| lagon_token | Your Lagon API token         | true     |                        |
| command     | The Lagon CLI command to run | true     |                        |
| config      | API key to Lagon Dashboard   | false    | {}                     |
| site_url    | Specify Lagon API domain     | flase    | https://dash.lagon.app |

`site_url` is used to specify a custom endpoint if you are using a self-hosted instance of Lagon.

`confiag` is used to specify vairous options for the CLI. This is required when deploying a function because the CLI must know what `function_id` and `organization_id` to use. Additionally, you could specify other inputs like `assets`, `index, and `client`.

The config input is expected to be a JSON string like so:

```
         config: |
          {
            "function_id":"cleoau1wk0000mj0843yvsgi7",
            "organization_id":"cleeepy2j0006jx08ew36ivpg",
            "index":"server/index.mjs",
            "client":null,
            "assets":"public"
          }
```

You can even specify the function_id and organization_id via variables so that you don't have to update your workflow if you need to update your function/fleet:

```
         config: |
          {
            "function_id":"${{ vars.LAGON_FUNCTION_ID }}",
            "organization_id":"${{ vars.LAGON_ORG_ID }}",
            ...
          }
```

See the github docs on how to specify variables for a repository [here](https://docs.github.com/en/actions/learn-github-actions/variables#creating-configuration-variables-for-a-repository).

## Outputs

| key | Description | Nullable |
| --- | ----------- | -------- |

No outputs for now... not sure what the CLI can output, function hash ?

## Development

See the [development](DEVELOPMENT.md) docs.
