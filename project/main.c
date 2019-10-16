#include <stdio.h>
#include "serial.h"
#include "clock.h"
#include "mimon.h"
#include "weather.h"

#include <unistd.h>

int main(int argc, const char *argv[])
{
	int fd = serial_openclock(NULL, 0);

	while (true)
	{
		int c = serial_readclock(fd);
		if (c > 0)
		{
			printf("Received: %c(%d)\n", c, c);
			if (c == 'B')
			{
				int weather_value = weather_query();
				serialPrintf(fd, "Weather\n");
				serialPrintf(fd, "Current :%2d\n", weather_value);
				sleep(3);
			}
			else if (c == 'C')
			{
				int mimon_value = mimon_query();
				serialPrintf(fd, "Mimon\n");
				serialPrintf(fd, "Current :%2d\n", mimon_value);
				sleep(3);
			}
			else
			{
				clock_config_timezone(fd, c);
			}
		}
		clock_print_time(fd);
		sleep(1);
	}

	serial_closeclock(fd);

	return 0;
}

