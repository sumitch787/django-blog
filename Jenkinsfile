pipeline {
  agent any
  stages {
    stage('SAST') {
      agent {
        docker {
          image 'python:build:v1'
        }

      }
      steps {
        sh 'bandit -r . --exit-zero'
      }
    }

    stage('Build') {
      agent {
        docker {
          image 'docker:20.10.12-alpine3.15'
          args ''' --privileged
--volume /var/run/docker.sock:/var/run/docker.sock
--user=root'''
        }

      }
      environment {
        registry = ''
      }
      steps {
        sh '''IMAGE_TAG=$(echo $GIT_COMMIT| cut -c1-6)
IMAGE_NAME=$(echo $JOB_NAME | cut -d \'/\' -f1)
docker build . -t $registry:$IMAGE_NAME-$IMAGE_TAG
docker push $registry:$IMAGE_NAME-$IMAGE_TAG'''
        input 'Deploy To LocalMachine'
      }
    }

    stage('Deploy') {
      agent {
        docker {
          image 'docker:20.10.12-alpine3.15'
          args '''--privileged
--volume /var/run/docker.sock:/var/run/docker.sock
--user=root'''
        }

      }
      environment {
        registry = ''
        PORT = '8080'
        CI = 'true'
      }
      steps {
        sh 'chmod +x ./deploy.sh'
        sh './deploy.sh'
      }
    }

  }
}
