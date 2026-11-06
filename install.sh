#!/usr/bin/env bash
# Instal·la el dictat en català amb Speech Note per a l'usuari actual.
# No demana contrasenya d'administració: tot queda a la carpeta personal.
#
# Ús: ./install.sh              instal·la script, llançadors i configuració
#     ./install.sh   --drecera  a més, assigna la drecera Super+Z (GNOME)
#
# Copyright (C) 2026 Trama Educació — GPL-3.0-or-later.
set -euo pipefail

APP=net.mkiol.SpeechNote
DIR="$(cd "$(dirname "$0")" && pwd)"
BIN="$HOME/.local/bin"
APPS="$HOME/.local/share/applications"
CONF="$HOME/.var/app/$APP/config/net.mkiol/dsnote/settings.conf"

echo "1/4 Comprovant Speech Note…"
if ! flatpak info "$APP" >/dev/null 2>&1; then
    echo "   Speech Note no hi és. Instal·lant-lo des de Flathub (usuari)…"
    flatpak install --user -y flathub "$APP"
fi

echo "2/4 Copiant l'script a $BIN…"
mkdir -p "$BIN"
install -m 755 "$DIR/dictat-alterna" "$BIN/dictat-alterna"

echo "3/4 Creant els llançadors…"
mkdir -p "$APPS"
for f in "$DIR"/llancadors/*.desktop; do
    sed "s|@BIN@|$BIN|g" "$f" > "$APPS/$(basename "$f")"
done
update-desktop-database "$APPS" 2>/dev/null || true

echo "4/4 Ajustant la configuració de Speech Note…"
if pgrep -x dsnote >/dev/null; then
    echo "   Speech Note està obert. Tanca'l (també de la safata) i torna a executar aquest script."
    exit 1
fi
if [ ! -f "$CONF" ]; then
    echo "   Encara no hi ha configuració: obre Speech Note un cop, tanca'l i torna a executar l'script."
    exit 1
fi
cp "$CONF" "$CONF.bak-$(date +%Y%m%d-%H%M%S)"
python3 - "$CONF" <<'EOF'
import sys
p = sys.argv[1]
lines = open(p, encoding="utf-8").read().split("\n")
valors = {
    "actions_api_enabled": "true",   # permet controlar-lo des de fora
    "speech_mode": "1",              # manual: escolta fins que l'atures
    "stt_play_beep": "true",         # so d'inici i final
    "desktop_notification_policy": "2",
}
if "[General]" not in lines:
    lines.insert(0, "[General]")
for k, v in valors.items():
    if any(l.startswith(k + "=") for l in lines):
        lines = [f"{k}={v}" if l.startswith(k + "=") else l for l in lines]
    else:
        lines.insert(lines.index("[General]") + 1, f"{k}={v}")
open(p, "w", encoding="utf-8").write("\n".join(lines))
EOF

if [ "${1:-}" = "--drecera" ]; then
    echo "Assignant la drecera Super+Z…"
    BASE=org.gnome.settings-daemon.plugins.media-keys
    P=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/dictat/
    ACTUALS="$(gsettings get $BASE custom-keybindings)"
    if [[ "$ACTUALS" != *"$P"* ]]; then
        if [ "$ACTUALS" = "@as []" ] || [ "$ACTUALS" = "[]" ]; then
            NOUS="['$P']"
        else
            NOUS="${ACTUALS%]}, '$P']"
        fi
        gsettings set $BASE custom-keybindings "$NOUS"
    fi
    S="$BASE.custom-keybinding:$P"
    gsettings set "$S" name 'Dictat a la finestra (inicia / atura)'
    gsettings set "$S" command "$BIN/dictat-alterna finestra"
    gsettings set "$S" binding '<Super>z'
fi

echo
echo "Fet. Falta un pas manual: obre Speech Note → Idiomes → Català"
echo "i descarrega «Català (FasterWhisper Small)». Després ja pots dictar."
