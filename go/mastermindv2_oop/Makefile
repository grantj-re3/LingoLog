# See https://makefiletutorial.com
# and https://crashlaker.github.io/linux/2020/04/24/writing_bash_inside_makefile.html

TARGET_EXEC=mastermindv2
OUT_FNAME=$(TARGET_EXEC).txt

SRC_DIRS := ./game
SRCS := $(shell find $(SRC_DIRS) -name '*.go')

$(TARGET_EXEC): $(SRCS)
	go build -o $(TARGET_EXEC) .

build:	$(TARGET_EXEC)

fmt:
	gofmt -l -w .

clean:
	go clean
	rm -f $(OUT_FNAME)

tar:	clean
	set -e; \
	dir=`pwd |sed 's:^.*/::'`; \
	dtime=`date +%y%m%d-%H%M%S`; \
	cd ..; \
	cmd="tar cvzf \"$${dir}-$${dtime}.tgz\"  \"$${dir}\""; \
	echo "COMMAND: $$cmd"; \
	eval $${cmd}

backup: tar

##############################################################################
# Various run scenarios
##############################################################################
run:	build
	./$(TARGET_EXEC)

run-c:	build
	./$(TARGET_EXEC) -c

run-e:	build
	./$(TARGET_EXEC) -e

run-g:	build
	./$(TARGET_EXEC) -g 998877-4-5-t

# The exe with -h switch exits with error code 2.
# Prevent make from seeing exit code 2 with: || true
run-h:	build
	./$(TARGET_EXEC) -h || true

run-r:	build
	./$(TARGET_EXEC) -r

