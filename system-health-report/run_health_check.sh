#!/bin/bash

BASE_DIR="/home/ubuntu/ansible-assignment/system-health-report"

cd "$BASE_DIR" || exit 1

ansible-playbook -i inventory system_health.yml
