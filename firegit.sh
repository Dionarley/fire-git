#!/usr/bin/env bash
set -e

ascii_art=
' _____ _             ____ _ _   
|  ___(_)_ __ ___   / ___(_) |_ 
| |_  | | '__/ _ \ | |  _| | __|
|  _| | | | |  __/ | |_| | | |_ 
|_|   |_|_|  \___|  \____|_|\__|
'
echo -e " ascii_art "

echo "🚀 Iniciando instalador do Git Config Helper..."

# === Detectar SO e gerenciador de pacotes ===
if command -v apt >/dev/null 2>&1; then
  PKG_MANAGER="apt"
elif command -v dnf >/dev/null 2>&1; then
  PKG_MANAGER="dnf"
elif command -v yum >/dev/null 2>&1; then
  PKG_MANAGER="yum"
elif command -v pacman >/dev/null 2>&1; then
  PKG_MANAGER="pacman"
elif command -v pkg >/dev/null 2>&1; then
  PKG_MANAGER="pkg"   # Termux
else
  echo "❌ Não consegui detectar gerenciador de pacotes suportado."
  echo "Instale o Git manualmente e rode novamente."
  exit 1
fi

# === Instalar Git se necessário ===
if ! command -v git >/dev/null 2>&1; then
  echo "📦 Instalando Git com $PKG_MANAGER..."
  case "$PKG_MANAGER" in
    apt) sudo apt update && sudo apt install -y git ;;
    dnf) sudo dnf install -y git ;;
    yum) sudo yum install -y git ;;
    pacman) sudo pacman -Sy --noconfirm git ;;
    pkg) pkg install -y git ;;
  esac
fi

echo "✅ Git instalado: $(git --version)"

# === Coletar dados ===
if [ -z "$GIT_NAME" ]; then
  read -p "Digite seu nome para o Git: " GIT_NAME
fi

if [ -z "$GIT_EMAIL" ]; then
  read -p "Digite seu email para o Git: " GIT_EMAIL
fi

# === Aplicar configuração ===
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"

echo ""
echo "✅ Git configurado com sucesso!"
echo "   Nome  = $(git config --global user.name)"
echo "   Email = $(git config --global user.email)"
echo ""
echo "🚀 Finalizado!"
