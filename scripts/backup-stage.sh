#!/bin/bash

# Pasta do projeto: /mnt/disco_d/projetos/rust/cosmic-player/
# Pasta para o backup: /mnt/disco_d/projetos/rust/cosmic-player/scripts/backup_stage/

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Atualizado para o caminho do seu projeto Rust
SRC_DIR="/mnt/disco_d/projetos/rust/cosmic-player"
BASE_BACKUP_DIR="${SCRIPT_DIR}/backup_stage"
BACKUP_FLAT_DIR="${BASE_BACKUP_DIR}/flat"
BACKUP_HIE_DIR="${BASE_BACKUP_DIR}/hierarquico"

echo "Limpando backups anteriores..."
rm -rf "$BACKUP_FLAT_DIR"
rm -rf "$BACKUP_HIE_DIR"

mkdir -p "$BACKUP_FLAT_DIR"
mkdir -p "$BACKUP_HIE_DIR"

cd "$SRC_DIR" || { echo "Erro: pasta do projeto não encontrada."; exit 1; }

echo "Iniciando cópia dos arquivos do stage (ignorando 'target')..."

# Variável para armazenar os caminhos processados
arquivos_processados=""

# Lista arquivos no stage e filtra a pasta target
# O processo é feito via process substitution <() para manter as variáveis vivas fora do loop
while read -r file; do

  # --- 1. BACKUP FLAT ---
  base_name=$(basename "$file")
  dst_flat="$BACKUP_FLAT_DIR/$base_name"

  if [ -e "$dst_flat" ]; then
    timestamp=$(date +%s%N)
    dst_flat="$BACKUP_FLAT_DIR/${timestamp}_${base_name}"
  fi

  git show ":$file" > "$dst_flat"

  # --- 2. BACKUP HIERÁRQUICO ---
  dst_hie="$BACKUP_HIE_DIR/$file"
  mkdir -p "$(dirname "$dst_hie")"
  git show ":$file" > "$dst_hie"

  # Adiciona o caminho absoluto à lista
  arquivos_processados+="$SRC_DIR/$file\n"

done < <(git diff --cached --name-only | grep -v "^target/")

echo "--------------------------------------"
echo "Backup finalizado com sucesso!"
echo "Local: $BASE_BACKUP_DIR"
echo -e "\nArquivos processados (Caminhos Completos):"
echo -e "------------------------"
echo -e "$arquivos_processados"