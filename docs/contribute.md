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
```

## what do you want to add?

### add extra local data to be served into the demo

Simply add files to the local `wwwroot/fairease.eu/data/` folder --> these are made available inside the local instance.

### add extra catalog entries

Edit the `wwwroot/init/fairease-main.json` to have extra entries added.
Look at the current file for examples and inspiration.

### enable other catalog entries

In stead of keepint to add more entries to the `fairease-main.json` one can also introduce extra files next to in the same `wwwroot/init` folder and reference them in the `wwwroot/config.json`

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

## ongoing challenges and work (mostly during FE hackathon in Brest March 2025)

- setting up this colab env
- have data from ERDDAP show up in terriamap
  - for one axemple
  - in a more generic metadata-aware way
- reading from IDDAS - selecting a source, then creating a config-entry for terriamap ?
- integratring IDDAS as type of catalog to terriamap
- see how we can fit into galaxy
- see how w3id usage can help us get past possible terriamap uri encoding issues
