#!/bin/bash

# aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 374070299695.dkr.ecr.us-east-2.amazonaws.com

pushd ~/kubeflow/components/crud-web-apps/jupyter && make docker-build docker-push && popd

# change deploy image, this should restart the pod
kubectl set image deployment/jupyter-web-app-deployment jupyter-web-app=374070299695.dkr.ecr.us-east-2.amazonaws.com/jupyter-web-app:latest -n kubeflow
