#!/bin/bash

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 374070299695.dkr.ecr.us-east-2.amazonaws.com

# build and push to ecr
pushd ~/kubeflow/components/centraldashboard && \
    TAG=latest make docker-build docker-push && \
    popd || exit 1

# restart pods
kubectl rollout restart deployment/centraldashboard -n kubeflow
