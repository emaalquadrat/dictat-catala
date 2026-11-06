# Dictat en català, local i lliure

Dicta en català i fes que el text aparegui escrit on tens el cursor, amb un clic o una drecera de teclat. **La veu es transcriu al teu ordinador**: l'àudio no surt cap a cap servidor.

Funciona sobre [Speech Note](https://github.com/mkiol/dsnote), una aplicació lliure per a Linux que fa servir models Whisper en local. Aquest repositori hi afegeix una capa petita perquè sigui còmoda d'usar:

- **Un sol botó que alterna:** primer clic, comença a escoltar (sona un avís); segon clic, atura i lliura el text.
- **Dues destinacions:** escriure directament a la finestra activa, o copiar-ho al porta-retalls.
- **Drecera de teclat** opcional: `Super + Z`.
- **El text no s'envia mai sol:** queda escrit perquè el revisis.

Explicació del procés a la Bitàcola de Trama: [Dictar en català sense enviar la veu a ningú](https://trama.emaalquadrat.cat/2026/11/06/dictar-en-catala-sense-enviar-la-veu/).

## Requisits

- Linux amb escriptori GNOME (provat a Ubuntu 24.04, sessió **X11**).
- [Flatpak](https://flatpak.org/setup/) amb el repositori Flathub.
- Un micròfon.
- Uns 2 GB de disc (aplicació + model) i 8 GB de RAM recomanats.

No cal targeta gràfica: el model funciona amb el processador.

## Instal·lació

```bash
git clone https://github.com/emaalquadrat/dictat-catala.git
cd dictat-catala
./install.sh --drecera      # sense --drecera si no vols Super+Z
```

L'script no demana contrasenya: tot queda a la teva carpeta personal. Fa això:

1. Instal·la Speech Note des de Flathub si no hi és.
2. Copia `dictat-alterna` a `~/.local/bin`.
3. Crea tres llançadors: **Dictat**, **Dictat a la finestra** i **Cancel·la el dictat**.
4. Activa a Speech Note el control extern, el mode manual (escolta fins que l'atures, no talla a la primera pausa) i el so d'avís. Abans en fa una còpia: `settings.conf.bak-…`.

Si Speech Note no s'ha obert mai, obre'l un cop, tanca'l i torna a executar l'script.

**Pas manual (un cop):** obre Speech Note → **Idiomes** → **Català** i descarrega **«Català (FasterWhisper Small)»** (uns 250 MB).

Per tenir les icones al costat de les altres aplicacions, busca «Dictat» a la llista d'aplicacions i fes clic dret → *Afegeix als preferits*.

## Ús

| Acció | Com |
|---|---|
| Començar a dictar | Clic a **Dictat a la finestra** o `Super + Z`. Sona un avís. |
| Acabar | Torna a fer clic o `Super + Z`. En uns segons el text apareix on és el cursor. |
| Cancel·lar | **Cancel·la el dictat**: atura sense transcriure. |
| Al porta-retalls | Icona **Dictat**: el text es copia i l'enganxes on vulguis. |

Després de reiniciar no cal fer res: el primer clic obre Speech Note (uns segons) i comença a escoltar.

## Què cal saber

- **No és instantani.** En un ordinador modest (Ryzen 3, sense GPU) cada frase triga uns 4–5 segons a aparèixer. Frases més llargues, proporcionalment més.
- **No cliquis la finestra de Speech Note mentre dictes.** En mode manual, interactuar-hi atura l'escolta i el text va a la nota interna de l'aplicació.
- **Porta-retalls:** si mentre esperes copies o selecciones alguna altra cosa, el dictat es pot perdre. Per escriure en una finestra concreta, millor l'opció *a la finestra*.
- **Wayland:** la inserció a la finestra necessita [`ydotool`](https://github.com/ReimuNotMoe/ydotool) en marxa i permís de Flatpak al seu socket (vegeu la documentació de Speech Note). El mode porta-retalls funciona igual.
- **Privacitat:** el que es queda a l'ordinador és la transcripció. Si després enganxes el text en un servei al núvol, allà s'apliquen les condicions d'aquell servei.

## Desinstal·lar

```bash
rm ~/.local/bin/dictat-alterna ~/.local/share/applications/dictat-*.desktop
flatpak uninstall --user net.mkiol.SpeechNote     # opcional
```

La drecera `Super + Z`, si la vas crear, s'esborra a Configuració → Teclat → Dreceres de teclat → Dreceres personalitzades.

## Crèdits i llicència

- [Speech Note](https://github.com/mkiol/dsnote), de Michal Kosciesza (MPL-2.0), fa tota la feina de reconeixement de veu. Aquest repositori només hi afegeix l'script i els llançadors.
- Fet per [Trama Educació](https://trama.emaalquadrat.cat). Codi sota llicència **GPL-3.0-or-later** (vegeu `LICENSE`).
