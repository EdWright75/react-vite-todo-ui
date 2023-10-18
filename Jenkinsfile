pipeline {
    agent any
    tools {
        nodejs 'Node-20'
    }
    environment {
        DOCKER_IMAGE_NAME = 'edwright6975df/todo-react-app'
        BUILD_ID = 'env.BUILD_ID'
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub')
    }
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test Application') {
            steps {
                sh 'npm run test-ci'
            }
        }
        stage('Build React App') {
            steps {
                sh 'npm run build'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${BUILD_ID}")
                }
            }
        }
    }
}