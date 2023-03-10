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

