pipeline {
    agent any
    stages {
        stage('Apply') {
            steps {
                ansiblePlaybook credentialsId: 'balin-key-01.pem', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'hosts', playbook: 'deploy_s3bucket.yml'
            }
        }
    }
}