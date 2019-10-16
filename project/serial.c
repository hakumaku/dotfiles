#include "serial.h"
#include <stdio.h>

#define true		1
#define false		0

int serial_openclock(const char *dev, unsigned brate)
{
	/* If not given, try default configs. */
	char *device = dev ? (char *)dev : SERIAL_DEVICE;
	unsigned board_rate = brate ? brate : SERIAL_BOARD_RATE;

	fprintf(stdout, "Opening device: %s at %u\n",
			device, board_rate);

	int fd = serialOpen(device, board_rate);
	if (fd < 0)
	{
		fprintf(stderr,
			"Opening %s failed.\nCheck USB cable.\n", device);

		return -1;
	}

	return fd;
}

void serial_closeclock(int clock)
{
	serialClose(clock);
}

int serial_readclock(int clock)
{
	int nchars = serialDataAvail(clock);
	return nchars > 0 ? serialGetchar(clock) : nchars;
}

