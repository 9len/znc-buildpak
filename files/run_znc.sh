./znc/bin/znc -f &
export ZNCPID=$!

./ngrok -authtoken $NGROK_API_KEY -log=stdout -config ngrok.conf start znc &
export NGROKPID=$!

echo "waiting for znc ($ZNCPID) or ngrok ($NGROKPID) to exit......."

while [ -e /proc/$ZNCPID -a -e /proc/$NGROKPID ]
do
    echo "znc ($ZNCPID) is running"
    echo "ngrok ($NGROKPID) is running"
    sleep 600
done

kill $NGROKPID
kill $ZNCPID
