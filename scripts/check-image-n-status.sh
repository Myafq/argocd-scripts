#!/bin/sh


UPDATED=false
SUCCESS=false

echo "checking if image has been updated..."

for i in [1..10]; do
    if argocd --server $ARGO_SERVER --auth-token $ARGO_TOKEN app manifests $APPLICATION | grep -q $IMAGE; then
        UPDATED=true 
        echo "Image updated!"
        break
    fi
    sleep 5
done

if [ $UPDATED == "true" ]; then
    echo "checking deployment success in general..."
    for i in [1..10]; do
        if argocd --server $ARGO_SERVER --auth-token $ARGO_TOKEN app wait $APPLICATION --timeout 5; then
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