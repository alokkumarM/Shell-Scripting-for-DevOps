#!/bin/bash

set -euo pipefail

# CHECK AWS CLI

check_awscli() {

    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed."
        return 1
    fi

    echo "AWS CLI is installed."
}


# INSTALL AWS CLI

install_awscli() {

    echo "Installing AWS CLI v2..."

    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
        -o awscliv2.zip

    if ! command -v unzip &> /dev/null; then
        echo "Installing unzip..."

        sudo apt-get update
        sudo apt-get install -y unzip
    fi

    unzip -q awscliv2.zip

    sudo ./aws/install

    rm -rf awscliv2.zip aws

    aws --version

    echo "AWS CLI installation completed."
}

# CHECK AWS CREDENTIALS

check_aws_credentials() {

    echo "Checking AWS credentials..."

    if ! aws sts get-caller-identity &> /dev/null; then
        echo "ERROR: AWS credentials are not configured or are invalid."
        echo "Run: aws configure"
        exit 1
    fi

    echo "AWS credentials are valid."
}

# CHECK REQUIRED VARIABLES

check_variables() {

    if [[ -z "$AWS_REGION" ]]; then
        echo "ERROR: AWS_REGION is empty."
        exit 1
    fi

    if [[ -z "$AMI_ID" ]]; then
        echo "ERROR: AMI_ID is empty."
        exit 1
    fi

    if [[ -z "$KEY_NAME" ]]; then
        echo "ERROR: KEY_NAME is empty."
        exit 1
    fi

    if [[ -z "$SUBNET_ID" ]]; then
        echo "ERROR: SUBNET_ID is empty."
        exit 1
    fi

    if [[ -z "$SECURITY_GROUP_ID" ]]; then
        echo "ERROR: SECURITY_GROUP_ID is empty."
        exit 1
    fi

    echo "All required variables are filled."
}

# CHECK AWS REGION

check_region() {

    configured_region=$(aws configure get region || true)

    if [[ -z "$configured_region" ]]; then
        echo "ERROR: AWS CLI region is not configured."
        echo "Run: aws configure"
        exit 1
    fi

    if [[ "$configured_region" != "$AWS_REGION" ]]; then
        echo "ERROR: AWS region mismatch."
        echo "AWS CLI region : $configured_region"
        echo "Script region  : $AWS_REGION"
        exit 1
    fi

    echo "AWS region: $AWS_REGION"
}

# WAIT FOR EC2 INSTANCE
wait_for_instance() {

    local instance_id="$1"

    echo "Waiting for instance $instance_id to become running..."

    for ((i=1; i<=30; i++)); do

        state=$(aws ec2 describe-instances \
            --region "$AWS_REGION" \
            --instance-ids "$instance_id" \
            --query 'Reservations[0].Instances[0].State.Name' \
            --output text)

        echo "Current state: $state"

        if [[ "$state" == "running" ]]; then
            echo "Instance $instance_id is now running."
            return 0
        fi

        if [[ "$state" == "terminated" ||
              "$state" == "shutting-down" ||
              "$state" == "stopped" ]]; then

            echo "ERROR: Instance entered state: $state"
            exit 1
        fi

        sleep 10

    done

    echo "ERROR: Instance did not become running within 5 minutes."
    exit 1
}

# CREATE EC2 INSTANCE

create_ec2_instance() {

    echo "Creating EC2 instance..."

    instance_id=$(aws ec2 run-instances \
        --region "$AWS_REGION" \
        --image-id "$AMI_ID" \
        --instance-type "$INSTANCE_TYPE" \
        --key-name "$KEY_NAME" \
        --subnet-id "$SUBNET_ID" \
        --security-group-ids "$SECURITY_GROUP_ID" \
        --tag-specifications \
        "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
        --query 'Instances[0].InstanceId' \
        --output text
    )

    if [[ -z "$instance_id" || "$instance_id" == "None" ]]; then
        echo "ERROR: Failed to create EC2 instance."
        exit 1
    fi

    echo "EC2 instance created successfully."
    echo "Instance ID: $instance_id"

    wait_for_instance "$instance_id"

    echo "EC2 instance creation completed successfully."
}

# MAIN


main() {

    # Check AWS CLI
    if ! check_awscli; then
        install_awscli
    fi


  # YOUR AWS SETTINGS

    AWS_REGION="ap-south-1"

    AMI_ID="ami-01a00762f46d584a1"

    INSTANCE_TYPE="t3.micro"

    KEY_NAME="task"

    SUBNET_ID="subnet-07c38aabf27a46bb6"

    SECURITY_GROUP_ID="sg-07669ae0effe9272f"

    INSTANCE_NAME="Shell-Script-EC2-Demo"


    # VALIDATE

    check_variables

    check_aws_credentials

    check_region

    # CREATE EC2
    
    create_ec2_instance
}

# START SCRIPT
main "$@"
