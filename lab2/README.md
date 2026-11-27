# Конкурентный контейнер

## 1. Создание разделяемого тома
```sh
docker volume create shared_vol
```

## 2. Сборка образа
```sh
docker build -t concurrent-container .
```

## 3. Запуск контейнеров
Каталог /shared внутри контейнера подключается к общему тому shared_vol:

### 1 экземпляр
```sh
docker run -d --name cc-1 -v shared_vol:/shared concurrent-container
```

### 10 экземпляров
```sh
for i in $(seq 1 10); do
    docker run -d --name "cc-$i" -v shared_vol:/shared concurrent-container
done
```

### 50 экземпляров
```sh
for i in $(seq 1 50); do
    docker run -d --name "cc-$i" -v shared_vol:/shared concurrent-container
done
```
