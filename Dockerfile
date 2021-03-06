# Description
# Custom base image for caifuOST function containers. The need for a custom image is based upon a number of usecases; (A) to 
# upport a more smooth build process for OpenFaas functions for ARM architecture deployment targets and (B) to ensure a set 
# of caifuOST specific requirments will always be included in the base image. 
#
# Do take note : a "faas build -f xxx.yml --shrinkwrap" action will by default influence the content of the build directory 
# and by default will replace the content of the Dockerfile. When using the caifuOST Dockerfile to use the caifuOST custom
# container image you will have to make sure you take care of the fact that you do not want to use the default OpenFaas 
# generated Dockerfile. An example for the caifuOST OpenFaaS Dockerfile (which can be a replacement for the default 
# Dockerfile generated by the --shrinkwrap flag) is provided. 


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
    apt-get install libatlas-base-dev && \
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
    curl -sL https://github.com/openfaas/of-watchdog/releases/download/0.8.4/fwatchdog-arm > /usr/bin/fwatchdog && \
    chmod +x /usr/bin/fwatchdog && \    
    printf "\n\n--------------------------------------------------------------------------------------------------------\n" && \
    printf " -- DONE -- "


# Define your binary here
ENV fprocess="/bin/cat"

CMD ["fwatchdog"]
