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
                            npx cypress run --config-file cypress.config.js --no-sandbox
                        """
                    } else {
                        // Windows agent
                        bat """
                        docker run --rm ^
                            -v %WORKSPACE%:/e2e ^
                            -w /e2e ^
                            ${CYPRESS_IMAGE} ^
                            npx cypress run --config-file cypress.config.js --no-sandbox
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
