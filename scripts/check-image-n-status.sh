#!/bin/sh


UPDATED=false
SUCCESS=false

echo "checking if image has been updated..."
if [ $DEBUG == "true" ]; then
    set -x
fi 

for i in $(seq 1 10); do
    if argocd --server $ARGO_SERVER --auth-token $ARGO_TOKEN app manifests $1 | grep -q $2; then
        UPDATED=true 
        echo "Image updated!"
        break
    fi
    sleep 5
done

if [ $UPDATED == "true" ]; then
    echo "checking deployment success in general..."
    for i in $(seq 1 10); do
        if argocd --server $ARGO_SERVER --auth-token $ARGO_TOKEN app wait $1 --timeout 5; then
            echo "deploy succeeded!"
            SUCCESS=true 
            break
        fi
        sleep 5
    done
fi 

if [ $SUCCESS != "true" ]; then
    echo "SUCCESS = $SUCCESS, so exit 1"
    exit 1
fi