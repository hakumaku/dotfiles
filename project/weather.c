#include "weather.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int weather_query(void)
{
	size_t n = strlen(WEATHERI_URL);
	char *cmd = malloc(sizeof(char)*(n+100));
	size_t end = sprintf(cmd, "wget -O %s \"%s\"",
			WEATHER_WGETLOG, WEATHERI_URL);
	cmd[end] = '\0';

	int value = -1;
	int wget_exitcode = system(cmd);
	if (wget_exitcode == 0)
	{
		FILE *sedp = popen(". /home/pi/project/parse.sh", "r");
		fscanf(sedp, "\"todaytemp\">%d", &value);
		fprintf(stdout, "Weather from naver: %d\n", value);
		pclose(sedp);
	}
	free(cmd);

	return value;

}
