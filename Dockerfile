# Description
# Custom base image for caifuOST function containers. The need for a custom image is based upon a number of usecases; (A) to 
# upport a more smooth build process for OpenFaas functions for ARM architecture deployment targets and (B) to ensure a set 
# of caifuOST specific requirments will always be included in the base image. 
#



# Pull base image
FROM balenalib/raspberry-pi-debian:latest

# Prepare the image with specific python3 needs and ensure we have the OpenFaas fwatchdog included.
RUN echo && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt-get update && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt-get install apt-utils && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt-get upgrade && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt-get install debconf && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt-get install python3 && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt-get install python3-pip && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    pip3 install setuptools && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    pip3 install wheel && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    python3 --version && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt autoremove && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    apt-get clean  && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    rm -rf /var/lib/apt/lists/* && \
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    curl -sL https://github.com/openfaas/faas/releases/download/0.9.14/fwatchdog > /usr/bin/fwatchdog && \
    chmod +x /usr/bin/fwatchdog && \    
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    printf " -- DONE -- "


# Define your binary here
ENV fprocess="/bin/cat"

CMD ["fwatchdog"]
