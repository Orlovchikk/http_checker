#!/usr/bin/env bash

# Список кодов для проверки
codes=(100 200 300 400 500)

# Временные файлы для тела ответа и ошибок
body_file=$(mktemp)
err_file=$(mktemp)

# Удаление временных файлов при выходе
trap 'rm -f "$body_file" "$err_file"' EXIT

for code in "${codes[@]}"; do
    url="https://mock.codes/$code"
    
    # Выполнение запроса и сохранение кода ответа в переменную http_code, а тело и ошибки в временные файлы 
    if ! http_code=$(curl -sS -m 10 -w "%{http_code}" -o "$body_file" "$url" 2> "$err_file"); then
        # Вывод ошибки в stderr, если curl завершился с ошибкой
        echo "[ERROR] $url: $(<"$err_file")" >&2
        continue
    fi

    body=$(<"$body_file")
    # Проверка кода ответа и вывод соответствующего сообщения
    if [[ "$http_code" =~ ^[1-3][0-9]{2}$ ]]; then
        echo "[INFO] Status: $http_code Body: $body"
    elif [[ "$http_code" =~ ^[45][0-9]{2}$ ]]; then
        echo "[ERROR] Status=$http_code, url=$url, body=$body" >&2
    else
        echo "[WARN] Unexpected status code $http_code, body: $body"
    fi
done