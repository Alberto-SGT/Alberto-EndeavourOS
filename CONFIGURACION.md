# 📋 Configuración del Sistema — Alberto-EndeavourOS

## 🖥️ Sistema Base
- **Distro:** EndeavourOS (Arch base)
- **Bootloader:** GRUB
- **WM:** i3-gaps
- **Shell:** Zsh + Oh My Zsh
- **Terminal:** Kitty
- **Editor:** Neovim (LazyVim)

---

## 🪟 i3-gaps — `~/.config/i3/config`

| Qué | Línea/Comando | Notas |
|-----|---------------|-------|
| Gaps entre ventanas | `gaps inner 10` / `gaps outer 5` | Al final del config |
| Barra i3 desactivada | Líneas 527-553 comentadas con `sed -i '527,553s/^/#/'` | i3bar reemplazada por polybar |
| Terminal por defecto | `bindsym $mod+Return exec kitty` | Línea 175 |
| Rofi con iconos | `bindsym $mod+d exec rofi -show drun -show-icons` | Línea 592 |
| Picom autoarranque | `exec_always --no-startup-id picom --config ~/.config/picom/picom.conf` | |
| Polybar autoarranque | `exec_always --no-startup-id ~/.config/polybar/launch.sh` | |
| Fondo de pantalla | `exec_always --no-startup-id feh --bg-scale ~/Imágenes/wallpaper.png` | |
| Pantalla bloqueo | `bindsym $mod+l exec ~/.config/i3/scripts/blur-lock` | |
| Cheatsheet atajos | `bindsym $mod+F1 exec ~/.config/rofi/i3-cheatsheet.sh` | |
| Sticky window | `bindsym $mod+Shift+s sticky toggle` | Ventana visible en todos los workspaces |
| Workspaces sin iconos | Líneas 322-326 — `set $ws1 "1"` etc | Quitados iconos por defecto de EndeavourOS |

---

## 📊 Polybar — `~/.config/polybar/config.ini`

| Qué | Valor | Notas |
|-----|-------|-------|
| Fuente | `JetBrainsMono Nerd Font:size=11;2` | `font-0` |
| Módulos izquierda | `xworkspaces xwindow` | |
| Módulos centro | `spotify date` | |
| Módulos derecha | `brightness filesystem pulseaudio memory cpu eth powermenu` | |
| Fecha/hora clickable | `type = custom/script` / `exec = date "+%d/%m/%Y  %H:%M"` | Click abre Google Calendar |
| Botón apagado | `[module/powermenu]` con `rofi-power-menu` | Label: ⏻ |
| Módulo spotify | `playerctl metadata` con interval 2 | Muestra canción activa |
| Script arranque | `~/.config/polybar/launch.sh` | `killall -q polybar && polybar example 2>/dev/null &` |

---

## 🎨 Picom — `~/.config/picom/picom.conf`

| Qué | Valor | Notas |
|-----|-------|-------|
| Transparencia kitty | `opacity = 0.65` en rules | `match = "class_g = 'kitty'"` |
| Transparencia normal | `opacity = 0.85` en rules | `match = "window_type = 'normal'"` |
| Sombras | `shadow = true` / `shadow-radius = 7` | |
| Sintaxis | Usar `rules` moderno | `inactive-opacity` está deprecado y causa warnings |

---

## 🐱 Kitty — `~/.config/kitty/kitty.conf`

| Qué | Valor | Notas |
|-----|-------|-------|
| Fuente | `JetBrainsMono Nerd Font` | `font_family` |
| Tamaño fuente | `12.0` | |
| Fondo | `#282A2E` | |
| Transparencia | Gestionada por picom | `background_opacity` comentado |
| Tema colores | Catppuccin Mocha | 16 colores definidos |
| Selección | `#89B4FA` | Azul |
| Tabs | `powerline` / `slanted` | |
| Padding | `window_padding_width 10` | |
| Scrollback | `10000` líneas | |
| Copia al seleccionar | `copy_on_select yes` | |

---

## 🚀 Rofi — `~/.config/rofi/`

