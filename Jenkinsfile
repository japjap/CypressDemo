pipeline {
    agent any

    environment {
        CYPRESS_IMAGE = 'cypress/included:14.5.4'
        WORKDIR = '/var/jenkins_home/workspace/CypressPipeline'
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
                    
                    if (isUnix()) {
                        sh 'ls -la'
                    } else {
                        bat 'dir'
                    }
                }
            }
        }

        stage('Prepare Cypress Environment') {
            steps {
                echo "🧪 Preparing Cypress Test Environment..."
                script {
                    if (isUnix()) {
                        sh """
                        echo "➡ Cypress image: ${CYPRESS_IMAGE}"
                        echo "➡ Docker version:"
                        docker --version

                        echo "➡ Checking mounted workspace path:"
                        ls -la ${env.WORKDIR}
                        """
                    }
                }
                echo "✔ Environment ready."
            }
        }

        stage('Run Cypress Tests in Docker') {
            steps {
                script {
                    echo "🚀 Starting Cypress tests inside Docker container..."

                    if (isUnix()) {
                        sh """
                        echo "➡ Running Cypress with config file: /e2e/cypress.config.js"
                        echo "➡ Mounting workspace: ${WORKDIR} → /e2e"

                        docker run --rm \
                            -v ${WORKDIR}:/e2e \
                            -w /e2e \
                            ${CYPRESS_IMAGE} \
                            npx cypress run --config-file /e2e/cypress.config.js ||
                            (echo "❌ Cypress execution failed. Check logs above." && exit 1)
                        """
                    } else {
                        bat """
                        echo Running Cypress on Windows agent...
                        docker run --rm ^
                            -v ${WORKDIR}:/e2e ^
                            -w /e2e ^
                            ${CYPRESS_IMAGE} ^
                            npx cypress run --config-file /e2e/cypress.config.js
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo '✅ Cypress tests passed!'
        }
        failure {
            echo '❌ Cypress tests failed! Check the logs for details.'
        }
        always {
            echo "📦 Pipeline finished. Cleaning up..."
        }
    }
}