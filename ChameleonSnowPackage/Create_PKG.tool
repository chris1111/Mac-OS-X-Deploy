#!/bin/bash
# Installer Mac OS X Snow Leopard
# (c) Copyright 2026 chris1111 
# This will create a Package Bundle Installer Mac OS X Snow Leopard
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
find . -name '.DS_Store' -type f -delete
Sleep 1
rm -rf ./Chameleon-Snow.pkg
rm -rf ./InstallerChameleon
rm -rf /tmp/Package-DIR
rm -rf ./*.pkg

if [[ -d "./Chameleon-Snow.pmdoc" ]]; then
    Sleep 1
    mkdir -p ./InstallerChameleon
    mkdir -p ./InstallerChameleon/BUILD-PACKAGE
    mkdir -p /tmp/Package-DIR
    pkgbuild --root ./Chameleon/standard --scripts ./Scripts/ScriptChameleonStandard --identifier com.chameleonMacOsXSnowLeopard.standard.pkg --version 1 --install-location / ./InstallerChameleon/BUILD-PACKAGE/standard.pkg
    pkgbuild --root ./Chameleon/efi --scripts ./Scripts/ScriptChameleonEfi --identifier com.chameleonMacOsXSnowLeopard.efi.pkg --version 1 --install-location / ./InstallerChameleon/BUILD-PACKAGE/efi.pkg
    pkgbuild --root ./PC --identifier com.chameleonMacOsXSnowLeopard.Extra-1.pkg --version 1 --install-location / ./InstallerChameleon/BUILD-PACKAGE/extra-1.pkg
    pkgbuild --root ./Laptop --identifier com.chameleonMacOsXSnowLeopard.Extra-2.pkg --version 1 --install-location / ./InstallerChameleon/BUILD-PACKAGE/extra-2.pkg
    Sleep 2
    pkgutil --expand ./InstallerChameleon/BUILD-PACKAGE/Standard.pkg /tmp/Package-DIR/standard.pkg
    pkgutil --expand ./InstallerChameleon/BUILD-PACKAGE/Efi.pkg /tmp/Package-DIR/efi.pkg
    pkgutil --expand ./InstallerChameleon/BUILD-PACKAGE/Extra-1.pkg /tmp/Package-DIR/extra-1.pkg
    pkgutil --expand ./InstallerChameleon/BUILD-PACKAGE/Extra-2.pkg /tmp/Package-DIR/extra-2.pkg
    Sleep 2
    cp -r ./Distribution /tmp/Package-DIR
    cp -r ./Resources /tmp/Package-DIR
    Sleep 1
    pkgutil --flatten /Private/tmp/Package-DIR ./Chameleon-Snow.pkg
    Sleep 1
    rm -rf ./InstallerChameleon

fi