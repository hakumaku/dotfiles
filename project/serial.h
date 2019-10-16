#ifndef SERIAL_H
#define SERIAL_H
#include <wiringSerial.h>

#define SERIAL_BOARD_RATE	9600U
#define SERIAL_DEVICE		"/dev/ttyACM0"

int serial_openclock(const char *dev, unsigned brate);
void serial_closeclock(int clock);
int serial_readclock(int clock);

#endif /* SERIAL_H */
