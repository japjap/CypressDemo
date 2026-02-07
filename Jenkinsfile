pipeline {
    agent any

    tools {
        nodejs 'node-25'
    }

    stages {
        stage('Checkout code') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']], // or your default branch
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [[$class: 'CloneOption', depth: 1, shallow: true]],
                    userRemoteConfigs: [[url: 'https://github.com/japjap/CypressDemo']]
                ])
            }
        }

        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run Cypress tests') {
            steps {
                // Start Xvfb on display :99 in the background, then run Cypress
                sh '''
                    Xvfb :99 -screen 0 1280x1024x24 &
                    export DISPLAY=:99
                    npx cypress run
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
