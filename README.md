# Тестовое задание: Пошаговая автоматизация с использованием Bash/Python, Docker и Ansible

## 📂 Структура репозитория

```text
.
├── part1_script/           # Раздел 1: Работа со скриптом
│   └── http_checker.sh
├── part2_docker/           # Раздел 2: Работа с Docker
│   ├── Dockerfile
├── part3_ansible/          # Раздел 3: Автоматизация процесса с помощью Ansible
│   ├── ansible.cfg
│   ├── requirements.yml
│   ├── inventory/
│   ├── playbooks/
│   │   └── main.yml
│   ├── roles/
│   │   ├── docker/
│   │   └── http_checker/
│   └── molecule/
└── README.md
```

## Раздел 1

Был написан bash-скрипт, который выполняет HTTP-запросы к сервису <https://mock.codes/>, так как <https://httpstat.us/> не был доступен, и логирует ответы в консоль.

## Раздел 2

Был разработан Docker образ на базе Ubuntu 22.04, который устанавливает зависимость curl и запускает скрипт из Раздела 1. Образ был запушен на docker hub под именем orlovchik/http_checker:1

## Раздел 3

Был написан Ansible Playbook, который использует 2 роли: docker, отвечающую за установку Docker на целевой хост, и http_checker, которая запускает образ из Раздела 2 и собирает логи.

Также для тестирования была добавлена molecule. Тестирование запускалось на хостах Ubuntu:jammy и Debian:12. Все тесты прошли успешно, подтверждая работоспособность playbook'а.
