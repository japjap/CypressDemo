pipeline {
    agent any

    stages {
        stage('Checkout code') {
            steps {
                checkout scm
            }
        }

        stage('Run Cypress tests in Docker') {
            steps {
                sh '''
                docker run --rm \
                  -v $PWD:/e2e \
                  -w /e2e \
                  cypress/included:14.5.4
                '''
            }
        }
    }

    post {
        always { echo 'Pipeline finished.' }
        success { echo 'Tests passed ✅' }
        failure { echo 'Tests failed ❌' }
    }
}
