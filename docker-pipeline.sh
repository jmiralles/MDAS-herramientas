set -e

image='votingapp'
registry=${REGISTRY:-'jmiralles99'}
network='votingapp-network'

docker network create $network || true

# BUILD
docker build -t $registry/$image -f ./src/votingapp/Dockerfile ./src/votingapp

# INTEGRATION TESTS
docker rm -f $image || true
docker run --name $image -d --network $network $registry/$image

docker build -t votingapp-test ./test
docker run --rm --network $network -e VOTING_URL="http://$image:8080" votingapp-test

# DELIVERY
docker push $registry/$image
