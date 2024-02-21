#!/bin/ksh
SAVE=/var/lib/jenkins/url/url.txt
FILE=test/integration/todoApiTest.py
URL="$(egrep Value url_output.txt)"
val=`echo $?`
if [ $val -ne 0 ] ; then
        URL=`cat $SAVE`
        A=`egrep -ia ^BASE_URL test/integration/todoApiTest.py`
        sed -i "s|${A}|BASE_URL = \"${URL}\"|g" $FILE
        exit 0
else
        URL="$(egrep Value url_output.txt|tr -s " "|cut -f2 -d" "|grep todos|egrep -v id|uniq|sed 's/\/$//g'|uniq|sed 's/\/todos//g')"
        A=`egrep -ia ^BASE_URL test/integration/todoApiTest.py`
        sed -i "s|${A}|BASE_URL = \"${URL}\"|g" $FILE
        echo $URL > $SAVE
        exit 0
fi
