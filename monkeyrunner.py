#!/usr/bin/python
import sys
from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice, MonkeyImage
device = MonkeyRunner.waitForConnection()
device.installPackage('./Ppdaba_dev.apk')
device.startActivity(component='com.daba.pp/.activity.SplashActivity')
result = device.takeSnapshot()
result.writeToFile('./splash.png','png')
