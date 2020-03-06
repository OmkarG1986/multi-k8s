## Build the images with 2 tags - latest and $SHA
docker build -t omkarsonawane/docker-multi-client:latest -t omkarsonawane/docker-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omkarsonawane/docker-multi-server:latest -t omkarsonawane/docker-multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omkarsonawane/docker-multi-worker:latest -t omkarsonawane/docker-multi-worker:$SHA -f ./worker/Dockerfile ./worker

## Push the images to docker hub
docker push omkarsonawane/docker-multi-client:latest
docker push omkarsonawane/docker-multi-client:$SHA
docker push omkarsonawane/docker-multi-server:latest
docker push omkarsonawane/docker-multi-server:$SHA
docker push omkarsonawane/docker-multi-worker:latest
docker push omkarsonawane/docker-multi-worker:$SHA

## apply k8s config files present under k8s dir
kubectl apply -f k8s

## set/apply $SHA tag images to k8s deployments
kubectl set image deployments/client-deployment client=omkarsonawane/docker-multi-client:$SHA
kubectl set image deployments/server-deployment server=omkarsonawane/docker-multi-server:$SHA
kubectl set image deployments/worker-deployment worker=omkarsonawane/docker-multi-worker:$SHA
