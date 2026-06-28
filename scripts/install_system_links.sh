#!/bin/bash

# Define os caminhos
PROJECT_DIR="/mnt/disco_d/projetos/rust/cosmic-player"
BINARY_PATH="$PROJECT_DIR/target/debug/cosmic-player"
LOCAL_BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"

echo "Configurando links do sistema para usar o cosmic-player do projeto..."

# 1. Garante que o diretório bin local existe
mkdir -p "$LOCAL_BIN_DIR"

# 2. Cria um link simbólico para o binário do projeto
# Isso fará com que o comando 'cosmic-player' no terminal use a versão do projeto
# (Assumindo que ~/.local/bin está no seu PATH)
ln -sf "$PROJECT_DIR/scripts/run.sh" "$LOCAL_BIN_DIR/cosmic-player"

# 3. Substitui o atalho do sistema
# Remove o atalho original se existir na pasta de usuário para evitar conflitos
rm -f "$DESKTOP_DIR/com.system76.CosmicPlayer.desktop"

# Copia o nosso atalho com o nome padrão do sistema para sobrepor o ícone do menu
cp "$PROJECT_DIR/scripts/cosmic-player.desktop" "$DESKTOP_DIR/com.system76.CosmicPlayer.desktop"

# 4. Atualiza o banco de dados de aplicativos
update-desktop-database "$DESKTOP_DIR"

echo "Sucesso!"
echo "Terminal: Agora o comando 'cosmic-player' usará a versão deste projeto."
echo "Menu: O atalho do sistema agora aponta para o script de execução deste projeto."
echo "Nota: Certifique-se de que '$LOCAL_BIN_DIR' está no seu PATH do terminal."
