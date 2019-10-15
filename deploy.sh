docker build -t arijitchat2006/multi-client:latest -t arijitchat2006/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arijitchat2006/multi-server:latest -t arijitchat2006/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arijitchat2006/multi-worker:latest -t arijitchat2006/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arijitchat2006/multi-client:latest
docker push arijitchat2006/multi-server:latest
docker push arijitchat2006/multi-worker:latest

docker push arijitchat2006/multi-client:$SHA
docker push arijitchat2006/multi-server:$SHA
docker push arijitchat2006/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arijitchat2006/multi-server:$SHA
kubectl set image deployments/client-deployment client=arijitchat2006/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arijitchat2006/multi-worker:$SHA
