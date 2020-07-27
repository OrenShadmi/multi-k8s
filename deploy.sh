docker build -t orenshadmi/multi-client:latest -t stephengrider/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t orenshadmi/multi-server:latest  -t stephengrider/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t orenshadmi/multi-worker:latest -t stephengrider/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push orenshadmi/multi-client:latest
docker push orenshadmi/multi-server:latest
docker push orenshadmi/multi-worker:latest

docker push orenshadmi/multi-client:$SHA
docker push orenshadmi/multi-server:$SHA
docker push orenshadmi/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA