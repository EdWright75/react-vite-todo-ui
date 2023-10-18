pipeline {
    agent any
    tools {
        nodejs 'Node-18'
    }
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'node -v'
                sh 'npm -v'
                sh 'npm install'
            }
        }
        stage('Test Application') {
            steps {
                sh './jenkins_scripts/test.sh'
            }
        }
        stage('Build React App') {
            steps {
                sh 'npm run build'
            }
        }
    }
}