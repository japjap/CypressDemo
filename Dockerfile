# Base Jenkins LTS image with Java 17
FROM jenkins/jenkins:lts-jdk17

# Switch to root to install packages
USER root

# Install dependencies: Node.js, npm, Docker CLI, curl, git
RUN apt-get update && \
    apt-get install -y curl gnupg2 lsb-release software-properties-common git && \
    # Install Node.js 18 (latest LTS)
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest && \
    # Install Docker CLI
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
        > /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    # Clean up
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch back to Jenkins user
USER jenkins

# Expose Jenkins ports
EXPOSE 8080 50000
