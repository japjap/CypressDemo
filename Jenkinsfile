pipeline {
    agent any

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
                script {
                    if (isUnix()) {
                        sh 'ls -la'
                    } else {
                        bat 'dir'
                    }
                }
            }
        }

        stage('Run Cypress Tests in Docker') {
            steps {
                script {
                    if (isUnix()) {

                        sh """
                        docker run --rm \
                            -v \$WORKSPACE:/e2e \
                            -w /e2e \
                            ${CYPRESS_IMAGE} \
                            npx cypress run --config-file /e2e/cypress.config.js
                        """

                    } else {
                        // Windows agent (not used in your case)
                        bat """
                        docker run --rm ^
                            -v %WORKSPACE%:/e2e ^
                            -w /e2e ^
                            ${CYPRESS_IMAGE} ^
                            npx cypress run --config-file /e2e/cypress.config.js
                        """
                    }
                }
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