# Containerized Log Parser for Environment Sensors
CMG Homework

This is still a work in progress, but I had constant interruptions and time delays working on this, so I wanted to get this out to the team as soon as possible covering all the requirements.  Some of this I am aware is not perfect, and without access to cloud resources at this time, my terraform infrastructure provisioning is likely incomplete.

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

K8s Deployment:

The container is deployed to K8s as a simple Helm Chart CronJob deployment and service (to allow for external outreach to the pseudo external "container's logs").

This runs in k8s every minute, and keeps track of recent jobs allowing you to check the status of each job, and it's subsequent output on a minute by minute basis.  I would definitely prefer to output this information to something more useful to allow me to say, do analytics or enable alerting in the future, for example, an ELK stack.

Notes:
- I chose a standard debian container for simplicity of the Dockerfile, I have now decided to change it to alpine.
- If I did this project again I would use Python probably, although the awk works as expected and is arguably lighterweight, I still would have saved a lot of time probably just using python instead, my awk was a bit rusty and I had to do things that I don't find "as maintainable", however, the script itself is super maintainable requiring only awk and jq to run.
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

 
