Containerized Log Parser for Environment Sensors
CMG Homework


Notes:
- As an SRE I would request back to the development team a change in log output to support better logging (or make the change myself if possible).  The proposed change would be:

FROM

```thermometer temp-1
2007-04-05T22:00 72.4```

TO

`2007-04-05T22:00 | thermometer | temp-1 | 72.4`

This maintains quick readability, ease of data manipulation, ensures log reliability, and ensures a single log line contains all necessary information.

 
