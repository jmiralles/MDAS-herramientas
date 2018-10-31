set -e
docker build -t votingapp-builder .
docker run -v $(pwd):/app -w /app votingapp-builder bash -c "./pipeline.sh"

docker build -t jmiralles99/votingapp ./src/votingapp

docker rm -f mivotingapp || true
docker run --name mivotingapp -d -p 8085:8080 votingapp

docker push jmiralles99/votingapp