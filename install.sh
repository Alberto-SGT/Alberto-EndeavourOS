#!/bin/bash

set -e # Parar si hay error crítico

echo "==> Actualizando sistema..."
sudo pacman -Syu --noconfirm

echo "==> Instalando paquetes base..."
sudo pacman -S --noconfirm \
  i3-gaps \
  polybar \
  picom \
  rofi \
  feh \
  kitty \
  ttf-jetbrains-mono \
  ttf-jetbrains-mono-nerd \
  ttf-font-awesome \
  neovim \
  zsh \
  git \
  curl \
  wget \
  htop \
  tmux \
  openssh \
  python \
  go \
  jq \
  docker \
  docker-compose \
  podman \
  terraform \
  ansible \
  aws-cli \
  kubectl \
  helm \
  postgresql \
  grafana \
  prometheus \
  nodejs \
  npm \
  playerctl \
  brightnessctl \
  lazygit \
  pass \
  i3lock \
  keepassxc \
  jdk-openjdk \
  xclip \
  scrot \
  imagemagick

echo "==> Instalando paquetes AUR..."
yay -S --noconfirm \
  rofi-power-menu \
  google-cloud-cli \
  k9s \
  mongodb-bin \
  dbeaver \
  i3lock-color \
  lightdm-slick-greeter \
  jenkins \
  ollama \
  onedrive-abraunegg

echo "==> Instalando Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/omz.sh
  RUNZSH=no CHSH=yes ZSH= sh /tmp/omz.sh --unattended
  # Cambiar shell a zsh
  sudo chsh -s /usr/bin/zsh $USER
else
  echo "Oh My Zsh ya instalado, omitiendo..."
fi

echo "==> Instalando plugins Zsh..."
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ] &&
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] &&
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ] &&
  git clone https://github.com/romkatv/powerlevel10k.git \
    ~/.oh-my-zsh/custom/themes/powerlevel10k

echo "==> Configurando .zshrc..."
# Cambiar tema
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
# Cambiar plugins
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
# Añadir npm global al PATH
grep -q "npm-global" ~/.zshrc || echo 'export PATH=~/.npm-global/bin:$PATH' >>~/.zshrc

echo "==> Instalando TPM (Tmux Plugin Manager)..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
~/.tmux/plugins/tpm/scripts/install_plugins.sh
[ ! -f "$HOME/.tmux.conf" ] && ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf

echo "==> Instalando Claude Code..."
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
npm install -g @anthropic-ai/claude-code

echo "==> Copiando configs..."
mkdir -p ~/.config/i3
mkdir -p ~/.config/polybar
mkdir -p ~/.config/picom
mkdir -p ~/.config/kitty
mkdir -p ~/.config/rofi
mkdir -p ~/.config/tmux

cp -r config/i3/* ~/.config/i3/
cp -r config/polybar/* ~/.config/polybar/
cp config/picom/picom.conf ~/.config/picom/
cp -r config/kitty/* ~/.config/kitty/
cp -r config/rofi/* ~/.config/rofi/
cp config/tmux/tmux.conf ~/.config/tmux/tmux.conf

echo "==> Instalando LazyVim..."
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi
# Copiar plugins personalizados encima de LazyVim
cp -r config/nvim/* ~/.config/nvim/

echo "==> Aplicando permisos..."
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/i3/scripts/blur-lock

echo "==> Configurando fondo de pantalla..."
sudo mkdir -p /usr/share/backgrounds
sudo cp wallpaper.png /usr/share/backgrounds/wallpaper.png

echo "==> Configurando LightDM..."
sudo cp config/lightdm-slick-greeter.conf /etc/lightdm/slick-greeter.conf

echo "==> Configurando servicios..."
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
sudo systemctl enable --now grafana
sudo systemctl enable --now prometheus
sudo systemctl enable --now jenkins
sudo systemctl enable --now ollama

echo "==> Configurando npm global..."
grep -q "npm-global" ~/.zshrc || echo 'export PATH=~/.npm-global/bin:$PATH' >>~/.zshrc

echo "==> Descargando modelo Ollama..."
sleep 5 # Esperar a que ollama arranque
ollama pull llama3.2 || echo "Ollama no disponible todavía - ejecuta 'ollama pull llama3.2' manualmente"

echo ""
echo "✅ Instalación completa."
echo ""
echo "⚠️  Pasos manuales pendientes:"
echo "   1. Autenticar Claude Code: claude"
echo "   2. Configurar AWS CLI: aws configure"
echo "   3. Configurar Google Cloud: gcloud auth login"
echo "   4. Configurar OneDrive: onedrive --synchronize"
echo "   5. Reiniciar el sistema: reboot"
echo ""
