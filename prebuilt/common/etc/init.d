#!/system/bin/sh
# call userinit.sh and/or userinit.d/* scripts if present in /data/local

if [ -e /data/local/userinit.sh ];
then
   log -p i -t userinit "Executing /data/local/userinit.sh";
   logwrapper /system/bin/sh /data/local/userinit.sh;
fi;

if [ -d /data/local/userinit.d ];
then
   logwrapper busybox run-parts /data/local/userinit.d;
fi;
