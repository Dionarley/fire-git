#!/usr/bin/env bash
set -e

ascii_art=" _____ _             ____ _ _   
|  ___(_)_ __ ___   / ___(_) |_ 
| |_  | | '__/ _ \ | |  _| | __|
|  _| | | | |  __/ | |_| | | |_ 
|_|   |_|_|  \___|  \____|_|\__|"

echo -e "$ascii_art"
echo "🚀 Iniciando configurador do Git..."

# === Passo 1: Verificar se o Git já existe ===
if command -v git >/dev/null 2>&1; then
    echo "✅ Git detectado: $(git --version)"
else
    echo "📦 Git não encontrado. Tentando detectar instalador..."
    
    # === Detectar SO (Apenas se o Git não existir) ===
    if command -v apt >/dev/null 2>&1; then PKG_MANAGER="apt"
    elif command -v dnf >/dev/null 2>&1; then PKG_MANAGER="dnf"
    elif command -v pacman >/dev/null 2>&1; then PKG_MANAGER="pacman"
    else
        echo "❌ Ambiente isolado ou gestor não encontrado. Instale o Git no sistema host."
        exit 1
    fi

    # Instalação (Se encontrar o gestor)
    echo "Instalando via $PKG_MANAGER..."
    # [Comandos de instalação originais aqui...]
fi

# === Passo 2: Coletar dados (Independente do SO) ===
if [ -z "$GIT_NAME" ]; then
  read -p "Digite seu nome para o Git: " GIT_NAME
fi

if [ -z "$GIT_EMAIL" ]; then
  read -p "Digite seu email para o Git: " GIT_EMAIL
fi

# === Passo 3: Aplicar configuração ===
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo -e "\n✅ Git configurado com sucesso!"
echo "   Nome  = $(git config --global user.name)"
echo "   Email = $(git config --global user.email)"
echo -e "\n🚀 Finalizado!"