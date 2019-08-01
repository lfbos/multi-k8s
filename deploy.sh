#!/usr/bin/env bash
docker build -t lfbos19/multi-client:latest -t lfbos19/multi-client:$SHA ./client
docker build -t lfbos19/multi-server:latest -t lfbos19/multi-server:$SHA ./server
docker build -t lfbos19/multi-worker:latest -t lfbos19/multi-worker:$SHA ./worker
docker push lfbos19/multi-client:latest
docker push lfbos19/multi-server:latest
docker push lfbos19/multi-worker:latest

docker push lfbos19/multi-client:$SHA
docker push lfbos19/multi-server:$SHA
docker push lfbos19/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lfbos19/multi-server:$SHA
kubectl set image deployments/client-deployment client=lfbos19/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lfbos19/multi-worker:$SHA
