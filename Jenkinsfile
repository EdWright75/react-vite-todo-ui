pipeline {
    agent any
    tools {
        nodejs 'Node-20'
    }
    environment {
        DOCKER_IMAGE_NAME = 'edwright6975df/todo-react-app'
        BUILD_ID = "${env.BUILD_ID}"
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
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image to a registry (e.g., Docker Hub)
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub') {
                        docker.build("${DOCKER_IMAGE_NAME}:${BUILD_ID}").push()
                    }
                }
            }
        }
    }
}