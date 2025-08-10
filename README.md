# Laboratório de Automações - Raspberry Pi 4

Laboratório completo de automações com n8n, PostgreSQL e Ollama otimizado para Raspberry Pi 4.

## 📋 Pré-requisitos

- Raspberry Pi 4 (4GB ou 8GB RAM recomendado)
- Docker e Docker Compose instalados
- Cartão SD de 32GB ou mais (recomendado 64GB)

## 🚀 Instalação Rápida

```bash
# Primeira execução
make first-run
```

## 🛠️ Comandos Disponíveis

| Comando | Descrição |
|---------|-----------|
| `make up` | Inicia todos os serviços |
| `make down` | Para todos os serviços |
| `make restart` | Reinicia todos os serviços |
| `make logs` | Mostra logs de todos os serviços |
| `make status` | Verifica status dos serviços |
| `make clean` | Remove todos os dados (cuidado!) |
| `make backup` | Faz backup dos dados |
| `make update` | Atualiza imagens e reinicia |

## 🌐 Acessos

- **n8n**: http://localhost:5678
  - Usuário: admin
  - Senha: admin123

- **PostgreSQL**: localhost:5432
  - Database: n8n
  - Usuário: n8n
  - Senha: n8n_password

- **Ollama API**: http://localhost:11434

## 📊 Modelos Ollama Recomendados para Raspberry Pi

Execute o script para baixar modelos otimizados:
```bash
./scripts/download-models.sh
```

Modelos disponíveis:
- **tinyllama**: 1.1GB - Modelo leve para tarefas básicas
- **phi3**: 2.3GB - Excelente desempenho para o tamanho
- **orca-mini**: 1.9GB - Otimizado para instruções

## 🔧 Configuração Personalizada

### Variáveis de Ambiente
Edite o arquivo `.env` para personalizar:
- Credenciais de acesso
- Portas
- Configurações de rede

## 🐛 Solução de Problemas

### Memória Insuficiente
Se encontrar problemas de memória, edite `docker-compose.yml` e reduza os limites:
```yaml
deploy:
  resources:
    limits:
      memory: 512M  # Reduza de 1G para 512M
```

### Lentidão no Raspberry Pi
- Use cartão SD de alta velocidade (Class 10 ou superior)
- Considere usar SSD USB 3.0 para melhor performance
- Monitore temperatura: `vcgencmd measure_temp`

## 📈 Monitoramento

Verifique uso de recursos:
```bash
# Uso de CPU e memória
docker stats

# Logs em tempo real
make logs-n8n
make logs-ollama
```

## 🔒 Segurança

- Altere as senhas padrão no arquivo `.env`
- Configure firewall se exposto à internet
