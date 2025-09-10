MODNAME = mod_audio_fork.so
SRC = mod_audio_fork.c audio_pipe.cpp lws_glue.cpp parser.cpp
CXX = g++
CXXFLAGS = -fPIC -Wall -Wno-unused-variable -Wno-parentheses -Wno-unused-but-set-variable -Wno-reorder -g \
    `pkg-config --cflags freeswitch` \
    `pkg-config --cflags libwebsockets`
LDFLAGS = \
    `pkg-config --libs freeswitch` \
    `pkg-config --libs libwebsockets`

all: $(MODNAME)

$(MODNAME): $(SRC)
	$(CXX) -shared -o $@ $(SRC) $(CXXFLAGS) $(LDFLAGS)

install: $(MODNAME)
	install -d /usr/lib/freeswitch/mod
	install $(MODNAME) /usr/lib/freeswitch/mod

clean:
	rm -f $(MODNAME) *.o
