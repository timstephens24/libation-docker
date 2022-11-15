# docker-libation
A dockerized version of [https://github.com/rmcrackan/Libation](rmcrackan/Libation). When run it will scan all accounts for updates, then download any missing books. It currently relies on having an external mechanism to run the image periodically.

## Building
1. Clone this repository
2. Download the Linux version of Libation into the cloned directory
3. Run `./build.sh <libation.zip>`

## Running
In order to run the container you will need an existing Libation configuration directory. The easiest way to obtain this is to run Libation and configure it through the gui.
The config directory can be found from the gui by going to `Settings -> Settings -> Open log folder`. Make a copy of this folder and edit the `Settings.json` file. 
You'll need to change the following file paths:
1. `Books` to `"/data"`
2. `InProgress` to `"/tmp"`
3. Under `Serilog.WriteTo.Args` set the `path` to `"/var/log/libation.log"`

```
sudo docker run -d \
  -v <path to copied config folder>:/config \
  -v <path to audiobook folder>:/data \
  --name libation \
  pixil/libation:latest
```

Optionally, the `LibationContext.db` file can be stored in a separate folder and mounted in at `/db/LibationContext.db`. This is to allow the image to run in Kubernetes with the config files stored as ConfigMaps.
