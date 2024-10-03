#!/bin/bash

for i in {1..10000}
do
    (
        curl -s $1
    ) &
done
