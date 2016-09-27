#! /bin/bash
DEVICE=dev-fake
CONTROL=light1
USER=user
PASSWORD=password
while true
do
	OUT=$(mosquitto_sub -u ${USER} -P ${PASSWORD} -C 1 -t "/IoTmanager/${DEVICE}/${CONTROL}/control")
	STATUS=${?}
#	echo ${STATUS}

	if [ ${STATUS} -eq "0" ]
	then
		mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/${CONTROL}/status -m "{\"status\":\"${OUT}\"}"
		echo ${OUT} > ${DEVICE}.${CONTROL}.txt
#		echo ${OUT}
#		Here you could change status of the port with something like
#		if [ ${OUT} -eq "0" ]
#		then
#			echo "0" > /sys/class/gpio/gpio3/value
#		else
#			echo "1" > /sys/class/gpio/gpio3/value
#		fi
	else
#		echo error
		sleep 10
	fi
done
