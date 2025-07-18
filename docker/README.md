### `docker/README.md`

```markdown
## Развёртывание сервисов в Docker Swarm

### Настройка кластера

```bash
docker swarm init --advertise-addr <EXTERNAL_IP>
docker swarm join --token <TOKEN> <MANAGER_IP>:2377
