@echo off
SETLOCAL EnableDelayedExpansion

:: Check and Install Docker
docker --version > NUL 2>&1
IF !ERRORLEVEL! EQU 0 (
    echo Docker is installed.
) ELSE (
    echo Docker is not installed. Installing Docker...
    powershell -Command "Invoke-WebRequest https://desktop.docker.com/win/stable/Docker%20Desktop%20Installer.exe -OutFile docker.exe"
    start /wait docker.exe install --quiet
    del docker.exe
    docker --version > NUL 2>&1
    IF !ERRORLEVEL! EQU 0 (
        echo Docker was installed successfully.
    ) ELSE (
        echo Failed to install Docker.
    )
)

:: Check and Install npm/Node.js
npm --version > NUL 2>&1
IF !ERRORLEVEL! EQU 0 (
    echo npm is installed.
) ELSE (
    echo npm is not installed. Installing Node.js (which includes npm)...
    powershell -Command "Invoke-WebRequest https://nodejs.org/dist/v14.18.1/node-v14.18.1-x64.msi -OutFile node.msi"
    start /wait msiexec /i node.msi /qn
    del node.msi
    npm --version > NUL 2>&1
    IF !ERRORLEVEL! EQU 0 (
        echo Node.js was installed successfully.
    ) ELSE (
        echo Failed to install Node.js.
    )
)

:: Check and Install Vagrant
vagrant --version > NUL 2>&1
IF !ERRORLEVEL! EQU 0 (
    echo Vagrant is installed.
) ELSE (
    echo Vagrant is not installed. Installing Vagrant...
    powershell -Command "Invoke-WebRequest https://releases.hashicorp.com/vagrant/2.2.18/vagrant_2.2.18_x86_64.msi -OutFile vagrant.msi"
    start /wait msiexec /i vagrant.msi /qn
    del vagrant.msi
    vagrant --version > NUL 2>&1
    IF !ERRORLEVEL! EQU 0 (
        echo Vagrant was installed successfully.
    ) ELSE (
        echo Failed to install Vagrant.
    )
)

:: Check and Install VirtualBox
VBoxManage --version > NUL 2>&1
IF !ERRORLEVEL! EQU 0 (
    echo VirtualBox is installed.
) ELSE (
    echo VirtualBox is not installed. Installing VirtualBox...
    powershell -Command "Invoke-WebRequest https://download.virtualbox.org/virtualbox/6.1.26/VirtualBox-6.1.26-145957-Win.exe -OutFile virtualbox.exe"
    start /wait virtualbox.exe --silent
    del virtualbox.exe
    VBoxManage --version > NUL 2>&1
    IF !ERRORLEVEL! EQU 0 (
        echo VirtualBox was installed successfully.
    ) ELSE (
        echo Failed to install VirtualBox.
    )
)

pause