pipeline {
    agent any

    environment {
        envsetup = "${WORKSPACE}/env"
    }

    stages {

        stage("Clean the WorkSpace") {
            steps {
                cleanWs()
            }
        }

        stage("checkoutSCM") {
            steps {
              checkout scm
            }
        }

        stage("Run Tests when PR is created from stage to main") {

            when {
                  changeRequest()
              }

            steps {
                sh """
                    python3 -m venv $envsetup
                    . $envsetup/bin/activate
                    $envsetup/bin/pip install --upgrade pip
                    $envsetup/bin/pip install -r requirements.txt
                    $envsetup/bin/python -m unittest discover tests
                """
            }
        }

        stage("Build the Dockerfile and push the docker image to DockerHub") {
         
            when {
              allOf {
                    branch 'main'
                    not { 
                       changeRequest()
                      }
                    }
                 }

            steps {
                script {
                    sh 'docker build -t tulajaram/8bytes:8bytes${BUILD_NUMBER} .'

                    withCredentials([usernamePassword(
                        credentialsId: 'DockerLogin',
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD'
                    )]) {
                        sh """
                            echo ${PASSWORD} | docker login -u ${USERNAME} --password-stdin
                            docker push tulajaram/8bytes:8bytes${BUILD_NUMBER}
                        """
                    }
                }
            }
        }

        stage("Deploy to the StagingEnv") {
            
            when {
              allOf {
                    branch 'main'
                    not {
                       changeRequest()
                      }
                    }
                 }

            steps {
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'DockerLogin',
                        usernameVariable: 'USERNAME',
                        passwordVariable: 'PASSWORD'
                    )]) {
                        sh """
                            docker rm -f 8bytes-stage || true
                            echo ${PASSWORD} | docker login -u ${USERNAME} --password-stdin
                            docker run -d --name 8bytes-stage -p 5000:5000 tulajaram/8bytes:8bytes${BUILD_NUMBER}
                        """
                    }
                }
            }
        }

        stage("Scan Docker Image with Trivy") {
            when {
              allOf {
                    branch 'main'
                    not {
                       changeRequest()
                      }
                    }
                 }

            steps {
                sh """
                    trivy image --download-db-only
                    trivy image --exit-code 0 --severity CRITICAL,HIGH --scanners vuln tulajaram/8bytes:8bytes${BUILD_NUMBER} || true
                """
            }
        }
       
        stage("Manual Approval for Production Deploy") {
            when {
                branch 'main'
                not {
                    changeRequest()
                }
            }
            steps {
                input message: "Approve deployment to Production?"
            }
        }

    }

    post {
        always {
            emailext(
                attachLog: true,
                subject: "Jenkins Build Status: ${currentBuild.currentResult}",
                body: "The Jenkins build completed with status: ${currentBuild.currentResult}.",
                to: "tulajaramkamble@gmail.com"
            )
        }
    }
}

