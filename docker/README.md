### `docker/README.md`

## Развёртывание сервисов в Docker Swarm

### Настройка кластера

```bash
docker swarm init --advertise-addr <EXTERNAL_IP>
docker swarm join --token <TOKEN> <MANAGER_IP>:2377

# Развёртывание сервисов
docker network create --driver overlay shop_default

# пример запуска frontend
docker service create \
  --name shop_frontend \
  --network shop_default \
  --env CURRENCY_SERVICE_ADDR=currencyservice:7000 \
  --publish 80:8080 \
  gcr.io/google-samples/microservices-demo/frontend:v0.8.0

# Масштабирование
docker service scale shop_frontend=2
