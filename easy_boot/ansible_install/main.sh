#!/bin/bash
set -x

ansible-playbook bootstrap.yaml -i hosts -k -K
ansible-playbook install.yaml -i hosts -k -K
ansible-playbook run.yaml -i hosts -k -K
