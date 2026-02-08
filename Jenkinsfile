pipeline {
    agent {
        docker {
            // Cypress Docker image with everything pre-installed
            image 'cypress/included:14.5.4'
            args '--rm'
        }
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo 'Checking out code...'
                checkout scm
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo 'Running Cypress tests...'
                // Cypress runs headless by default in this image
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
