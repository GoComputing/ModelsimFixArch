#!/bin/bash

QUARTUS_VER=19.1
INSTALL_DIR=/opt/intelFPGA/$QUARTUS_VER





# Assert folder exists
if ! [ -d "$INSTALL_DIR" ]; then
	echo "$INSTALL_DIR doesn't exists. Check Quartus install path"
	exit -1
fi




# Assert that this script is executed as root
if [[ $UID != 0 ]]; then
	echo "This script should be executed as root"
	exit -1
fi




# Install dependencies
pacman -S --noconfirm wget lib32-gcc-libs gperf




# Make directories
mkdir $INSTALL_DIR/modelsim_ase/lib32/
LIB32_PATH=$INSTALL_DIR/modelsim_ase/lib32/




# FreeType6 2.4.12
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.12.tar.bz2
tar -xf freetype-2.4.12.tar.bz2
pushd freetype-2.4.12
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make -j8
cp objs/.libs/libfreetype.so* $LIB32_PATH
popd




# FontConfig 2.12.6
wget https://www.freedesktop.org/software/fontconfig/release/fontconfig-2.12.6.tar.bz2
tar -xf fontconfig-2.12.6.tar.bz2
pushd fontconfig-2.12.6
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make -j8
cp src/.libs/libfontconfig.so* $LIB32_PATH
popd




# Configure Modelsim-Altera
mv $INSTALL_DIR/modelsim_ase/linuxaloem $INSTALL_DIR/modelsim_ase/linuxaloem_orig
mkdir $INSTALL_DIR/modelsim_ase/linuxaloem
ln -s $INSTALL_DIR/modelsim_ase/linuxaloem_orig/* $INSTALL_DIR/modelsim_ase/linuxaloem
rm $INSTALL_DIR/modelsim_ase/linuxaloem/vsim
printf "#!/bin/sh\nLD_LIBRARY_PATH=%s %s \"\$@\"\nexit \$?\n" "$LIB32_PATH" "$INSTALL_DIR/modelsim_ase/linuxaloem_orig/vsim" > $INSTALL_DIR/modelsim_ase/linuxaloem/vsim
chmod a+x $INSTALL_DIR/modelsim_ase/linuxaloem/vsim
