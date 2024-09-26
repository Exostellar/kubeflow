#!/bin/bash

aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 374070299695.dkr.ecr.us-east-2.amazonaws.com

pushd components/crud-web-apps/jupyter && make image && popd
kubectl set image deployment/jupyter-web-app-deployment jupyter-web-app=374070299695.dkr.ecr.us-east-2.amazonaws.com/jupyter-web-app:latest -n kubeflow
