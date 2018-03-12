# Random Stuff

These are scripts probably useless for anyone but me but just in case and to keep track; I'll leave them here. They're also awfully written and missing of security checks: they're written as root and root know what's doing. If there's a help, it's also quite rude because I'm [bofh](https://en.wikipedia.org/wiki/Bastard_Operator_From_Hell) inside. 

## logrotate.sh
Simple logrotate, launch it with the name of the logs, wildcards will be expanded.
> Ex: 

> logrotate.sh boring.{log,err}
By default it'll keep the last 10 rotated files plus the working copy, there's no support for policies on rotating (time, size, whatever) yet


## create_logs_test.sh
It creates dummy files to test the logrotate.sh and it's expecting a parameters
> Ex:

> create_logs_test.sh boring

It'll create boring.out, boring.err and 2 rotations (boring.out.1, boring.out.2, etc)

## aws_ec2_info
It takes the json coming from "aws ec2 describe-instances", and it produces a CSV (a nested one) on the standard output like this:
> server-1|i-12345abcdefa511234|running|10.11.12.13 |Name server-cluster-1,Role server, Master True, ...

The fields are:
>  Name   |  instance_id       | state |  priv_ip   | Tags

(I used it in combination with ansible and terraform, sigh)
*It require [jq](https://stedolan.github.io/jq/)* to parse json files.

## git-merge-dry-run
A simple script to do a git merge --dry-run like with a couple of checks, it can show a git diff or not
> Ex:

> git-merge-dry-run random_stuff_1 verbose

## aws_cw_logs
  Usage: ./aws_cw_logs [-g <log_group_name>] [-s <log_group_name> <stream_name>] [-l <log_group_name> ] [-h]

  -g <log_group_name> List the Group_log\'s streams
    ex:
       ./aws_cw_logs -g dev-app-logs
    2018-02-15T11:46:16Z app/app/c0df45ec-ab89-4a69-80d3-95341eb5f7c7
    [...]

  -s <log_group_name> <stream_name> Download the stream from the log group
    ex:
       ./aws_cw_logs -s dev-app-logs app/app/c0df45ec-ab89-4a69-80d3-95341eb5f7c7
       will create the file ./streams/app/app/c0df45ec-ab89-4a69-80d3-95341eb5f7c7/dev-app-logs.log

  -l  <log_group_name> It will download the last stream from the log group.
    ex:
       ./aws_cw_logs -l dev-app-logs



## My Gist
[Gist](https://gist.github.com/jtheo) that I should probably delete
