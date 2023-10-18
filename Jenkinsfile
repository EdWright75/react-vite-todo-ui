pipeline {
    agent any
    tools {
        nodejs 'Node-18'
    }
    stages {
        // stage('Checkout') {
        //     steps {
        //         checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/EdWright75/react-vite-todo-ui.git']]])
        //     }
        // }
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
}