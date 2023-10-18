pipeline {
    agent any
    tools {
        nodejs 'Node-20'
    }
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'node -v'
                sh 'npm cache clean --force'
                sh 'npm cache verify'
                sh 'pwd'
                sh 'npm install'
            }
        }
        stage('Test Application') {
            steps {
                sh 'pwd'
                sh 'ls'
                sh 'cd ./tests'
                sh 'ls'
                sh 'cd ./..'
                sh 'pwd'
                sh 'npm run test-ci'
            }
        }
        stage('Build React App') {
            steps {
                sh 'npm run build'
            }
        }
    }
}