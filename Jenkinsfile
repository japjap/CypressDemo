pipeline {
    agent any

    tools {
        nodejs 'node-25'   // must match the NodeJS installation name in Jenkins
    }

    stages {
        stage('Install dependencies') {
            steps {
                echo 'Installing npm dependencies...'
                sh 'npm install'
            }
        }

        stage('Run Cypress tests') {
            steps {
                echo 'Running Cypress tests...'
                sh 'npx cypress run'
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
