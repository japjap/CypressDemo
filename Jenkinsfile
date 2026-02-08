pipeline {
    agent {
        docker {
            // Cypress base image with Node.js installed
            image 'cypress/base:18'
            // Optional: remove container after run
            args '--rm'
        }
    }

    environment {
        // You can set any environment variables here if needed
        CYPRESS_BASE_URL = 'http://localhost:3000'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Install Node.js Dependencies') {
            steps {
                echo 'Installing Node.js dependencies...'
                sh 'npm install'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo 'Running Cypress tests...'
                // Run headless Cypress tests
                sh 'npx cypress run'
            }
        }
    }

    post {
        success {
            echo 'Cypress tests passed ✅'
        }
        failure {
            echo 'Cypress tests failed ❌'
        }
    }
}
