#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <wordexp.h>

char* Concat(char* str1, char* str2);
int SplitString(char* str, char* delim, char* array[]);
char* ReadFile(char *filename);

int main(int argc, char *argv[])
{
	const int lineCount = 3;
	char *lines[lineCount];
	char *parsedData[lineCount][2];
	wordexp_t exp_res;

	wordexp("~/dotfiles/scripts/scripts", &exp_res, 0);
	char *scriptsFile = ReadFile(exp_res.we_wordv[0]);

	printf("Got scripts file contents\n%s", scriptsFile);
	SplitString(scriptsFile, "\n", lines);

	for (int i = 0; i < lineCount; i++) {
		SplitString(lines[i], ";", parsedData[i]);
	}


	char *coal = malloc(strlen(parsedData[0][1]) + 1);
	char *buf1;
	char *buf2;

	strcpy(coal, parsedData[0][1]);

	for (int i = 1; i < lineCount; i++)
	{
		buf1 = Concat("\n", parsedData[i][1]);
		buf2 = Concat(coal, buf1);
		free(coal);
		free(buf1);
		coal = buf2;
	}

	printf("%s\n", coal);

	buf1 = Concat("echo \"", coal);
	char *command = Concat(buf1, "\" | rofi -dmenu -p \"Scripts\"");
	printf("%s\n", command);

	int status = system(command);
	
	free(scriptsFile);
	free(coal);
	free(buf1);
	free(command);
	wordfree(&exp_res);
	return 0;
}

char* Concat(char* str1, char* str2)
{
	char* buffer = malloc(strlen(str1) + strlen(str2) + 1);

	strcpy(buffer, str1);
	strcat(buffer, str2);

	return buffer;
}

int SplitString(char* str, char* delim, char* array[])
{
	char *token = strtok(str, delim);
	int i = 0;

	while (token != NULL)
	{
		array[i++] = token;
		token = strtok(NULL, delim);
	}
	free(token);
	return 0;
}

char* ReadFile(char *filename)
{
	FILE *handler = fopen(filename, "r");
	int string_size, read_size;
	char *buffer = NULL;
	
	if (handler)
	{
		fseek(handler, 0, SEEK_END);
		string_size = ftell(handler);
		rewind(handler);

		buffer = (char*) malloc(sizeof(char) * (string_size + 1));
		read_size = fread(buffer, sizeof(char), string_size, handler);

		buffer[string_size] = (char) 0;

		if (string_size != read_size)
		{
			free(buffer);
			buffer = NULL;
		}
		fclose(handler);
	}
	return buffer;
}
