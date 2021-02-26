#!/bin/bash
set -e
curl https://raw.githubusercontent.com/oCroso/homework/main/cmg2/example.log | \
awk '{
    if ($1 ~ "reference") {
        reftemp=$2
        refhum=$3
    } else if ($1 ~ "thermometer") {
        header=$2
	is_humidity=0;
    } else if ($1 ~ "humidity") {
        header=$2
	is_humidity=1;
	humidity_sensors[header]=1;
    } else {
        value=$2
        if (header) {
	    if (is_humidity){
                if ( value - refhum > 1.0 || value - refhum < -1.0 ) {
		    humidity_sensors[header]=0;
	        }      	    
	   } else {
               temp[header] += value;
               tempcount[header] += 1;
	       temp_sensors[header][value]=1;
	    }
        }
    }
} END {
    for (var in temp) {
	sum=0
	count=0
	sumsq=0
	for (e in temp_sensors[var]){
	#    printf("%.2f\n", e);
	    sum+=e; sumsq+=e*e
	    count+=1
	}
	standard_dev=sqrt(sumsq/count - (sum/count)**2)
        mean=temp[var] / tempcount[var]
	printed=0
	if ( mean - reftemp > 0.5 || mean - reftemp < 0.5 ){
		if ( standard_dev < 3 ){
	        	printf("%s %s\n", var, "ultra-precise")
			printed=1
	        }
                else if ( standard_dev < 5 ) {
	        	printf("%s %s\n", var, "very-precise")
			printed=1
		}
        }
	if (printed==0) {
        	printf("%s %s\n", var, "precise")
        }
	}
    for (var in humidity_sensors) {
	if (humidity_sensors[var]==1){
		printf("%s %s\n", var, "keep");
	}
	else {
		printf("%s %s\n", var, "discard");
	}
    }
}'
