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

        stage('Install Dependencies') {
            steps {
                echo "Installing Node.js dependencies inside Docker..."
                sh '''
                docker run --rm -v $WORKSPACE_DIR:/e2e -w /e2e node:22-bullseye bash -c "
                    npm install
                "
                '''
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo "Running Cypress tests..."
                sh '''
                docker run --rm -v $WORKSPACE_DIR:/e2e -w /e2e node:22-bullseye bash -c "
                    npx cypress run
                "
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
