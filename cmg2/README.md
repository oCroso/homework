# Containerized Log Parser for Environment Sensors
CMG Homework

This is still a work in progress, but I had constant interruptions and time delays working on this, so I wanted to get this out to the team as soon as possible covering all the requirements.  Some of this I am aware is not perfect, and without access to cloud resources at this time, my terraform infrastructure provisioning is incomplete or non-existant.

The container is designed to hit a logging endpoint, via curl, on a "pseudo-container" (represented as the github api raw endpoint of the example.log) that displays the logging for a series of environment monitors.

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

## Terraform Provision:

WIP - Due to no Cloud Provider account at this time, may forego.  Deployment to Minikube proved successful.

## K8s Deployment:

The container is deployed to K8s as a simple Helm Chart CronJob deployment and service (to allow for external outreach to the pseudo external "container's logs").

This runs in k8s every minute, and keeps track of recent jobs allowing you to check the status of each job, and it's subsequent output on a minute by minute basis.  I would definitely prefer to output this information to something more useful to allow me to say, do analytics or enable alerting in the future, for example, an ELK stack, however in that scenario I would completely forego this container and just stash/filter the logs accordingly.

## Notes:
- I chose a standard debian container initially to avoid any alpine nuances, I have now changed it to alpine after seeing there would be none.
- If I did this project again I would likely use Python, although the awk works as expected and is arguably lighterweight, however I believe I would have saved a lot of time figuring out the solution with Python, my awk was a bit rusty and I had to do things that I don't find "as easy to work with", however, the script itself is super maintainable requiring only bash, curl, awk, and jq to run.
- In a production environment, I would request back to the development team to make a change in log output to support friendlier logging (or make the change myself if I have access).  The proposed change would be:


### From:

```
thermometer temp-1
2007-04-05T22:00 72.4
2007-04-05T22:00 71.4
2007-04-05T22:00 73.4
```
### To:

```
2007-04-05T22:00 | thermometer | temp-1 | 72.4
2007-04-05T22:00 | thermometer | temp-1 | 71.4
2007-04-05T22:00 | thermometer | temp-1 | 73.4
```

This maintains quick readability, ease of data manipulation, ensures log reliability, and ensures a single log line contains all necessary information (reinforcing log reliability). We could even forego any pipes if those were deemed too excessive.

 
