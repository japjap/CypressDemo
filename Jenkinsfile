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

        stage('Debug Workspace') {
            steps {
                script {
                    echo "🔍 Current workspace directory: ${env.WORKSPACE}"
                    echo "📁 Listing workspace contents:"
                    sh "ls -la ${env.WORKSPACE}"
                }
            }
        }

        stage('Create Docker Volume') {
            steps {
                echo "📦 Ensuring shared Docker volume exists..."
                sh """
                docker volume create ${DOCKER_VOLUME} || true
                """
            }
        }

        stage('Sync Workspace to Volume') {
            steps {
                echo "🔄 Syncing Jenkins workspace into shared Docker volume..."
                script {
                    sh """
                    docker run --rm \
                      -v ${DOCKER_VOLUME}:/e2e \
                      -v ${env.WORKSPACE}:/jenkins \
                      busybox sh -c "rm -rf /e2e/* && cp -r /jenkins/* /e2e/"
                    """
                }
                echo "✔ Sync complete."
            }
        }

        stage('Prepare Cypress Environment') {
            steps {
                echo "🧪 Preparing Cypress Environment..."
                script {
                    sh """
                    echo "➡ Cypress image: ${CYPRESS_IMAGE}"
                    echo "➡ Docker version:" 
                    docker --version
                    echo "➡ Files inside volume:"
                    docker run --rm -v ${DOCKER_VOLUME}:/e2e busybox sh -c "ls -la /e2e"
                    """
                }
                echo "✔ Environment Ready."
            }
        }

        stage('Run Cypress Tests in Docker') {
            steps {
                script {
                    echo "🚀 Running Cypress tests inside Docker..."
                    sh """
                    docker run --rm \
                        -v ${DOCKER_VOLUME}:/e2e \
                        -w /e2e \
                        ${CYPRESS_IMAGE} \
                        npx cypress run --config-file /e2e/cypress.config.js ||
                        (echo '❌ Cypress execution failed.' && exit 1)
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Cypress tests passed successfully!'
        }
        failure {
            echo '❌ Cypress tests failed! Check logs above.'
        }
        always {
            echo "📦 Pipeline finished. Cleaning up..."
        }
    }
}