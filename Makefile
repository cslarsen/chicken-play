TARGETS = test.db html5/html5.so

all: $(TARGETS) check

check: setup
	csi -bq -I html5/ main.scm

setup: html5/html5.so test.db

html5/html5.so: html5/html5.scm
	cd html5; chicken-install

test.db: setup.sql
	sqlite3 test.db < setup.sql
clean:
	rm -f test.db 
	cd html5; rm -f html5.o html5.so html5.import.so html5.import.scm
