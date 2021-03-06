FROM ubuntu:16.04

MAINTAINER drakos

RUN apt-get -y update && \
 apt-get -y install apt-utils locales git nano python3 python3-pip python3-dev python3-setuptools libssl-dev cron curl iputils-ping jq wget && \
 apt-get clean
 
# Locale fix for spinner
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN pip3 install --upgrade pip
RUN pip3 install -U git+https://github.com/Netherdrake/conductor && pip3 install -U git+https://github.com/Netherdrake/steem-python

#RUN pip3 install --upgrade pip && \
# pip3 install -U requests && \
# pip3 install -U steem && \
# pip3 uninstall funcy -y && \
# wget https://github.com/Suor/funcy/archive/1.8.tar.gz && \
# tar xzvf 1.8.tar.gz && \
# cd funcy-1.8 && \
# python3 setup.py install

# Set environment variables.
ENV HOME /root
ENV PATH="$HOME/bin:${PATH}"

# Define working directory.
WORKDIR /root

# copy scripts
#COPY scripts /root

# Define default command.
CMD ["bash"]
