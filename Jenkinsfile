pipeline{
    agent any

    trigger{
        pollSCM ["H/2 * * * *"]
    }

    tools{
        maven "Mave-3.9"
        jdk "JDK-23"
    }

    environment{
        DOCKER_IMAGE = "dhruvamaheshwari47/jenkins_etp_java_try",
        DOCKER_TAG = 'latest',
        CONTAINER_NAME = 'etp_java_try',
        PORT = 8080
    }

    stages{
        stage("Clone from the gitHub")
        {
            steps{
                git url: "https://github.com/Dhruvamaheshwari/jenkins_etp_sem_6_java_try.git",
                branch :"main"
            }
        }
        stage("install all the dependency")
        {
            steps{
                bat "mvn clean install"
            }
        }
        stage("Build the docker image")
        {
            steps{
                bat "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }
        
        stage("push the image on docker hub")
        {
            steps{
                withCredentials([
                    usernamePassword(
                        credentialsId:"dockerhub",
                        usernameVariable:"DOCKER_USERNAME",
                        passwordVariable:"DOCKER_PASSWORD"
                    )
                ]){
                    bat """ 
                        echo %DOCKER_PASSWORD%| docker login -u %DOCKER_USERNAME% --password-stdin
                    """
                }
            }
        }

        stage("stop the old container")
        {
            steps{
                bat "docker rm -f ${CONTAINER_NAME} || true"
            }
        }

        stage("Re-Run the container")
        {
            steps{
                bat "docker run -d -p ${PORT}:8080 --name ${ CONTAINER_NAME} ${DOCKER_IMAGE}:${DOCKER_TAG}"
            }
        }
    }
    post{
        success{
            echo "pipeline is successfully completed"
        }
    }
}