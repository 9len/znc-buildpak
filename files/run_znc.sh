./znc/bin/znc -f &
export ZNCPID=$!
if [ -n "$NGROK_SUBDOMAIN" ]; then
  SUBDOMAIN_FLAG="-subdomain $NGROK_SUBDOMAIN"
fi
./ngrok -authtoken $NGROK_API_KEY -log=stdout $SUBDOMAIN_FLAG --config ngrok.conf start znc &
export NGROKPID=$!
echo "waiting for znc ($ZNCPID) to exit......."
while [ -e /proc/$ZNCPID ]
do
    echo "$ZNCPID is running"
    sleep 600
done

kill $NGROKPID
kill $ZNCPID
