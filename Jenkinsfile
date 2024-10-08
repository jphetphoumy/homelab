pipeline {
    agent { label 'iac' } 

    environment {
      PROXMOX_PASSWORD = credentials('proxmox-password-id')
    }
    stages {
        stage('Tofu init') {
            steps {
                dir('infra/production/dns') {
                  sh 'tofu init'
                }
            }
        }
        stage('Tofu plan') {
            steps {
                dir('infra/production/dns') {
                  sh 'tofu plan -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key=/home/jenkins/.ssh/id_ed25519 -out tofu.plan'
                }
            }
        }

        stage('Tofu deploy') {
            steps {
                dir('infra/production/dns') {
                  sh 'tofu apply tofu.plan' 
                }
            }
        }
    }
}
