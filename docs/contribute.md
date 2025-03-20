# docs for colab contributors and devs

## useful commands

```bash
# see what you can do here
$ make

# build the local fork TerriaMap for fair-ease
$ make dc

# run the local docker stack
$ make dc-start

# stop the local docker stack
$ make dc-stop

# git into the terriamap container with a shell
$ make dc-exec  # use ctrl-d to get out

# check any logs from the terriamap container
$ make dc-logs  # use ctrl-c to get out
```

## what do you want to add?

### add extra local data to be served into the demo

Simply add files to the local `wwwroot/fairease.eu/data/` folder --> these are made available inside the local instance.

### add extra catalog entries

Edit the `wwwroot/init/fairease-main.json` to have extra entries added.
Look at the current file for examples and inspiration.

### enable other catalog entries

In stead of keeping to add more entries to the `fairease-main.json` one can also introduce extra files next to in the same `wwwroot/init` folder and reference them in the `wwwroot/config.json`

This is is done at the top of that file:

```json
  /* Names of init files (in wwwroot/init), without the .json extension, to load by default */
  "initializationUrls": ["fairease-main"],
```

## how to contribute

We recommend to

- create your own branch (ask access to the repo in fairease, or use your own fork)
- commit and push to that
- propose a PR to be merged for the rest of fair-ease to enjoy

Tip: most of the contributions below do not require a rebuild of the docker image, not even a restart of the docker restart as most config changes are picked up. This means you don't have to execute the (lengthy) `make dc` again, and even can avoid cycling through the restart by `make dc-stop dc-start`

## ongoing challenges and work (mostly during FE hackathon in Brest March 2025)

- setting up this colab env
- have data from ERDDAP show up in terriamap
  - for one axemple
  - in a more generic metadata-aware way
- reading from IDDAS - selecting a source, then creating a config-entry for terriamap ?
- integratring IDDAS as type of catalog to terriamap
- see how we can fit into galaxy
- see how w3id usage can help us get past possible terriamap uri encoding issues

## about some uncommon hackery going on ...

### the `./secrets-merge.sh`

Some of the terriamap features can use available online services that require some API_TOKEN (or any other form of credentials).

Those are typically tied to personal accounts and should never be committed to git nor shared via github.

In stead we recommend adding them into the local `./.secrets` file (which is ignored from the git repo)
To use its value you can simply add a `${VARNAME}` reference to the `./wwwroot/config.json` file.

These will get replaced with the actucal values by the `./secrets-merge.sh` script that will effectively produce some temporary `/tmp/wwwroot-config-*.json` file. This in turn gets passed down to the docker container via the `TMCFG` environment variable that is picked up in the `docker-compose.yml`

This only assumes you startup the container (as our `make dc-start` is doing) with this command:

```bash
$ TMCFG="$(./secrets-merge.sh)" docker compose up -d
```

### The TerriaMap submodule

The folder TerriaMap in this repo is in fact a git-submodule to the [fair-ease fork of TerriaMap](https://github.com/fair-ease/TerriaMap)

It got added through

```bash
$ git submodule add git@github.com:fair-ease/TerriaMap.git
```

Our `docker-compose.yml` is pointing to that folder to (if called) build the terriamap docker image based on the contents of that folder.

The reasoning behind it, is to easily allow switching between working with our custom fork, or the upstream baseline.
