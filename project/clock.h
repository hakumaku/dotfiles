#ifndef CLOCK_H
#define CLOCK_H

#define true	1
#define false	0

#define TIMEZONE_SEOUL		0
#define TIMEZONE_TOKYO		1
#define TIMEZONE_BEIJING	2
#define TIMEZONE_NEWYORK	3
#define TIMEZONE_VANCOUVER	4
#define TIMEZONE_LONDON		5

#define UTC_SEOUL		(9)
#define UTC_TOKYO		UTC_SEOUL
#define UTC_BEIJING		(8)
#define UTC_NEWYORK		(-4)
#define UTC_VANCOUVER	(-7)
#define UTC_LONDON		(1)

void clock_print_time(int clock);
void clock_config_timezone(int clock, char option);

#endif /* CLOCK_H */
