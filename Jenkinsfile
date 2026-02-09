pipeline {
    agent any

    environment {
        CYPRESS_IMAGE = 'cypress/included:14.5.4'
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Run Cypress Tests in Docker') {
            steps {
                sh '''
                docker run --rm \
                    -v $WORKSPACE:/e2e \
                    -w /e2e/Cypress-Foundations-Course \
                    cypress/included:14.5.4 \
                    npx cypress run
                '''
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
