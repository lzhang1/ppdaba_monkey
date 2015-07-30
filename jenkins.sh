#!/bin/bash
export ANDROID_HOME=/home/rayzhang/adt/sdk
export PATH=ANDROID_HOME/platform-tools:PATH  
export PATH=ANDROID_HOME/tools:PATH
export PATH=/home/rayzhang/genymotion/:PATH

# Get run level
run_level=" -v"
case {LEVEL} in
	0) 
		run_level=" -v";;
	1)
		run_level=" -v -v";;
	2)
    run_level=" -v -v -v";;
  *)
    run_level=" -v";;
esac

# Get Pct event
pct_cmd=""
if [ {PCTTOUCH} -ne 0 ];then
	pct_cmd="{pct_cmd} --pct-touch {PCTTOUCH}"
fi
if [ {PCTMOTION} -ne 0 ];then
	pct_cmd="{pct_cmd} --pct-motion {PCTMOTION}"
fi
if [ {PCTTRACKBALL} -ne 0 ];then
	pct_cmd="{pct_cmd} --pct-trackball {PCTTRACKBALL}"
fi
if [ {PCTNAV} -ne 0 ];then
	pct_cmd="{pct_cmd} --pct-nav {PCTNAV}"
fi
if [ {PCTSYSKEYS} -ne 0 ];then
	pct_cmd="{pct_cmd} --pct-syskeys {PCTSYSKEYS}"
fi
if [ {PCTAPPSWITCH} -ne 0 ];then
	pct_cmd="{pct_cmd} --pct-appswitch {PCTAPPSWITCH}"
fi
if [ {PCTANYEVENT} -ne 0 ];then
	pct_cmd="{pct_cmd} --pct-anyevent {PCTANYEVENT}"
fi

#Get seed
seed=" -s {SEED}"

#Get throttle
throttle=" --throttle {THROTTLE}"

#Get eventcount
event_total={EVENT:=100}

#Get ignore opt
ignore_opt=""
if {IGNORE_TIMEOUTS};then
	ignore_opt=" --ignore-timeouts"
fi
if {IGNORE_SECURITY_EXCEPTIONS};then
 	ignore_opt="{ignore_opt} --ignore-security-exceptions"
fi
if {IGNORE_CRASHES};then
	ignore_opt="{ignore_opt} --ignore-crashes"
fi
if {KILL_PROCESS_AFTER_ERROR};then
	ignore_opt="{ignore_opt} --kill-process-after-error"
fi

#Get emulator

emu_list=`adb devices|grep '\<device\>'|awk '{print 1}'`
for emu in {emu_list};
do
	adb -s emu shell monkey -p {PACKAGE} {pct_cmd} {ignore_opt} {seed} {throttle} {run_level} {event_total}
done
