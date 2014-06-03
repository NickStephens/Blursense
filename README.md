Blursense
=========
Blursense depends on Sensibility Testbed: github.com/yyzhuang/sensibility

0. run adb to connect to Android console
install sl4a (scripting layer for seattle testbed)
clone yyzhuang repo on github to repy_V2/seattlelib/

1. git clone https://github.com/haonguyen14/Blursense/
2. copy Misc/exports.sh to /sdcard/data/tmp/
3. run exports.sh
4. copy all .repy files from /Misc and XMLRPCServer/ to repy_v2/Seattlelib
the functions in Misc/ are needed because repy_V2 doesn't have waitforconn()
5. invoke python repy.py blurserver.repy

** need to write server that initializes BlurServer object **

how to redirect sensor request to XMLRPCserver

I. subclass SensorManager class. src is 
on github, gitorious.org
look for sensor_data_init() inject code to XMLRPCServer before that.
in static private class SensorThread

II. change every installed App (from apk file) and add call to XMLRPCServer whenever
sensor data is requested.
