#!/bin/bash

echo Введите ip адрес сервера
read serverIp

file_a="./hosts.dist"
file_b="./hosts"

if [ ! -f "$file_a" ]; then
  echo "Ошибка: Файл $file_a не существует."
  exit 1
fi

sed_command="s/<server_ip>/${serverIp}/g"
eval "sed \"$sed_command\" \"$file_a\" > \"$file_b\""

if [ $? -eq 0 ]; then
  echo "Создан файл hosts"
else
  echo "Ошибка при выполнении команды sed."
  exit 1
fi

ansible-playbook --become --become-user root --become-method sudo -i hosts nextcloud.yaml

exit 0

