#!/bin/bash

#se asigna la cantidad de procesos
CANPROCESOS=$(ps ax | tail -n +2 | wc -l)


#Se asignan la cantidad total de memoria y la cantidad libre y depues se saca el porcentaje
CANMEMORIALIBRE=$(vmstat --stats | grep 'memoria libre' | awk '{print $1}')
CANTOTALMEMORIA=$(vmstat --stats | grep 'memoria total' | awk '{print $1}')

PORCENTAJEMEMORIA=$((CANMEMORIALIBRE*100/CANTOTALMEMORIA))

#Se resta 100 menos el procentaje de uso para hallar el porcentaje libre
PORCENTAJEDISCO=$( df | grep root | awk '{print $5}' | sed -e 's/.$// ')


#se envian los datos
curl --silent --request POST --header "X-THINGSPEAKAPIKEY:P0U8U6LV3U2O47B9" --data "field1=${CANPROCESOS}&field2=${PORCENTAJEMEMORIA}&field3=$((100-PORCENTAJEDISCO))" http://api.thingspeak.com/update
