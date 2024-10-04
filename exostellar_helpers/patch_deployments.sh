#!/bin/bash


kubectl set image deployment/jupyter-web-app-deployment jupyter-web-app=374070299695.dkr.ecr.us-east-2.amazonaws.com/kubeflow/jupyter-web-app:latest -n kubeflow
kubectl patch deployment jupyter-web-app-deployment -n kubeflow \
  --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/imagePullPolicy", "value": "Always"}]'


kubectl set image deployment/centraldashboard centraldashboard=374070299695.dkr.ecr.us-east-2.amazonaws.com/kubeflow/centraldashboard:latest -n kubeflow
kubectl patch deployment centraldashboard -n kubeflow \
  --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/imagePullPolicy", "value": "Always"}]'