| Qué | Comando | Notas |
|-----|---------|-------|
| Lanzador apps | `rofi -show drun -show-icons` | `Mod + d` |
| Cambiar ventana | `rofi -show window` | `Mod + t` |
| Cheatsheet i3 | `~/.config/rofi/i3-cheatsheet.sh` | `Mod + F1` |

---

## 🐚 Zsh — `~/.zshrc`

| Qué | Valor | Notas |
|-----|-------|-------|
| Tema | `powerlevel10k/powerlevel10k` | `ZSH_THEME` |
| Plugins | `git zsh-syntax-highlighting zsh-autosuggestions` | |
| npm global | `~/.npm-global` | Para Claude Code sin sudo |

---

## 📝 Neovim — `~/.config/nvim/`

| Qué | Archivo | Notas |
|-----|---------|-------|
| Base | LazyVim | `git clone https://github.com/LazyVim/starter` |
| Tema | Catppuccin Mocha | En `lazy.lua` — `opts = { colorscheme = "catppuccin" }` |
| Plugins extra | `lua/plugins/extras.lua` | Catppuccin, nvim-tree, telescope, gitsigns, lazygit, toggleterm, terraform, ansible, indent-blankline |

---

## 🔒 Pantalla de bloqueo — `~/.config/i3/scripts/blur-lock`

- Usa `i3lock-color`
- Captura pantalla con `scrot` y aplica blur con `magick`
- Muestra hora, fecha y usuario
- Ring radius: 200, width: 12
- Colores: Catppuccin Mocha + tonos del wallpaper

---

## 🛠️ Apps DevOps instaladas

| App | Instalación | Notas |
|-----|-------------|-------|
| Docker + compose | `pacman` | `systemctl enable docker` + `usermod -aG docker $USER` |
| Podman | `pacman` | Alternativa a Docker sin daemon |
| Terraform | `pacman` | |
| Ansible | `pacman` | |
| AWS CLI | `pacman` | |
| Google Cloud CLI | `yay` | |
| kubectl + helm | `pacman` | Kubernetes |
| k9s | `yay` | Gestión K8s en terminal |
| PostgreSQL | `pacman` | |
| MongoDB | `yay` (mongodb-bin) | |
| DBeaver | `yay` | Cliente gráfico BBDD |
| Grafana | `pacman` | `http://localhost:3000` |
| Prometheus | `pacman` | `http://localhost:9090` |
| lazygit | `pacman` | |
| Ollama | script oficial | Modelos IA locales — CPU only en VM |
| Claude Code | `npm` global | Autenticación con cuenta Claude.ai |

---

## ⚠️ Errores conocidos y soluciones

| Error | Causa | Solución |
|-------|-------|----------|
| `gaps` orden no encontrada | No es comando de terminal | Va en `~/.config/i3/config` |
| Ruta polybar config | Faltaba `/examples/` | `/usr/share/doc/polybar/examples/config.ini` |
| `inactive-opacity` warnings en picom | Sintaxis antigua | Usar bloque `rules` moderno |
| Picom no arranca solo | No estaba en autoarranque | `exec_always --no-startup-id picom --config ~/.config/picom/picom.conf` en i3 config |
| Polybar no arranca sola | Ruta mal escrita `~./` | Corregir a `~/` en i3 config |
| `lazygit` error 404 mirrors | Mirror desactualizado | `sudo pacman -Sy && sudo pacman -S lazygit` |
| npm sin permisos | Instalación global sin permisos | `mkdir ~/.npm-global && npm config set prefix ~/.npm-global` |
| Kitty transparencia no cambia | picom gestiona la opacidad | Usar `rules` en picom.conf con `class_g = 'kitty'` |
| Workspaces con iconos | EndeavourOS los define en i3 config | Cambiar líneas 322-326 a solo números |

---

## 📌 Pendiente

- [ ] Pantalla de login LightDM (slick-greeter)
- [ ] Brillo en polybar (funciona en ordenador real con pantalla)
- [ ] Spotify en polybar (funciona cuando hay reproductor activo)
- [ ] Jenkins
- [ ] Neovim LSP configurado por idioma
