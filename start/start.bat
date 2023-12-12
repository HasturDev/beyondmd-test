@echo off

:: Set a flag to indicate whether each dependency is installed
set "docker_installed=false"
set "npm_installed=false"
set "vagrant_installed=false"
set "virtualbox_installed=false"
set "node_installed=false"

:: Check for Docker
where docker > NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Docker is not installed. Installing Docker
    powershell -Command "Invoke-WebRequest https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe -OutFile docker.exe"
    start /wait docker.exe install --quiet
) ELSE (
    echo Docker is installed.
    set "docker_installed=true"
)

:: Check for npm
where npm > NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo npm is not installed. Installing Node.js (which includes npm)
    powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v14.18.1/node-v14.18.1-x64.msi -OutFile node.msi"
    start /wait msiexec /i node.msi /qn
    del node.msi
) ELSE (
    echo npm is installed.
    set "npm_installed=true"
)

:: Check for Vagrant
where vagrant > NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Vagrant is not installed. Installing Vagrant
    powershell -Command "Invoke-WebRequest https://releases.hashicorp.com/vagrant/2.2.18/vagrant_2.2.18_x86_64.msi -OutFile vagrant.msi"
    start /wait msiexec /i vagrant.msi /qn
    del vagrant.msi
) ELSE (
    echo Vagrant is installed.
    set "vagrant_installed=true"
)

:: Check for VirtualBox
where VBoxManage > NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo VirtualBox is not installed. Installing VirtualBox
    powershell -Command "Invoke-WebRequest https://download.virtualbox.org/virtualbox/6.1.26/VirtualBox-6.1.26-145957-Win.exe -OutFile virtualbox.exe"
    start /wait virtualbox.exe --silent
    del virtualbox.exe
) ELSE (
    echo VirtualBox is installed.
    set "virtualbox_installed=true"
)

:: Check for Node.js
where node > NUL 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Node.js is not installed.
) ELSE (
    echo Node.js is installed.
    set "node_installed=true"
)

:: Check if all dependencies are installed
IF "%docker_installed%"=="true" (
    IF "%npm_installed%"=="true" (
        IF "%vagrant_installed%"=="true" (
            IF "%virtualbox_installed%"=="true" (
                IF "%node_installed%"=="true" (
                    echo All dependencies are installed.
                )
            )
        )
    )
)