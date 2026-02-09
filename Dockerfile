FROM jenkins/jenkins:lts

USER root

# install ONLY docker client
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean

# allow jenkins user to access docker
RUN usermod -aG docker jenkins

USER jenkins
