#include "serial.h"
#include "clock.h"
#include <stdio.h>
#include <time.h>
#include <unistd.h>

#define convert_time(utc, v) (utc->tm_hour = ((utc->tm_hour + 24 + v) % 24))
#define EPOCH	1900

static int current_timezone = 0;
static time_t ctm;
static struct tm *utctime = NULL;

void clock_print_time(int clock)
{
	time(&ctm);
	utctime = gmtime(&ctm);

	switch (current_timezone)
	{
		/* Korea */
		case TIMEZONE_SEOUL:
			convert_time(utctime, UTC_SEOUL);
			break;

		/* Japan */
		case TIMEZONE_TOKYO:
			convert_time(utctime, UTC_TOKYO);
			break;

		/* China */
		case TIMEZONE_BEIJING:
			convert_time(utctime, UTC_BEIJING);
			break;

		/* USA  */
		case TIMEZONE_NEWYORK:
			convert_time(utctime, UTC_NEWYORK);
			break;

		/* Canada */
		case TIMEZONE_VANCOUVER:
			convert_time(utctime, UTC_VANCOUVER);
			break;

		/* England */
		case TIMEZONE_LONDON:
			convert_time(utctime, UTC_LONDON);
			break;

		default:
			break;
	}

	serialPrintf(clock, "%4u-%02u-%02u\n",
		utctime->tm_year + EPOCH, utctime->tm_mon + 1, utctime->tm_mday);
	serialPrintf(clock, "%02u:%02u:%02u\n",
		utctime->tm_hour, utctime->tm_min, utctime->tm_sec);
}

void clock_config_timezone(int clock, char option)
{
	switch (option)
	{
		case '0':
			printf("Seoul\n");
			current_timezone = TIMEZONE_SEOUL;
			serialPrintf(clock, "Seoul\n");
			break;

		case '1':
			printf("Japan\n");
			current_timezone = TIMEZONE_TOKYO;
			serialPrintf(clock, "Tokyo\n");
			break;

		case '2':
			printf("Beijing\n");
			current_timezone = TIMEZONE_BEIJING;
			serialPrintf(clock, "Beijing\n");
			break;

		case '3':
			printf("Newyork\n");
			current_timezone = TIMEZONE_NEWYORK;
			serialPrintf(clock, "Newyork\n");
			break;

		case '4':
			printf("Vancouver\n");
			current_timezone = TIMEZONE_VANCOUVER;
			serialPrintf(clock, "Vancouver\n");
			break;

		case '5':
			printf("London\n");
			current_timezone = TIMEZONE_LONDON;
			serialPrintf(clock, "London\n");
			break;

		default:
			break;
	}
	serialPrintf(clock, "Modified.\n");
	sleep(1);
}
