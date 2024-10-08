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
            when {
              expression { ACTION ==~ "deploy"}
            }
            steps {
                dir('infra/production/dns') {
                  sh 'tofu apply tofu.plan' 
                }
            }
        }

        stage('Tofu destroy') {
            when {
              expression { ACTION ==~ "destroy"}
            }
            steps {
                dir('infra/production/dns') {
                  sh 'tofu destroy -auto-approve -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key=/home/jenkins/.ssh/id_ed25519' 
                }
            }
        }

        stage('Configure servers') {
          when {
            expression { ACTION ==~ "deploy"}
          }
          steps {
            dir('provisioning/') {
              ansiblePlaybook credentialsId: 'ansible-ssh-root', extras: '-u root', installation: 'ansible-playbook', inventory: 'inventory.yml', playbook: 'dns.yml'
            }
          }
        }
    }
}
