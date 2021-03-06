
if [[ $# -eq 0 ]];then
  kcenv="LOCAL"
else
  kcenv=$1
fi
source ./scripts/setenv.sh $kcenv

if [[ -z "$IPADDR" ]]
then
    export IPADDR=$(ifconfig en0 |grep "inet " | awk '{ print $2}')
fi


if [[ $kcenv == "LOCAL" ]]
then
  docker run -e DISPLAY=$IPADDR:0 -v $(pwd):/home -e KAFKA_BROKERS=$KAFKA_BROKERS \
     -e KAFKA_APIKEY=$KAFKA_APIKEY \
     --network docker_default\
      -e MONGO_DB_URL=$MONGO_DB_URL \
      -e MONGO_SSL_PEM=$MONGO_SSL_PEM\
      -e MONGO_DATABASE=$MONGODB_DATABASE \
      -e MONGODB_USER=$MONGODB_USER\
      -e MONGODB_PASSWORD=$MONGODB_PASSWORD\
      -e cp4d_user=$cp4d_user\
      -e cp4d_pwd=$cp4d_pwd\
      -e PREDICTION_BASE_URL=$PREDICTION_BASE_URL\
      -e PREDICTION_URL=$PREDICTION_URL\
      -ti ibmcase/python bash
else
  docker run  -e DISPLAY=$IPADDR:0 -v $(pwd):/home -e KAFKA_BROKERS=$KAFKA_BROKERS \
     -e KAFKA_APIKEY=$KAFKA_APIKEY \
     -e MONGO_DB_URL=$MONGO_DB_URL \
     -e MONGO_SSL_PEM=$MONGO_SSL_PEM\
     -e MONGO_DATABASE=$MONGODB_DATABASE \
      -e MONGODB_USER=$MONGODB_USER \
      -e MONGODB_PASSWORD=$MONGODB_PASSWORD \
      -e cp4d_user=$cp4d_user \
      -e cp4d_pwd=$cp4d_pwd \
      -e PREDICTION_BASE_URL=$PREDICTION_BASE_URL \
      -e PREDICTION_URL=$PREDICTION_URL \
      -ti ibmcase/python bash
fi
