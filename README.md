# ModelsimFixArch
Minor fixes for Modelsim installed on ArchLinux

This repository contains a script which is able to fix Modelsim bug related to
freetype6. To use it, you have to modity installation dir on line `QUARTUS_VER=19.1`
or `INSTALL_DIR=/opt/intelFPGA/$QUARTUS_VER`. First one is used when Quartus II was
installed in normal way, while second one is used when a custom installation
directory for Quartus II was chosen. After setting up installation directory, you
can execute this script using `bash fix_modelsim.sh`. If all is ok, now you are
available to execute Modelsim. 
