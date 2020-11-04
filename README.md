# ValeriyTyutyunnik_microservices

[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_microservices)


## docker-2

1. Установлен docker-machine (docker уже был)
2. Поднят docker-host в YC, создан и запушен имайдж в docker hub
3. Создан прототип инфраструктуры под докер: создание образа с установленным docker через packer, поднятие инстансов через терраформ, запуск контейнера через ansible
4. Ansible можно запустить через vagrant (Vagrantfile в директории docker-monolith/infra/ansible)
```
# Из директории docker-monolith/infra
packer build -var-file=packer/variables.json packer/docker_host.json

# docker-monolith/infra/terraform
terraform apply -auto-approve

# из директории docker-monolith/infra/ansible
ansible-playbook -i environments/dynamic_inventory.py playbooks/deploy.yml
```

## docker-3

1. Запуск микросервисов в докере
2. Использование hadolint через контейнер докера
```
docker run --rm -i hadolint/hadolint < Dockerfile
```
3. Запуск сети докер контейнеров с другими алиасами и переменными окружения (без изменения Dockerfile) через опцию --env (-e)
```
docker run -d --network=reddit --network-alias=post_db2 --network-alias=comment_db mongo:latest
docker run -d --network=reddit --network-alias=post2 -e POST_DATABASE_HOST=post_db2 allien/post:1.0
docker run -d --network=reddit --network-alias=comment2 -e COMMENT_DATABASE_HOST=comment2 allien/comment:1.0
docker run -d --network=reddit -p 9292:9292 -e POST_SERVICE_HOST=post2 -e COMMENT_SERVICE_HOST=comment2 allien/ui:1.0
```
