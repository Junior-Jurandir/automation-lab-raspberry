#!/bin/bash

# Script para baixar modelos otimizados para Raspberry Pi 4

echo "Baixando modelos otimizados para Raspberry Pi 4..."

# Modelos leves recomendados para Raspberry Pi
MODELS=("tinyllama" "phi3" "orca-mini")

for model in "${MODELS[@]}"; do
    echo "Baixando modelo: $model"
    ollama pull $model
done

echo "Modelos baixados com sucesso!"
