docker build -t lykaion/multi-client:latest -t lykaion/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lykaion/multi-server:latest -t lykaion/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lykaion/multi-worker:latest -t lykaion/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lykaion/multi-client:latest
docker push lykaion/multi-server:latest
docker push lykaion/multi-worker:latest

docker push lykaion/multi-client:$SHA
docker push lykaion/multi-server:$SHA
docker push lykaion/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lykaion/multi-server:$SHA
kubectl set image deployments/client-deployment client=lykaion/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lykaion/multi-worker:$SHA
