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
                sh '''
                    Xvfb :99 &             # Start virtual display
                    export DISPLAY=:99     # Set DISPLAY environment variable
                    npx cypress run        # Run Cypress tests
                '''
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
