#! /bin/bash
function mqtt {
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager -m "${DEVICE}"
#	echo ${OUT}
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":0,\"page\":\"Piano terra\",\"pageId\":2,\"descr\":\"Luce cucina\",\"widget\":\"toggle\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}0\",\"color\":\"blue\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":1,\"page\":\"Piano terra\",\"pageId\":2,\"descr\":\"Luce sala\",\"widget\":\"toggle\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}1\",\"color\":\"yellow\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":2,\"page\":\"Primo piano\",\"pageId\":3,\"descr\":\"Luce camera da letto\",\"widget\":\"toggle\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}2\",\"color\":\"green\"}"
	OUT=$(cat ${DEVICE}.${CONTROL}0.txt)
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/${CONTROL}0/status -m "{\"status\":\"${OUT}\"}"	
	OUT=$(cat ${DEVICE}.${CONTROL}1.txt)
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/${CONTROL}1/status -m "{\"status\":\"${OUT}\"}"	
	OUT=$(cat ${DEVICE}.${CONTROL}2.txt)
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/${CONTROL}2/status -m "{\"status\":\"${OUT}\"}"	
}

DEVICE=dev-fake
CONTROL=light
USER=user
PASSWORD=password
mqtt
while true
do
	IN=$(mosquitto_sub -u ${USER} -P ${PASSWORD} -C 1 -t /IoTmanager)
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
