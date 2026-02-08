pipeline {
    agent any

    environment {
        WORKSPACE_DIR = "${env.WORKSPACE}"
    }

    stages {
        stage('Checkout SCM') {
            steps {
                echo "Checking out code..."
                checkout scm
            }
        }

        stage('Install Node.js Dependencies') {
            steps {
                echo "Installing Node.js dependencies..."
                // Run inside Jenkins container
                sh '''
                npm install
                '''
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo "Running Cypress tests..."
                sh '''
                # Run Cypress using TypeScript config
                npx cypress run
                '''
            }
        }
    }

    post {
        success {
            echo "Cypress tests passed ✅"
        }
        failure {
            echo "Cypress tests failed ❌"
        }
    }
}
