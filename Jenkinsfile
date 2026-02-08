pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run Cypress Tests') {
            steps {
                sh '''
                  echo "Workspace: $(pwd)"
                  docker run --rm \
                    -v "$(pwd):/e2e" \
                    -w /e2e \
                    cypress/included:14.5.4
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Tests passed ✅'
        }
        failure {
            echo 'Tests failed ❌'
        }
    }
}
