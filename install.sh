#!/bin/bash

set -e # Parar si hay error crítico

# ─────────────────────────────────────────────
# COLORES
# ─────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${GREEN}==>${NC} $1"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }

# ─────────────────────────────────────────────
# VERIFICACIONES PREVIAS
# ─────────────────────────────────────────────
info "Verificando entorno..."

# Verificar que se ejecuta desde el directorio del repo
if [ ! -f "wallpaper.png" ]; then
  error "Ejecuta este script desde el directorio del repositorio (donde está wallpaper.png)"
  exit 1
fi

# Verificar que yay está instalado
if ! command -v yay &>/dev/null; then
  error "yay no está instalado. Instálalo primero: https://github.com/Jguer/yay"
  exit 1
fi

# ─────────────────────────────────────────────
# 1. ACTUALIZAR SISTEMA
# ─────────────────────────────────────────────
info "Actualizando sistema..."
sudo pacman -Syu --noconfirm

# ─────────────────────────────────────────────
# 2. PAQUETES BASE (pacman)
# ─────────────────────────────────────────────
info "Instalando paquetes base..."
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
  keepassxc \
  jdk-openjdk \
  xclip \
  scrot \
  imagemagick \
  blueman \
  network-manager-applet \
  plymouth \
  virtualbox \
  virtualbox-host-modules-arch \
  evince \
  libreoffice-fresh \
  libreoffice-fresh-es
# NOTA: NO incluir i3lock aquí — conflicta con i3lock-color (AUR)

# ─────────────────────────────────────────────
# 3. PAQUETES AUR (yay)
# ─────────────────────────────────────────────
info "Instalando paquetes AUR..."
yay -S --noconfirm \
  rofi-power-menu \
  rofi-wifi-menu \
  google-cloud-cli \
  k9s \
  mongodb-bin \
  dbeaver \
  i3lock-color \
  lightdm-slick-greeter \
  jenkins \
  ollama \
  onedrive-abraunegg \
  spotify \
  plymouth-theme-catppuccin-mocha-git

# ─────────────────────────────────────────────
# 4. OH MY ZSH + PLUGINS
# ─────────────────────────────────────────────
info "Instalando Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o /tmp/omz.sh
  RUNZSH=no CHSH=yes ZSH= sh /tmp/omz.sh --unattended
  sudo chsh -s /usr/bin/zsh $USER
else
  warning "Oh My Zsh ya instalado, omitiendo..."
fi

info "Instalando plugins Zsh..."
[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ] &&
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

[ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ] &&
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ] &&
  git clone https://github.com/romkatv/powerlevel10k.git \
    ~/.oh-my-zsh/custom/themes/powerlevel10k

info "Configurando .zshrc..."
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc
grep -q "npm-global" ~/.zshrc || echo 'export PATH=~/.npm-global/bin:$PATH' >>~/.zshrc

# ─────────────────────────────────────────────
# 5. TMUX
# ─────────────────────────────────────────────
info "Instalando TPM (Tmux Plugin Manager)..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
[ ! -f "$HOME/.tmux.conf" ] && ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
~/.tmux/plugins/tpm/scripts/install_plugins.sh || warning "TPM plugins fallaron — ejecuta manualmente: prefix + I"

# ─────────────────────────────────────────────
# 6. CLAUDE CODE
# ─────────────────────────────────────────────
info "Instalando Claude Code..."
mkdir -p ~/.npm-global
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
npm install -g @anthropic-ai/claude-code

# ─────────────────────────────────────────────
# 7. COPIAR CONFIGS
# ─────────────────────────────────────────────
info "Copiando configuraciones..."
mkdir -p ~/.config/i3/scripts
mkdir -p ~/.config/polybar
mkdir -p ~/.config/picom
mkdir -p ~/.config/kitty
mkdir -p ~/.config/rofi
mkdir -p ~/.config/tmux
mkdir -p ~/.config/nvim

