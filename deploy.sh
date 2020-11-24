docker build -t brianrienecker/multi-client:latest -t brianrienecker/multi-client:$SHA -f ./client/Dockerfile ./client 
docker build -t brianrienecker/multi-server:latest -t brianrienecker/multi-server:$SHA -f ./server/Dockerfile ./server 
docker build -t brianrienecker/multi-worker:latest -t brianrienecker/multi-worker:$SHA -f ./worker/Dockerfile ./worker 
docker push brianrienecker/multi-client:latest 
docker push brianrienecker/multi-server:latest
docker push brianrienecker/multi-worker:latest 

docker push brianrienecker/multi-client:latest:$SHA
docker push brianrienecker/multi-server:latest:$SHA
docker push brianrienecker/multi-worker:latest:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=brianrienecker/multi-server:$SHA
kubectl set image deployments/client-deployment server=brianrienecker/multi-client:$SHA 
kubectl set image deployments/worker-deployment server=brianrienecker/multi-worker:$SHA  