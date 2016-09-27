# RaspyIot
Raspberry Pi Iot Manager bash samples with mosquitto mqtt protocol, actually thei do nothing but is really easy hange Raspberry GPIO port status.

Change execute bit with

chmod a+x *.sh

to all shell file, and execute __START_DEAMONS.sh

If you want use GPIO you must setup them before run script!

You need mosquitto client commands, tested with mosquitto 1.4.10 commands, previous release could not work, they elimnate -1 parameter and insert the new -C parameter.
