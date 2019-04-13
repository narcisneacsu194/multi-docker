docker build -t narcisneacsu194/multi-client:latest -t narcisneacsu194/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t narcisneacsu194/multi-server:latest -t narcisneacsu194/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t narcisneacsu194/multi-worker:latest -t narcisneacsu194/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push narcisneacsu194/multi-client:latest
docker push narcisneacsu194/multi-server:latest
docker push narcisneacsu194/multi-worker:latest

docker push narcisneacsu194/multi-client:$SHA
docker push narcisneacsu194/multi-server:$SHA
docker push narcisneacsu194/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=narcisneacsu194/multi-server:$SHA
kubectl set image deployments/client-deployment client=narcisneacsu194/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=narcisneacsu194/multi-worker:$SHA