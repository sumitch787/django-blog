#!/bin/sh
set -u
IMAGE_TAG=$(echo $GIT_COMMIT| cut -c1-6)
IMAGE_NAME=$(echo $JOB_NAME | cut -d '/' -f1)
check(){
exit_code=$(docker inspect -f 0 django 2&> /dev/null)
if [[ $exit_code == "" ]];
then
docker run -d --name django -p $PORT:8080 $registry:$IMAGE_NAME-$IMAGE_TAG
else
docker rm -f django
docker run -d --name django -p $PORT:8080 $registry:$IMAGE_NAME-$IMAGE_TAG
fi
}
check
