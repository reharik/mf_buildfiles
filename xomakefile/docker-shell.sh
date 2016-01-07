#!/usr/bin/env bash

TEST_MODE=test
JENKINSBUILD_MODE=jenkinsbuild
MODE=$TEST_MODE

#parse argument list
while [[ $# > 0 ]]
do
	ARG=$1

	case $ARG in
	-t|--test) MODE=$TEST_MODE ;;
	-j|--jenkintest) MODE=JENKINSBUILD_MODE ;;
	esac

	shift
done

#set pwd
cd /opt/app/current

#echo out environment variables we care about
echo APPLICATION_VARIABLES
echo NODE_ENV=$NODE_ENV

#check for port on pg box
waitOnResources()
{
	while ! nc -z pgbox 5432; do
		sleep 1
		echo WAITING FOR pgbox:5432
	done

	#check for yellow status when es cluster consist of only a single box
	while [[ "yellow" != $(curl -s "esbox:9200/_cat/health?h=status" | tr -d '[:space:]') ]] ; do
		sleep 1
		echo WAITING FOR esbox:9200
	done
}

#execution based on argument
if [ $MODE == $TEST_MODE ]; then
	waitOnResources
	echo RUNNING TEST
	make test
elif [ $MODE == JENKINSBUILD_MODE ]; then
	waitOnResources
	echo RUNINNG JENKINs BUILD
	make jenkins-build
fi
