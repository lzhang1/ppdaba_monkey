#!/bin/bash

vm_list=$*
for vm in ${vm_list};
do
	/usr/bin/nohup player --vm-name $vm &
done

sleep 30
emu_list=`adb devices|grep '\<device\>'|awk '{print $1}'`
for emu in ${emu_list};
do
	adb -s $emu install ./Ppdaba_dev.apk
done
