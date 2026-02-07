pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/japjap/CypressDemo', branch: 'main'
            }
        }

        stage('Run Cypress Tests') {
            steps {
                // Runs Cypress in its official Docker container
                sh '''
                docker run --rm -v $PWD:/e2e -w /e2e cypress/included:14.5.4
                '''
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
    }
}
