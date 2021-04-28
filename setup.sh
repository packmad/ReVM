#!/usr/bin/env bash

function install_vscode {
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
    sudo apt install code
}

function install_imhex {
    install_dir="$HOME/ImHex"
    if [ -d $install_dir ]
    then
        echo "ImHex already installed!"
        exit 1
    fi
    cd $HOME/Downloads
    wget https://github.com/WerWolv/ImHex/releases/download/v1.7.0/Linux.ELF.zip
    unzip -q Linux.ELF.zip -d $install_dir
    #TODO continue
}

function install_cutter {
    install_dir="$HOME/Cutter"
    if [ -d $install_dir ]
    then
        echo "Cutter already installed!"
        exit 1
    fi
    cd $HOME/Downloads
    wget https://github.com/rizinorg/cutter/releases/download/v2.0.2/Cutter-v2.0.2-x64.Linux.appimage
    cutter_appimage=`ls | grep Cutter-*.appimage`
    chmod +x $cutter_appimage
    mkdir $install_dir
    mv $cutter_appimage $install_dir
    #rm $cutter_appimage
}

function install_ghidra {
    install_dir="$HOME/Ghidra"
    if [ -d $install_dir ]
    then
        echo "Ghidra already installed!"
        exit 1
    fi
    cd $HOME/Downloads
    #TOFIX wget -r -l1 -H -t1 -nd -N -np -A.zip -erobots=off https://www.ghidra-sre.org
    wget https://www.ghidra-sre.org/ghidra_9.2.3_PUBLIC_20210325.zip
    ghidra_zip=`ls | grep ghidra_`
    ver="$(echo $ghidra_zip | cut -d'_' -f2)"
    hsh_url=https://www.ghidra-sre.org/releaseNotes_$ver.html
    cksm=`echo $(wget $hsh_url -q -O -) | awk -F'</*code>' '$2{print $2}' | head -1`
    echo "$cksm $ghidra_zip" | sha256sum --check
    retVal=$?
    if [ $retVal -ne 0 ]; then
        echo "Hash mismatch - file corrupted! Exiting."
        exit 1
    fi
    mkdir $install_dir
    unzip -q $ghidra_zip -d $install_dir
    cd $install_dir
    ghi_dir=`ls | grep ghidra_`
    echo "alias ghidra='$install_dir/$ghi_dir/ghidraRun'" # >> ~/.bashrc
    #rm $HOME/Downloads/ghidra*zip
}


sudo apt -y update && sudo apt -y upgrade
sudo apt -y install python3-pip vim bvi vbindiff build-essential ruby-dev nasm ht reptyr libseccomp-dev libc6-dbg software-properties-common apt-transport-https wget binutils xxd openjdk-11-jdk openjdk-11-jre-headless qemu-system-arm
sudo pip3 install --upgrade pip
sudo pip3 install capstone ropper unicorn keystone-engine pwntools

install_vscode
install_imhex
install_cutter
install_ghidra
bash -c "$(wget http://gef.blah.cat/sh -O -)"  # Install GEF - GDB Enhanced Features
