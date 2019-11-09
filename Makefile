
_SYS := $(shell uname 2>/dev/null || echo Unknown)
_SYS := $(patsubst MSYS%,MSYS,$(_SYS))
_SYS := $(patsubst MINGW%,MinGW,$(_SYS))

ifneq ($(filter $(_SYS),MSYS MinGW),)
WIN32 := 1
endif

ifdef WIN32
#SOEXT:=.dll
SOEXT:=.so
EXEXT:=.exe
else
SOEXT:=.so
EXEXT:=
endif

TARGET:=
TARGET+=cplugtest$(EXEXT)
TARGET+=plugin/plugin$(SOEXT)

ifdef WIN32
else
LDLIBS+=-ldl
endif

V:=v

all: $(TARGET)

plugin/plugin$(SOEXT): plugin/plugin.v
	$(V) -shared $^

%.exe: %.o
	$(CC) -o $@ $^ $(LDLIBS)

check: all
	@echo "============="
	@echo PLUGTEST C
	@echo "============="
	./cplugtest$(EXEXT)
	@echo "============="
	@echo PLUGTEST V
	@echo "============="
	$(V) run vplugtest.v
	@echo "============="
	@echo IMPTEST V
	@echo "============="
	$(V) run vimptest.v

clean:
	$(RM) $(TARGET) vimptest$(EXEXT) vplugtest$(EXEXT)
