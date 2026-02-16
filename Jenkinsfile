pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                echo "📥 Checking out repository..."
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "📦 Installing npm dependencies..."
                sh """
                    cd ${WORKSPACE}
                    npm ci
                """
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo "🚀 Running Cypress tests inside Jenkins container..."
                sh """
                    cd ${WORKSPACE}
                    npx cypress run --config-file cypress.config.js
                """
            }
        }
    }

    post {
        success {
            echo '✅ Cypress tests passed!'
        }
        failure {
            echo '❌ Cypress tests failed! Check logs above.'
        }
    }
}