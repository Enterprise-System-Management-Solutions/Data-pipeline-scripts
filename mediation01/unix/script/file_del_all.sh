#!/bin/sh
#!/bin/bash

##+7 days files remove for IN CDR for all Source

##source=$1
##ftype=$2
cd $1

###find $ftype*.gz -mtime +7 -exec rm {} \;

find . -mtime +7 | xargs rm -Rf;

exit
