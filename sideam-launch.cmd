@echo off

:check-git
echo revisando si git esta instalado
echo.
git --version && (
  goto :inicio
) || (
  goto :git-installchoice
)
pause

:git-installchoice
cls
echo Instalar git (solo seleccionar no si no esta instalado)?
echo.
set choice=
set /p choice=Escribe s para SI o n para NO.
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='s' goto :git-install
if '%choice%'=='n' goto :inicio


:inicio
cls
echo clonar repositorio?
set choice=
set /p choice=Escribe s para SI o n para NO.
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='s' goto :git
if '%choice%'=='n' goto :selecpyt

:git-download
powershell -Command "Invoke-WebRequest https://github.com/git-for-windows/git/releases/download/v2.36.1.windows.1/Git-2.36.1-64-bit.exe -OutFile git-install.exe"
goto :git-install

:git-install
cls
if exist git-install.exe (
start git-install.exe
echo.
timeout 15
echo Una vez instalado:
pause
goto :inicio
) else (
goto :git-download
)


:git
echo iniciando clonacion
git clone https://github.com/Raztorr/SIDEAM.git
echo clonacion exitosa
timeout 2
goto :slecpyt


:selecpyt
cls
echo instalar pytorch?
set choice=
set /p choice=Escribe s para SI o n para NO.
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='s' goto :pytorch
if '%choice%'=='n' goto :selecrequ


:pytorch
echo instalando Py Torch Cuda...
echo =========================
echo.
python3 -m pip install --no-input torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu113
goto :selecrequ

:selecrequ
cls
echo Instalar requirements.txt?
echo.
set choice=
set /p choice=Escribe s para SI o n para NO.
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='s' goto :requirements.txt
if '%choice%'=='n' goto :selecinicio

:requirements.txt
echo instalando requirements.txt...
python3 -m pip install --no-input -r requirements.txt
goto :selecinicio

:selecinicio
cls
echo Iniciar demo?
echo.
set choice=
set /p choice=Escribe s para SI o n para NO.
echo.
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='s' goto :iniciar
if '%choice%'=='n' goto :end

:iniciar
echo iniciando test2.py
py SIDEAM/test2.py
pause
goto :end

:end
cls
echo instalacion finalizada
pause