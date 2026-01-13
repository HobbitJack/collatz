#define _POSIX_C_SOURCE 202405L

#include <libgen.h>
#include <stdio.h>
#include <unistd.h>

#include "collatz.g.h"
#include "collatz.l.h"

static char *progname;
static int status;

static struct gengetopt_args_info args;

int
collatz(unsigned long long int target)
{
	int iter = 0;

	while (target != 1)
	{
		if (target % 2)
			target = (3 * target + 1);
		else
			target /= 2;
		if (args.verbose_given)
			printf("%lld\n", target);
		iter++;
	}

	return iter;
}

int
get_num(char *num, unsigned long long int *n)
{
        char *buf;
	int len;

        errno = 0;
        if (!((*n = strtoll(num, &buf, 0)) || (buf[0] != '\0')))
        {
                if (!args.silent_given)
                        fprintf(stderr, "%s: %s: Bad argument\n", progname, num);
                return 1;
        }
        else if (errno)
        {
                if (!args.silent_given)
                {
                        len = strlen(progname) + strlen(num) + 3;
                        buf = calloc(len, sizeof(char));
                        snprintf(buf, len, "%s: %s", progname, num);
                        perror(buf);
                }
                return 1;
        }

        return 0;
}

int
main(int argc, char *argv[])
{
	int i, iter;
	unsigned long long int target;
	
	progname = basename(argv[0]);

	if (ggo(argc, argv, &args))
		return 1;

	if (args.help_given)
	{
		ggo_print_help();
		return 0;
	}
	if (args.version_given)
	{
		ggo_print_version();
		return 0;
	}
	
	if (args.inputs_num)
	{
		for (i=0; i<args.inputs_num; i++)
		{
			if (get_num(args.inputs[i], &target))
			{
				status = 1;
				continue;
			}

			if (!args.quiet_given)
				printf("%lld%c", target, args.verbose_given ? '\n' : ':');
				
			iter = collatz(target);
			if (!args.verbose_given)
			{
				if (!args.quiet_given)
					putchar(' ');
				printf("%d\n", iter);
			}
		}
	}
	else
	{
		while (yylex() != -1)
		{
			if (get_num(yytext, &target))
			{
				status = 1;
				continue;
			}

			if (!args.quiet_given)
				printf("%lld%c", target, args.verbose_given ? '\n' : ':');
				
			iter = collatz(target);
			if (!args.verbose_given)
			{
				if (!args.quiet_given)
					putchar(' ');
				printf("%d\n", iter);
			}
		}
	}

	return args.loose_exit_status_given ? 0 : status;
}
