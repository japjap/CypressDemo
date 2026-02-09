FROM jenkins/jenkins:lts

USER root

# Install only Docker CLI
RUN apt-get update && \
    apt-get install -y docker.io && \
    apt-get clean

# Give Jenkins permission to run Docker
RUN usermod -aG docker jenkins

USER jenkins
