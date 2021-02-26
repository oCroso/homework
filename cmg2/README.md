Containerized Log Parser for Environment Sensors
CMG Homework

The container is designed to hit a logging endpoint on a pseudo container that dispalys the logging for a series of environment monitors.

The container uses awk to determine 




Notes:
- I chose a standard debian container as I needed a few more packages not available with alpine, and adding what I needed was just simpler this way.  Sure, the container is a whopping 50 Mb, but everything around it otherwise is super simple and idempotent and changes are easy to make (no gotchas or alpine nuances).
- As an SRE I would request back to the development team make a change in log output to support better logging (or make the change myself if possible).  The proposed change would be:

From:

```thermometer temp-1
2007-04-05T22:00 72.4
2007-04-05T22:00 71.4
2007-04-05T22:00 73.4```

To:

```2007-04-05T22:00 | thermometer | temp-1 | 72.4
2007-04-05T22:00 | thermometer | temp-1 | 71.4
2007-04-05T22:00 | thermometer | temp-1 | 73.4```

This maintains quick readability, ease of data manipulation, ensures log reliability, and ensures a single log line contains all necessary information.

 
