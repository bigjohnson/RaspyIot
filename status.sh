#! /bin/bash
USER=user
PASSWORD=password
while true
do
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/dev-fake2/light5/status -m "{ \"status\" : \"OFF\", \"class3\" : \"calm-bg light padding-left padding-right rounded\" }"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/dev-fake2/light6/status -m "{\"descr\":\"Heating already stopped\",\"class2\":\"calm\",\"class3\":\"button icon ion-close-circled\",\"widgetConfig\":{\"fill\":\"#AAAAAA\",\"fillPressed\":\"#EEEEEE\",\"disabled\": 1}}"
	BOILER=$(cat boiler.txt)
	let "BOILER = BOILER + 20"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/dev-fake2/light4/status -m "{\"status\":\"${BOILER}\"}"
	sleep 30
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/dev-fake2/light5/status -m "{ \"status\" : \"ON\", \"class3\" : \"assertive-bg light padding-left padding-right rounded\" }"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/dev-fake2/light6/status -m "{ \"descr\"  : \"Emergency Stop heating\",\"class2\" : \"assertive\",\"class3\" : \"button icon ion-checkmark-circled\",\"widgetConfig\" : { \"fill\" : \"#FF5050\",\"fillPressed\" : \"#FF7070\",\"disabled\": 0 }}"
	BOILER=$(cat boiler.txt)
        let "BOILER = BOILER - 20"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/dev-fake2/light4/status -m "{\"status\":\"${BOILER}\"}"
	sleep 30
done
