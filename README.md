# ValeriyTyutyunnik_microservices

[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_microservices)


## docker-2

1. Установлен docker-machine (docker уже был)
2. Поднят docker-host в YC, создан и запушен имайдж в docker hub
3. Создан прототип инфраструктуры под докер: создание образа с установленным docker через packer, поднятие инстансов через терраформ, запуск контейнера через ansible
4. Ansible можно запусти через vagrant (Vagrantfile в директории docker-monolith/infra/ansible)
```
# Из директории docker-monolith/infra
packer build -var-file=packer/variables.json packer/docker_host.json

# docker-monolith/infra/terraform
terraform apply -auto-approve

# из директории docker-monolith/infra/ansible
ansansible-playbook -i environments/dynamic_inventory.py playbooks/deploy.yml
```
