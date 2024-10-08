pipeline {
    agent { label 'iac' } 

    environment {
      PROXMOX_PASSWORD = credentials('proxmox-password-id')
      SSH_KEY_PATH = "/home/jenkins/.ssh/id_ed25519"
    }
    stages {
        stage('Prepare SSH Key') {
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'ssh-key-root', keyFileVariable: 'SSH_KEY_FILE')]) {
                    sh 'cp "$SSH_KEY_FILE" $SSH_KEY_PATH'
                    sh 'chmod 600 $SSH_KEY_PATH'
                }
            }
        }
        stage('Tofu init') {
            parallel {
                stage('Initialize DNS') {
                    steps {
                        dir('infra/production/dns') {
                          sh 'tofu init'
                        }
                    }
                }
                stage('Initialize Traefik') {
                    steps {
                        dir('infra/production/traefik') {
                          sh 'tofu init'
                        }
                    }
                }
            }
        }
        stage('Tofu plan') {
            parallel {
                stage('Plan DNS') {
                    steps {
                        dir('infra/production/dns') {
                            sh 'tofu plan -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key="$SSH_KEY_PATH" -out tofu.plan'
                        }
                    }
                }
                stage('Plan traefik') {
                    steps {
                        dir('infra/production/traefik') {
                            sh 'tofu plan -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key="$SSH_KEY_PATH" -out tofu.plan'
                        }
                    }
                }
            }
        }

        stage('Tofu deploy') {
            parallel {
                stage('Deploy DNS') {
                    when {
                        expression { ACTION ==~ "deploy"}
                    }
                    steps {
                        dir('infra/production/dns') {
                            sh 'tofu apply tofu.plan' 
                        }
                    }
                }
                stage('Deploy traefik') {
                    when {
                        expression { ACTION ==~ "deploy"}
                    }
                    steps {
                        dir('infra/production/traefik') {
                            sh 'tofu apply tofu.plan' 
                        }
                    }
                }

            }
        }

        stage('Tofu destroy') {
            parallel {
                stage('Destroy DNS') {
                    when {
                        expression { ACTION ==~ "destroy"}
                    }
                    steps {
                        dir('infra/production/dns') {
                            sh 'tofu destroy -auto-approve -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key="$SSH_KEY_PATH"' 
                        }
                    }
                }
                stage('Destroy traefik') {
                    when {
                        expression { ACTION ==~ "destroy"}
                    }
                    steps {
                        dir('infra/production/traefik') {
                            sh 'tofu destroy -auto-approve -var proxmox_password=${PROXMOX_PASSWORD_PSW} -var ssh_private_key="$SSH_KEY_PATH"' 
                        }
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
              ansiblePlaybook credentialsId: 'ansible-ssh-root', extras: '-u root', installation: 'ansible-playbook', inventory: 'inventory.yml', playbook: 'traefik.yml'
            }
          }
        }
    }
}
