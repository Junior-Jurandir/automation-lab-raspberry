.PHONY: help up down restart logs clean install

# Cores para output
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

help: ## Mostra comandos disponíveis
	@echo ''
	@echo 'Comandos disponíveis:'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "; printf "  ${YELLOW}%-20s${RESET} %s\n", $$1, $$2}'

up: ## Inicia todos os serviços
	@echo "${GREEN}Iniciando laboratório de automações...${RESET}"
	docker-compose up -d

down: ## Para todos os serviços
	@echo "${YELLOW}Parando todos os serviços...${RESET}"
	docker-compose down

restart: ## Reinicia todos os serviços
	@echo "${GREEN}Reiniciando serviços...${RESET}"
	docker-compose restart

logs: ## Mostra logs de todos os serviços
	docker-compose logs -f

logs-n8n: ## Mostra logs do n8n
	docker-compose logs -f n8n

logs-ollama: ## Mostra logs do Ollama
	docker-compose logs -f ollama

logs-postgres: ## Mostra logs do PostgreSQL
	docker-compose logs -f postgres

clean: ## Remove todos os containers e volumes
	@echo "${RED}Limpando todos os dados...${RESET}"
	docker-compose down -v
	docker system prune -f

install: ## Instala dependências e prepara ambiente
	@echo "${GREEN}Preparando ambiente...${RESET}"
	mkdir -p n8n-workflows ollama-models n8n-custom
	chmod +x scripts/download-models.sh

status: ## Verifica status dos serviços
	@echo "${GREEN}Status dos serviços:${RESET}"
	docker-compose ps

pull: ## Atualiza imagens Docker
	@echo "${GREEN}Atualizando imagens...${RESET}"
	docker-compose pull

update: ## Atualiza e reinicia serviços
	@echo "${GREEN}Atualizando serviços...${RESET}"
	docker-compose pull
	docker-compose up -d

backup: ## Faz backup dos dados
	@echo "${GREEN}Fazendo backup...${RESET}"
	mkdir -p backups
	docker-compose exec postgres pg_dump -U n8n n8n > backups/n8n_backup_$(shell date +%Y%m%d_%H%M%S).sql
	docker run --rm -v n8n_data:/data -v $(PWD)/backups:/backup alpine tar czf /backup/n8n_data_$(shell date +%Y%m%d_%H%M%S).tar.gz /data

restore: ## Restaura backup (especifique arquivo)
	@echo "${YELLOW}Use: make restore FILE=nome_do_backup.sql${RESET}"

first-run: ## Primeira execução com configuração inicial
	@echo "${GREEN}Executando primeira configuração...${RESET}"
	make install
	make up
	@echo "${GREEN}Aguardando inicialização...${RESET}"
	sleep 30
	@echo "${GREEN}Laboratório pronto! Acesse: http://localhost:5678${RESET}"
