pipeline {
    agent {
        docker {
            image 'cypress/included:14.5.4'
            args '--user root'
        }
    }

    environment {
        CYPRESS_IMAGE = 'cypress/included:14.5.4'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "🔄 Checking out code from Git..."
                checkout scm
            }
        }

        stage('Debug Workspace') {
            steps {
                echo "🛠 Listing workspace contents..."
                sh 'ls -la'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo "🏃 Running Cypress tests..."
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
