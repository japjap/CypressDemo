pipeline {
    agent {
        docker {
            image 'cypress/included:14.5.4' // prebuilt image with Cypress + dependencies
            args '-u root' // run as root
        }
    }

    environment {
        DISPLAY = ':99'
    }

    stages {
        stage('Checkout code') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']], // replace if your branch is different
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
