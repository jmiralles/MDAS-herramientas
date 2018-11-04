votingappPath='./src/votingapp'

build(){
    pushd $votingappPath # change directory, better than cd 
    ./deps.sh
    rm -rf ./deploy
    (go build -o ./deploy/votingapp && cp -r ui ./deploy) || exit 1
    popd
}

run(){
    app='votingapp'
    pushd $votingappPath
    pid=$(ps | grep $app | awk '{ print $1 }' | head -1)
    kill -9 $pid || true
    ./deploy/votingapp &  # to execute en background
    popd
}

test() {
    http_client() {
        curl --url 'http://localhost:8080/vote' --request $1 --data "$2" --header 'Content-Type: application/json' 
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
        return 0
    else
        return 1
    fi        
}

if build > log 2> error; then
    echo "Build Completed"
    run
    if test; then
        echo "Test Passed"
    else 
        echo "Test Failed"
    fi        
else
    echo "FAILED"
fi    