pipeline {
    agent any

    environment {
        CYPRESS_CACHE_FOLDER = '/tmp/.cache/Cypress' // optional: speeds up repeated builds
    }

    stages {
        stage('Checkout code') {
            steps {
                // Simple checkout from your repo
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '*/main']], // replace with your default branch if needed
                    extensions: [[$class: 'CloneOption', depth: 1, shallow: true]],
                    userRemoteConfigs: [[url: 'https://github.com/japjap/CypressDemo']]
                ])
            }
        }

        stage('Run Cypress tests in Docker') {
            steps {
                // Use Cypress official Docker image with Node + Cypress + dependencies included
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
