pipeline {
    agent {
        docker {
            image 'cypress/included:14.5.4'
            args '--user root'
        }
    }

    environment {
        // Directory to cache node_modules
        NODE_MODULES_CACHE = "${WORKSPACE}/node_modules"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Debug Workspace') {
            steps {
                sh 'ls -la'
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "📦 Installing Node.js dependencies..."
                // Only install if node_modules folder doesn't exist
                sh '''
                if [ ! -d "$NODE_MODULES_CACHE" ]; then
                    npm install
                else
                    echo "📁 node_modules already exists, skipping npm install"
                fi
                '''
            }
        }

        stage('Run Cypress Tests') {
            steps {
                echo "🏃 Running Cypress tests..."
                sh 'npx cypress run --config-file cypress.config.js --no-sandbox'
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
