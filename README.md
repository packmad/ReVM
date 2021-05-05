# ReVM

ReVM is a pre-configured Ubuntu 20.04 virtual machine with the necessary tools to practice reverse engineering and exploitation of binary files.

The purpose of this git repository (you will find it inside the VM at `/home/dude/ReVM/`) is to update remotely the software and/or fix problems.

However, for the end user there is a link "`Update ReVM`" in the desktop of the VM.
Just double click on it and a script will take care to pull this repository and proceed with any updates.

<br/>

## Download and run ReVM
You can download `ReVM.ova` from [here](https://drive.google.com/file/d/1Uc76h_vFZW3v1hn2XxPbc5hp9NtF3zs4/view?usp=sharing).
An OVA file is a virtual appliance used by virtualization applications such as VMware Workstation and Oracle VM Virtualbox.


### Import the OVA with VirtualBox

1. [Download](https://www.virtualbox.org/) and install VirtualBox if you do not have it already
   + on Debian/Ubuntu: `sudo apt install virtualbox`
2. Open VirtualBox
3. Select File and Import Appliance
4. Select your OVA file in the import box and verify the settings in the center window
5. Make any changes if you need (maybe you want to give it more RAM)
6. Click Import at the bottom.

### Errors related to VT-x/AMD-V
Modern CPUs include hardware virtualization features that help accelerate virtual machines, but those features are not always enabled by default.
Unfortunately to enable them there is not a unique way that works on all computers.
Therefore, you need to google how to access your computer's BIOS/UEFI settings and enable the Virtualization Technology.

For example, you can google: 

`enable virtualization technology on dell inspiron`

rest assured that you will find a tutorial among the very first results!


<br/>

## Raspberry Pi OS
Raspberry Pi OS is a Debian-based operating system for the Raspberry Pi, a small single-board computer with an integrated ARM CPU.
There is a link "`Start Raspi`" in the desktop of the VM that is in charge of running QEMU and emulate this operating system.
1. Double click on it, and two windows will be opened
2. Wait until the system finishes booting up, then minimize such windows
3. Open a terminal and type: `ssh raspi`

You are now connected to the Pi OS!

<br/>

### Transfer files from/to Ubuntu and RPi OS

You can use `scp`, have a look at its man page.

From RPi to Ubuntu:

`scp raspi:/source/file/path /dest/file/path`

From Ubuntu to RPi:

`scp /source/file/path raspi:/dest/file/path`




<br/>

## Installed Tools
+ Debugging
  + [GDB](https://www.gnu.org/software/gdb/) with [GEF](https://gef.readthedocs.io/en/master/)
+ Hex Editors
  + [010editor](https://www.sweetscape.com/010editor/)
    + License expiration: 04 June 2021
+ Integrated Development Environments
  + [Visual Studio Code](https://code.visualstudio.com/)
+ Network Analyzers
  + [Wireshark](https://www.wireshark.org/)
  + [tshark](https://www.wireshark.org/docs/man-pages/tshark.html)
+ Penetration Testing
  + [Metasploit Framework](https://www.metasploit.com/)
+ Python Packages
  + [capstone](https://pypi.org/project/capstone/)
  + [frida](https://pypi.org/project/frida/)
  + [keystone-engine](https://pypi.org/project/keystone-engine/)
  + [pwntools](https://pypi.org/project/pwntools/)
  + [ropper](https://pypi.org/project/ropper/)
  + [scapy](https://pypi.org/project/scapy/)
  + [unicorn](https://pypi.org/project/unicorn/)
  + [volatility3](https://pypi.org/project/volatility3/)
  + [z3-solver](https://pypi.org/project/z3-solver/)
+ Reversing Frameworks
  + [Cutter](https://cutter.re/)
  + [Ghidra](https://www.ghidra-sre.org/)
  + [IDA Freeware](https://www.hex-rays.com/products/ida/support/download_freeware/)
  + [Rizin](https://rizin.re/)

<br/>

## Documents
  + [A First Introduction to System Exploitation](https://research.checkpoint.com/wp-content/uploads/2020/03/pwnable_writeup.pdf)
  + [RE4B - Reverse Engineering for Beginners](https://beginners.re/main.html)
  + [SAT/SMT by Example](https://sat-smt.codes/)

<br/>

## Useful aliases
```
alias cutter='/home/dude/Cutter/Cutter-v2.0.2-x64.Linux.appimage'
alias ghidra='/home/dude/Ghidra/ghidra_9.2.3_PUBLIC/ghidraRun'
alias ida64free='/home/dude/idafree-7.0/ida64'
alias rizin='/home/dude/rizin/bin/rizin'
```

<br/>

## Password

| System       | Username | Password |
| -----------  | -------- | -------- |
| Ubuntu 20.04 | dude     | dude     |
| RPi OS 10    | pi       | pi       |
|

You should change them :)
