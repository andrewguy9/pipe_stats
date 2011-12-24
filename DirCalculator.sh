#!/bin/bash
echo "Looking up $@"

find $@ | 
xargs -I {} -P1 ls -l {} | 
grep -v total | 
awk '{print $5,$9}' | 
awk '
{
        size = $1; 
        if(match($2, /\.[^\/.]*$/ ) != 0) {
                ext = substr($2,RSTART,RLENGTH)
        } else {
                ext = "no_ext";
        }
        print size,ext;
}' |
./StatCalculator.out 
