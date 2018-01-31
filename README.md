# Random Stuff

These are scripts probably useless for anyone but me but just in case and to keep track, I'll leave them here.
They're also awfully written and missing of security checks: they're written as root and root knows what's doing.
If there's an help, it's also quite rude because I'm [bofh](https://en.wikipedia.org/wiki/Bastard_Operator_From_Hell) inside.

## logrotate.sh
Simple logrotate, launch it with the name of the logs, wildcard will be expanded.
> Ex: 
> logrotate.sh boring.{log,err}
By default it'll keep the last 10 rotated files plus the working copy


## create_logs_test.sh
It'll create dummuy files to test the logrotate.sh and it's expecting a parameters
> Ex:
> create_logs_test.sh boring
It'll create boring.out, boring.err and 2 rotations (boring.out.1, boring.out.2, etc)


## My Gist
[Gist](https://gist.github.com/jtheo) that I should probably delete
