#!/bin/bash
yum update -y
yum install -y docker git
service docker start
usermod -a -G docker ec2-user
docker run -d -p 3007:3007 ghcr.io/jayson-s/task-tracker-api:latest