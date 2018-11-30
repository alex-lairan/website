pipeline {
  agent any
  environment {
    AMBER_ENV = 'test'
  }
  stages {
    stage('Install') {
      parallel {
        stage('shards') {
          steps {
            echo 'Shards'
            sh '''#!/bin/bash -e
shards install'''
          }
        }
      }
    }
    stage('Script') {
      parallel {
        stage('Spec') {
          steps {
            echo 'Spec'
            sh '''#!/bin/bash -e
crystal spec'''
          }
        }
      }
    }
    stage('Mail') {
      steps {
        def mailRecipients = "your_recipients@company.com"

        emailext (
  	      subject: "STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
        	body: """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
        	  <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>""",
          to: "${mailRecipients}",
          replyTo: "${mailRecipients}",
        	recipientProviders: [[$class: 'DevelopersRecipientProvider']]
        )
      }
    }
  }
}
