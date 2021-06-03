#!/usr/bin/env bash

function download_documents {
    doc_dir="$HOME/Documents"
    cd $doc_dir
    if [ ! -f "$doc_dir/SAT_SMT_by_example.pdf" ]; then
        wget https://sat-smt.codes/SAT_SMT_by_example.pdf
    fi
    return 0
}

function install_vscode {
    grep -r vscode /etc/apt/
    retVal=$?
    if [ $retVal -ne 0 ]; then
        wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
        sudo apt install code
        echo ">>> Visual Studio installed."
        return 0
    fi
    echo ">>> Visual Studio Code already installed!"
    return 1
}

function install_cutter {
    install_dir="$HOME/Cutter"
    if [ -d $install_dir ]
    then
        echo ">>> Cutter already installed!"
        return 1
    fi
    cd $HOME/Downloads
    wget https://github.com/rizinorg/cutter/releases/download/v2.0.2/Cutter-v2.0.2-x64.Linux.appimage
    cutter_appimage=`ls | grep Cutter-*.appimage`
    chmod +x $cutter_appimage
    mkdir $install_dir
    mv $cutter_appimage $install_dir
    echo ">>> Cutter installed."
    return 0
}

function install_ghidra {
    install_dir="$HOME/Ghidra"
    if [ -d $install_dir ]
    then
        echo ">>> Ghidra already installed!"
        return 1
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
        return 1
    fi
    mkdir $install_dir
    unzip -q $ghidra_zip -d $install_dir
    cd $install_dir
    ghi_dir=`ls | grep ghidra_`
    rm $HOME/Downloads/ghidra*zip
    echo ">>> Ghidra installed."
    return 0
}

function install_metasploit {
    if [[ -f /usr/bin/msfvenom ]]
    then
	echo ">>> Metasploit already installed."
	return 1
    fi
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /tmp/msfinstall && chmod 755 /tmp/msfinstall && /tmp/msfinstall
    return 0
}

sudo apt -y update && sudo apt -y upgrade
sudo apt -y install python3-pip vim bvi vbindiff build-essential ruby-dev nasm ht reptyr libseccomp-dev libc6-dbg software-properties-common apt-transport-https wget binutils xxd openjdk-11-jdk openjdk-11-jre-headless qemu-system-arm tmux git wireshark tshark terminator yara curl gcc-multilib g++-multilib libc6-dbg:i386 ipython3
sudo pip3 install --upgrade pip
sudo pip3 install capstone ropper unicorn keystone-engine z3-solver pwntools scapy volatility3 frida ipdb ipython

download_documents
install_vscode
install_imhex
install_cutter
install_ghidra
bash -c "$(wget http://gef.blah.cat/sh -O -)"  # GEF - GDB Enhanced Features
install_metasploit
