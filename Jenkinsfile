pipeline {
    agent {
        docker { 
            image 'node:18-alpine3.18'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
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
    }
    post {
        success {
            // Store the result of the 'Build React App' stage in an artifact
            archiveArtifacts(artifacts: 'dist/**') // Adjust the path as needed
        }
    }
    pipeline {
        agent any
        stages {
            stage('Build Docker Image') {
                steps {
                    script {
                        // Retrieve the result of 'Build React App' from the artifact
                        def buildArtifacts = findFiles(glob: 'dist/**')
                    
                        // Build the Docker image using the artifacts
                        dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${BUILD_ID}", "--build-arg APP_ARTIFACT=${buildArtifacts[0].name}")
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
}