pipeline {
    agent any
    tools {
        nodejs 'Node-18'
        docker 'docker'
    }
    environment {
        DOCKER_IMAGE_NAME = 'todo-react-app'
        BUILD_ID = "${env.BUILD_ID}"
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
                    // Use credentials directly within the withCredentials block
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'DOCKER_HUB_USERNAME', passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                        sh """
                        echo \${DOCKER_HUB_PASSWORD} | docker login -u \${DOCKER_HUB_USERNAME} --password-stdin
                        docker build -t "${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:${BUILD_ID}" .
                        docker tag "${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:${BUILD_ID}" "${DOCKER_IMAGE_NAME}:latest"
                        docker push "${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:${BUILD_ID}"
                        docker push "${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:latest"
                        """
                    }
                }
            }
        }
    }
}







