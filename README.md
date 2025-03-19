# terria-config

## intro

This repository provides a docker-compose.yml to build and run a terriamap instance for showcasing fair-ease results.
It does so by providinga local config and local data files (and fair-ease branding changes)

## usage

```bash
# git-checkout
$ git clone git@github.com:fair-ease/terria-config.git  # note we recommend using proport git-ssh key setup - alternatively use the https://... uri

# enter the project
$ cd terria-config

# copy and change .env and .secrets
$ cp example.dot.env .env && vi .env
$ cp example.dot.secrets .secrets && vi .secrets

# select / build the terriamap docker image by either option 1/2
# option 1. build locally
$ make dc

# option 2. select the published one
$ export REG_NS=ghcr.io/terriajs/terriamap  #you could also add this to your local .env file

# run the stack
$ make dc-start

```

## dealing with secrets

In the `.secrets` file you can specify any personal api_tokens or credentials to be injected through `${VARNAME}` into the `./wwwroot/config.json`

See `example.dot.secrets` for some available variables and their meaning.

## dealing with custom settings

In the `.env` file you can specify a number of distinct alternative to common defaults. Most of these are infecting the workings of the `docker-compose.yml` and can be verified over there.

See `example.dot.env` for some available variables and their meaning.
