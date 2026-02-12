pipeline {
    agent {
        docker {
            image 'cypress/included:14.5.4'
            args '-u root'
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
                sh 'ls -la'
            }
        }
        
        stage('Run Cypress Tests in Docker') {
            steps {
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
