#! /bin/bash
function mqtt {
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager -m "${DEVICE}"
#	echo ${OUT}
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":0,\"page\":\"boiler\",\"pageId\":4,\"widget\":\"anydata\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}0\",\"class3\":\"calm text-center\",\"style3\":\"font-size:20px;\",\"status\":\"Boiler\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":1,\"page\":\"boiler\",\"pageId\":4,\"widget\":\"simple-btn\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}1\",\"class1\":\"col-xs-4\",\"class2\":\"calm\",\"class3\":\"button button-calm icon ion-minus\",\"style3\":\"height:70px;\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":2,\"page\":\"boiler\",\"pageId\":4,\"widget\":\"display-value\",\"class1\":\"no-padding-left col-xs-4\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}2\",\"height\":\"70\",\"color\":\"#58b7ff\",\"inactive-color\":\"#58b7ff\",\"digits-count\":2}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":3,\"page\":\"boiler\",\"pageId\":4,\"widget\":\"simple-btn\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}3\",\"class1\":\"col-xs-4\",\"class2\":\"calm\",\"class3\":\"button button-calm icon ion-plus\",\"style3\":\"height:70px;\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":4,\"page\":\"boiler\",\"pageId\":4,\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}4\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left\",\"descr\":\"Curren twater temp\",\"class3\":\"assertive\",\"style3\":\"font-size:40px;font-weight:bold;float:right\",\"status\":\"60\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":5,\"page\":\"boiler\",\"pageId\":4,\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}5\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left;\",\"descr\":\"Heater status\",\"class3\":\"light padding-left padding-right rounded\",\"style3\":\"font-size:20px;font-weight:bold;float:right;\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":6,\"page\":\"boiler\",\"pageId\":4,\"widget\":\"simple-btn\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}6\",\"class1\":\"item no-border padding-bottom\",\"class2\":\"assertive padding-top\",\"style2\":\"float:left;\",\"descr\":\"Emergency Stop heating\",\"class3\":\"button icon ion-checkmark-circled\",\"style3\":\"float:right;\",\"widgetConfig\":{\"fill\":\"widgetConfig\",\"fillPressed\":\"#FF7070\",\"label\":\"#FFFFFF\",\"labelPressed\":\"#000000\",\"alertText\":\"A you sure?\",\"alertTitle\":\"Stop heating\"}}"
	sleep 5
	BOILER=$(cat boiler.txt)
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/${CONTROL}2/status -m "{\"status\":\"${BOILER}\"}"


####	OUT=$(cat ${DEVICE}.${CONTROL}0.txt)
#	mosquitto_pub -t /IoTmanager/${DEVICE}/${CONTROL}0/status -m "{\"status\":\"${OUT}\"}"	
#	OUT=$(cat ${DEVICE}.${CONTROL}1.txt)
#	mosquitto_pub -t /IoTmanager/${DEVICE}/${CONTROL}1/status -m "{\"status\":\"${OUT}\"}"	
#	OUT=$(cat ${DEVICE}.${CONTROL}2.txt)
#	mosquitto_pub -t /IoTmanager/${DEVICE}/${CONTROL}2/status -m "{\"status\":\"${OUT}\"}"	
}

DEVICE=dev-fake2
CONTROL=light
USER=localhost
PASSWORD=55bPBs3
mqtt
while true
do
	IN=$(mosquitto_sub -u ${USER} -P ${PASSWORD} -1 -t /IoTmanager)
	STATUS=${?}
#	echo ${STATUS}
	if [ ${STATUS} -eq "0" ]
	then
		if [ ${IN} == "HELLO" ]
		then
			mqtt
		fi
	else
#		echo error
		sleep 10
	fi
done
