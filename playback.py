#!/usr/bin/python
import sys
from com.android.monkeyrunner import MonkeyRunner


CMD_MAP={
    'TOUCH':lambda dev,arg: dev.touch(**arg),
    'DRAG':lambda dev,arg: dev.drag(**arg),
    'PRESS':lambda dev,arg: dev.press(**arg),
    'TYPE':lambda dev,arg: dev.type(**arg),
    'WAIT':lambda dev,arg: MonkeyRunner.sleep(**arg)
}

def process_file(fp,device):
    for line in fp:
        (cmd,rest)=line.split('|')
        try:
            print cmd,"---",rest
            rest=eval(rest)
            print cmd,"---",rest
        except:
            print 'unabletoparseoptions'
            continue

        if cmd not in CMD_MAP:
            print 'unknowncommand:' + cmd
            continue

        CMD_MAP[cmd](device,rest)

def main():
    file = sys.argv[1]
    fp = open(file,'r')
    device = MonkeyRunner.waitForConnection()
    process_file(fp,device)
    fp.close();


if __name__=='__main__':
    main()
