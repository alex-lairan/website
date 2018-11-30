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
  }
}

