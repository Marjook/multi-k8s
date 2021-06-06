docker build -t marjook/multi-client:latest -t marjook/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t marjook/multi-server:latest -t marjook/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t marjook/multi-worker:latest -t marjook/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push marjook/multi-client:latest
docker push marjook/multi-server:latest
docker push marjook/multi-worker:latest

docker push marjook/multi-client:$SHA
docker push marjook/multi-server:$SHA
docker push marjook/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=marjook/multi-server:$SHA
kubectl set image deployments/client-deployment client=marjook/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=marjook/multi-worker:$SHA