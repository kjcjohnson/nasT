# This Makefile is used to spawn the sever process as well as create the
# handler and db scripts from templates. 

# Where to Listen
PORT = 8080
OUTPIPE = out_pipe

listen:
	while true; do cat $OUTPIPE | nc -l $PORT | ./routes.sh; done

