pipeline {
    // Use a Docker container with Cypress pre-installed as the agent
    agent {
        docker {
            image 'cypress/included:14.5.4'
            args '--user root'  // optional: run as root to avoid permission issues
        }
    }

    environment {
        CYPRESS_IMAGE = 'cypress/included:14.5.4'
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Debug Workspace') {
            steps {
                // List files to verify checkout
                sh 'ls -la'
            }
        }
        
        stage('Run Cypress Tests') {
            steps {
                // Run Cypress directly inside the container
                sh 'npx cypress run --config-file cypress.config.js --no-sandbox'
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
    }
}
