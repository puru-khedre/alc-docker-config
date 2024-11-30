#!/bin/bash
#Database Settings
sed -i  's/127.0.0.1:9200/'$ELASTICSEARCH_HOST':9200/g' $CONF_FILE
sed -i -e 's/name="webapp_http_host" value=""/name="webapp_http_host" value="'$Moqui_HOST'"/g' $CONF_FILE
sed -i 's/name="elasticsearch_user" value=""/name="elasticsearch_user" value="'${ELASTICSEARCH_USER}'_"/g' $CONF_FILE
sed -i 's/name="elasticsearch_password" value=""/name="elasticsearch_password" value="'${ELASTICSEARCH_PASSWORD}'_"/g' $CONF_FILE

sed -i -e 's/name="entity_ds_host" value="127.0.0.1"/name="entity_ds_host" value="'$Moqui_DB_HOST'"/g' $CONF_FILE
sed -i 's/name="entity_ds_user" value="moqui"/name="entity_ds_user" value="'$Moqui_DB_USER'"/g' $CONF_FILE
sed -i 's/name="entity_ds_password" value="moqui"/name="entity_ds_password" value="'$Moqui_DB_PASSWORD'"/g' $CONF_FILE
sed -i 's/name="entity_ds_database" value="moqui"/name="entity_ds_database" value="'$Moqui_DB_NAME'"/g' $CONF_FILE
sed -i 's/name="entity_ds_database_configuration" value="moqui_configuration"/name="entity_ds_database_configuration" value="'$Moqui_configuration_DB_Name'"/g' $CONF_FILE

#Timezone Setting
sed -i 's|name="default_time_zone" value=""|name="default_time_zone" value="'$TIME_ZONE'"|g' $CONF_FILE
sed -i 's|name="database_time_zone" value=""|name="database_time_zone" value="'$TIME_ZONE'"|g' $CONF_FILE

$SLEEP
screen -dmS Moqui java $JAVA_OPTS -cp . MoquiStart port=8080 conf=$CONF_FILE
tail -F runtime/log/moqui.log