#!/bin/bash

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
  jdk-openjdk \
  pass \
  keepassxc \
  i3lock

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
  onedrive-abraunegg \
  ollama

echo "==> Instalando TPM (Tmux Plugin Manager)..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/scripts/install_plugins.sh
ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf

echo "==> Instalando Oh My Zsh..."
RUNZSH=no CHSH=yes curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/omz.sh
ZSH= sh /tmp/omz.sh

echo "==> Instalando plugins Zsh..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

echo "==> Instalando Claude Code..."
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
npm install -g @anthropic-ai/claude-code

echo "==> Copiando configs..."
mkdir -p ~/.config/tmux
cp config/tmux/tmux.conf ~/.config/tmux/tmux.conf
mkdir -p ~/.config/i3
mkdir -p ~/.config/kitty
mkdir -p ~/.config/polybar
mkdir -p ~/.config/picom
mkdir -p ~/.config/rofi
mkdir -p ~/.config/nvim

cp -r config/i3/* ~/.config/i3/
cp -r config/kitty/* ~/.config/kitty/
cp -r config/polybar/* ~/.config/polybar/
cp config/picom/picom.conf ~/.config/picom/
cp -r config/rofi/* ~/.config/rofi/
cp -r config/nvim/* ~/.config/nvim/

echo "==> Aplicando permisos..."
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/i3/scripts/blur-lock

echo "==> Configurando servicios..."
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
sudo systemctl enable --now grafana
sudo systemctl enable --now prometheus
sudo systemctl enable --now jenkins

echo "==> Configurando npm global..."
echo 'export PATH=~/.npm-global/bin:$PATH' >>~/.zshrc

echo "==> Instalando LazyVim..."
git clone https://github.com/LazyVim/starter ~/.config/nvim
cp -r config/nvim/* ~/.config/nvim/

echo "==> Instalando Ollama modelo..."
ollama pull llama3.2

echo "✅ Instalación completa. Reinicia el sistema."
