./znc/bin/znc -f &
export ZNCPID=$!

./ngrok -authtoken $NGROK_API_KEY -log=stdout -config ngrok.conf start znc &
export NGROKPID=$!

echo "waiting for znc ($ZNCPID) or ngrok ($NGROKPID) to exit......."

i=0
while [ -e /proc/$ZNCPID -a -e /proc/$NGROKPID ]
do
    if (( i % 60 == 0 )); then
        echo "znc ($ZNCPID) is running"
        echo "ngrok ($NGROKPID) is running"
    fi
    let "i += 1"
    
    sleep 1
done

echo "znc ($ZNCPID) or ngrok ($NGROKPID) quit. killing PIDs"

kill $NGROKPID
kill $ZNCPID
