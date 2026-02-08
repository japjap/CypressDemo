pipeline {
    agent any

    environment {
        // Cypress Docker image
        CYPRESS_IMAGE = 'cypress/included:14.5.4'
        // Convert Windows workspace path to Docker-friendly format
        WORKSPACE_DIR = "${env.WORKSPACE.replaceAll('\\\\','/')}"
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
                // Use PowerShell compatible Docker run
                bat """
                docker run --rm ^
                    -v ${WORKSPACE_DIR}:/e2e ^
                    -w /e2e ^
                    ${CYPRESS_IMAGE} ^
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
