#include "mimon.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int mimon_query(void)
{
	size_t n = strlen(AIRKOREA_URL);
	size_t m = strlen(GANGSEO_URL);
	char *cmd = malloc(sizeof(char)*(n+m+100));
	size_t end = sprintf(cmd, "wget -O %s \"%s%s\"",
			MIMON_WGETLOG, AIRKOREA_URL, GANGSEO_URL);
	cmd[end] = '\0';

	int value = -1;
	int wget_exitcode = system(cmd);
	if (wget_exitcode == 0)
	{
		FILE *sedp = popen(
			"sed -ne 's/.*>\\([0-9]*\\)㎍\\/㎥.*/\\1/p' ./"MIMON_WGETLOG, "r");
		fscanf(sedp, "%d", &value);
		fprintf(stdout, "Mimon from airkorea: %d\n", value);
		pclose(sedp);
	}
	free(cmd);

	return value;
}

