pipeline {
    agent any
    tools {
        terraform 'terra-tool'
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-cred')
        AWS_SECRET_ACCESS_KEY = credentials('aws-cred')
    }
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/anjalikota10/terraform-jenkins.git' // Replace with your repo URL
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Terraform Destroy') {
            when {
                expression { params.DESTROY } // Add a condition to control when to destroy
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
    parameters {
        booleanParam(name: 'DESTROY', defaultValue: false, description: 'Set to true to destroy the infrastructure')
    }
}
