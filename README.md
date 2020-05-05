Repository for argo-scripts images, intended for ci/cd pipelines

##check-image-n-status.sh
Expected env variables:
ARGO_SERVER - hostname for grpc endpoint of argocd
ARGO_TOKEN - argocd api token

Arguments:
`check-image-n-status.sh $app_name $search_string`
app_name - argocd application name
search_string - image name, tag or whatever we want to find in application's manifests

Example of usage:
```bash
export ARGO_TOKEN=____TOKEN____
export ARGO_SERVER=argo-cd-grpc.sm.pepstaging.com
check-image-n-status.sh sm-api 64c28fdb555c31ac5de9451bf85742cf0940ba93
```
in this case script will search for string "64c28fdb555c31ac5de9451bf85742cf0940ba93", which is supposedly image tag, in the "sm-api" application's manifests on the "argo-cd-grpc.sm.pepstaging.com" server using ____TOKEN____ token. 