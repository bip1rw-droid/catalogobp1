@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
echo ============================================
echo  Reorganizador de portadas - BP1 Rawson
echo ============================================
echo.

set COUNT=0

rem Primero corregir los archivos que quedaron en la carpeta !PREFIX!
if exist "!PREFIX!" (
    echo Corrigiendo archivos mal movidos...
    for %%F in ("!PREFIX!\*.jpg" "!PREFIX!\*.jpeg" "!PREFIX!\*.png" "!PREFIX!\*.webp") do (
        set "FNAME=%%~nF"
        set "PRE=!FNAME:~0,3!"
        if not exist "!PRE!" mkdir "!PRE!"
        move "%%F" "!PRE!\%%~nxF" >nul 2>&1
        echo Corregido: %%~nxF
        set /a COUNT+=1
    )
    rmdir "!PREFIX!" >nul 2>&1
)

rem Ahora mover los archivos que quedaron en la raiz
echo Moviendo archivos restantes...
for %%F in (*.jpg *.jpeg *.png *.webp *.gif) do (
    set "FNAME=%%~nF"
    set "PRE=!FNAME:~0,3!"
    if not exist "!PRE!" mkdir "!PRE!"
    move "%%F" "!PRE!\%%F" >nul 2>&1
    echo Movido: %%F ^-^> !PRE!\%%F
    set /a COUNT+=1
)

echo.
echo ============================================
echo  Listo! Archivos procesados: %COUNT%
echo ============================================
echo.
echo Abri GitHub Desktop y hace Commit + Push.
echo.
pause
endlocal
