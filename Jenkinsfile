pipeline {
    agent any

    environment {
        CYPRESS_CACHE_FOLDER = '/tmp/.cache/Cypress' // optional: cache Cypress to speed up builds
    }

    stages {
        stage('Checkout code') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']], // change if your default branch is different
                    extensions: [[$class: 'CloneOption', depth: 1, shallow: true]], // shallow clone
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
                // Run Cypress in Docker manually
                sh '''
                docker run --rm \
                    -v $PWD:/e2e \
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
