# This Makefile is used to spawn the sever process as well as create the
# handler and db scripts from templates. 

# Where to Listen
PORT = 8080
OUTPIPE = out_pipe

.PHONY: db handler

listen:
	@touch $(OUTPIPE)
	@while true; do cat $(OUTPIPE) | nc -l $(PORT) | ./routes.sh; done

db:
	@echo "Enter the name of the table you would like to make: "
	@./nTemplates/make_db.sh

