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
                  withCredentials([sshUserPrivateKey(credentialsId: 'ssh-key-root', keyFileVariable: 'SSH_KEY_FILE')]) {
                    sh 'tofu plan -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key="$SSH_KEY_FILE -out tofu.plan'
                  }
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
                  withCredentials([sshUserPrivateKey(credentialsId: 'ssh-key-root', keyFileVariable: 'SSH_KEY_FILE')]) {
                    sh 'tofu destroy -auto-approve -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key="$SSH_KEY_FILE"' 
                  }
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
