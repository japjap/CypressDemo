pipeline {
    agent any

    environment {
        CYPRESS_BASE_URL = 'http://localhost:3000'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Run Cypress in Docker') {
            steps {
                echo 'Running Cypress tests inside Docker...'

                // Run Docker container with Cypress base image
                sh '''
                    docker run --rm \
                        -v $PWD:/e2e \
                        -w /e2e \
                        cypress/base:18 \
                        /bin/bash -c "npm install && npx cypress run"
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
