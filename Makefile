CC := g++
CPPFLAGS := -Wno-write-strings
BTREE_SRC := btree.cpp
BTREAD_SRC := btread.cpp
BTMAKE_SRC := btmake.cpp
SRCS := $(BTREE_SRC) $(BTREAD_SRC) $(BTMAKE_SRC)

BTREE_OBJ := $(patsubst %.cpp,%.o,$(BTREE_SRC)) 
BTREAD_OBJ := $(patsubst %.cpp,%.o,$(BTREAD_SRC)) 
BTMAKE_OBJ := $(patsubst %.cpp,%.o,$(BTMAKE_SRC)) 
OBJS := $(BTREE_OBJ) $(BTREAD_OBJ) $(BTMAKE_OBJ)

DEPS := $(patsubst %.cpp,%.d,$(SRCS)) 

EXES := btread btmake

.PHONY: deps $(EXES)

all: deps $(EXES)

btread:$(BTREE_OBJ) $(BTREAD_OBJ)
	$(CC) $^ -o $@ 

btmake:$(BTREE_OBJ) $(BTMAKE_OBJ)
	$(CC) $^ -o $@ 

deps:$(DEPS)

%.d:%.cpp
	$(CC) -MM $< > $@

%.o:%.cpp
	$(CC) -c $(CPPFLAGS) $< -o $@

-include $(DEPS)

clean:
	rm -f *.o *.dat $(EXES) *.d

