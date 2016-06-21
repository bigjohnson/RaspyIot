#! /bin/bash
DEVICE=dev-fake
CONTROL=light2
USER=user
PASSWORD=password
while true
do
	OUT=$(mosquitto_sub -u ${USER} -P ${PASSWORD} -1 -t "/IoTmanager/${DEVICE}/${CONTROL}/control")
	STATUS=${?}
#	echo ${STATUS}
	if [ ${STATUS} -eq "0" ]
	then
		mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/${CONTROL}/status -m "{\"status\":\"${OUT}\"}"
		echo ${OUT} > ${DEVICE}.${CONTROL}.txt
#		echo ${OUT}		
	else
#		echo error
		sleep 10
	fi
done
