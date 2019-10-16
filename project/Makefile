CC=gcc
CFLAGS=-O2
LDLIBS=-lwiringPi

TARGET=program
OBJS=main.o clock.o serial.o mimon.o weather.o

all: $(TARGET)

weather.o: weather.c weather.h
	$(CC) -c $^ $(CFLAGS)

mimon.o: mimon.c mimon.h
	$(CC) -c $^ $(CFLAGS)

clock.o: clock.c clock.h
	$(CC) -c $^ $(CFLAGS)

serial.o: serial.c serial.h
	$(CC) -c $^ $(CFLAGS) $(LDLIBS)

main.o: main.c
	$(CC) -c $^ $(CFLAGS) $(LDLIBS)

$(TARGET): $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS) $(LDLIBS)

clean:
	rm *.gch
	rm *.o

