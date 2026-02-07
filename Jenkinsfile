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
