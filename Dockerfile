FROM jenkins/jenkins:lts

USER root

# install docker cli inside Jenkins container
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean

# allow jenkins user to run docker
RUN usermod -aG docker jenkins

USER jenkins
