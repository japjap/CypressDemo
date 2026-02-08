pipeline {
    agent any

    environment {
        CYPRESS_IMAGE = 'cypress/included:14.5.4'
        WORKSPACE_DIR = "${env.WORKSPACE}"
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
                echo 'Running Cypress tests inside Docker...'
                sh """
                    docker run --rm \
                        -v ${WORKSPACE_DIR}:/e2e \
                        -w /e2e \
                        ${CYPRESS_IMAGE} \
                        npx cypress run
                """
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
