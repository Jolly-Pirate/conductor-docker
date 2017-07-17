# Conductor docker
This is a docker container setup for https://github.com/Netherdrake/conductor
  
# Install
`git clone https://github.com/Jolly-Pirate/conductor-docker.git`

`cd conductor-docker`

`chmod +x run.sh`

If you don't have docker installed, do it with

`./run.sh install_docker`

Build the container

`./run.sh build`


# Usage
Starting the container: `./run.sh start`

Entering the container: `./run.sh enter`

Stopping and removing the container: `./run.sh stop`

When you enter the container, you can type `exit`. This will leave it running of course.

`./run.sh enter` will re-enter it.

After entering the container, run `conductor`.

You can find detailed usages at the original link at https://github.com/Netherdrake/conductor.

# NOTE
If you stop the container, you will lose any settings you did with steempy or conductor. You'll have to re-enter them on restarting the container. Hence, the secure aspect of using docker setups.
