# docker-libation
A dockerized version of [https://github.com/rmcrackan/Libation](rmcrackan/Libation) originally done by [https://github.com/pixil98/docker-libation](pixil98/docker-libation) but updated the build script. When run it will scan all accounts for updates, then download any missing books. It currently relies on having an external mechanism to run the image periodically.

## Build script mod
The build script will check if your docker repo already has that version of Libation, and if not, it will build it and tag it for that version and latest. It will also push it Docker Hub and remove the leftover files.

## Building
1. Clone this repository
2. Download the Linux version of Libation into the cloned directory
3. Modify build.sh to change the DOCKER_USER variable
3. Run `./build.sh`

## Running
In order to run the container you will need an existing Libation configuration directory. The easiest way to obtain this is to run Libation and configure it through the gui.
The config directory can be found from the gui by going to `Settings -> Settings -> Open log folder`. Make a copy of this folder and edit the `Settings.json` file. 
You'll need to change the following file paths:
1. `Books` to `"/data"`
2. `InProgress` to `"/tmp"`
3. Under `Serilog.WriteTo.Args` set the `path` to `"/var/log/libation.log"`

```
docker run -d \
  -v <path to copied config folder>:/config \
  -v <path to audiobook folder>:/data \
  --name libation \
  timstephens24/libation:latest
```

Optionally, the `LibationContext.db` file can be stored in a separate folder and mounted in at `/db/LibationContext.db`. This is to allow the image to run in Kubernetes with the config files stored as ConfigMaps.