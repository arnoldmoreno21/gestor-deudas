#!/bin/bash
set -e

cd "$(dirname "$0")"

echo "=========================================================="
echo "💳 DEUDA CERO: CREAR Y SUBIR REPOSITORIO A GITHUB"
echo "=========================================================="
echo ""

# 1. Verificar si ya está autenticado
if ! gh auth status >/dev/null 2>&1; then
  echo "🔑 Paso 1: Autenticación con GitHub (abrirá tu navegador)..."
  gh auth login -w -p https
else
  echo "✅ Ya estás autenticado en GitHub CLI."
fi

echo ""
echo "🚀 Paso 2: Creando el repositorio 'gestor-deudas' en tu cuenta de GitHub..."

# Comprobar si el remoto ya existe
if ! git remote | grep -q "origin"; then
  gh repo create gestor-deudas --public --source=. --remote=origin --push
else
  git push -u origin main
fi

echo ""
echo "=========================================================="
echo "🎉 ¡LISTO! Tu proyecto ha sido publicado en GitHub con éxito:"
echo "👉 https://github.com/$(gh api user -q .login)/gestor-deudas"
echo "=========================================================="
