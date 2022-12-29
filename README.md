
# HELLO SPRING-BOOT on AWS


This guide provides instructions for building a Greetings from Spring Boot Java Application using Maven, creating a Docker image to push to a remote repository then deploying the image/container to AWS.



## Prerequisites

Java Development Kit (JDK)

Apache Maven

Docker

Dockerhub account

AWS EC2 instance (Ubuntu)

Git


## EC2 Configuration (Ubuntu)

I created a bash script to install all of the dependencies needed for this project. There are 2 options listed below:

Option #1

Install Git: 

    apt install git

Clone repo to server:

    git clone git clone http://whitespace-vxijer@git.codesubmit.io/whitespace/devops-assessment-jpvfzf

cd into folder containing bash script:

    cd whitespace/devops-assessment-jpvfzf/bashs

Allow permissions to execute bash script:
   
    chmod +x configf.sh

Run bash script:

    ./configf.sh

Option #2

Create your own .sh file/copy and paste syntax below:

    vi Bash-script-name.sh

 Copy and Paste syntax:   

    #!/bin/bash

    # Declare variables
    maven_package="maven"
    jdk_package="openjdk-17-jdk"
    docker_package="docker.io"
    git_package="git"

    # Update package manager cache
    sudo apt update

    # Install JDK
    sudo apt install $jdk_package

    # Install Maven
    sudo apt install $maven_package

    # Install Docker
    sudo apt install $docker_package

    # Install Git
    sudo apt install $git_package

Save file by exiting insert mode "Esc" and entering:
 
    :wq

## Building the Image with Maven

Clone the repository:

    git clone https://github.com/spring-guides/gs-spring-boot.git

Move into `gs-spring-boot/complete` directory:

    cd gs-spring-boot/complete

Run the following command to test project:

    mvn spring-boot:run

Compile and create JAR file in the target directory:

    mvn clean package

The JAR file will be created in the target directory of your project once the build is complete.  To follow good practices we must test the JAR with the following:

    java -jar spring-boot-complete-0.0.1-SNAPSHOT.jar

Once the test is complete we can move to the next step of dockerizing the application.












# Dockerizing the Application/Create dockerfile

Create a file named "dockerfile" in the root directory of your project.

Add the following syntax to the "dockerfile":

    FROM amazoncorretto:17-alpine-jdk
    WORKDIR /app
    COPY complete/target/spring-boot-complete-0.0.1-SNAPSHOT.jar .
    ENTRYPOINT ["java","-jar","spring-boot-complete-0.0.1-SNAPSHOT.jar"]

Replace your "jar-file.jar" with the name of the JAR file that you built in the previous step.

Save the "dockerfile".
## Building the Docker Image

To make sure you have permission to access the Docker daemon run this command to grant access:

    sudo usermod -aG docker $USER

Log out of the current session and log back in to apply the group change.

Navigate to the root directory of your project in a terminal.
Run the following command to build the Docker image:

    docker build -t gs-spring-boot .

Before we tag and push the image to dockerhub, test run the image with the following command:

    docker run --rm -p 8080:8080 gs-spring-boot

The test should output the same text as test prior to building the image. Once we have a successful test now we can start the process of pushing the image to dockerhub repo.




## Login to DockerHub

Login to dockerhub from CLI with the following syntax:

     docker login --username=yourusername

It will then prompt you to enter your password. Once the login in is complete we are ready for the next step.




## Tag and Push Docker Image

Before we push our image to dockerhub we want to practice good habits by custom tagging our image:

    docker tag gs-spring-boot yourusername/springboot-whitespace

Next we will push the image to our dockerhub:
    
    docker push yourusername/springboot-whitespace


## Pull Docker image

    docker pull yc22/springboot-whitespace

## Run Docker container

    docker run --rm -d 8080:8080 yourusername/springboot-whitespace
## Test Docker container from CLI

To test the container from the 

    curl localhost:8080

If everything is functioning correctly the output should read "Greetings from Spring Boot!"


## Test Docker container from Web Browser

To test the application from a web browser first we must edit the inbound rules inside of the security groups for our EC2 instance. This will expose port :8080 for external traffic.

Open security groups and click "edit inbound rules"

Next click "add rule"

Add port :8080 to your "port range"

Modify source to "Anywhere-IPv4

Type should be "Custom TCP"

Once you have made those changes click "Save rules"

After you have saved the rules, go to your browser and input your server's IP address followed by port :8080.

You will now see "Greetings from Spring Boot!" as the output.




