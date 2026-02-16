pipeline {
    agent any

    environment {
        CYPRESS_IMAGE = 'cypress/included:14.5.4'
        DOCKER_VOLUME = 'cypress-workspace'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "📥 Checking out repository..."
                checkout scm
                echo "✔ Checkout complete."
            }
        }

        stage('Prepare Volume') {
            steps {
                echo "📦 Creating shared Docker volume if not exists..."
                sh "docker volume create ${DOCKER_VOLUME} || true"
            }
        }

        stage('Sync Workspace to Volume') {
            steps {
                script {
                    echo "🔄 Copying Jenkins workspace into shared volume..."

                    sh """
                    rm -rf /tmp/cypress-sync
                    mkdir -p /tmp/cypress-sync

                    # Copy FROM Jenkins container filesystem → host temp folder
                    docker cp ${env.NODE_NAME}:/var/jenkins_home/workspace/CypressPipeline /tmp/cypress-sync

                    # Copy FROM host temp folder → Docker volume
                    docker run --rm \
                        -v ${DOCKER_VOLUME}:/e2e \
                        -v /tmp/cypress-sync/CypressPipeline:/src \
                        busybox sh -c "rm -rf /e2e/* && cp -r /src/* /e2e/"
                    """

                    echo "✔ Workspace synced to volume."
                }
            }
        }

        stage('Debug Volume Contents') {
            steps {
                echo "🔍 Checking files inside the Docker volume..."
                sh """
                docker run --rm \
                    -v ${DOCKER_VOLUME}:/e2e \
                    busybox sh -c "ls -la /e2e"
                """
            }
        }

        stage('Run Cypress Tests') {
            steps {
                script {
                    echo "🚀 Running Cypress tests inside Docker..."
                    sh """
                    docker run --rm \
                        -v ${DOCKER_VOLUME}:/e2e \
                        -w /e2e \
                        ${CYPRESS_IMAGE} \
                        npx cypress run --config-file /e2e/cypress.config.js
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Cypress tests passed!'
        }
        failure {
            echo '❌ Cypress tests failed!'
        }
        always {
            echo '📦 Pipeline complete.'
        }
    }
}