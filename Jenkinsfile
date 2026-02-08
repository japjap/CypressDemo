pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install cypress'
            }
        }

        stage('Run Cypress Tests') {
            steps {
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
