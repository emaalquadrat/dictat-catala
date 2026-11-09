@echo off
rem Dictat en català per a Windows: instal·lador de Trama
rem https://github.com/emaalquadrat/dictat-catala
rem
rem Fa quatre coses, sense demanar contrasenya ni escriure res:
rem   1. Descarrega Whisper Local (versió fixada) i en comprova la integritat.
rem   2. Posa la configuració en català (user_settings.yaml) al seu lloc,
rem      amb còpia de seguretat de la que hi hagués.
rem   3. Crea la icona «Dictat en català» a l'escriptori.
rem   4. Obre el programa.
rem
rem Copyright (C) 2026 Trama Educació. GPL-3.0-or-later.

chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion
title Dictat en català: instal·lació

set "VERSIO=v0.24.0"
set "HASH=baafd759702d0e95fcc8b765398a6f1c47f35697f33e4435849077c011afa804"
set "URL=https://github.com/drajb/whisper-local/releases/download/%VERSIO%/whisper-local.exe"
set "DESTI=%LOCALAPPDATA%\Programs\WhisperLocal"
set "EXE=%DESTI%\whisper-local.exe"
set "CONF=%APPDATA%\whisperkey"
set "ORIGEN=%~dp0"

echo.
echo  ============================================
echo   Dictat en català per a Windows (Trama)
echo  ============================================
echo.

if not exist "%ORIGEN%user_settings.yaml" (
    echo  No trobo el fitxer user_settings.yaml al costat d'aquest instal·lador.
    echo  Segurament l'has obert des de dins del fitxer .zip sense extreure'l.
    echo  Fes clic dret al .zip, tria «Extreu-ho tot» i torna a obrir
    echo  instala-dictat-catala.cmd des de la carpeta extreta.
    goto :error
)

echo  1/4  Descarregant Whisper Local %VERSIO% (uns 23 MB^)...
if not exist "%DESTI%" mkdir "%DESTI%"
curl.exe -sSfL -o "%EXE%.baixant" "%URL%"
if errorlevel 1 (
    echo  No s'ha pogut descarregar. Comprova la connexió a internet i torna-ho a provar.
    goto :error
)
set "CALCULAT="
for /f "skip=1 delims=" %%h in ('certutil -hashfile "%EXE%.baixant" SHA256') do (
    if not defined CALCULAT set "CALCULAT=%%h"
)
set "CALCULAT=!CALCULAT: =!"
if /I not "!CALCULAT!"=="%HASH%" (
    echo  El fitxer descarregat no coincideix amb l'original. Per seguretat, no s'instal·la.
    del "%EXE%.baixant" >nul 2>&1
    goto :error
)
move /Y "%EXE%.baixant" "%EXE%" >nul
echo       Fet i comprovat.

echo  2/4  Posant la configuració en català...
if not exist "%CONF%" mkdir "%CONF%"
if exist "%CONF%\user_settings.yaml" (
    copy /Y "%CONF%\user_settings.yaml" "%CONF%\user_settings.abans-dictat-catala.yaml" >nul
    echo       Hi havia una configuració anterior: guardada com a user_settings.abans-dictat-catala.yaml
)
copy /Y "%ORIGEN%user_settings.yaml" "%CONF%\user_settings.yaml" >nul
if errorlevel 1 (
    echo  No s'ha pogut copiar la configuració.
    goto :error
)
echo       Fet.

echo  3/4  Creant la icona a l'escriptori...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$n = 'Dictat en catal' + [char]0x00E0 + '.lnk'; $d = [Environment]::GetFolderPath('Desktop'); $s = (New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path $d $n)); $s.TargetPath = $env:EXE; $s.WorkingDirectory = $env:DESTI; $s.Description = 'Dictat en catala (Whisper Local)'; $s.Save()"
if errorlevel 1 (
    echo       No s'ha pogut crear la icona. El programa és a: %EXE%
) else (
    echo       Fet.
)

if defined DICTAT_NO_OBRIS goto :fi

echo  4/4  Obrint el dictat...
echo.
echo  La primera vegada triga uns minuts: descarrega el que necessita i el
echo  model de veu. Després ja funciona sense internet.
echo.
echo  Com es fa servir:
echo    - Fes clic on vulguis escriure.
echo    - Prem Ctrl + Majúscules (una tecla amb cada mà serveix^) i parla.
echo    - Prem Ctrl per acabar: el text s'escriu on hi ha el cursor.
echo.
start "" "%EXE%"

:fi
echo  Instal·lació acabada. Ja pots tancar aquesta finestra.
echo.
pause
exit /b 0

:error
echo.
echo  La instal·lació no s'ha completat.
echo.
pause
exit /b 1