cp -r config/i3/* ~/.config/i3/
cp -r config/polybar/* ~/.config/polybar/
cp config/picom/picom.conf ~/.config/picom/
cp -r config/kitty/* ~/.config/kitty/
cp -r config/rofi/* ~/.config/rofi/
cp config/tmux/tmux.conf ~/.config/tmux/tmux.conf

# Permisos scripts
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/i3/scripts/blur-lock
chmod +x ~/.config/i3/scripts/screenshot.sh
chmod +x ~/.config/i3/scripts/bluetooth-status.sh

# ─────────────────────────────────────────────
# 8. NEOVIM LAZYVIM
# ─────────────────────────────────────────────
info "Instalando LazyVim..."
if [ ! -d "$HOME/.config/nvim" ]; then
  git clone https://github.com/LazyVim/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
fi
cp -r config/nvim/* ~/.config/nvim/

# ─────────────────────────────────────────────
# 9. WALLPAPER Y LIGHTDM
# ─────────────────────────────────────────────
info "Configurando fondo de pantalla..."
sudo mkdir -p /usr/share/backgrounds
sudo cp wallpaper.png /usr/share/backgrounds/wallpaper.png

info "Configurando LightDM..."
sudo cp config/lightdm-slick-greeter.conf /etc/lightdm/slick-greeter.conf

# ─────────────────────────────────────────────
# 10. GRUB — TEMA CATPPUCCIN MOCHA
# ─────────────────────────────────────────────
info "Configurando GRUB..."
sudo mkdir -p /usr/share/grub/themes
sudo cp -r config/grub/catppuccin-mocha-grub-theme /usr/share/grub/themes/

# Reemplazar fondo del tema con nuestro wallpaper
sudo cp wallpaper.png /usr/share/grub/themes/catppuccin-mocha-grub-theme/background.png

# Activar el tema en /etc/default/grub
sudo sed -i 's|#\?GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt"|' /etc/default/grub

# Añadir quiet splash para Plymouth
sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT='/GRUB_CMDLINE_LINUX_DEFAULT='quiet splash /" /etc/default/grub

# Regenerar GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg

# ─────────────────────────────────────────────
# 11. PLYMOUTH — TEMA CUSTOM
# ─────────────────────────────────────────────
info "Configurando Plymouth..."

# Añadir Plymouth a dracut
echo 'add_dracutmodules+=" plymouth "' | sudo tee /etc/dracut.conf.d/plymouth.conf

# Crear tema custom
sudo mkdir -p /usr/share/plymouth/themes/endeavouros-custom
sudo cp wallpaper.png /usr/share/plymouth/themes/endeavouros-custom/background.png

# Generar imágenes con ImageMagick
magick -background none -fill "#CDD6F4" -font Cantarell -weight 700 -pointsize 48 \
  label:"EndeavourOS" /tmp/label.png
magick -size 400x8 xc:"#c94a1a" /tmp/progress_bar.png
magick -size 400x8 xc:"#2a2a2a" /tmp/progress_bg.png

sudo cp /tmp/label.png /tmp/progress_bar.png /tmp/progress_bg.png \
  /usr/share/plymouth/themes/endeavouros-custom/

# Descriptor del tema
sudo tee /usr/share/plymouth/themes/endeavouros-custom/endeavouros-custom.plymouth <<'EOF'
[Plymouth Theme]
Name=EndeavourOS Custom
Description=EndeavourOS custom theme with wallpaper and progress bar
ModuleName=script

[script]
ImageDir=/usr/share/plymouth/themes/endeavouros-custom
ScriptFile=/usr/share/plymouth/themes/endeavouros-custom/endeavouros-custom.script
EOF

# Script del tema
sudo tee /usr/share/plymouth/themes/endeavouros-custom/endeavouros-custom.script <<'EOF'
bg = Image("background.png");
bg_sprite = Sprite(bg.Scale(Window.GetWidth(), Window.GetHeight()));
bg_sprite.SetX(0);
bg_sprite.SetY(0);
bg_sprite.SetZ(-1);

label = Image("label.png");
label_sprite = Sprite(label);
label_sprite.SetX(Window.GetWidth() / 2 - label.GetWidth() / 2);
label_sprite.SetY(Window.GetHeight() * 0.72);

bar_bg = Image("progress_bg.png");
bar_bg_sprite = Sprite(bar_bg);
bar_bg_sprite.SetX(Window.GetWidth() / 2 - 200);
bar_bg_sprite.SetY(Window.GetHeight() * 0.80);

bar = Image("progress_bar.png");
bar_sprite = Sprite(bar);
bar_sprite.SetX(Window.GetWidth() / 2 - 200);
bar_sprite.SetY(Window.GetHeight() * 0.80);

progress = 0;

fun boot_progress_cb(time, percent) {
    progress = percent;
    scaled = bar.Scale(Math.Int(400 * percent) + 1, 8);
    bar_sprite.SetImage(scaled);
}

Plymouth.SetBootProgressFunction(boot_progress_cb);
EOF

# Activar tema
sudo plymouth-set-default-theme endeavouros-custom

# Regenerar initramfs
sudo dracut --force /boot/initramfs-linux.img

# ─────────────────────────────────────────────
# 12. SERVICIOS
# ─────────────────────────────────────────────
info "Configurando servicios del sistema..."
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
sudo usermod -aG vboxusers $USER
sudo modprobe vboxdrv
sudo systemctl enable --now grafana
sudo systemctl enable --now prometheus
sudo systemctl enable --now jenkins
sudo systemctl enable --now ollama
sudo systemctl enable --now bluetooth

# ─────────────────────────────────────────────
# 13. OLLAMA — DESCARGAR MODELO
# ─────────────────────────────────────────────
info "Descargando modelo Ollama..."
sleep 5
ollama pull llama3.2 || warning "Ollama no disponible todavía — ejecuta 'ollama pull llama3.2' manualmente"

# ─────────────────────────────────────────────
# FIN
# ─────────────────────────────────────────────
echo ""
echo -e "${GREEN}✅ Instalación completa.${NC}"
echo ""
echo -e "${YELLOW}⚠️  Pasos manuales pendientes:${NC}"
echo "   1. Autenticar Claude Code:       claude"
echo "   2. Configurar AWS CLI:           aws configure"
echo "   3. Configurar Google Cloud:      gcloud auth login"
echo "   4. Configurar OneDrive:          onedrive && systemctl --user enable --now onedrive"
echo "   5. Emparejar Bluetooth:          bluetoothctl → scan on → pair XX:XX → trust XX:XX"
echo "   6. Reiniciar el sistema:         reboot"
echo ""
