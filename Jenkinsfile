pipeline {
    agent any
    tools {
        nodejs 'Node-20'
    }
    environment {
        DOCKER_IMAGE_NAME = 'edwright6975df/todo-react-app'
        BUILD_ID = "${env.BUILD_ID}"
        // DOCKER_HUB_CREDENTIALS = credentials('docker-hub')
        // DOCKER_HUB_PASSWORD = credentials('docker-hub').password
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
                        docker build -t "${DOCKER_IMAGE_NAME}:${BUILD_ID}" .
                        docker push "${DOCKER_IMAGE_NAME}:${BUILD_ID}"
                        """
                    }
                }
            }
        }
    }
}







