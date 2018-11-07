#!/bin/bash

http_client() {
    curl --url 'http://votingapp:8080/vote' --request $1 --data "$2" --header 'Content-Type: application/json' 
}
topics='{"topics":["bash","python","go"]}'
expectedWinner='bash'
http_client POST $topics

echo "Given voting topics $topics, When vote for $options, Then winner is $expectedWinner"

for option in bash bash bash python
do
    http_client PUT '{"topic":"'$option'"}'
done

winner=$(http_client DELETE | jq -r '.winner')

if [ "$expectedWinner" = "$winner" ]; then
    echo "TEST PASSED"
    exit 0
else
    echo "TEST FAILED"
    exit 1
fi        
