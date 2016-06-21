#! /bin/bash
function mqtt {
# You should get some data from some sensors!
#	ROOMTEMP=$( cat ambient_temp.txt)
#	TEMPERATURA=$( cat cpu_temp.txt )
#	SDA=$( cat sda_temp.txt )
#	SDB=$( cat sdb_temp.txt )
#	SDC=$( cat sdc_temp.txt )
#	SDD=$( cat mrtg/sdd_temp.txt )
	ROOMTEMP=21
	TEMPERATURA=30
	SDA=40
	SDB=35
	SDC=30
	SDD=45
	
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager -m "${DEVICE}"
#			echo ${OUT}
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":0,\"page\":\"Sala server\",\"pageId\":1,\"descr\":\"Temperatura stanza\",\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}0\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left\",\"class3\":\"assertive\",\"style3\":\"font-size:40px;font-weight:bold;float:right\",\"status\":\"${ROOMTEMP} °C\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":1,\"page\":\"Sala server\",\"pageId\":1,\"descr\":\"Temperatura CPU\",\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}1\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left\",\"class3\":\"assertive\",\"style3\":\"font-size:40px;font-weight:bold;float:right\",\"status\":\"${TEMPERATURA} °C\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":2,\"page\":\"Sala server\",\"pageId\":1,\"descr\":\"Temperatura SDA\",\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}2\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left\",\"class3\":\"assertive\",\"style3\":\"font-size:40px;font-weight:bold;float:right\",\"status\":\"${SDA} °C\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":3,\"page\":\"Sala server\",\"pageId\":1,\"descr\":\"Temperatura SDB\",\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}3\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left\",\"class3\":\"assertive\",\"style3\":\"font-size:40px;font-weight:bold;float:right\",\"status\":\"${SDB} °C\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":4,\"page\":\"Sala server\",\"pageId\":1,\"descr\":\"Temperatura SDC\",\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}4\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left\",\"class3\":\"assertive\",\"style3\":\"font-size:40px;font-weight:bold;float:right\",\"status\":\"${SDC} °C\"}"
	mosquitto_pub -u ${USER} -P ${PASSWORD} -t /IoTmanager/${DEVICE}/config -m "{\"id\":5,\"page\":\"Sala server\",\"pageId\":1,\"descr\":\"Temperatura SDD\",\"widget\":\"anydata\",\"topic\":\"/IoTmanager/${DEVICE}/${CONTROL}5\",\"class1\":\"item no-border\",\"style2\":\"font-size:16px;float:left\",\"class3\":\"assertive\",\"style3\":\"font-size:40px;font-weight:bold;float:right\",\"status\":\"${SDD} °C\"}"
	
}

DEVICE=serverstatus
CONTROL=termomether
USER=user
PASSWORD=password
mqtt
while true
do
	IN=$(mosquitto_sub -1 -t /IoTmanager)
	STATUS=${?}
#	echo ${STATUS}
	if [ ${STATUS} == "0" ]
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
