#!/usr/bin/env bash
#
# Conductor docker manager
#

# function for warning($1 = text)
function boldtext() {
  echo -e `tput bold`"$1"`tput sgr0` >&2
}

DOCKER_NAME="conductor"
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

#echo "Bash version ${BASH_VERSION}..."

build() {
    boldtext "Building docker container"
    time docker build -t conductor .
}

install_docker() {
    sudo apt -y update
    sudo apt -y install curl git
    curl https://get.docker.com | sh
    if [ "$EUID" -ne 0 ]; then 
        echo "Adding user $(whoami) to docker group"
        sudo usermod -aG docker $(whoami)
        echo "IMPORTANT: Please re-login (or close and re-connect SSH) for docker to function correctly"
    fi
}

start() {
	[[ ! -z $(docker ps -a | grep $DOCKER_NAME) ]] && boldtext "Container already started"  ||  ( boldtext "Starting container..." && docker run -h "conductor-container" -itd --name $DOCKER_NAME conductor )
}

stop() {
    [[ ! -z $(docker ps -a | grep $DOCKER_NAME) ]] && ( docker stop $DOCKER_NAME ; docker rm $DOCKER_NAME ; boldtext "Stopping container..." ) || boldtext "Container not running"
}

enter() {
    [[ ! -z $(docker ps -a | grep $DOCKER_NAME) ]] && ( docker start $DOCKER_NAME && docker exec -it $DOCKER_NAME bash ) || boldtext "Container not running"
}

logs() {
    echo "Monitoring the logs: "
    docker logs --tail=30 -f $DOCKER_NAME
}

help() {
    echo "Usage: $0 COMMAND"
    echo
    echo "Commands: "
	echo "    install_docker - install docker"
    echo "    start - starts container"
    echo "    stop - stops container"
    echo "    build - build container (from docker file)"
    echo "    logs - monitor the conductor logs"
    echo "    enter - enter a bash session in the container"
    echo
    exit
}

case $1 in
    build)
        build
        ;;
    install_docker)
        install_docker
        ;;
    start)
        start
        ;;
    stop)
        stop
        ;;
    enter)
        enter
        ;;
    *)
        echo "Invalid cmd"
        help
        ;;
esac
