# Dictat en català, local i lliure

Dicta en català i fes que el text aparegui escrit on tens el cursor, amb un clic o una drecera de teclat. **La veu es transcriu al teu ordinador**: l'àudio no surt cap a cap servidor.

Explicació del procés a la Bitàcola de Trama: [Dictar en català sense enviar la veu a ningú](https://trama.emaalquadrat.cat/2026/11/06/dictar-en-catala-sense-enviar-la-veu/).

**Hi ha dues versions:**

- **[Windows](#windows)**: sobre [Whisper Local](https://github.com/drajb/whisper-local), amb una configuració en català i un instal·lador d'un sol doble clic.
- **[Linux](#linux)**: sobre [Speech Note](https://github.com/mkiol/dsnote).

Totes dues fan servir el model de veu Whisper al teu ordinador. Estan pensades també perquè les pugui fer servir una persona que no pot escriure amb el teclat: n'hi ha prou de prémer dues tecles, una amb cada mà.

## Windows

### Instal·lar-lo (un sol cop, uns 10 minuts)

1. **[⬇ Descarrega `dictat-catala-windows.zip`](https://github.com/emaalquadrat/dictat-catala/releases/latest/download/dictat-catala-windows.zip)**.
2. Obre la carpeta **Baixades**, fes **clic dret** al fitxer `.zip` → **Extreu-ho tot…** → **Extreu**.
3. A la carpeta que s'obre, fes **doble clic** a **`instala-dictat-catala`**.
   - Si surt l'avís blau **«Windows ha protegit l'ordinador»**, prem **Més informació** → **Executa igualment**. Surt amb tots els programes petits que no paguen una signatura digital.
4. L'instal·lador descarrega el programa, en comprova la integritat, posa la configuració en català i crea la icona **Dictat en català** a l'escriptori. Al final obre el programa.
5. **La primera vegada triga uns minuts**: descarrega el que necessita i el model de veu (uns 500 MB). Cal internet només aquesta vegada.
6. Surt una finestra de benvinguda en anglès. Si vols que el dictat s'obri sol cada vegada que engegues l'ordinador, marca **Start on login**. Després tanca-la.

El programa queda com una icona petita al costat del rellotge. Si el tanques, el tornes a obrir amb la icona **Dictat en català** de l'escriptori.

### Dictar

| Acció | Com |
|---|---|
| Començar | Fes clic on vulguis escriure i prem **Ctrl + Majúscules**. Pots fer servir el Ctrl d'un costat i la Majúscula de l'altre, una tecla amb cada mà. |
| Parlar | En català, amb calma. Pots fer pauses: no s'atura fins que tu ho dius. |
| Acabar | Prem **Ctrl**. En uns segons el text apareix on hi ha el cursor. |

Whisper ja posa punts i comes quan fas pauses. Si vols forçar un signe, digues:

| Dius | Escriu |
|---|---|
| «punt i seguit» / «punt i a part» / «punt final» | `.` (i, amb «punt i a part», salt de línia) |
| «punt i coma» / «dos punts» | `;` / `:` |
| «signe d'interrogació» / «signe d'exclamació» | `?` / `!` |
| «nova línia» | salt de línia |
| «obre parèntesi» … «tanca parèntesi» | `(` … `)` |
| «obre cometes» … «tanca cometes» | `«` … `»` |

### Si alguna cosa no va bé

- **En prémer Ctrl + Majúscules canvia l'idioma del teclat i no comença a escoltar.** Windows fa servir aquesta combinació per canviar de teclat quan n'hi ha més d'un. Desactiva-ho a Configuració → Hora i idioma → Escriptura → Configuració avançada del teclat → Tecles d'accés ràpid d'idioma d'entrada, o tria una altra combinació (vegeu el punt següent).
- **Vull fer servir altres tecles.** Clic dret a la icona del costat del rellotge → **Settings…** → pestanya **Hotkeys** → **Record hotkey**. Exemples: `ctrl+win`, `f9` (una sola tecla), `ctrl+alt`. Després, clic dret a la icona → **Restart Whisper Local**.
- **Triga massa.** El model per defecte («Small») va bé en un ordinador normal. En un ordinador molt antic, prova el model «Base» (clic dret a la icona → model). En un ordinador potent, pots triar **Català AINA/BSC amb puntuació**, entrenat amb milers d'hores de català (3 GB).
- **El text no apareix.** Comprova que havies fet clic dins un lloc on es pot escriure abans de començar a dictar.

### Què hi ha dins

- [`windows/user_settings.yaml`](windows/user_settings.yaml): la configuració de Trama, comentada en català. Català fix, model, tecles accessibles, mode «un toc per començar, un altre per acabar» i signes dictats.
- [`windows/instala-dictat-catala.cmd`](windows/instala-dictat-catala.cmd): l'instal·lador. Descarrega una versió concreta de Whisper Local i en comprova la suma SHA-256 abans d'instal·lar-la. GitHub el prova en un Windows real a cada canvi.

La configuració anterior, si n'hi havia, es guarda com a `user_settings.abans-dictat-catala.yaml`.

## Linux

Funciona sobre [Speech Note](https://github.com/mkiol/dsnote), una aplicació lliure per a Linux que fa servir models Whisper en local. Aquest repositori hi afegeix una capa petita perquè sigui còmoda d'usar:

- **Un sol botó que alterna:** primer clic, comença a escoltar (sona un avís); segon clic, atura i lliura el text.
- **Dues destinacions:** escriure directament a la finestra activa, o copiar-ho al porta-retalls.
- **Drecera de teclat** opcional: `Super + Z`.
- **El text no s'envia mai sol:** queda escrit perquè el revisis.

### Requisits

- Linux amb escriptori GNOME (provat a Ubuntu 24.04, sessió **X11**).
- [Flatpak](https://flatpak.org/setup/) amb el repositori Flathub.
- Un micròfon.
- Uns 2 GB de disc (aplicació + model) i 8 GB de RAM recomanats.

No cal targeta gràfica: el model funciona amb el processador.

### Instal·lació

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

### Ús

| Acció | Com |
|---|---|
| Començar a dictar | Clic a **Dictat a la finestra** o `Super + Z`. Sona un avís. |
| Acabar | Torna a fer clic o `Super + Z`. En uns segons el text apareix on és el cursor. |
| Cancel·lar | **Cancel·la el dictat**: atura sense transcriure. |
| Al porta-retalls | Icona **Dictat**: el text es copia i l'enganxes on vulguis. |

Després de reiniciar no cal fer res: el primer clic obre Speech Note (uns segons) i comença a escoltar.

### Què cal saber

- **No és instantani.** En un ordinador modest (Ryzen 3, sense GPU) cada frase triga uns 4–5 segons a aparèixer. Frases més llargues, proporcionalment més.
- **No cliquis la finestra de Speech Note mentre dictes.** En mode manual, interactuar-hi atura l'escolta i el text va a la nota interna de l'aplicació.
- **Porta-retalls:** si mentre esperes copies o selecciones alguna altra cosa, el dictat es pot perdre. Per escriure en una finestra concreta, millor l'opció *a la finestra*.
- **Wayland:** la inserció a la finestra necessita [`ydotool`](https://github.com/ReimuNotMoe/ydotool) en marxa i permís de Flatpak al seu socket (vegeu la documentació de Speech Note). El mode porta-retalls funciona igual.
- **Privacitat:** el que es queda a l'ordinador és la transcripció. Si després enganxes el text en un servei al núvol, allà s'apliquen les condicions d'aquell servei.

### Desinstal·lar

```bash
rm ~/.local/bin/dictat-alterna ~/.local/share/applications/dictat-*.desktop
flatpak uninstall --user net.mkiol.SpeechNote     # opcional
```

La drecera `Super + Z`, si la vas crear, s'esborra a Configuració → Teclat → Dreceres de teclat → Dreceres personalitzades.

## Crèdits i llicència

- **Windows:** [Whisper Local](https://github.com/drajb/whisper-local) (MIT) fa tota la feina; aquest repositori hi afegeix la configuració en català i l'instal·lador. El model opcional «Català AINA/BSC» és del [Barcelona Supercomputing Center i el Projecte AINA](https://huggingface.co/BSC-LT/faster-whisper-large-v3-ca-punctuated-3370h) (Apache-2.0).
- **Linux:** [Speech Note](https://github.com/mkiol/dsnote), de Michal Kosciesza (MPL-2.0), fa tota la feina de reconeixement de veu. Aquest repositori només hi afegeix l'script i els llançadors.
- Fet per [Trama Educació](https://trama.emaalquadrat.cat). Codi sota llicència **GPL-3.0-or-later** (vegeu `LICENSE`).
