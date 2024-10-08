pipeline {
    agent { label 'iac' } 

    stages {
        stage('Tofu init') {
            steps {
                dir('infra/production/dns') {
                  sh 'tofu init'
                }
            }
        }
    }
}
