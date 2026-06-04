# 🐧 Alberto-EndeavourOS — Dotfiles & DevOps Setup

Configuración completa y reproducible de un entorno Linux basado en **EndeavourOS (Arch)** orientado a **DevOps y uso personal**. Todo el sistema está documentado y automatizado para poder replicarlo en cualquier máquina con un solo script.

---

## 📋 Índice

- [Requisitos previos](#requisitos-previos)
- [Instalación rápida](#instalación-rápida)
- [Entorno visual](#entorno-visual)
- [Terminal y Shell](#terminal-y-shell)
- [Editor — Neovim](#editor--neovim)
- [Stack DevOps](#stack-devops)
- [Inteligencia Artificial](#inteligencia-artificial)
- [Seguridad](#seguridad)
- [Estructura del repositorio](#estructura-del-repositorio)
- [Pendiente](#pendiente)

---

## ⚙️ Requisitos previos

1. **EndeavourOS** instalado con el instalador online seleccionando **i3-wm**
2. **Secure Boot** desactivado en BIOS
3. **yay** instalado (AUR helper)
4. Conexión a internet
5. Cuenta en **GitHub** con token de acceso personal

### Instalar yay si no está disponible
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
```

---

## 🚀 Instalación rápida

```bash
# Clonar el repositorio
git clone https://github.com/Alberto-SGT/Alberto-EndeavourOS.git ~/dotfiles

# Entrar al directorio
cd ~/dotfiles

# Dar permisos y ejecutar
chmod +x install.sh
./install.sh
```

> ⚠️ El script instalará todos los paquetes, copiará las configs y configurará los servicios automáticamente. Solo se requiere intervención manual para las credenciales (API keys, OneDrive).

### Post-instalación manual
```bash
# Autenticar Claude Code
claude

# Configurar OneDrive
onedrive --synchronize

# Configurar AWS CLI
aws configure

# Configurar Google Cloud
gcloud auth login
```

---

## 🪟 Entorno Visual

### Window Manager — i3-gaps
Tiling window manager para X11. Las ventanas se organizan automáticamente sin solaparse.

**Config:** `~/.config/i3/config`

| Atajo | Acción |
|-------|--------|
| `Mod + Enter` | Terminal (Kitty) |
| `Mod + d` | Lanzador apps (Rofi) |
| `Mod + q` | Cerrar ventana |
| `Mod + f` | Pantalla completa |
| `Mod + l` | Bloquear pantalla |
| `Mod + F1` | Cheatsheet de atajos |
| `Mod + Shift+r` | Reiniciar i3 |
| `Mod + Shift+e` | Menú apagado |
| `Mod + 1..9` | Cambiar workspace |
| `Mod + Shift+1..9` | Mover ventana a workspace |
| `Mod + Tab` | Workspace siguiente |
| `Mod + Shift+Tab` | Workspace anterior |
| `Mod + h/v` | Dividir horizontal/vertical |
| `Mod + s` | Layout stacking |
| `Mod + g` | Layout tabbed |
| `Mod + Shift+Space` | Alternar flotante/tiling |
| `Mod + Shift+s` | Sticky (visible en todos los workspaces) |

**Modificaciones aplicadas:**
- Gaps inner 10 / outer 5
- Barra i3 desactivada (líneas 527-553 comentadas)
- Polybar como barra de estado
- Picom como compositor
- Feh para fondo de pantalla automático

---

### Polybar
Barra de estado superior con módulos informativos.

**Config:** `~/.config/polybar/config.ini`
**Script arranque:** `~/.config/polybar/launch.sh`

| Posición | Módulos |
|----------|---------|
| Izquierda | Workspaces, título ventana activa |
| Centro | Spotify, fecha/hora (click → Google Calendar) |
| Derecha | Brillo, filesystem, volumen, RAM, CPU, red, PWR |

**Botón PWR:** abre menú con Shutdown, Reboot, Suspend, Hibernate, Log out, Lock screen.

---

### Picom
Compositor para X11 — gestiona transparencias y sombras.

**Config:** `~/.config/picom/picom.conf`

- Transparencia Kitty: `0.65`
- Transparencia ventanas normales: `0.85`
- Sintaxis moderna `rules` (la antigua `inactive-opacity` está deprecada)

---

### Rofi
Lanzador de aplicaciones moderno con iconos.

**Config:** `~/.config/rofi/`

```bash
# Lanzador apps
rofi -show drun -show-icons

# Cheatsheet atajos i3
~/.config/rofi/i3-cheatsheet.sh
```

---

### Pantalla de bloqueo — i3lock-color
Pantalla de bloqueo con fondo difuminado, hora, fecha y usuario.

**Script:** `~/.config/i3/scripts/blur-lock`
**Atajo:** `Mod + l`

- Captura pantalla con `scrot` y aplica blur con `magick`
- Ring radius: 200, width: 12
- Colores Catppuccin Mocha + tonos del wallpaper

---

### Pantalla de login — LightDM Slick Greeter
**Config:** `/etc/lightdm/slick-greeter.conf`

- Fondo: wallpaper personalizado
- Grid desactivado
- Botón de apagado visible

---

## 💻 Terminal y Shell

### Kitty
Terminal GPU-accelerated con soporte de tabs y transparencia.

**Config:** `~/.config/kitty/kitty.conf`

| Parámetro | Valor |
|-----------|-------|
| Fuente | JetBrains Mono Nerd Font |
| Tamaño | 12.0 |
| Tema | Catppuccin Mocha |
| Transparencia | Gestionada por picom (0.65) |
| Selección | Azul `#89B4FA` |
| Tabs | Powerline slanted |
| Scrollback | 10000 líneas |

**Atajos Kitty:**
| Atajo | Acción |
|-------|--------|
| `Ctrl+Shift+T` | Nueva tab |
| `Ctrl+Shift+V` | Pegar |

---

### Zsh + Oh My Zsh
Shell con plugins y tema visual.

**Config:** `~/.zshrc`

| Componente | Valor |
|------------|-------|
| Tema | Powerlevel10k |
| Plugins | git, zsh-syntax-highlighting, zsh-autosuggestions |

**Características:**
- Prompt muestra rama git activa
- Comandos en verde (válidos) o rojo (inválidos)
- Sugerencias al escribir basadas en historial

---

### Tmux
Multiplexor de terminal — esencial para sesiones remotas SSH.

**Config:** `~/.config/tmux/tmux.conf`
**Symlink:** `~/.tmux.conf`

| Atajo | Acción |
|-------|--------|
| `Ctrl+a` | Prefix |
| `Ctrl+a + -` | Dividir vertical |
| `Ctrl+a + h` | Dividir horizontal |
| `Ctrl+a + r` | Recargar config |
| `Alt+flechas` | Navegar paneles |

**Plugins:**
- `tmux-resurrect` — guardar y restaurar sesiones
- `tmux-continuum` — auto-guardar sesiones cada minuto

---

## 📝 Editor — Neovim

Base: **LazyVim** con configuración personalizada.

**Config:** `~/.config/nvim/`

### Tema
Catppuccin Mocha — configurado en `lua/config/lazy.lua`

### Plugins instalados
| Plugin | Función |
|--------|---------|
| nvim-tree | Árbol de archivos (`<leader>e`) |
| telescope | Buscador de archivos y texto (`<leader>ff`, `<leader>fg`) |
| gitsigns | Cambios git en el margen |
| lazygit.nvim | LazyGit dentro de neovim (`<leader>lg`) |
| toggleterm | Terminal dentro de neovim (`Ctrl+t`) |
| indent-blankline | Líneas de indentación |
| ansible-vim | Syntax highlighting Ansible |
| vim-terraform | Soporte Terraform/HCL |
| catppuccin | Tema visual |

### LSP configurados (Mason)
- `pyright` — Python
- `bash-language-server` — Bash
- `gopls` — Go
- `yaml-language-server` — YAML (Ansible, K8s)
- `terraform-ls` — Terraform
- `lua-language-server` — Lua

---

## 🛠️ Stack DevOps

### Contenedores
```bash
# Docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Verificar
docker --version
docker-compose --version
podman --version
```

### IaC
```bash
terraform --version
ansible --version
```

### Cloud CLI
```bash
# AWS
aws configure

# Google Cloud
gcloud auth login
gcloud config set project PROJECT_ID
```

### Kubernetes
```bash
# kubectl
kubectl version --client

# k9s — interfaz TUI para K8s
k9s
```

### Bases de datos
| BBDD | Puerto | Comando |
|------|--------|---------|
| PostgreSQL | 5432 | `psql -U postgres` |
| MongoDB | 27017 | `mongosh` |
| DBeaver | — | `dbeaver` (cliente gráfico) |

### Monitorización
| Servicio | URL | Credenciales |
|---------|-----|-------------|
| Grafana | `http://localhost:3000` | admin/admin |
| Prometheus | `http://localhost:9090` | — |

```bash
sudo systemctl enable --now grafana
sudo systemctl enable --now prometheus
```

### CI/CD — Jenkins
```bash
sudo systemctl enable --now jenkins
# Contraseña inicial:
cat /var/lib/jenkins/secrets/initialAdminPassword
```
**URL:** `http://localhost:8090`

---

## 🤖 Inteligencia Artificial

### Claude Code
CLI oficial de Anthropic para usar Claude en terminal.

```bash
# Autenticar con cuenta Claude.ai
claude
```

**Usos:**
- Generar scripts bash, Dockerfiles, Ansible playbooks
- Revisar y depurar código
- Consultas DevOps en terminal
- Generar commits descriptivos

### Ollama — IA Local
Modelos LLM que corren localmente sin internet.

```bash
# Iniciar servicio
sudo systemctl start ollama

# Ejecutar modelo
ollama run llama3.2

# Listar modelos
ollama list
```

> ⚠️ Requiere GPU para rendimiento óptimo. En CPU-only el modelo va lento.

---

## 🔒 Seguridad

### KeePassXC
Gestor de contraseñas compatible con KeePass (.kdbx).

- Sincronizar BD con OneDrive via cliente `onedrive`
- Compatible con la misma BD de KeePass en Windows

```bash
# Configurar OneDrive
onedrive --synchronize
```

### pass
Gestor de contraseñas en terminal basado en GPG.

```bash
# Inicializar
pass init "tu-email@ejemplo.com"

# Añadir contraseña
pass insert nombre/contraseña

# Ver contraseña
pass nombre/contraseña
```

---

## 📁 Estructura del repositorio
\```
```
Alberto-EndeavourOS/
├── install.sh                    # Script maestro de instalación
├── wallpaper.png                 # Fondo de pantalla
├── README.md                     # Este archivo
├── CONFIGURACION.md              # Documentación técnica detallada
└── config/
├── i3/
│   ├── config                # Config principal i3
│   └── scripts/
│       ├── blur-lock         # Script pantalla bloqueo
│       └── ...               # Scripts auxiliares i3
├── polybar/
│   ├── config.ini            # Config polybar
│   └── launch.sh             # Script arranque polybar
├── picom/
│   └── picom.conf            # Config transparencias
├── kitty/
│   └── kitty.conf            # Config terminal
├── rofi/
│   ├── i3-cheatsheet.sh      # Cheatsheet atajos
│   └── ...                   # Configs rofi
├── nvim/
│   └── lua/
│       ├── config/           # Config LazyVim
│       └── plugins/
│           ├── extras.lua    # Plugins personalizados
│           └── lsp.lua       # Configuración LSP
├── tmux/
│   └── tmux.conf             # Config tmux
└── lightdm-slick-greeter.conf # Config pantalla login
---
```
\```
## ⚠️ Errores conocidos y soluciones

| Error | Causa | Solución |
|-------|-------|----------|
| `gaps` orden no encontrada | No es comando de terminal | Va en `~/.config/i3/config` |
| Picom warnings `inactive-opacity` | Sintaxis antigua | Usar bloque `rules` moderno |
| Picom no arranca solo | No estaba en autoarranque | `exec_always --no-startup-id picom --config ~/.config/picom/picom.conf` |
| Polybar no arranca | Ruta mal `~./` | Corregir a `~/` en i3 config |
| `lazygit` error 404 | Mirror desactualizado | `sudo pacman -Sy && sudo pacman -S lazygit` |
| npm sin permisos | Instalación global sin permisos | `mkdir ~/.npm-global && npm config set prefix ~/.npm-global` |
| Kitty transparencia no cambia | picom gestiona opacidad | Usar `rules` en picom.conf con `class_g = 'kitty'` |
| Workspaces con iconos | EndeavourOS los define en i3 | Cambiar líneas 322-326 a solo números |
| Polybar fondo de pantalla no carga | Nombre archivo incorrecto en ruta | Verificar nombre exacto en `~/Imágenes/` |

---

## 📌 Pendiente

- [ ] Brillo en polybar (requiere pantalla real — `intel_backlight` o `amdgpu_bl0`)
- [ ] Spotify en polybar (funciona cuando hay reproductor activo con playerctl)
- [ ] OneDrive sync configuración en equipo real
- [ ] Jenkins configuración inicial de pipelines
- [ ] Pantalla login LightDM — personalización avanzada de tema slick-greeter

---

## 🖥️ Probado en

- EndeavourOS con i3-wm (online installer)
- VirtualBox VM durante desarrollo
- Arch Linux base compatible

---

*Desarrollado sesión a sesión — configuración progresiva y documentada.*
