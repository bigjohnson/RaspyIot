#! /bin/bash
DEVICE=dev-fake2
CONTROL=light1
TARGET=light2
USER=user
PASSWORD=password
while true
do
	OUT=$(mosquitto_sub -u ${USER} -P ${PASSWORD} -1 -t "/IoTmanager/${DEVICE}/${CONTROL}/control")
	STATUS=${?}
#	echo ${STATUS}
	if [ ${STATUS} -eq "0" ]
	then
		BOILER=$(cat boiler.txt)
		if [ ${BOILER} -gt 40 ]
		then
			let "BOILER = BOILER - 1"
			mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/${TARGET}/status -m "{\"status\":\"${BOILER}\"}"
			echo ${BOILER} > boiler.txt
#			echo ${OUT}
		fi		
	else
#		echo error
		sleep 10
	fi
done
