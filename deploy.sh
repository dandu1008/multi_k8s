docker build -t dandu1008/multi-client:latest -t dandu1008/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dandu1008/multi-server:latest -t dandu1008/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dandu1008/multi-worker:latest -t dandu1008/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dandu1008/multi-client:latest
docker push dandu1008/multi-server:latest
docker push dandu1008/multi-worker:latest

docker push dandu1008/multi-client:$SHA
docker push dandu1008/multi-server:$SHA
docker push dandu1008/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=dandu1008/multi-client:$SHA
kubectl set image deployments/server-deployment server=dandu1008/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=dandu1008/multi-worker:$SHA