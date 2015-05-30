# Datawrapper Docker
Dockerfile and related build scripts for a docker image for datawrapper.

# To Pull
```bash
docker pull arahayrabedian/datawrapper:latest
```

# To Build
```bash
docker build .
```

# To Run
- export env var DATAWRAPPER_SECURE_AUTH_KEY and expose appropriate ports (-p 0.0.0.0:80:80 if you like).
- if you'd like some fancier config options, some are available, but look through the various .tpl files to figure them out, will be documented when this is more mature.
for example ```docker run -e DATAWRAPPER_SECURE_AUTH_KEY=slartibartfast -p 0.0.0.0:80:80 arahayrabedian/datawrapper:latest```

# Caveats
 - Uses @rubensfernando's plugin-embed to allow embedding charts - not native as native is broken.

# Limitations
 - currently has an ephemeral on-board sql, this is fine to develop against and such, but is NOT production ready.

# How it works
 - A lot of this script has to be deferred to startup due to dynamic configuration based on environment variables, the startup script itself is generated from a template at startup. mind = blown
 - At build time we'll have put everything in place ready for runtime to start up and do the final putting-it-all together parts.

# Credits
Thnaks to the people at datawrapper for putting this solution together, I'm bored of dealing with gcharts and other solutions that didn't fit my needs.
Special thanks to @rubensfernando for writing the plugin used to re-enable embedding charts (and generating them correctly)

# Anti-Credits
The people at datawrapper for (appearing) to fall off the open source trail (which alone is okay, but be open about it), disabling embedding charts and not mentioning it anywhere, and generally ignoring the community that's trying to help them on their repository (see issues and pull requests).
