pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                sh '''
                rm -rf springboot-app
                git clone https://github.com/TEJESH-THALLURU/springboot-app.git
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                cd springboot-app
                docker build -t springboot-app:v1 .
                '''
            }
        }
    }
}
