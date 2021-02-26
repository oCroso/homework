# Containerized Log Parser for Environment Sensors
CMG Homework

The container is designed to hit a logging endpoint, via curl, on a pseudo-container that displays the logging for a series of environment monitors.

The container uses awk to grab the appropriate data:
```
thermometer temp-1
2007-04-05T22:00 72.4
2007-04-05T22:00 71.4
2007-04-05T22:00 73.4
```
And convert it to the following, more useful information:

```
{
"temp-1": "precise",
"temp-2": "ultra precise",
"hum-1": "keep",
"hum-2": "discard"
}
```
The container can be found here:
https://hub.docker.com/repository/docker/ocroso/cmg-logparser

Notes:
- I chose a standard debian container for simplicity of the Dockerfile, I have now decided to change it to alpine.
- In a production environment, I would request back to the development team to make a change in log output to support friendlier logging (or make the change myself if I have access).  The proposed change would be:

From:

```
thermometer temp-1
2007-04-05T22:00 72.4
2007-04-05T22:00 71.4
2007-04-05T22:00 73.4
```
To:

```
2007-04-05T22:00 | thermometer | temp-1 | 72.4
2007-04-05T22:00 | thermometer | temp-1 | 71.4
2007-04-05T22:00 | thermometer | temp-1 | 73.4
```

This maintains quick readability, ease of data manipulation, ensures log reliability, and ensures a single log line contains all necessary information.

 
