pipeline {
    agent {
        docker { image 'node:18-alpine3.18' }
    }
    environment {
        DOCKER_IMAGE_NAME = 'edwright6975df/todo-react-app'
        BUILD_ID = 'env.BUILD_ID'
        DOCKER_HUB_CREDENTIALS = credentials('docker-hub')
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/EdWright75/react-vite-todo-ui.git']]])
            }
        }
        stage('Test') {
            steps {
                sh 'npm install'
                sh 'npm test'
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
                    docker.build("${DOCKER_IMAGE_NAME}:${BUILD_ID}")
                    docker.withRegistry('https://registry.hub.docker.com', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${DOCKER_IMAGE_NAME}:${env.BUILD_ID}").push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.run("${DOCKER_IMAGE_NAME}:${BUILD_ID}", "--name react-app-container -p 8080:80 -d")
                }
            }
        }
    }
}