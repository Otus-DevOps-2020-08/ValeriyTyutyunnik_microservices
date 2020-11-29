# ValeriyTyutyunnik_microservices

[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_microservices)


## docker-2

1. Установлен docker-machine (docker уже был)
2. Поднят docker-host в YC, создан и запушен имайдж в docker hub
```
yc compute instance create --name docker-host --zone ru-central1-a --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1804-lts,size=15 --ssh-key ~/.ssh/otusyc.pub

docker-machine create --driver generic --generic-ip-address=<PUB IP> --generic-ssh-user yc-user --generic-ssh-key ~/.ssh/otusyc docker-host
eval $(docker-machine env docker-host)
```

3. Создан прототип инфраструктуры под докер: создание образа с установленным docker через packer, поднятие инстансов через терраформ, запуск контейнера через ansible
4. Ansible можно запустить через vagrant (Vagrantfile в директории docker/docker-monolith/infra/ansible)
```
# Из директории docker/docker-monolith/infra
packer build -var-file=packer/variables.json packer/docker_host.json

# docker/docker-monolith/infra/terraform
terraform apply -auto-approve

# из директории docker/docker-monolith/infra/ansible
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

## docker-4

1. Запуск контейнеров в разных сетях
2. Описание развертывания сервисов в docker compouse

Базовое имя проекта по умолчанию принимает значение папки проекта.
Чтобы изменить имя нужно указать свое название с флагом -p, но в этом случае при уничтожении сервисов этот флаг так же нужно задать.
```
docker-compose -p <name> up -d
docker-compose -p <name> down
```
Либо установить переменную окружения COMPOUSE_PROJECT_NAME через export или в .env файле

3. Override compouse конфиг
```
docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

## gitlab-ci

1. Развернут gitlab из контейнера

Запуск привелигерованного раннера в контейнере:
```
docker run -d --name gitlab-runner --restart always \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:latest

docker exec -it gitlab-runner gitlab-runner register \
      --run-untagged \
      --locked=false \
      --non-interactive \
      --url http://<SERVER_IP>/ \
      --registration-token <GITLAB_RUNNER_TOKEN> \
      --description "docker-runner" \
      --tag-list "linux,xenial,ubuntu,docker" \
      --executor docker   \
      --docker-image "alpine:latest" \
      --docker-privileged \
      --docker-volumes "docker-certs-client:/certs/client" \
      --env "DOCKER_DRIVER=overlay2"
```
2. В src/gitlab-ci docker-compouse для запуска раннера с регистраций. Токен и url указываются в .env файле (или переменных окружения системы)
3. Настройка нотификаций в Slack из гитлаба:
- В слаке добавить интеграции с Incoming WebHooks в чате, скопировать ссылку.
- В гиталбе Settings -> Integrations -> Slack notifications -> включить нотификации на нужные события и ссылку нотификации
