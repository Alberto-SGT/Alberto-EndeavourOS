#!/bin/bash
cat << 'EOF' | rofi -dmenu -p "i3 atajos" -no-custom
── BÁSICOS ──────────────────────────
Mod + Enter → Terminal (kitty)
Mod + q → Cerrar ventana
Mod + Shift + c → Recargar config
Mod + Shift + r → Reiniciar i3
Mod + Shift + e → Menú apagado
Mod + l → Bloquear pantalla
── APPS ─────────────────────────────
Mod + d → Lanzador apps (rofi)
Mod + t → Cambiar ventana (rofi)
Mod + w → Firefox
Mod + n → Thunar (archivos)
Mod + p → Cambiar dispositivo audio
Mod + Shift + p → Perfiles de energía
── FOCO ─────────────────────────────
Mod + flechas → Mover foco
Mod + j → Foco izquierda
Mod + k → Foco abajo
Mod + b → Foco arriba
Mod + o → Foco derecha
Mod + Space → Alternar foco flotante/tiling
Mod + a → Foco ventana padre
── MOVER VENTANAS ───────────────────
Mod + Shift + flechas → Mover ventana
Mod + Shift + j → Mover ventana izquierda
Mod + Shift + k → Mover ventana abajo
Mod + Shift + b → Mover ventana arriba
Mod + Shift + o → Mover ventana derecha
── WORKSPACES ───────────────────────
Mod + 1..9 → Cambiar workspace
Mod + Shift + 1..9 → Mover ventana a workspace
Mod + Tab → Workspace siguiente
Mod + Shift + Tab → Workspace anterior
Mod + Shift + n → Workspace vacío
── LAYOUTS ──────────────────────────
Mod + s → Layout stacking
Mod + g → Layout tabbed
Mod + e → Layout split
Mod + h → Dividir horizontal
Mod + v → Dividir vertical
Mod + f → Pantalla completa
── FLOTANTE ─────────────────────────
Mod + Shift + Space → Alternar flotante/tiling
Mod + click izq → Mover ventana flotante
Mod + click der → Redimensionar flotante
── VOLUMEN ──────────────────────────
Tecla vol+ → Subir volumen
Tecla vol- → Bajar volumen
Mod + Tecla vol+ → Subir volumen 1% (fino)
Mod + Tecla vol- → Bajar volumen 1% (fino)
Tecla mute → Silenciar
Tecla mute mic → Silenciar micrófono
── BRILLO ───────────────────────────
Tecla brillo+ → Subir brillo
Tecla brillo- → Bajar brillo
── MEDIA ────────────────────────────
Tecla play/pause → Play/Pausa
Tecla siguiente → Siguiente canción
Tecla anterior → Canción anterior
── CAPTURAS ─────────────────────────
Print → Captura pantalla completa
Mod + Print → Captura ventana activa
Mod + Shift + Print → Captura selección
── AYUDA ────────────────────────────
Mod + F1 → Este menú
F1 → Keyhint EndeavourOS
EOF
