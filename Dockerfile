FROM ubuntu:16.04

MAINTAINER drakos

RUN apt-get -y update && \
 apt-get -y install apt-utils locales git nano python3 python3-pip python3-dev python-setuptools libssl-dev && \
 apt-get clean
 
# Locale fix for spinner
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN pip3 install --upgrade pip && \
 pip3 install -U git+https://github.com/Netherdrake/conductor

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash"]
