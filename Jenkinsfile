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
        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             // Run a shell command to find the 'dist' folder and its contents
        //             // def distArtifacts = sh(returnStdout: true, script: 'find dist/ -type f -print')
                    
        //             // Build the Docker image and copy the 'dist' folder artifacts
        //             def dockerImage = docker.build("my-docker-image:${BUILD_ID}") // , "--build-arg APP_ARTIFACT=${distArtifacts}", "-f Dockerfile .")
        //         }
        //     }
        // }
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